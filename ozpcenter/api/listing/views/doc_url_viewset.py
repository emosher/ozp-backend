import logging

from rest_framework import viewsets

import ozpcenter.api.listing.model_access as model_access
import ozpcenter.api.listing.serializers as serializers
from ozpcenter import permissions

logger = logging.getLogger('ozp-center.' + str(__name__))


class DocUrlViewSet(viewsets.ModelViewSet):
    """
    TODO: Remove?
    """
    permission_classes = (permissions.IsUser,)
    queryset = model_access.get_all_doc_urls()
    serializer_class = serializers.DocUrlSerializer
