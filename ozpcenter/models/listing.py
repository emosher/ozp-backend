import logging

from django.core.cache import cache
from django.core.validators import RegexValidator
from django.db import models
from django.db.models import Prefetch
from django.db.models.signals import post_delete
from django.db.models.signals import post_save
from django.dispatch import receiver

from ozpcenter import constants, utils
from plugins.plugin_manager import system_has_access_control
from .agency import Agency
from .category import Category
from .contact import Contact
from .external_model import ExternalModel
from .image import Image
from .intent import Intent
from .listing_type import ListingType
from .profile import Profile
from .util import get_user_excluded_orgs

logger = logging.getLogger('ozp-center.' + str(__name__))


class AccessControlListingManager(models.Manager):
    """
    Use a custom manager to control access to Listings
    """

    def apply_select_related(self, queryset):
        queryset = queryset.select_related('agency')
        queryset = queryset.select_related('agency__icon')
        queryset = queryset.select_related('listing_type')
        queryset = queryset.select_related('small_icon')
        queryset = queryset.select_related('small_icon__image_type')
        queryset = queryset.select_related('large_icon')
        queryset = queryset.select_related('large_icon__image_type')
        queryset = queryset.select_related('banner_icon')
        queryset = queryset.select_related('banner_icon__image_type')
        queryset = queryset.select_related('large_banner_icon')
        queryset = queryset.select_related('large_banner_icon__image_type')
        queryset = queryset.select_related('required_listings')
        queryset = queryset.select_related('last_activity')
        queryset = queryset.select_related('current_rejection')
        return queryset

    def get_queryset(self):
        queryset = super(AccessControlListingManager, self).get_queryset()
        return self.apply_select_related(queryset)

    def find_published_for_export(self):
        from .listing_activity import ListingActivity
        from .review import Review
        from .screenshot import Screenshot

        agencies = Agency.objects \
            .select_related('icon') \
            .select_related('icon__image_type')

        intents = Intent.objects \
            .select_related('icon') \
            .select_related('icon__image_type')

        profiles = Profile.objects.get_base_queryset() \
            .defer('user') \
            .prefetch_related(Prefetch('organizations', queryset=agencies)) \
            .prefetch_related(Prefetch('stewarded_organizations', queryset=agencies))

        listing_activities = ListingActivity.objects.get_base_queryset() \
            .prefetch_related('change_details') \
            .prefetch_related(Prefetch('author', queryset=profiles))

        reviews = Review.objects.get_base_queryset() \
            .prefetch_related(Prefetch('author', queryset=profiles))

        screenshots = Screenshot.objects.get_base_queryset() \
            .select_related('small_image') \
            .select_related('small_image__image_type') \
            .select_related('large_image') \
            .select_related('large_image__image_type')

        return super().get_queryset() \
            .filter(is_exportable=True,
                    is_private=False) \
            .select_related('agency') \
            .select_related('agency__icon') \
            .select_related('agency__icon__image_type') \
            .select_related('banner_icon') \
            .select_related('banner_icon__image_type') \
            .prefetch_related('categories') \
            .prefetch_related('contacts') \
            .prefetch_related('doc_urls') \
            .prefetch_related(Prefetch('intents', queryset=intents)) \
            .prefetch_related(Prefetch('listing_activities', queryset=listing_activities)) \
            .select_related('listing_type') \
            .select_related('large_banner_icon') \
            .select_related('large_banner_icon__image_type') \
            .select_related('large_icon') \
            .select_related('large_icon__image_type') \
            .prefetch_related(Prefetch('owners', queryset=profiles)) \
            .prefetch_related(Prefetch('reviews', queryset=reviews)) \
            .prefetch_related(Prefetch('screenshots', queryset=screenshots)) \
            .select_related('small_icon') \
            .select_related('small_icon__image_type') \
            .prefetch_related('tags')

    def for_user(self, username):
        objects = super(AccessControlListingManager, self).get_queryset()
        profile_instance = Profile.objects.get(user__username=username)
        # filter out private listings
        exclude_orgs = get_user_excluded_orgs(profile_instance)

        objects = objects.exclude(is_private=True, agency__in=exclude_orgs)
        objects = self.apply_select_related(objects)

        # Filter out listings by user's access level
        ids_to_exclude = []
        for i in objects:
            if not i.security_marking:
                logger.debug('Listing {0!s} has no security_marking'.format(i.title))
            if not system_has_access_control(username, i.security_marking):
                ids_to_exclude.append(i.id)
        objects = objects.exclude(pk__in=ids_to_exclude)

        return objects

    def for_user_organization_minus_security_markings(self, username):
        objects = super(AccessControlListingManager, self).get_queryset()
        profile_instance = Profile.objects.get(user__username=username)
        # filter out private listings
        exclude_orgs = get_user_excluded_orgs(profile_instance)

        objects = objects.exclude(is_private=True, agency__in=exclude_orgs)
        objects = self.apply_select_related(objects)
        return objects


