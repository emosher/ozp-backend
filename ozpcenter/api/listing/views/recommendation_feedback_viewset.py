import logging

from rest_framework import status
from rest_framework import viewsets
from rest_framework.response import Response

import ozpcenter.api.listing.model_access as model_access
import ozpcenter.api.listing.serializers as serializers
from ozpcenter import errors
from ozpcenter import permissions

logger = logging.getLogger('ozp-center.' + str(__name__))


class RecommendationFeedbackViewSet(viewsets.ModelViewSet):
    """
    Recommendation Feedback for a given listing

    Access Control
    ===============
    - All users can view

    URIs
    ======
    GET /api/listing/{pk}/feedback
    Summary:
        Find a feedback Entry by ID
    Response:
        200 - Successful operation - ListingSerializer
    """
    permission_classes = (permissions.IsUser,)
    serializer_class = serializers.RecommendationFeedbackSerializer

    # pagination_class = pagination.StandardPagination

    def get_queryset(self, listing):
        recommendation_feedback_query = model_access.get_recommendation_feedback(self.request.user.username, listing)
        return recommendation_feedback_query

    def list(self, request, listing_pk=None):
        listing = model_access.get_listing_by_id(request.user.username, listing_pk, True)

        queryset = self.get_queryset(listing)

        if not queryset:
            return Response({'feedback': 0}, status=status.HTTP_404_NOT_FOUND)

        serializer = serializers.RecommendationFeedbackSerializer(queryset,
                                                                  context={'request': request, 'listing': listing})
        data = serializer.data
        return Response(data)

    def create(self, request, listing_pk=None):
        listing = model_access.get_listing_by_id(request.user.username, listing_pk, True)

        serializer = serializers.RecommendationFeedbackSerializer(data=request.data,
                                                                  context={'request': request, 'listing': listing})

        if not serializer.is_valid():
            logger.error('{0!s}'.format(serializer.errors), extra={'request': request})
            raise errors.ValidationException('{0}'.format(serializer.errors))

        serializer.save()

        return Response(serializer.data, status=status.HTTP_201_CREATED)

    def destroy(self, request, listing_pk=None, pk=None):
        listing = model_access.get_listing_by_id(request.user.username, listing_pk, True)
        feedback = model_access.get_recommendation_feedback(request.user.username, listing)

        if feedback is None:
            return Response(status=status.HTTP_404_NOT_FOUND)

        model_access.delete_recommendation_feedback(listing, feedback)
        return Response(status=status.HTTP_204_NO_CONTENT)
