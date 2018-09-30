import logging

from rest_framework import viewsets

import ozpcenter.api.listing.model_access as model_access
import ozpcenter.api.listing.serializers as serializers
from ozpcenter import permissions

logger = logging.getLogger('ozp-center.' + str(__name__))


class TagViewSet(viewsets.ModelViewSet):
    """
    Listing Types

    ModelViewSet for getting all Tags for a given listing

    Access Control
    ===============
    - All users can view

    URIs
    ======
    GET /api/tag/
    Summary:
        Get a list of all system-wide Tag entries
    Response:
        200 - Successful operation - [TagSerializer]

    POST /api/tag/
    Summary:
        Add a Tag
    Request:
        data: TagSerializer Schema
    Response:
        200 - Successful operation - TagSerializer

    GET /api/tag/{pk}
    Summary:
        Find a Tag Entry by ID
    Response:
        200 - Successful operation - TagSerializer

    PUT /api/tag/{pk}
    Summary:
        Update a Tag Entry by ID

    PATCH /api/tag/{pk}
    Summary:
        Update (Partial) a Tag Entry by ID

    DELETE /api/tag/{pk}
    Summary:
        Delete a Tag Entry by ID
    """

    permission_classes = (permissions.IsUser,)
    queryset = model_access.get_all_tags()
    serializer_class = serializers.TagSerializer
