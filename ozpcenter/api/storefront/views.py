"""
Storefront and Metadata Views for the Discovery page

These are GET only views for retrieving a) metadata (categories, organizations,
etc) and b) the apps displayed in the storefront (featured, recent, and
most popular)
"""

import logging

from rest_framework.decorators import api_view
from rest_framework.decorators import permission_classes
from rest_framework import viewsets
from rest_framework.response import Response

from ozpcenter.utils import str_to_bool
from ozpcenter import permissions
import ozpcenter.api.storefront.model_access as model_access
import ozpcenter.api.storefront.serializers as serializers


logger = logging.getLogger('ozp-center.' + str(__name__))


@api_view(['GET'])
@permission_classes((permissions.IsUser, ))
def MetadataView(request):
    """
    Metadata for the store including categories, agencies, contact types,
    intents, and listing types
    """
    request_username = request.user.username
    data = model_access.get_metadata(request_username)
    return Response(data)


class StorefrontViewSet(viewsets.ViewSet):
    """
    Access Control
    ===============
    - All users can view

    URIs
    ======
    GET /api/storefront
    Summary:
        Get the Storefront view
    Response:
        200 - Successful operation - [StorefrontSerializer]
    """
    permission_classes = (permissions.IsUser,)

    def _add_recommended_scores(self, serialized_data, extra_data, debug_recommendations):
        """
        Add Scores to recommendations
        """
        if 'recommender_profile_result_set' in extra_data:
            recommender_profile_result_set = extra_data['recommender_profile_result_set']
            listing_recommend_data = recommender_profile_result_set.listing_recommend_data

            # Add scores to recommended entries
            recommendation_serialized_list = []
            for serialized_listing in serialized_data['recommended']:
                serialized_listing['_score'] = listing_recommend_data[serialized_listing['id']]
                recommendation_serialized_list.append(serialized_listing)
            serialized_data['recommended'] = recommendation_serialized_list

            if debug_recommendations:
                serialized_data['recommended_debug'] = recommender_profile_result_set.debug_dict()

    def list(self, request):
        """
        Recommended, Featured, recent, and most popular listings
        ---
        serializer: ozpcenter.api.storefront.serializers.StorefrontSerializer
        """
        debug_recommendations = str_to_bool(request.query_params.get('debug_recommendations', False))

        data, extra_data = model_access.get_storefront(request, True)
        serializer = serializers.StorefrontSerializer(data, context={'request': request})

        serialized_data = serializer.data
        self._add_recommended_scores(serialized_data, extra_data, debug_recommendations)

        return Response(serialized_data)

    def retrieve(self, request, pk=None):
        debug_recommendations = str_to_bool(request.query_params.get('debug_recommendations', False))

        data, extra_data = model_access.get_storefront(request, True, pk)
        serializer = serializers.StorefrontSerializer(data, context={'request': request})

        serialized_data = serializer.data
        self._add_recommended_scores(serialized_data, extra_data, debug_recommendations)
        return Response(serialized_data)
