"""
Agency Urls
"""
from django.conf.urls import url, include
from rest_framework_nested import routers

import ozpcenter.api.agency.views as views

router = routers.DefaultRouter()
router.register(r'agency', views.AgencyViewSet)

urlpatterns = [
    url(r'^', include(router.urls)),
]
