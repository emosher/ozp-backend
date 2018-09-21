"""
Image URLs
"""
from django.conf.urls import url, include
from rest_framework_nested import routers

import ozpcenter.api.image.views as views

router = routers.SimpleRouter()

router.register(r'image', views.ImageViewSet, base_name='image')
router.register(r'imagetype', views.ImageTypeViewSet, base_name='imagetype')

urlpatterns = [
    url(r'^', include(router.urls)),
]
