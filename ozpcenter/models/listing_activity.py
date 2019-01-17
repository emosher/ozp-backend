from django.db import models

from ozpcenter import utils
from .external_model import ExternalModel
from .listing import Listing
from .profile import Profile


class AccessControlListingActivityManager(models.Manager):
    """
    Use a custom manager to control access to ListingActivities
    """

    def apply_select_related(self, queryset):
        queryset = queryset.select_related('author')
        queryset = queryset.select_related('listing')
        return queryset

    def get_queryset(self):
        queryset = super(AccessControlListingActivityManager, self).get_queryset()
        return self.apply_select_related(queryset)

    def get_base_queryset(self):
        return super().get_queryset()

    def for_user(self, username):
        from .listing import Listing

        all_activities = super(AccessControlListingActivityManager, self).get_queryset()
        listings = Listing.objects.for_user(username).all()
        # filter out listing_activities for listings this user cannot see
        filtered_listing_activities = all_activities.filter(listing__in=listings)
        return filtered_listing_activities


class ListingActivity(ExternalModel):
    """
    Listing Activity
    """

    # Actions
    # listing is initially created
    CREATED = 'CREATED'
    # field of a listing is modified - has a corresponding ChangeDetail entry
    MODIFIED = 'MODIFIED'
    # listing is submitted for approval by org steward and apps mall steward
    SUBMITTED = 'SUBMITTED'
    # listing is approved by an org steward
    APPROVED_ORG = 'APPROVED_ORG'
    # listing is approved by apps mall steward (upon previous org steward
    # approval) - it is now visible to users
    APPROVED = 'APPROVED'
    # listing is rejected for approval by org steward or apps mall steward
    REJECTED = 'REJECTED'
    # listing is enabled (visible to users)
    ENABLED = 'ENABLED'
    # listing is disabled (hidden from users)
    DISABLED = 'DISABLED'
    # listing outside visibility enabled (visible to outside users)
    ENABLED_OUTSIDE_VISIBILITY = 'ENABLED_OUTSIDE_VISIBILITY'
    # listing outside visibility disabled (not visible to outside users)
    DISABLED_OUTSIDE_VISIBILITY = 'DISABLED_OUTSIDE_VISIBILITY'
    # listing is deleted (hidden from users)
    DELETED = 'DELETED'
    # a review for a listing has been modified
    REVIEW_EDITED = 'REVIEW_EDITED'
    # a review for a listing has been deleted
    REVIEW_DELETED = 'REVIEW_DELETED'
    PENDING_DELETION = 'PENDING_DELETION'
    REVIEWED = 'REVIEWED'

    ACTION_CHOICES = (
        (CREATED, 'CREATED'),
        (MODIFIED, 'MODIFIED'),
        (SUBMITTED, 'SUBMITTED'),
        (APPROVED_ORG, 'APPROVED_ORG'),
        (APPROVED, 'APPROVED'),
        (REJECTED, 'REJECTED'),
        (ENABLED, 'ENABLED'),
        (DISABLED, 'DISABLED'),
        (DELETED, 'DELETED'),
        (REVIEWED, 'REVIEWED'),
        (REVIEW_EDITED, 'REVIEW_EDITED'),
        (REVIEW_DELETED, 'REVIEW_DELETED'),
        (PENDING_DELETION, 'PENDING_DELETION'),
        (ENABLED_OUTSIDE_VISIBILITY, 'ENABLED_OUTSIDE_VISIBILITY'),
        (DISABLED_OUTSIDE_VISIBILITY, 'DISABLED_OUTSIDE_VISIBILITY')
    )

    action = models.CharField(max_length=128, choices=ACTION_CHOICES)
    # TODO: change this back after the migration
    # activity_date = models.DateTimeField(auto_now=True)
    activity_date = models.DateTimeField(default=utils.get_now_utc)
    # an optional description of the activity (required if the action is REJECTED)
    description = models.CharField(max_length=2000, blank=True, null=True)
    author = models.ForeignKey(Profile, related_name='listing_activities')
    listing = models.ForeignKey(Listing, related_name='listing_activities')
    change_details = models.ManyToManyField(
        'ChangeDetail',
        related_name='listing_activity',
        db_table='listing_activity_change_detail'
    )

    # use a custom Manager class to limit returned activities
    objects = AccessControlListingActivityManager()

    def __repr__(self):
        return '{0!s} {1!s} {2!s} at {3!s}'.format(self.author.user.username, self.action,
                                                   self.listing.title, self.activity_date)

    def __str__(self):
        return '{0!s} {1!s} {2!s} at {3!s}'.format(self.author.user.username, self.action,
                                                   self.listing.title, self.activity_date)

    class Meta:
        verbose_name_plural = "listing activities"
