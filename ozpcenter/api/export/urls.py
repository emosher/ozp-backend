from django.conf.urls import include
from django.conf.urls import url
from rest_framework_nested import routers

from .views import ExportViewSet

router = routers.DefaultRouter()
router.register(r'export', ExportViewSet, base_name="export")

urlpatterns = [
    url(r'^', include(router.urls)),
]
