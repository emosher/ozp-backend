import logging

from rest_framework import viewsets
from rest_framework.response import Response

import ozpcenter.api.listing.model_access as model_access
import ozpcenter.api.listing.serializers as serializers
from ozpcenter import permissions

logger = logging.getLogger('ozp-center.' + str(__name__))


class ListingUserActivitiesViewSet(viewsets.ModelViewSet):
    """
    ListingUserActivitiesViewSet endpoints are read-only

    ModelViewSet for getting all Listing User Activities for a given listing

    Access Control
    ===============
    - All users can view

    URIs
    ======
    GET /api/self/listings/activity
    Summary:
        Get a list of all system-wide ListingUserActivities entries
    Response:
        200 - Successful operation - [ListingActivitySerializer]

    GET /api/self/listings/activity/{pk}
    Summary:
        Find a Listing User Activity Entry by ID
    Response:
        200 - Successful operation - ListingActivitySerializer
    """

    permission_classes = (permissions.IsUser,)
    serializer_class = serializers.ListingActivitySerializer

    def get_queryset(self):
        return model_access.get_listing_activities_for_user(
            self.request.user.username)

    def list(self, request):
        queryset = self.get_queryset()
        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = serializers.ListingActivitySerializer(page,
                                                               context={'request': request}, many=True)
            return self.get_paginated_response(serializer.data)
        serializer = serializers.ListingActivitySerializer(queryset,
                                                           context={'request': request}, many=True)
        return Response(serializer.data)
