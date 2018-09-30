"""
Views
"""
import os

from django.http import HttpResponse
from django.views.decorators.http import require_http_methods
from rest_framework_swagger.renderers import OpenAPIRenderer, SwaggerUIRenderer
from rest_framework.decorators import api_view, renderer_classes
from rest_framework import response, schemas

import ozp.urls
from ozp import version


@api_view()
@renderer_classes([SwaggerUIRenderer, OpenAPIRenderer])
def schema_view(request):
    generator = schemas.SchemaGenerator(title='API Docs', patterns=ozp.urls.apipatterns)
    return response.Response(generator.get_schema())


@require_http_methods(["GET"])
def health_check(request):
    return HttpResponse('{"status": "ok"}', content_type="application/json")
