import logging
from typing import Optional

from django.db.models import QuerySet

from ozpcenter.models import CustomFieldType

logger = logging.getLogger('ozp-center.' + str(__name__))


def get_all_custom_field_types():
    return CustomFieldType.objects.all()


def get_custom_field_type_by_id(id, reraise=False):
    try:
        return CustomFieldType.objects.get(id=id)
    except CustomFieldType.DoesNotExist as err:
        if reraise:
            raise err
        return None
