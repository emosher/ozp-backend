from django.conf.urls import include
from django.conf.urls import url
from rest_framework_nested import routers

from .views import CustomFieldTypeViewSet

router = routers.DefaultRouter()
router.register(r'custom_field_type', CustomFieldTypeViewSet)


urlpatterns = [
    url(r'^', include(router.urls)),
]
