import logging

from rest_framework import viewsets

import ozpcenter.api.listing.model_access as model_access
import ozpcenter.api.listing.serializers as serializers
from ozpcenter import permissions

logger = logging.getLogger('ozp-center.' + str(__name__))


class ScreenshotViewSet(viewsets.ModelViewSet):
    """
    Listing Types

    ModelViewSet for getting all Screenshots for a given listing

    Access Control
    ===============
    - All users can view

    URIs
    ======
    GET /api/screenshot/
    Summary:
        Get a list of all system-wide Screenshot entries
    Response:
        200 - Successful operation - [ScreenshotSerializer]

    POST /api/screenshot/
    Summary:
        Add a Screenshot
    Request:
        data: ScreenshotSerializer Schema
    Response:
        200 - Successful operation - ScreenshotSerializer

    GET /api/screenshot/{pk}
    Summary:
        Find a Screenshot Entry by ID
    Response:
        200 - Successful operation - ScreenshotSerializer

    PUT /api/screenshot/{pk}
    Summary:
        Update a Screenshot Entry by ID

    PATCH /api/screenshot/{pk}
    Summary:
        Update (Partial) a Screenshot Entry by ID

    DELETE /api/screenshot/{pk}
    Summary:
        Delete a Screenshot Entry by ID
    """

    permission_classes = (permissions.IsUser,)
    queryset = model_access.get_all_screenshots()
    serializer_class = serializers.ScreenshotSerializer
