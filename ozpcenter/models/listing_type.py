from django.core.cache import cache
from django.db import models
from django.db.models.signals import post_delete
from django.db.models.signals import post_save
from django.dispatch import receiver

from .external_model import ExternalModel


class ListingType(ExternalModel):
    """
    The type of a Listing
    In NextGen OZP, only two listing types are supported: web apps and widgets
    TODO: Auditing for create, update, delete
    """
    title = models.CharField(max_length=50)
    description = models.CharField(max_length=255)
    custom_fields = models.ManyToManyField('CustomField',
                                           related_name='custom_listing_field',
                                           db_table='listing_type_custom_field',
                                           blank=True)

    def __repr__(self):
        return self.title

    def __str__(self):
        return self.title


@receiver(post_save, sender=ListingType)
def post_save_listing_types(sender, instance, created, **kwargs):
    cache.delete_pattern('metadata-*')


@receiver(post_delete, sender=ListingType)
def post_delete_listing_types(sender, instance, **kwargs):
    cache.delete_pattern('metadata-*')
