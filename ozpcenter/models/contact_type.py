from django.core.cache import cache
from django.db import models
from django.db.models.signals import post_delete
from django.db.models.signals import post_save
from django.dispatch import receiver

from .external_model import ExternalModel


class ContactType(ExternalModel):
    """
    Contact Type
    Examples: TechnicalPOC, GovieGuy, etc

    TODO: Auditing for create, update, delete
    """
    name = models.CharField(max_length=50)
    required = models.BooleanField(default=False)

    def __repr__(self):
        return self.name


@receiver(post_save, sender=ContactType)
def post_save_contact_types(sender, instance, created, **kwargs):
    cache.delete_pattern('metadata-*')


@receiver(post_delete, sender=ContactType)
def post_delete_contact_types(sender, instance, **kwargs):
    cache.delete_pattern('metadata-*')
