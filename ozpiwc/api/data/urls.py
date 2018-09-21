"""
ozpiwc data
"""
from django.conf.urls import url, include
from rest_framework_nested import routers

import ozpiwc.api.data.views as views

router = routers.SimpleRouter()
router.register(r'self/data', views.DataApiViewSet, base_name='data_list_view')

urlpatterns = [
    url(r'^', include(router.urls)),
]
