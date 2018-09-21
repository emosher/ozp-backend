import logging

from rest_framework.decorators import api_view
from rest_framework.decorators import permission_classes
from rest_framework.decorators import renderer_classes
from rest_framework import permissions
from rest_framework import renderers as rf_renderers
from rest_framework import status
from rest_framework.response import Response
from rest_framework import viewsets

import ozpcenter.model_access as model_access
import ozpcenter.api.listing.model_access as listing_model_access
import ozpcenter.api.listing.serializers as listing_serializers
import ozpiwc.hal as hal
import ozpiwc.renderers as renderers

logger = logging.getLogger('ozp-iwc.' + str(__name__))


class ApplicationViewSet(viewsets.ViewSet):
    """
    List of applications
    """
    permission_classes = (permissions.IsAuthenticated,)
    renderer_classes = (renderers.RootResourceRenderer, rf_renderers.JSONRenderer)

    def list(self, request):
        if not hal.validate_version(request.META.get('HTTP_ACCEPT')):
            return Response('Invalid version requested',
                status=status.HTTP_406_NOT_ACCEPTABLE)

        listing_root_url = hal.get_abs_url_for_iwc(request)
        profile = model_access.get_profile(request.user.username)
        data = hal.create_base_structure(request, hal.generate_content_type(
            request.accepted_media_type))
        applications = listing_model_access.get_listings(profile.user.username)
        items = []
        embedded_items = []
        for i in applications:
            item = {"href": '{0!s}listing/{1!s}/'.format(listing_root_url, i.id),
                "type": hal.generate_content_type(renderers.ApplicationResourceRenderer.media_type)}
            items.append(item)

            embedded = {'_links': {'self': item}}
            embedded['id'] = i.id
            embedded['title'] = i.title
            embedded['unique_name'] = i.unique_name

            intents = []
            for j in i.intents.all():
                intent = {'action': j.action, 'media_type': j.media_type,
                'label': j.label, 'icon_id': j.icon.id}
                intents.append(intent)

            embedded['intents'] = intents
            embedded_items.append(embedded)

        data['_links']['item'] = items
        data['_embedded']['item'] = embedded_items

        return Response(data)


class ApplicationListingViewSet(viewsets.ViewSet):
    """
    Single application
    """
    permission_classes = (permissions.IsAuthenticated,)
    renderer_classes = (renderers.RootResourceRenderer, rf_renderers.JSONRenderer)

    def retrieve(self, request, pk):
        if not hal.validate_version(request.META.get('HTTP_ACCEPT')):
            return Response('Invalid version requested',
                status=status.HTTP_406_NOT_ACCEPTABLE)

        listing_root_url = hal.get_abs_url_for_iwc(request)  # flake8: noqa TODO: Is Necessary? - Variable not being used in method
        profile = model_access.get_profile(request.user.username)

        # TODO: only include the fields that are necessary for IWC. This will also
        # allow us to sever ties with ozpcenter.api.listing.serializers

        # This minimal definition of what a Listing object must have should be
        # advertised so that others can use IWC with their own systems
        queryset = listing_model_access.get_listing_by_id(profile.user.username, pk)
        if not queryset:
            return Response(status=status.HTTP_404_NOT_FOUND)
        serializer = listing_serializers.ListingSerializer(queryset,
                context={'request': request})
        data = serializer.data
        data = hal.add_hal_structure(data, request, hal.generate_content_type(
            request.accepted_media_type))

        return Response(data)


class SystemViewSet(viewsets.ViewSet):
    """
    System view - TODO
    """
    permission_classes = (permissions.IsAuthenticated,)
    renderer_classes = (renderers.RootResourceRenderer, rf_renderers.JSONRenderer)

    def list(self, request):
        if not hal.validate_version(request.META.get('HTTP_ACCEPT')):
            return Response('Invalid version requested',
                status=status.HTTP_406_NOT_ACCEPTABLE)

        listing_root_url = hal.get_abs_url_for_iwc(request)  # flake8: noqa TODO: Is Necessary? - Variable not being used in method
        profile = model_access.get_profile(request.user.username)  # flake8: noqa TODO: Is Necessary? - Variable not being used in method

        data = hal.create_base_structure(request, hal.generate_content_type(
            request.accepted_media_type))
        data["version"] = "1.0"
        data["name"] = "TBD"
        return Response(data)
