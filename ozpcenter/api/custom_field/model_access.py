import logging
from typing import Optional

from django.db.models import QuerySet

from ozpcenter.models import CustomField

logger = logging.getLogger('ozp-center.' + str(__name__))


def get_all_custom_fields():
    return CustomField.objects.all()


def get_custom_field_by_id(id, reraise=False):
    try:
        return CustomField.objects.get(id=id)
    except CustomField.DoesNotExist as err:
        if reraise:
            raise err
        return None