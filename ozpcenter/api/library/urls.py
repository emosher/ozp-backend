"""
Library URLs
"""
from django.conf.urls import url, include
from rest_framework_nested import routers

import ozpcenter.api.library.views as views

router = routers.SimpleRouter()
router.register(r'library', views.LibraryViewSet)
router.register(r'self/library', views.UserLibraryViewSet, base_name='applicationlibraryentry')

urlpatterns = [
    url(r'^', include(router.urls)),
]
