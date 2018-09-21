"""
"""
import logging

from rest_framework.decorators import api_view
from rest_framework.decorators import permission_classes
from rest_framework.decorators import renderer_classes
from rest_framework import permissions
from rest_framework import renderers as rf_renderers
from rest_framework import status
from rest_framework.response import Response
from rest_framework import viewsets

import ozpcenter.api.intent.model_access as intent_model_access
import ozpcenter.api.intent.serializers as intent_serializers
import ozpcenter.model_access as model_access
import ozpiwc.hal as hal
import ozpiwc.renderers as renderers


logger = logging.getLogger('ozp-iwc.' + str(__name__))


class IntentListViewSet(viewsets.ViewSet):
    """
    List of intents
    """
    permission_classes = (permissions.IsAuthenticated,)
    renderer_classes = (renderers.RootResourceRenderer, rf_renderers.JSONRenderer)

    def list(self, request):
        if not hal.validate_version(request.META.get('HTTP_ACCEPT')):
            return Response('Invalid version requested',
                status=status.HTTP_406_NOT_ACCEPTABLE)

        root_url = hal.get_abs_url_for_iwc(request)
        profile = model_access.get_profile(request.user.username)  # flake8: noqa TODO: Is Necessary? - Variable not being used in method
        data = hal.create_base_structure(request,
            hal.generate_content_type(request.accepted_media_type))
        intents = intent_model_access.get_all_intents()
        items = []
        for i in intents:
            item = {"href": '{0!s}intent/{1!s}/'.format(root_url, i.id)}
            items.append(item)
        data['_links']['item'] = items

        return Response(data)


class IntentViewSet(viewsets.ViewSet):
    """
    Single intent
    """
    permission_classes = (permissions.IsAuthenticated,)
    renderer_classes = (renderers.RootResourceRenderer, rf_renderers.JSONRenderer)

    def retrieve(self, request, pk):
        if not hal.validate_version(request.META.get('HTTP_ACCEPT')):
            return Response('Invalid version requested', status=status.HTTP_406_NOT_ACCEPTABLE)

        root_url = hal.get_abs_url_for_iwc(request)  # flake8: noqa TODO: Is Necessary? - Variable not being used in method
        profile = model_access.get_profile(request.user.username)  # flake8: noqa TODO: Is Necessary? - Variable not being used in method

        queryset = intent_model_access.get_intent_by_id(pk)
        if not queryset:
            return Response(status=status.HTTP_404_NOT_FOUND)
        serializer = intent_serializers.IntentSerializer(queryset,
                context={'request': request})
        data = serializer.data
        data = hal.add_hal_structure(data, request,
            hal.generate_content_type(request.accepted_media_type))

        return Response(data)
