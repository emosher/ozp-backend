import logging

from django.core.exceptions import ValidationError
from django.core.validators import MaxValueValidator
from django.core.validators import MinValueValidator
from django.db import models

from ozpcenter import constants
from ozpcenter import utils
from .external_model import ExternalModel
from .listing import Listing
from .profile import Profile

logger = logging.getLogger('ozp-center.' + str(__name__))


class AccessControlReviewManager(models.Manager):
    """
    Use a custom manager to control access to Reviews
    """

    def apply_select_related(self, queryset):
        queryset = queryset.select_related('listing')
        queryset = queryset.select_related('listing__agency')
        queryset = queryset.select_related('listing__listing_type')
        queryset = queryset.select_related('listing__small_icon')
        queryset = queryset.select_related('listing__large_icon')
        queryset = queryset.select_related('listing__banner_icon')
        queryset = queryset.select_related('listing__large_banner_icon')
        queryset = queryset.select_related('listing__required_listings')
        queryset = queryset.select_related('listing__last_activity')
        queryset = queryset.select_related('listing__current_rejection')

        queryset = queryset.select_related('author')
        queryset = queryset.select_related('author__user')

        queryset = queryset.select_related('review_parent')

        return queryset

    def get_queryset(self):
        queryset = super(AccessControlReviewManager, self).get_queryset()
        return self.apply_select_related(queryset)

    def get_base_queryset(self):
        return super().get_queryset()

    def for_user(self, username):
        # get all reviews
        all_reviews = super(AccessControlReviewManager, self).get_queryset()
        # get all listings for this user
        listings = Listing.objects.for_user(username)

        # filter out reviews for listings this user cannot see
        filtered_reviews = all_reviews.filter(listing__in=listings)

        return filtered_reviews


class Review(ExternalModel):
    """
    A Review made on a Listing
    """
    review_parent = models.ForeignKey('self', null=True, blank=True)

    text = models.CharField(max_length=constants.MAX_VALUE_LENGTH, blank=True, null=True)
    rate = models.IntegerField(
        validators=[MinValueValidator(1),
                    MaxValueValidator(5)]
    )
    listing = models.ForeignKey(Listing, related_name='reviews')
    author = models.ForeignKey(Profile, related_name='reviews')

    # TODO: change this back after the database migration
    # edited_date = models.DateTimeField(auto_now=True)
    edited_date = models.DateTimeField(default=utils.get_now_utc)
    created_date = models.DateTimeField(default=utils.get_now_utc)

    objects = AccessControlReviewManager()

    def validate_unique(self, exclude=None):
        if self.is_external:
            super(Review, self).validate_unique(exclude)
            return

        queryset = Review.objects.filter(author=self.author, listing=self.listing)
        self_id = self.pk  # If None: it means it is a new review

        if self_id:
            queryset = queryset.exclude(id=self_id)

        if self.review_parent is None:
            queryset = queryset.filter(review_parent__isnull=True, author=self.author)

            if queryset.count() >= 1:
                raise ValidationError('Can not create duplicate review')

        super(Review, self).validate_unique(exclude)

    def save(self, *args, **kwargs):
        self.validate_unique()  # TODO: Figure why when review_parent, pre overwritten validate_unique does not work
        super(Review, self).save(*args, **kwargs)

    def __repr__(self):
        return '[{0!s}] rate: [{1:d}] text:[{2!s}] parent: [{3!s}]'.format(self.author.user.username,
                                                                           self.rate, self.text, self.review_parent)

    def __str__(self):
        return '[{0!s}] rate: [{1:d}] text:[{2!s}] parent: [{3!s}]'.format(self.author.user.username,
                                                                           self.rate, self.text, self.review_parent)
