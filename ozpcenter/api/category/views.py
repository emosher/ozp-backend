"""
Category Views
"""
import logging

from django.shortcuts import get_object_or_404
from rest_framework import viewsets
from rest_framework import status
from rest_framework.response import Response

from ozpcenter.errors import PermissionDenied
from ozpcenter import permissions

import ozpcenter.api.category.model_access as model_access
import ozpcenter.api.category.serializers as serializers
from ozpcenter.models import Listing
from ozpcenter import errors


logger = logging.getLogger('ozp-center.' + str(__name__))


class CategoryViewSet(viewsets.ModelViewSet):
    """
    ModelViewSet for getting all category entries for all users

    Access Control
    ===============
    - All users can read
    - AppMallSteward can view

    URIs
    ======
    GET /api/category
    Summary:
        Get a list of all system-wide categories

    Response:
        200 - Successful operation - [CategorySerializer]

    POST /api/category/
    Summary:
        Add an category
    Request:
        data: CategorySerializer Schema
    Response:
        200 - Successful operation - CategorySerializer

    GET /api/category/{pk}
    Summary:
        Find an category Entry by ID
    Response:
        200 - Successful operation - CategorySerializer

    PUT /api/category/{pk}
    Summary:
        Update an category Entry by ID

    PATCH /api/category/{pk}
    Summary:
        Update (Partial) an category Entry by ID

    DELETE /api/category/{pk}
    Summary:
        Delete an category Entry by ID
    """
    queryset = model_access.get_all_categories()
    serializer_class = serializers.CategorySerializer
    filter_fields = ('title',)
    permission_classes = (permissions.IsAppsMallStewardOrReadOnly,)

    def destroy(self, request, pk=None):
        """
        Validate to make sure that no listing has this category
        If it does then raise exception with number of listing that has this category
        """
        queryset = self.get_queryset()
        category = get_object_or_404(queryset, pk=pk)

        category_listing_count = Listing.objects.filter(categories__in=[category]).count()

        if category_listing_count >= 1:
            raise PermissionDenied('Cannot delete category {}, {} listings use this category'.format(category.title, category_listing_count))

        category.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)


class BulkCategoryListingViewSet(viewsets.ModelViewSet):
    permission_classes = (permissions.IsUser,)
    serializer_class = serializers.CategoryListingSerializer

    def get_queryset(self):
        return

    def list(self, request, category_pk=None):
        """
        Get a list of listings for that category
        """
        queryset = model_access.get_listing_by_category_id(request.user.profile, category_pk)
        serializer = serializers.CategoryListingSerializer(queryset, context={'request': request}, many=True)

        return Response(serializer.data)

    def create(self, request, category_pk=None):
        """
        ModelViewSet for Bulk Update (Post)

        [
            {
                "id": 7,
                "categories": [
                    {
                        "title": "Business",
                    },
                    {
                        "title": "Finance",
                    }
                ]
            },
            {
                "id": 65,
                "categories": [
                    {
                        "title": "Finance",
                    }
                ]
            }
        ]
        """
        serializer = serializers.CreateCategoryListingSerializer(data=request.data, context={'request': request}, many=True)

        if not serializer.is_valid():
            raise errors.ValidationException('{0}'.format(serializer.errors))

        serializer.save()

        return Response(serializer.data, status=status.HTTP_201_CREATED)

    def retrieve(self, request, category_pk=None, pk=None):
        """
        This method is not supported
        """
        raise errors.NotImplemented('HTTP Verb Not Supported')

    def update(self, request, category_pk=None, pk=None):
        """
        This method is not supported
        """
        raise errors.NotImplemented('HTTP Verb Not Supported')

    def partial_update(self, request, category_pk=None, pk=None):
        """
        This method is not supported
        """
        raise errors.NotImplemented('HTTP Verb Not Supported')

    def destroy(self, request, category_pk=None, pk=None):
        """
        This method is not supported
        """
        raise errors.NotImplemented('HTTP Verb Not Supported')
