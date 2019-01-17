from django.db import models

from .custom_field import CustomField
from .external_model import ExternalModel
from .listing import Listing
from .image import Image


class CustomFieldValueManager(models.Manager):

    def get_queryset(self):
        return super().get_queryset()

    def find_all(self):
        return self.all()

    def find_by_id(self, id):
        return self.get(id=id)

    def find_listings_by_field_id(self, id):
        return Listing.objects.filter(custom_fields__pk=id)


class CustomFieldValue(ExternalModel):
    """
    Custom Field Value

    Defines what the value of a custom field on a specific listing is
    """

    class Meta:
        db_table = 'custom_field_value'

    objects = CustomFieldValueManager()

    listing = models.ForeignKey(Listing, related_name="custom_fields")
    custom_field = models.ForeignKey(CustomField)
    value = models.CharField(max_length=2000, blank=True, null=True)
    # listing = models.ForeignKey(Listing, related_name='custom_field_values', null=True)

    def __repr__(self):
        return self.value

    def __str__(self):
        return self.value
