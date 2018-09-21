"""
Contact Types URLs
"""
from django.conf.urls import url, include
from rest_framework_nested import routers

import ozpcenter.api.contact_type.views as views

router = routers.SimpleRouter()

router.register(r'contact_type', views.ContactTypeViewSet)
router.register(r'contact', views.ContactViewSet)

urlpatterns = [
    url(r'^', include(router.urls)),
]
