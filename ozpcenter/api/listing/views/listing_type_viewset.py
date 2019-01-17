import logging

from django.shortcuts import get_object_or_404
from rest_framework import status
from rest_framework import viewsets
from rest_framework.response import Response

import ozpcenter.api.listing.model_access as model_access
import ozpcenter.api.listing.serializers as serializers
from ozpcenter import errors
from ozpcenter import permissions

logger = logging.getLogger('ozp-center.' + str(__name__))


class ListingTypeViewSet(viewsets.ModelViewSet):
    """
    Listing Types

    ModelViewSet for getting all Listing Types for a given listing

    Access Control
    ===============
    - All users can view
    - Only AppsMallSteward can CUD

    URIs
    ======
    GET /api/listingtype
    Summary:
        Get a list of all system-wide ListingType entries
    Response:
        200 - Successful operation - [ListingTypeSerializer]

    POST /api/listingtype
    Summary:
        Add a ListingType
    Request:
        data: ListingTypeSerializer Schema
    Response:
        200 - Successful operation - ListingTypeSerializer

    GET /api/listingtype/{pk}
    Summary:
        Find a ListingType Entry by ID
    Response:
        200 - Successful operation - ListingTypeSerializer

    PUT /api/listingtype/{pk}
    Summary:
        Update a ListingType Entry by ID

    PATCH /api/listingtype/{pk}
    Summary:
        Update (Partial) a ListingType Entry by ID

    DELETE /api/listingtype/{pk}
    Summary:
        Delete a ListingType Entry by ID
    If there are associated listings
        payload = {
            "delete_associated_listings": true
        }
    This will DELETE all associated listings
    """
    permission_classes = (permissions.IsAppsMallStewardOrReadOnly,)
    queryset = model_access.get_all_listing_types()
    serializer_class = serializers.ListingTypeSerializer

    def get_serializer_class(self):
        if self.request.method in ('POST', 'PUT'):
            return serializers.ListingTypePOSTSerializer
        else:
            return self.serializer_class

    def destroy(self, request, pk=None):
        """
        Delete a listing type
        """
        queryset = self.get_queryset()
        listing_type = get_object_or_404(queryset, pk=pk)
        associated_listings = model_access.get_associated_listings_by_listing_type(listing_type)
        if associated_listings:
            delete_associated_listings = request.data[
                'delete_associated_listings'] if 'delete_associated_listings' in request.data else None
            if delete_associated_listings != True:
                raise errors.InvalidInput(
                    "delete_associated_listings field (boolean=true) required when listings are associated with the listing_type you are trying to delete.")
        model_access.delete_listing_type(listing_type)
        return Response(status=status.HTTP_204_NO_CONTENT)
