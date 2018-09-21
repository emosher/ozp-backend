"""
Notification Views
"""
import logging

from django.shortcuts import get_object_or_404
from rest_framework import filters
from rest_framework import generics
from rest_framework import status
from rest_framework import viewsets
from rest_framework.response import Response

from ozpcenter import errors
from ozpcenter import permissions
import ozpcenter.api.notification.model_access as model_access
import ozpcenter.api.listing.model_access as model_access_listing
import ozpcenter.api.notification.serializers as serializers


logger = logging.getLogger('ozp-center.' + str(__name__))


class NotificationViewSet(viewsets.ModelViewSet):
    """
    ModelViewSet for getting all Notification entries for all users

    URIs
    ======

    GET /api/notification/
        Summary:
            Get a list of all system-wide Notification entries
        Response:
            200 - Successful operation - [NotificationSerializer]

    POST /api/notification/
        Summary:
            Add a Notification
        Request:
            data: NotificationSerializer Schema
        Response:
            200 - Successful operation - NotificationSerializer

    PUT /api/notification/{pk}
        Summary:
            Update an Notification Entry by ID

    DELETE /api/notification/{pk}
    Summary:
        Delete a Notification Entry by ID
    """

    serializer_class = serializers.NotificationSerializer
    permission_classes = (permissions.IsUser,)

    def get_queryset(self):
        queryset = model_access.get_all_notifications()

        listing_id = self.request.query_params.get('listing', None)
        if listing_id is not None:
            queryset = queryset.filter(notification_type='listing', entity_id=listing_id)

        return queryset

    def create(self, request):
        serializer = serializers.NotificationSerializer(data=request.data,
            context={'request': request}, partial=True)

        if not serializer.is_valid():
            logger.error('{0!s}'.format(serializer.errors))
            raise errors.ValidationException('{0!s}'.format(serializer.errors))

        serializer.save()

        return Response(serializer.data, status=status.HTTP_201_CREATED)

    def update(self, request, pk=None):
        """
        Update is used only change the expiration date of the message
        """
        instance = self.get_queryset().get(pk=pk)
        serializer = serializers.NotificationSerializer(instance,
            data=request.data, context={'request': request}, partial=True)

        if not serializer.is_valid():
            logger.error('{0!s}'.format(serializer.errors))
            raise errors.ValidationException('{0!s}'.format(serializer.errors))

        serializer.save()

        return Response(serializer.data, status=status.HTTP_200_OK)

    def destroy(self, request, pk=None):
        current_request_profile = model_access.get_self(request.user.username)

        if not current_request_profile.is_steward():
            raise errors.PermissionDenied('Only Stewards can delete notifications')

        queryset = self.get_queryset()
        notification_instance = get_object_or_404(queryset, pk=pk)
        notification_instance.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)


class UserNotificationViewSet(viewsets.ModelViewSet):
    """
    ModelViewSet for getting all UserNotification entries for all users

    URIs
    ======

    GET /api/self/notification/
        Summary:
            Get a list of all user Notification (NotificationMailBox) entries
        Response:
            200 - Successful operation - [NotificationMailboxSerializer]

    DELETE /api/self/notification/{pk}
    Summary:
        Delete a user Notification (NotificationMailBox) Entry by ID

    PUT /api/self/notification/{pk}
    Summary:
        Update user Notification (NotificationMailBox) Entry by ID
    """

    permission_classes = (permissions.IsUser,)
    serializer_class = serializers.NotificationMailBoxSerializer
    filter_backends = (filters.OrderingFilter,)
    ordering_fields = ('notification__created_date',)
    ordering = ('-notification__created_date',)

    def get_queryset(self):
        """
        Get current user's notifications
        """
        return model_access.get_self_notifications_mailbox(self.request.user.username)

    def destroy(self, request, pk=None):
        """
        Dismiss notification
        """
        queryset = self.get_queryset()
        notification = get_object_or_404(queryset, pk=pk)
        model_access.dismiss_notification_mailbox(notification, self.request.user.username)
        return Response(status=status.HTTP_204_NO_CONTENT)

    def update(self, request, pk=None):
        """
        Update is used only change the read_status or acknowledged_status of the NotificationMailBox
        """
        instance = self.get_queryset().get(pk=pk)
        serializer = serializers.NotificationMailBoxSerializer(instance,
            data=request.data, context={'request': request}, partial=True)

        if not serializer.is_valid():
            logger.error('{0!s}'.format(serializer.errors))
            raise errors.ValidationException('{0!s}'.format(serializer.errors))

        serializer.save()

        return Response(serializer.data, status=status.HTTP_200_OK)


