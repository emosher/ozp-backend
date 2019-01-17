from django.db import models

from ozpcenter import constants
from .external_model import ExternalModel


class ChangeDetail(ExternalModel):
    """
    A change made to a field of a Listing

    Every time a Listing is modified, a ChangeDetail is created for each field
    that was modified

    Additional db.relationships:
        * ListingActivity (ManyToMany)
    """
    field_name = models.CharField(max_length=255)
    old_value = models.CharField(max_length=constants.MAX_VALUE_LENGTH,
                                 blank=True, null=True)
    new_value = models.CharField(max_length=constants.MAX_VALUE_LENGTH,
                                 blank=True, null=True)

    def __repr__(self):
        return "id:{0:d} field {1!s} was {2!s} now is {3!s}".format(
            self.id, self.field_name, self.old_value, self.new_value)
