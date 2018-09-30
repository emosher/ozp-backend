from django.core.cache import cache
from django.db import models
from django.db.models.signals import post_delete
from django.db.models.signals import post_save
from django.dispatch import receiver

from .external_model import ExternalModel
from .image import Image


class Agency(ExternalModel):
    """
    Agency (like of the three letter variety)

    TODO: Auditing for create, update, delete
    """
    title = models.CharField(max_length=255)
    icon = models.ForeignKey(Image, related_name='agency', null=True, blank=True)
    short_name = models.CharField(max_length=32)

    def __repr__(self):
        return self.title

    def __str__(self):
        return self.title

    class Meta:
        verbose_name_plural = "agencies"


@receiver(post_save, sender=Agency)
def post_save_agency(sender, instance, created, **kwargs):
    cache.delete_pattern('metadata-*')


@receiver(post_delete, sender=Agency)
def post_delete_agency(sender, instance, **kwargs):
    cache.delete_pattern('metadata-*')
