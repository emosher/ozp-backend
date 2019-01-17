from rest_framework import filters
from rest_framework import viewsets

from ozpcenter import permissions
from ozpcenter.models import ImportTask
from ozpcenter.models import ImportTaskResult
from .serializers import ImportTaskResultSerializer
from .serializers import ImportTaskSerializer


class ImportTaskViewSet(viewsets.ModelViewSet):
    queryset = ImportTask.objects.find_all()

    serializer_class = ImportTaskSerializer

    permission_classes = (permissions.IsAppsMallSteward,)

    filter_backends = (filters.OrderingFilter,)

    ordering = ('name', 'id')


class ImportTaskResultViewSet(viewsets.ReadOnlyModelViewSet):
    serializer_class = ImportTaskResultSerializer

    permission_classes = (permissions.IsAppsMallSteward,)

    filter_backends = (filters.OrderingFilter,)

    ordering = ('run_date', 'id')

    def get_queryset(self):
        return ImportTaskResult.objects.find_all_by_import_task(self.kwargs['import_task_pk'])
