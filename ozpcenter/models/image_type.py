from django.db import models

from .external_model import ExternalModel


class ImageTypeManager(models.Manager):

    def internal_only(self):
        return self.filter(import_metadata__isnull=True)


class ImageType(ExternalModel):
    """
    Image types (as in Small Screenshot, not png)

    This data should be rather static, but is convenient to place in the DB

    listing_small_icon: 16x16
    listing_large_icon: 32x32
    listing_banner_icon: 220x137
    listing_large_banner_icon: 600x376
    listing_small_screenshot: 600x376
    listing_large_screenshot: 960x600
    """
    SMALL_ICON = 'small_icon'
    LARGE_ICON = 'large_icon'
    BANNER_ICON = 'banner_icon'
    LARGE_BANNER_ICON = 'large_banner_icon'
    SMALL_SCREENSHOT = 'small_screenshot'
    LARGE_SCREENSHOT = 'large_screenshot'
    NAME_CHOICES = (
        (SMALL_ICON, 'small_icon'),
        (LARGE_ICON, 'large_icon'),
        (BANNER_ICON, 'banner_icon'),
        (LARGE_BANNER_ICON, 'large_banner_icon'),
        (SMALL_SCREENSHOT, 'small_screenshot'),
        (LARGE_SCREENSHOT, 'large_screenshot'),
    )

    objects = ImageTypeManager()

    name = models.CharField(max_length=64, choices=NAME_CHOICES)
    max_size_bytes = models.IntegerField(default=1048576)
    max_width = models.IntegerField(default=2048)
    max_height = models.IntegerField(default=2048)
    min_width = models.IntegerField(default=16)
    min_height = models.IntegerField(default=16)

    def __repr__(self):
        return self.name

    def __str__(self):
        return self.name