class Listing(ExternalModel):
    """
    Listing

    To allow users to save Listings in an incompleted state, most of the fields
    in this model are nullable, even though that's not valid for a finalized
    listing
    """
    # Approval Statuses
    # This is the Djangoy mechanism for doing CHOICES fields:
    # https://docs.djangoproject.com/en/1.8/ref/models/fields/#choices
    IN_PROGRESS = 'IN_PROGRESS'
    PENDING = 'PENDING'
    APPROVED_ORG = 'APPROVED_ORG'
    APPROVED = 'APPROVED'
    REJECTED = 'REJECTED'
    DELETED = 'DELETED'
    PENDING_DELETION = 'PENDING_DELETION'
    APPROVAL_STATUS_CHOICES = (
        (IN_PROGRESS, 'IN_PROGRESS'),
        (PENDING, 'PENDING'),
        (APPROVED_ORG, 'APPROVED_ORG'),
        (APPROVED, 'APPROVED'),
        (REJECTED, 'REJECTED'),
        (DELETED, 'DELETED'),
        (PENDING_DELETION, 'PENDING_DELETION')
    )
    # title is not guaranteed to be unique
    title = models.CharField(max_length=255)
    approved_date = models.DateTimeField(null=True, blank=True)
    # TODO: change this back after the migration
    # edited_date = models.DateTimeField(auto_now=True)
    edited_date = models.DateTimeField(default=utils.get_now_utc)
    featured_date = models.DateTimeField(null=True, blank=True)
    agency = models.ForeignKey(Agency, related_name='listings')

    listing_type = models.ForeignKey(ListingType, related_name='listings', null=True, blank=True)

    description = models.CharField(max_length=8192, null=True, blank=True)

    launch_url = models.CharField(
        max_length=constants.MAX_URL_SIZE,
        validators=[
            RegexValidator(
                regex=constants.URL_REGEX,
                message='launch_url must be a url',
                code='invalid url')
        ], null=True, blank=True
    )

    version_name = models.CharField(max_length=255, null=True, blank=True)
    # NOTE: replacing uuid with this - will need to add to the form
    unique_name = models.CharField(max_length=255, null=True, blank=True)
    small_icon = models.ForeignKey(Image, related_name='listing_small_icon', null=True, blank=True)
    large_icon = models.ForeignKey(Image, related_name='listing_large_icon', null=True, blank=True)
    banner_icon = models.ForeignKey(Image, related_name='listing_banner_icon', null=True, blank=True)
    large_banner_icon = models.ForeignKey(Image, related_name='listing_large_banner_icon', null=True, blank=True)

    what_is_new = models.CharField(max_length=255, null=True, blank=True)
    description_short = models.CharField(max_length=150, null=True, blank=True)
    usage_requirements = models.CharField(max_length=1000, null=True, blank=True)
    system_requirements = models.CharField(max_length=1000, null=True, blank=True)
    approval_status = models.CharField(max_length=255, choices=APPROVAL_STATUS_CHOICES, default=IN_PROGRESS)
    is_enabled = models.BooleanField(default=True)
    is_featured = models.BooleanField(default=False)
    is_deleted = models.BooleanField(default=False)
    is_508_compliant = models.BooleanField(default=False)
    # a weighted average (5*total_rate5 + 4*total_rate4 + ...) / total_votes
    avg_rate = models.FloatField(default=0.0)
    total_votes = models.IntegerField(default=0)
    total_rate5 = models.IntegerField(default=0)
    total_rate4 = models.IntegerField(default=0)
    total_rate3 = models.IntegerField(default=0)
    total_rate2 = models.IntegerField(default=0)
    total_rate1 = models.IntegerField(default=0)
    total_reviews = models.IntegerField(default=0)
    total_review_responses = models.IntegerField(default=0)
    feedback_score = models.IntegerField(default=0)
    iframe_compatible = models.BooleanField(default=True)

    contacts = models.ManyToManyField(Contact, related_name='listings', db_table='contact_listing')

    owners = models.ManyToManyField(Profile, related_name='owned_listings', db_table='profile_listing')

    categories = models.ManyToManyField(Category, related_name='listings', db_table='category_listing')

    tags = models.ManyToManyField(
        'Tag',
        related_name='listings',
        db_table='tag_listing'
    )

    required_listings = models.ForeignKey('self', null=True, blank=True)

    last_activity = models.OneToOneField('ListingActivity', related_name='+', null=True, blank=True)

    current_rejection = models.OneToOneField('ListingActivity', related_name='+', null=True, blank=True)

    intents = models.ManyToManyField(
        'Intent',
        related_name='listings',
        db_table='intent_listing'
    )

    security_marking = models.CharField(max_length=1024, null=True, blank=True)

    # private listings can only be viewed by members of the same agency
    is_private = models.BooleanField(default=False)

    # user's outside the marketplace can find and access
    is_exportable = models.BooleanField(default=False)

    objects = AccessControlListingManager()

    def _is_bookmarked(self):
        return False

    def _feedback(self):
        return 0

    is_bookmarked = property(_is_bookmarked)
    feedback = property(_feedback)

    def __repr__(self):
        listing_name = None

        if self.unique_name:
            listing_name = self.unique_name
        elif self.title:
            listing_name = self.title.lower().replace(' ', '_')

        return '({0!s}-{1!s})'.format(listing_name, [owner.username for owner in self.owners.all()])

    def __str__(self):
        return self.__repr__()


@receiver(post_save, sender=Listing)
def post_save_listing(sender, instance, created, **kwargs):
    cache.delete_pattern("storefront-*")
    cache.delete_pattern("library_self-*")


@receiver(post_delete, sender=Listing)
def post_delete_listing(sender, instance, **kwargs):
    # TODO: When logic is in place to delete, make sure elasticsearch logic is here
    cache.delete_pattern("storefront-*")
    cache.delete_pattern("library_self-*")
