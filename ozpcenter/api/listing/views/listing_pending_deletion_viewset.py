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


class ListingPendingDeletionViewSet(viewsets.ModelViewSet):
    """
    ModelViewSet for getting all Listing Pending Deletions

    Access Control
    ===============
    - All users can view

    URIs
    ======
    POST /api/listing/{pk}/pendingdeletion
    Summary:
        Add a ListingPendingDeletion
    Request:
        data: ListingPendingDeletionSerializer Schema
    Response:
        200 - Successful operation - ListingActivitySerializer

    GET /api/listing/{pk}/pendingdeletion
    Summary:
        Find a ListingPendingDeletion Entry by ID
    Response:
        200 - Successful operation - ListingActivitySerializer
    """

    permission_classes = (permissions.IsUser,)
    serializer_class = serializers.ListingActivitySerializer

    def get_queryset(self):
        queryset = model_access.get_pending_deletion_listings(
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
            description = request.data['description'] if 'description' in request.data else None
            if not description:
                raise errors.InvalidInput('Description is required when pending a listing for deletion')

            listing = model_access.pending_delete_listing(user, listing, description)
            return Response(data={"listing": {"id": listing.id}},
                            status=status.HTTP_201_CREATED)
        except Exception as e:
            logger.error('Exception: {}'.format(e), extra={'request': request})
            raise errors.RequestException('Error pending listing for deletion')
