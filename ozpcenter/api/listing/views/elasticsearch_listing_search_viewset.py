import logging

from rest_framework import status
from rest_framework import viewsets
from rest_framework.decorators import list_route
from rest_framework.response import Response

import ozpcenter.api.listing.model_access_es as model_access_es
from ozpcenter import errors
from ozpcenter import permissions

logger = logging.getLogger('ozp-center.' + str(__name__))


class ElasticsearchListingSearchViewSet(viewsets.ViewSet):
    """
    Elasticsearch Listing Search Viewset

    It must support pagination. offset, limit

    GET /api/listings/essearch/?search=6&offset=0&limit=24 HTTP/1.1
    GET /api/listings/essearch/?search=6&offset=0&limit=24 HTTP/1.1

    GET api/listings/essearch/?search=6&offset=0&category=Education&limit=24&type=web+application&agency=Minitrue&agency=Miniluv&minscore=0.4

    ModelViewSet for searching all Listings with Elasticsearch

    Access Control
    ===============
    - All users can view

    URIs
    ======
    GET /api/listings/essearch
    """
    permission_classes = (permissions.IsUser,)

    def list(self, request):
        current_request_username = request.user.username
        params_obj = model_access_es.SearchParamParser(request)

        results = model_access_es.search(current_request_username, params_obj)
        return Response(results, status=status.HTTP_200_OK)

    @list_route(methods=['get'], permission_classes=[permissions.IsUser])
    def suggest(self, request):
        current_request_username = request.user.username
        params_obj = model_access_es.SearchParamParser(self.request)

        results = model_access_es.suggest(current_request_username, params_obj)
        return Response(results, status=status.HTTP_200_OK)

    def create(self, request):
        """
        This method is not supported
        """
        raise errors.NotImplemented('HTTP Verb Not Supported')

    def retrieve(self, request, pk=None):
        """
        This method is not supported
        """
        raise errors.NotImplemented('HTTP Verb Not Supported')

    def update(self, request, pk=None):
        """
        This method is not supported
        """
        raise errors.NotImplemented('HTTP Verb Not Supported')

    def partial_update(self, request, pk=None):
        """
        This method is not supported
        """
        raise errors.NotImplemented('HTTP Verb Not Supported')

    def destroy(self, request, pk=None):
        """
        This method is not supported
        """
        raise errors.NotImplemented('HTTP Verb Not Supported')
