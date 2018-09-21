"""
IWC Data

#  Working
```
curl --request PUT \
  --url http://127.0.0.1:8001/iwc-api/self/data/transportation/car7/ \
  --header 'authorization: Basic d3NtaXRoOnBhc3N3b3Jk' \
  --header 'content-type: application/vnd.ozp-iwc-data-object+json;version=2' \
  --data '{"version": "1.0", "permissions": {"name": "security"}, "entity": {"details": {"color": "red"}}, "pattern": "/transportation/car"}'
```

# Should `permissions` be a CharField or JsonField?

Looking at github.com/aml-development/ozp-iwc, it seems like it should be a JsonField
```
 this.permissions.pushIfNotExist('ozp:iwc:address', this.address);
67	            this.permissions.pushIfNotExist('ozp:iwc:sendAs', this.address);
68	            this.permissions.pushIfNotExist('ozp:iwc:receiveAs', this.address);
```
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

import ozpiwc.hal as hal
import ozpiwc.renderers as renderers
import ozpiwc.api.data.serializers as serializers
import ozpiwc.api.data.model_access as model_access


logger = logging.getLogger('ozp-iwc.' + str(__name__))


class DataApiViewSet(viewsets.ViewSet):

    permission_classes = (permissions.IsAuthenticated,)
    renderer_classes = (renderers.DataObjectResourceRenderer, rf_renderers.JSONRenderer)

    lookup_value_regex = '[0-9a-zA-Z/_\-]+'

    def list(self, request):
        """
        List all data entries for the user
        """
        if not hal.validate_version(request.META.get('HTTP_ACCEPT')):
            return Response('Invalid version requested', status=status.HTTP_406_NOT_ACCEPTABLE)

        listing_root_url = hal.get_abs_url_for_iwc(request)  # flake8: noqa TODO: Is Necessary? - Variable not being used in method

        data = hal.create_base_structure(request,
            hal.generate_content_type(request.accepted_media_type))

        keys = model_access.get_all_keys(request.user.username)
        embedded_items = []
        for k in keys:
            # remove the leading /
            k = k[1:]
            url = hal.get_abs_url_for_iwc(request) + 'self/data/' + k
            data = hal.add_link_item(url, data, hal.generate_content_type(
                renderers.DataObjectResourceRenderer.media_type))

            # add data items to _embedded
            key = '/' + k
            try:
                instance = model_access.get_data_resource(request.user.username, key)
                if not instance:
                    return Response(status=status.HTTP_404_NOT_FOUND)
                serializer = serializers.DataResourceSerializer(instance,
                    data=request.data, context={'request': request, 'key': key},
                    partial=True)
                if not serializer.is_valid():
                    logger.error('{0!s}'.format(serializer.errors))
                    return Response(serializer.errors,
                        status=status.HTTP_400_BAD_REQUEST)
                item = hal.add_hal_structure(serializer.data, request,
                    hal.generate_content_type(
                        renderers.DataObjectResourceRenderer.media_type))
                item['_links']['self']['href'] += k
                embedded_items.append(item)
            except Exception as e:
                # TODO debug
                raise e

            data['_embedded']['item'] = embedded_items

        return Response(data)

    def _get_key(self, key):
        # ensure key starts with a / and does not end with one
        if not key.startswith('/'):
            key = '/' + key
        if key.endswith('/'):
            key = key[:-1]
        return key

    def retrieve(self, request, pk):
        if not hal.validate_version(request.META.get('HTTP_ACCEPT')):
            return Response('Invalid version requested', status=status.HTTP_406_NOT_ACCEPTABLE)
        # listing_root_url = hal.get_abs_url_for_iwc(request)  # flake8: noqa TODO: Is Necessary? - Variable not being used in method
        # data = hal.create_base_structure(request,   # flake8: noqa TODO: Is Necessary? - Variable not being used in method
        #     hal.generate_content_type(
        #         request.accepted_media_type))
        key = self._get_key(pk)
        logger.debug('Got GET IWC Data request for key {0!s}'.format(key))

        instance = model_access.get_data_resource(request.user.username, key)
        if not instance:
            return Response(status=status.HTTP_404_NOT_FOUND)
        serializer = serializers.DataResourceSerializer(instance,
            data=request.data, context={'request': request, 'key': key},
            partial=True)
        if not serializer.is_valid():
            logger.error('{0!s}'.format(serializer.errors))
            return Response(serializer.errors,
                status=status.HTTP_400_BAD_REQUEST)
        resp = serializer.data
        resp = hal.add_hal_structure(resp, request,
            hal.generate_content_type(
                request.accepted_media_type))
        return Response(resp, status=status.HTTP_200_OK)

    def update(self, request, pk=None):
        if not hal.validate_version(request.META.get('HTTP_ACCEPT')):
            return Response('Invalid version requested', status=status.HTTP_406_NOT_ACCEPTABLE)

        key = self._get_key(pk)
        logger.debug('Got GET IWC Data request for key {0!s}'.format(key))

        logger.debug('request.data: {0!s}'.format(request.data))
        instance = model_access.get_data_resource(request.user.username, key)

        if instance:
            serializer = serializers.DataResourceSerializer(instance,
                data=request.data, context={'request': request, 'key': key},
                partial=True)
            if not serializer.is_valid():
                logger.error('{0!s}'.format(serializer.errors))
                return Response(serializer.errors,
                    status=status.HTTP_400_BAD_REQUEST)
            serializer.save()
            resp = serializer.data
            resp = hal.add_hal_structure(resp, request,
                hal.generate_content_type(
                    request.accepted_media_type))
            return Response(resp, status=status.HTTP_200_OK)
        else:
            serializer = serializers.DataResourceSerializer(
                data=request.data, context={'request': request, 'key': key},
                partial=True)
            if not serializer.is_valid():
                logger.error('ERROR: {0!s}'.format(serializer.errors))
                return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
            serializer.save()
            resp = serializer.data
            resp = hal.add_hal_structure(resp, request,
                hal.generate_content_type(
                    request.accepted_media_type))
            return Response(resp, status=status.HTTP_201_CREATED)

    def destroy(self, request, pk=None):
        if not hal.validate_version(request.META.get('HTTP_ACCEPT')):
            return Response('Invalid version requested', status=status.HTTP_406_NOT_ACCEPTABLE)

        key = self._get_key(pk)
        logger.debug('Got GET IWC Data request for key {0!s}'.format(key))

        instance = model_access.get_data_resource(request.user.username, key)
        if instance:
            instance.delete()
        else:
            return Response(status=status.HTTP_404_NOT_FOUND)
        return Response(status=status.HTTP_204_NO_CONTENT)
