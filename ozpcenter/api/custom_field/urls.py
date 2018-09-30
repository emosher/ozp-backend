from django.conf.urls import include
from django.conf.urls import url
from rest_framework_nested import routers

from .views import CustomFieldViewSet

router = routers.DefaultRouter()
router.register(r'custom_field', CustomFieldViewSet)


urlpatterns = [
    url(r'^', include(router.urls)),
]
