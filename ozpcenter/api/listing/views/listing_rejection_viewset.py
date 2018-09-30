import logging

from rest_framework import status
from rest_framework import viewsets
from rest_framework.response import Response

import ozpcenter.api.listing.model_access as model_access
import ozpcenter.api.listing.serializers as serializers
import ozpcenter.model_access as generic_model_access
from ozpcenter import errors
from ozpcenter import permissions

logger = logging.getLogger('ozp-center.' + str(__name__))


class ListingRejectionViewSet(viewsets.ModelViewSet):
    """
    ModelViewSet for getting all Listing Rejections

    Access Control
    ===============
    - AppsMallSteward can view

    URIs
    ======
    POST /api/listing/{pk}/rejection
    Summary:
        Add a ListingRejection
    Request:
        data: ListingRejectionSerializer Schema
    Response:
        200 - Successful operation - ListingActivitySerializer

    GET /api/listing/{pk}/rejection
    Summary:
        Find a ListingRejection Entry by ID
    Response:
        200 - Successful operation - ListingActivitySerializer
    """

    permission_classes = (permissions.IsOrgStewardOrReadOnly,)
    serializer_class = serializers.ListingActivitySerializer

    def get_queryset(self):
        queryset = model_access.get_rejection_listings(
            self.request.user.username)
        return queryset

    def list(self, request, listing_pk=None):
        queryset = self.get_queryset().filter(listing__id=listing_pk)
        serializer = serializers.ListingActivitySerializer(queryset,
                                                           context={'request': request}, many=True)
        return Response(serializer.data)

    def create(self, request, listing_pk=None):
        try:
            user = generic_model_access.get_profile(request.user.username)
            listing = model_access.get_listing_by_id(request.user.username,
                                                     listing_pk)
            rejection_description = request.data['description']
            listing = model_access.reject_listing(user, listing,
                                                  rejection_description)
            return Response(data={"listing": {"id": listing.id}},
                            status=status.HTTP_201_CREATED)
        except Exception as e:
            logger.error('Exception: {}'.format(e), extra={'request': request})
            raise errors.RequestException('Error rejecting listing')
