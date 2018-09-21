"""
Intent URLs
"""
from django.conf.urls import url, include
from rest_framework_nested import routers

import ozpcenter.api.intent.views as views

router = routers.SimpleRouter()
router.register(r'intent', views.IntentViewSet)

urlpatterns = [
    url(r'^', include(router.urls)),
]
