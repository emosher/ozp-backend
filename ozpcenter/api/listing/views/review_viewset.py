import logging

from django.shortcuts import get_object_or_404
from rest_framework import filters
from rest_framework import status
from rest_framework import viewsets
from rest_framework.response import Response

import ozpcenter.api.listing.model_access as model_access
import ozpcenter.api.listing.serializers as serializers
from ozpcenter import errors
from ozpcenter import pagination
from ozpcenter import permissions

logger = logging.getLogger('ozp-center.' + str(__name__))


class ReviewViewSet(viewsets.ModelViewSet):
    """
    Reviews for a given listing

    The unique_together contraints on models.Review make it difficult to
    use the standard Serializer classes (see the Note here:
        http://www.django-rest-framework.org/api-guide/serializers/#specifying-read-only-fields)

    Primarily for that reason, we forgo using Serializers for POST and PUT
    actions

    ModelViewSet for getting all Reviews for a given listing

    Access Control
    ===============
    - All users can view

    URIs
    ======
    GET /api/listing/{pk}/review
    Summary:
        Find a Review Entry by ID
    Response:
        200 - Successful operation - ReviewSerializer

    DELETE /api/listing/{pk}/review
    Summary:
        Delete a Review Entry by ID
    """
    permission_classes = (permissions.IsUser,)
    serializer_class = serializers.ReviewSerializer
    filter_backends = (filters.OrderingFilter,)
    pagination_class = pagination.ReviewLimitOffsetPagination

    ordering_fields = ('id', 'listing', 'text', 'rate', 'edited_date', 'created_date')
    ordering = ('-created_date')

    def get_queryset(self):
        return model_access.get_reviews(self.request.user.username)

    def list(self, request, listing_pk=None):
        queryset = self.get_queryset().filter(listing=listing_pk, review_parent__isnull=True)
        queryset = self.filter_queryset(queryset)
        # it appears that because we override the queryset here, we must
        # manually invoke the pagination methods
        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = serializers.ReviewSerializer(page, context={'request': request}, many=True)
            return self.get_paginated_response(serializer.data)
        serializer = serializers.ReviewSerializer(queryset, many=True, context={'request': request})
        return Response(serializer.data)

    def retrieve(self, request, pk=None, listing_pk=None):
        queryset = self.get_queryset().get(pk=pk, listing=listing_pk)
        serializer = serializers.ReviewSerializer(queryset, context={'request': request})
        return Response(serializer.data)

    def create(self, request, listing_pk=None):
        """
        Create a new review
        """
        listing = model_access.get_listing_by_id(request.user.username, listing_pk, True)

        serializer = serializers.ReviewSerializer(data=request.data, context={'request': request, 'listing': listing},
                                                  partial=True)
        if not serializer.is_valid():
            logger.error('{0!s}'.format(serializer.errors), extra={'request': request})
            raise errors.ValidationException('{0}'.format(serializer.errors))

        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)

    def update(self, request, pk=None, listing_pk=None):
        """
        Update an existing review
        """
        listing = model_access.get_listing_by_id(request.user.username, listing_pk, True)
        review = model_access.get_review_by_id(pk)

        serializer = serializers.ReviewSerializer(review, data=request.data,
                                                  context={'request': request, 'listing': listing}, partial=True)
        if not serializer.is_valid():
            logger.error('{0!s}'.format(serializer.errors), extra={'request': request})
            raise errors.ValidationException('{0}'.format(serializer.errors))

        serializer.save()
        return Response(serializer.data, status=status.HTTP_200_OK)

    def destroy(self, request, pk=None, listing_pk=None):
        queryset = self.get_queryset()
        review = get_object_or_404(queryset, pk=pk)
        model_access.delete_listing_review(request.user.username, review)
        return Response(status=status.HTTP_204_NO_CONTENT)
