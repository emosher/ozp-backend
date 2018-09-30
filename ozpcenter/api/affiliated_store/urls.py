from django.conf.urls import include
from django.conf.urls import url
from rest_framework_nested import routers

from .views import AffiliatedStoreViewSet

router = routers.DefaultRouter()
router.register(r'affiliated_store', AffiliatedStoreViewSet)

urlpatterns = [
    url(r'^', include(router.urls)),
]
