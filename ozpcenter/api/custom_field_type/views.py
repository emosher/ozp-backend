from rest_framework import filters
from rest_framework import viewsets

from ozpcenter import permissions
from ozpcenter.models import CustomFieldType
from .serializers import CustomFieldTypeSerializer
import ozpcenter.api.custom_field_type.model_access as model_access


class CustomFieldTypeViewSet(viewsets.ModelViewSet):
    queryset = model_access.get_all_custom_field_types()

    serializer_class = CustomFieldTypeSerializer

    permission_classes = (permissions.IsAppsMallStewardOrReadOnly,)

    filter_backends = (filters.OrderingFilter,)

    ordering = ('display_name', 'id')
