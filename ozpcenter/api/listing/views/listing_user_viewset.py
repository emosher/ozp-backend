import logging

from rest_framework import viewsets

import ozpcenter.api.listing.model_access as model_access
import ozpcenter.api.listing.serializers as serializers
from ozpcenter import permissions

logger = logging.getLogger('ozp-center.' + str(__name__))


class ListingUserViewSet(viewsets.ModelViewSet):
    """
    Listing Types

    Get all listings owned by this user

    ModelViewSet for getting all ListingUserViewSets

    Access Control
    ===============
    - All users can view

    URIs
    ======
    GET /api/self/listing
    Summary:
        Get a list of all system-wide Listing User entries
    Response:
        200 - Successful operation - [ListingSerializer]

    GET /api/self/listing/{pk}
    Summary:
        Find a ListingUserViewSet Entry by ID
    Response:
        200 - Successful operation - ListingSerializer
    """
    permission_classes = (permissions.IsUser,)
    serializer_class = serializers.ListingSerializer

    def get_queryset(self):
        return model_access.get_self_listings(self.request.user.username)

    def list(self, request):
        return super(ListingUserViewSet, self).list(self, request)
