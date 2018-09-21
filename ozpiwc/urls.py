"""
URLs for all resources - will be placed under /iwc-api route by the project level urls.py
"""
from django.conf.urls import url, include
from rest_framework_nested import routers

import ozpiwc.views as views

router = routers.SimpleRouter()
router.register(r'', views.RootApiViewSet, base_name='root_api')
router.register(r'self', views.UserViewSet, base_name='user_api')

urlpatterns = [
    url(r'', include('ozpiwc.api.data.urls')),
    url(r'', include('ozpiwc.api.intent.urls')),
    url(r'', include('ozpiwc.api.system.urls')),
    url(r'', include('ozpiwc.api.names.urls')),
    url(r'^', include(router.urls)),
]
