import logging

from rest_framework import viewsets
from rest_framework.response import Response

import ozpcenter.api.listing.model_access as model_access
import ozpcenter.api.listing.serializers as serializers
from ozpcenter import permissions

logger = logging.getLogger('ozp-center.' + str(__name__))


class ListingActivityViewSet(viewsets.ModelViewSet):
    """
    ListingActivity endpoints are read-only

    ModelViewSet for getting all Listing Activities for a given listing

    Access Control
    ===============
    - All users can view

    URIs
    ======
    GET /api/listing/{pk}/activity
    Summary:
        Find a Listing Activity Entry by ID
    Response:
        200 - Successful operation - ListingActivitySerializer
    """
    permission_classes = (permissions.IsUser,)
    serializer_class = serializers.ListingActivitySerializer

    def get_queryset(self):
        return model_access.get_all_listing_activities(
            self.request.user.username).order_by('-activity_date')

    def list(self, request, listing_pk=None):
        queryset = self.get_queryset().filter(listing=listing_pk)
        # it appears that because we override the queryset here, we must
        # manually invoke the pagination methods
        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = serializers.ListingActivitySerializer(page,
                                                               context={'request': request}, many=True)
            return self.get_paginated_response(serializer.data)
        serializer = serializers.ListingActivitySerializer(queryset,
                                                           context={'request': request}, many=True)
        return Response(serializer.data)

    def retrieve(self, request, pk=None, listing_pk=None):
        queryset = self.get_queryset().get(pk=pk, listing=listing_pk)
        serializer = serializers.ListingActivitySerializer(queryset,
                                                           context={'request': request})
        return Response(serializer.data)
