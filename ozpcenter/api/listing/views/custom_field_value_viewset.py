import logging

from rest_framework import filters
from rest_framework import status
from rest_framework import viewsets
from rest_framework.response import Response

import ozpcenter.api.listing.model_access as model_access
import ozpcenter.api.listing.serializers as serializers
from ozpcenter import errors
from ozpcenter import permissions
from ozpcenter.models import CustomFieldValue

logger = logging.getLogger('ozp-center.' + str(__name__))


class CustomFieldValueViewSet(viewsets.ModelViewSet):
    queryset = model_access.get_all_custom_field_values()

    serializer_class = serializers.CustomFieldValueSerializer

    permission_classes = (permissions.IsUser,)

    filter_backends = (filters.OrderingFilter,)

    ordering = 'id'

    def create(self, request, listing_pk=None):
        listing = model_access.get_listing_by_id(request.user.username, listing_pk, True)
        if model_access.is_listing_owner_or_admin(request.user.username, listing):
            serializer = serializers.CustomFieldValueSerializer(data=request.data,
                                                                context={'request': request, 'listing': listing})

            if not serializer.is_valid():
                logger.error('{0!s}'.format(serializer.errors), extra={'request': request})
                raise errors.ValidationException('{0}'.format(serializer.errors))

            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response(status=status.HTTP_403_FORBIDDEN)

    def update(self, request, pk=None, listing_pk=None):
        """
        Update an existing review
        """
        listing = model_access.get_listing_by_id(request.user.username, listing_pk, True)
        custom_field = model_access.get_custom_field_value_by_id(pk)
        if model_access.is_listing_owner_or_admin(request.user.username, listing):
            serializer = serializers.CustomFieldValueSerializer(custom_field, data=request.data,
                                                                context={'request': request, 'listing': listing},
                                                                partial=True)

            if not serializer.is_valid():
                logger.error('{0!s}'.format(serializer.errors), extra={'request': request})
                raise errors.ValidationException('{0}'.format(serializer.errors))

            serializer.save()
            return Response(serializer.data, status=status.HTTP_200_OK)

        else:
            return Response(status=status.HTTP_403_FORBIDDEN)

    def destroy(self, request, listing_pk=None, pk=None):
        listing = model_access.get_listing_by_id(request.user.username, listing_pk, True)
        custom_field = model_access.get_custom_field_value_by_id(pk)

        if custom_field is None:
            return Response(status=status.HTTP_404_NOT_FOUND)

        if model_access.is_listing_owner_or_admin(request.user.username, listing):
            custom_field.delete()
            return Response(status=status.HTTP_204_NO_CONTENT)
