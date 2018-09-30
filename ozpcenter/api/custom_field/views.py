from rest_framework import filters
from rest_framework import viewsets

from ozpcenter import permissions
from .serializers import CustomFieldSerializer, CustomFieldPOSTSerializer
from ozpcenter.models import CustomField


class CustomFieldViewSet(viewsets.ModelViewSet):
    queryset = CustomField.objects.find_all()

    serializer_class = CustomFieldSerializer

    permission_classes = (permissions.IsAppsMallStewardOrReadOnly,)

    filter_backends = (filters.OrderingFilter,)

    ordering = ('display_name', 'id')

    def get_serializer_class(self):
        if self.request.method in ('POST', 'PUT'):
            return CustomFieldPOSTSerializer
        else:
            return self.serializer_class