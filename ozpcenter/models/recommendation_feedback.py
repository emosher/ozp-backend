import logging

from django.db import models

from plugins.plugin_manager import system_has_access_control
from .listing import Listing
from .profile import Profile
from .util import get_user_excluded_orgs

logger = logging.getLogger('ozp-center.' + str(__name__))


class AccessControlRecommendationFeedbackManager(models.Manager):
    """
    Use a custom manager to control access to RecommendationsEntry
    """

    def apply_select_related(self, queryset):
        queryset = queryset.select_related('target_profile')
        queryset = queryset.select_related('target_listing')
        return queryset

    def get_queryset(self):
        queryset = super(AccessControlRecommendationFeedbackManager, self).get_queryset()
        return self.apply_select_related(queryset)

    def for_user(self, username):
        objects = super(AccessControlRecommendationFeedbackManager, self).get_queryset()

        profile_instance = Profile.objects.get(user__username=username)
        # filter out private listings
        exclude_orgs = get_user_excluded_orgs(profile_instance)

        objects = objects.filter(target_profile=profile_instance,
                                 target_listing__is_enabled=True,
                                 target_listing__approval_status=Listing.APPROVED,
                                 target_listing__is_deleted=False)

        objects = objects.exclude(target_listing__is_private=True,
                                  target_listing__agency__in=exclude_orgs)

        # Filter out listings by user's access level
        ids_to_exclude = []
        for recommend_feedback_obj in objects:
            if not recommend_feedback_obj.target_listing.security_marking:
                logger.debug(
                    'Listing {0!s} has no security_marking'.format(recommend_feedback_obj.target_listing.title))
            if not system_has_access_control(username, recommend_feedback_obj.target_listing.security_marking):
                ids_to_exclude.append(recommend_feedback_obj.target_listing.id)
        objects = objects.exclude(target_listing__pk__in=ids_to_exclude)
        return objects

    def for_user_organization_minus_security_markings(self, username):
        objects = super(AccessControlRecommendationFeedbackManager, self).get_queryset()

        profile_instance = Profile.objects.get(user__username=username)
        # filter out private listings
        exclude_orgs = get_user_excluded_orgs(profile_instance)

        objects = objects.filter(target_profile=profile_instance,
                                 target_listing__is_enabled=True,
                                 target_listing__approval_status=Listing.APPROVED,
                                 target_listing__is_deleted=False)

        objects = objects.exclude(target_listing_is_private=True,
                                  target_listing__agency__in=exclude_orgs)
        return objects


class RecommendationFeedback(models.Model):
    """
    Recommendations Feedback
    """
    target_profile = models.ForeignKey(Profile, related_name='recommendation_feedback_profile')
    target_listing = models.ForeignKey(Listing, related_name='recommendation_feedback_listing')
    feedback = models.IntegerField(default=0)

    objects = AccessControlRecommendationFeedbackManager()

    def __str__(self):
        return '{0!s}:RecommendationFeedback({1!s},, {2!s})'.format(self.target_profile, self.feedback,
                                                                    self.target_listing)

    def __repr__(self):
        return '{0!s}:RecommendationFeedback({1!s}, {2!s})'.format(self.target_profile, self.feedback,
                                                                   self.target_listing)

    class Meta:
        verbose_name_plural = "recommendation feedback"