class PendingNotificationView(generics.ListCreateAPIView):
    """
    APIView for getting all PendingNotification entries for all users

    URIs
    ======

    GET /api/notifications/pending/
        Summary:
            Get a list of all Pending Notification entries
        Response:
            200 - Successful operation - [NotificationSerializer]

    DELETE /api/notifications/pending/
    Summary:
        Delete a Pending Notification Entry
    """
    serializer_class = serializers.NotificationSerializer
    permission_classes = (permissions.IsUser,)

    def get_queryset(self):
        queryset = model_access.get_all_pending_notifications()
        profile = self.request.user.profile
        listing_id = self.request.query_params.get('listing', None)
        if listing_id is not None:
            listing = model_access_listing.get_listing_by_id(username=self.request.user.username, id=self.request.query_params.get('listing', None))
            if (profile in listing.owners.all()) or (profile.highest_role() in ['ORG_STEWARD', 'APPS_MALL_STEWARD']):
                queryset = queryset.filter(notification_type='listing', entity_id=listing_id)
                return queryset
        if profile.highest_role() in ['ORG_STEWARD', 'APPS_MALL_STEWARD']:
            return queryset
        return None

    def list(self, request):
        queryset = self.get_queryset()
        if queryset is None:
            return Response({'detail': 'Permission Denied'}, status=status.HTTP_403_FORBIDDEN)
        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = serializers.NotificationSerializer(page,
                context={'request': request}, many=True)
            return self.get_paginated_response(serializer.data)
        serializer = serializers.NotificationSerializer(queryset,
            context={'request': request}, many=True)
        return Response(serializer.data)


class ExpiredNotificationView(generics.ListCreateAPIView):
    """
    APIView for getting all PendingNotification entries for all users

    URIs
    ======

    GET /api/notification/expired
        Summary:
            Get a list of all Expired Notification entries
        Response:
            200 - Successful operation - [NotificationSerializer]
    """
    serializer_class = serializers.NotificationSerializer
    permission_classes = (permissions.IsUser,)

    def get_queryset(self):
        queryset = model_access.get_all_expired_notifications()
        profile = self.request.user.profile
        listing_id = self.request.query_params.get('listing', None)
        if listing_id is not None:
            listing = model_access_listing.get_listing_by_id(username=self.request.user.username, id=self.request.query_params.get('listing', None))
            if (profile in listing.owners.all()) or (profile.highest_role() in ['ORG_STEWARD', 'APPS_MALL_STEWARD']):
                queryset = queryset.filter(notification_type='listing', entity_id=listing_id)
                return queryset

        if profile.highest_role() in ['ORG_STEWARD', 'APPS_MALL_STEWARD']:
            return queryset
        return None

    def list(self, request):
        queryset = self.get_queryset()
        if queryset is None:
            return Response({'detail': 'Permission Denied'}, status=status.HTTP_403_FORBIDDEN)
        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = serializers.NotificationSerializer(page,
                context={'request': request}, many=True)
            return self.get_paginated_response(serializer.data)
        serializer = serializers.NotificationSerializer(queryset,
            context={'request': request}, many=True)
        return Response(serializer.data)
