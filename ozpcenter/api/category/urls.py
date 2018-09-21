"""
Category URLs
"""
from django.conf.urls import url, include
from rest_framework_nested import routers

import ozpcenter.api.category.views as views

router = routers.SimpleRouter()
router.register(r'category', views.CategoryViewSet)

# nested routes
nested_router = routers.NestedSimpleRouter(router, r'category', lookup='category')
nested_router.register(r'listing', views.BulkCategoryListingViewSet, base_name='category_listing')


urlpatterns = [
    url(r'^', include(router.urls)),
    url(r'^', include(nested_router.urls)),
]
