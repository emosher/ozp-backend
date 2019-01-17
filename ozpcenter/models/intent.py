from django.core.cache import cache
from django.core.validators import RegexValidator
from django.db import models
from django.db.models.signals import post_delete
from django.db.models.signals import post_save
from django.dispatch import receiver

from ozpcenter import constants
from .external_model import ExternalModel
from .image import Image


class Intent(ExternalModel):
    """
    An Intent is an abstract description of an operation to be performed

    TODO: Auditing for create, update, delete
    """
    # TODO unique on type
    action = models.CharField(
        max_length=64,
        validators=[
            RegexValidator(
                regex=constants.INTENT_ACTION_REGEX,
                message='action must be a valid action',
                code='invalid action')]
    )
    media_type = models.CharField(
        max_length=129,
        validators=[
            RegexValidator(
                regex=constants.MEDIA_TYPE_REGEX,
                message='type must be a valid media type',
                code='invalid type')]
    )
    label = models.CharField(max_length=255)
    icon = models.ForeignKey(Image, related_name='intent')

    def __repr__(self):
        return '{0!s}/{1!s}'.format(self.media_type, self.action)

    def __str__(self):
        return self.action


@receiver(post_save, sender=Intent)
def post_save_intents(sender, instance, created, **kwargs):
    cache.delete_pattern('metadata-*')


@receiver(post_delete, sender=Intent)
def post_delete_intents(sender, instance, **kwargs):
    cache.delete_pattern('metadata-*')
