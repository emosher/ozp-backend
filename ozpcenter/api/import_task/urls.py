from django.conf.urls import include
from django.conf.urls import url
from rest_framework_nested import routers

from .views import ImportTaskResultViewSet
from .views import ImportTaskViewSet

router = routers.DefaultRouter()
router.register(r'import_task', ImportTaskViewSet)

nested_router = routers.NestedSimpleRouter(router, r'import_task', lookup='import_task')
nested_router.register(r'result', ImportTaskResultViewSet, base_name='import_task-result')

urlpatterns = [
    url(r'^', include(router.urls)),
    url(r'^', include(nested_router.urls)),
]
