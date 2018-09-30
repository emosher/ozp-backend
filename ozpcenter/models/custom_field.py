from django.db import models

from .custom_field_type import CustomFieldType
from .external_model import ExternalModel


class CustomFieldManager(models.Manager):

    def get_queryset(self):
        return super().get_queryset() \
            .select_related('type')

    def find_all(self):
        return self.all()

    def find_by_id(self, id):
        return self.get(id=id)


class CustomField(ExternalModel):
    """
    Custom Field

    Defines a Custom input Field.
    """

    class Meta:
        db_table = 'custom_field'

    objects = CustomFieldManager()

    type = models.ForeignKey(CustomFieldType, related_name="field_type")
    section = models.CharField(max_length=50)
    display_name = models.CharField(max_length=100, blank=False)
    label = models.CharField(max_length=50, blank=False)
    description = models.CharField(max_length=250)
    tooltip = models.CharField(max_length=50)
    is_required = models.BooleanField(default=False)
    admin_only = models.BooleanField(default=False)
    properties = models.CharField(max_length=4000, null=True, blank=True)
    all_listing_types = models.BooleanField(default=False)

    def __str__(self):
        return self.display_name
