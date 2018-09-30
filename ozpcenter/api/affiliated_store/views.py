from rest_framework import filters
from rest_framework import viewsets

from ozpcenter.models import AffiliatedStore
from ozpcenter.permissions import IsAppsMallStewardOrReadOnly
from .serializers import AffiliatedStorePOSTSerializer
from .serializers import AffiliatedStoreSerializer


class AffiliatedStoreViewSet(viewsets.ModelViewSet):
    queryset = AffiliatedStore.objects.find_all()

    serializer_class = AffiliatedStoreSerializer

    permission_classes = (IsAppsMallStewardOrReadOnly,)

    filter_backends = (filters.OrderingFilter,)

    ordering = ('id',)

    def get_serializer_class(self):
        if self.request.method in ('POST', 'PUT'):
            return AffiliatedStorePOSTSerializer
        else:
            return self.serializer_class
