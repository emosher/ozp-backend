import logging

from rest_framework import filters
from rest_framework import viewsets

import ozpcenter.api.listing.model_access as model_access
import ozpcenter.api.listing.serializers as serializers
from ozpcenter import permissions

logger = logging.getLogger('ozp-center.' + str(__name__))


class ListingSearchViewSet(viewsets.ModelViewSet):
    """
    Search for listings

    ModelViewSet for getting all Listing Searches

    Access Control
    ===============
    - All users can view

    URIs
    ======
    GET /api/listings/search
    Summary:
        Get a list of all system-wide Listing Search entries
    Response:
        200 - Successful operation - [ListingSerializer]

    GET /api/listings/search/{pk}
    Summary:
        Find a ListingSearchViewSet Entry by ID
    Response:
        200 - Successful operation - ListingSerializer
    """

    permission_classes = (permissions.IsUser,)
    serializer_class = serializers.ListingSerializer
    filter_backends = (filters.SearchFilter,)
    search_fields = ('title', 'description', 'description_short', 'tags__name')

    def get_queryset(self):
        filter_params = {}
        categories = self.request.query_params.getlist('category', False)
        agencies = self.request.query_params.getlist('agency', False)
        listing_types = self.request.query_params.getlist('type', False)
        exportable = self.request.query_params.get('exportable', False)

        if categories:
            filter_params['categories'] = categories
        if agencies:
            filter_params['agencies'] = agencies
        if listing_types:
            filter_params['listing_types'] = listing_types
        if exportable:
            filter_params['exportable'] = exportable

        return model_access.filter_listings(self.request.user.username,
                                            filter_params)

    def list(self, request):
        """
        ---
        # YAML (must be separated by `---`)

        omit_serializer: false

        parameters:
            - name: search
              description: Text to search
              paramType: query
            - name: category
              description: List of category names (AND logic)
              required: false
              paramType: query
              allowMultiple: true
            - name: agency
              description: List of agencies
              paramType: query
            - name: type
              description: List of application types
              paramType: query
            - name: limit
              description: Max number of listings to retrieve
              paramType: query
            - name: offset
              description: Offset
              paramType: query

        responseMessages:
            - code: 401
              message: Not authenticated
        """
        return super(ListingSearchViewSet, self).list(self, request)
