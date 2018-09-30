import logging

from django.db.models import Min
from django.db.models.functions import Lower
from rest_framework import viewsets
from rest_framework.response import Response

import ozpcenter.api.listing.model_access as model_access
import ozpcenter.api.listing.serializers as serializers
from ozpcenter import permissions
from ozpcenter.pipe import pipeline
from ozpcenter.pipe import pipes
from ozpcenter.recommend import recommend_utils

logger = logging.getLogger('ozp-center.' + str(__name__))


class SimilarViewSet(viewsets.ModelViewSet):
    """
    Similar Apps for a given listing

    # TODO (Rivera 2017-2-22) Implement Similar Listing Algorithm

    Primarily for that reason, we forgo using Serializers for POST and PUT
    actions

    ModelViewSet for getting all Similar Apps for a given listing

    Access Control
    ===============
    - All users can view

    URIs
    ======
    GET /api/listing/{pk}/similar
    Summary:
        Find a Similar App Entry by ID
    Response:
        200 - Successful operation - ListingSerializer
    """
    permission_classes = (permissions.IsUser,)
    serializer_class = serializers.ListingSerializer

    # pagination_class = pagination.StandardPagination

    def get_queryset(self, listing_pk):
        approval_status = self.request.query_params.get('approval_status', None)
        # org = self.request.query_params.get('org', None)
        orgs = self.request.query_params.getlist('org', False)
        enabled = self.request.query_params.get('enabled', None)
        ordering = self.request.query_params.getlist('ordering', None)
        if enabled:
            enabled = enabled.lower()
            if enabled in ['true', '1']:
                enabled = True
            else:
                enabled = False

        listings = model_access.get_similar_listings(self.request.user.username, listing_pk)

        if approval_status:
            listings = listings.filter(approval_status=approval_status)
        if orgs:
            listings = listings.filter(agency__title__in=orgs)
        if enabled is not None:
            listings = listings.filter(is_enabled=enabled)
        # have to handle this case manually because the ordering includes an app multiple times
        # if there are multiple owners. We instead do sorting by case insensitive compare of the
        # app owner that comes first alphabetically
        param = [s for s in ordering if 'owners__display_name' == s or '-owners__display_name' == s]
        if ordering is not None and param:
            orderby = 'min'
            if param[0].startswith('-'):
                orderby = '-min'
            listings = listings.annotate(min=Min(Lower('owners__display_name'))).order_by(orderby)
            self.ordering = None
        return listings

    def list(self, request, listing_pk=None):
        queryset = self.filter_queryset(self.get_queryset(listing_pk))
        serializer = serializers.ListingSerializer(queryset, context={'request': request}, many=True)

        similar_listings = pipeline.Pipeline(recommend_utils.ListIterator(serializer.data),
                                             [pipes.ListingDictPostSecurityMarkingCheckPipe(self.request.user.username),
                                              pipes.LimitPipe(10)]).to_list()
        return Response(similar_listings)
