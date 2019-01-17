import logging

from django.db import models

from plugins.plugin_manager import system_has_access_control
from .listing import Listing
from .profile import Profile
from .util import get_user_excluded_orgs

logger = logging.getLogger('ozp-center.' + str(__name__))


class AccessControlRecommendationsEntryManager(models.Manager):
    """
    Use a custom manager to control access to RecommendationsEntry
    """

    def apply_select_related(self, queryset):
        queryset = queryset.select_related('target_profile')
        queryset = queryset.select_related('target_profile__user')
        return queryset

    def get_queryset(self):
        queryset = super(AccessControlRecommendationsEntryManager, self).get_queryset()
        return self.apply_select_related(queryset)

    def for_user(self, username):
        objects = super(AccessControlRecommendationsEntryManager, self).get_queryset()

        profile_instance = Profile.objects.get(user__username=username)
        # filter out private listings
        exclude_orgs = get_user_excluded_orgs(profile_instance)

        objects = objects.filter(target_profile=profile_instance,
                                 listing__is_enabled=True,
                                 listing__approval_status=Listing.APPROVED,
                                 listing__is_deleted=False)

        objects = objects.exclude(listing__is_private=True,
                                  listing__agency__in=exclude_orgs)

        # Filter out listings by user's access level
        ids_to_exclude = []
        for i in objects:
            if not i.listing.security_marking:
                logger.debug('Listing {0!s} has no security_marking'.format(i.listing.title))
            if not system_has_access_control(username, i.listing.security_marking):
                ids_to_exclude.append(i.listing.id)
        objects = objects.exclude(listing__pk__in=ids_to_exclude)
        return objects

    def for_user_organization_minus_security_markings(self, username):
        objects = super(AccessControlRecommendationsEntryManager, self).get_queryset()

        profile_instance = Profile.objects.get(user__username=username)
        # filter out private listings
        exclude_orgs = get_user_excluded_orgs(profile_instance)

        objects = objects.filter(target_profile=profile_instance,
                                 listing__is_enabled=True,
                                 listing__approval_status=Listing.APPROVED,
                                 listing__is_deleted=False)

        objects = objects.exclude(listing__is_private=True, listing__agency__in=exclude_orgs)
        return objects


class RecommendationsEntry(models.Model):
    """
    Recommendations Entry
    """
    target_profile = models.ForeignKey(Profile, related_name='recommendations_profile')
    recommendation_data = models.BinaryField(default=None)

    objects = AccessControlRecommendationsEntryManager()

    def __str__(self):
        return '{0!s}:RecommendationsEntry'.format(self.target_profile)

    def __repr__(self):
        return '{0!s}:RecommendationsEntry'.format(self.target_profile)

    class Meta:
        verbose_name_plural = "recommendations entries"
