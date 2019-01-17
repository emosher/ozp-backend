from django.core.validators import RegexValidator
from django.db import models

from ozpcenter import constants
from .external_model import ExternalModel
from .listing import Listing


class DocUrlManager(models.Manager):
    """
    DocUrl Manager
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
        return queryset

    def get_queryset(self):
        queryset = super(DocUrlManager, self).get_queryset()
        return self.apply_select_related(queryset)


class DocUrl(ExternalModel):
    """
    A documentation link that belongs to a Listing

    TODO: unique_together constraint on name and url
    """
    name = models.CharField(max_length=255)
    url = models.CharField(
        max_length=constants.MAX_URL_SIZE,
        validators=[
            RegexValidator(
                regex=constants.URL_REGEX,
                message='url must be a url',
                code='invalid url')]
    )
    listing = models.ForeignKey(Listing, related_name='doc_urls')

    objects = DocUrlManager()

    def __repr__(self):
        return '{0!s}:{1!s}'.format(self.name, self.url)

    def __str__(self):
        return '{0!s}: {1!s}'.format(self.name, self.url)
