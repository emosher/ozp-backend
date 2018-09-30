from django.db import models

from .external_model import ExternalModel


class CustomFieldType(ExternalModel):
    """
    Custom Field Type

    Defines the what kind of field a Custom Field will represent
    """

    class Meta:
        db_table = 'custom_field_type'

    name = models.CharField(max_length=50)
    display_name = models.CharField(max_length=50)
    media_type = models.CharField(max_length=255)
    options = models.CharField(max_length=4000, null=True, blank=True)

    def __repr__(self):
        return self.display_name

    def __str__(self):
        return self.display_name
