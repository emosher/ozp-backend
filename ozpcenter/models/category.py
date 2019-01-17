from django.db import models

from .external_model import ExternalModel


class Category(ExternalModel):
    """
    Categories for Listings

    TODO: Auditing for create, update, delete
    """
    title = models.CharField(max_length=50)
    description = models.CharField(max_length=500, null=True, blank=True)

    def __repr__(self):
        return self.title

    def __str__(self):
        return self.title

    class Meta:
        verbose_name_plural = "categories"
