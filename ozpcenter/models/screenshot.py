from django.db import models

from .external_model import ExternalModel
from .image import Image
from .listing import Listing


class ScreenshotManager(models.Manager):
    """
    Screenshot Manager
    """

    def apply_select_related(self, queryset):
        queryset = queryset.select_related('small_image')
        queryset = queryset.select_related('large_image')
        queryset = queryset.select_related('listing')
        return queryset

    def get_queryset(self):
        queryset = super(ScreenshotManager, self).get_queryset()
        return self.apply_select_related(queryset)

    def get_base_queryset(self):
        return super().get_queryset()


class Screenshot(ExternalModel):
    """
    A screenshot for a Listing

    TODO: Auditing for create, update, delete

    Additional db.relationships:
        * listing
    """
    order = models.IntegerField(default=0, null=True)
    small_image = models.ForeignKey(Image, related_name='screenshot_small')
    large_image = models.ForeignKey(Image, related_name='screenshot_large')
    listing = models.ForeignKey(Listing, related_name='screenshots')
    description = models.CharField(max_length=160, null=True, blank=True)
    objects = ScreenshotManager()

    def __repr__(self):
        return '{0!s}: {1!s}, {2!s}'.format(self.listing.title, self.large_image.id, self.small_image.id)

    def __str__(self):
        return '{0!s}: {1!s}, {2!s}'.format(self.listing.title, self.large_image.id, self.small_image.id)
