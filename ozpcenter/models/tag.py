from django.db import models

from .external_model import ExternalModel


class Tag(ExternalModel):
    """
    Tag name (for a listing)

    TODO: this will work differently than legacy
    """
    name = models.CharField(max_length=30, unique=True)

    def __repr__(self):
        return self.name

    def __str__(self):
        return self.name
