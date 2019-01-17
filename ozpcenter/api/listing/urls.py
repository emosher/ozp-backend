"""
Listing URLs

Unlike most (maybe all) of the other resources, the Listing resource has several
nested resources - reviews and activity, for example. To help generate
nested URLs for these resources, the drf-nested-routers package is used.
"""
from django.conf.urls import url, include
# use drf-nested-routers extension
from rest_framework_nested import routers

import ozpcenter.api.listing.views as views

# Create a 'root level' router and urls
router = routers.SimpleRouter()
router.register(r'listing', views.ListingViewSet, base_name="listing")
# Ideally this route would be listing/search, but that conflicts with the nested router
router.register(r'listings/search', views.ListingSearchViewSet, base_name='listingssearch')
router.register(r'listings/essearch', views.ElasticsearchListingSearchViewSet, base_name='eslistingssearch')
# Ideally this route would be listing/activity, but that conflicts with the nested router
router.register(r'listings/activity', views.ListingActivitiesViewSet, base_name='listingsactivity')
router.register(r'self/listing', views.ListingUserViewSet, base_name='selflisting')
router.register(r'self/listings/activity', views.ListingUserActivitiesViewSet, base_name='selflistingsactivity')

# nested routes
nested_router = routers.NestedSimpleRouter(router, r'listing', lookup='listing')
nested_router.register(r'similar', views.SimilarViewSet, base_name='similar')
nested_router.register(r'feedback', views.RecommendationFeedbackViewSet, base_name='feedback')
nested_router.register(r'review', views.ReviewViewSet, base_name='review')
nested_router.register(r'activity', views.ListingActivityViewSet, base_name='activity')
nested_router.register(r'rejection', views.ListingRejectionViewSet, base_name='rejection')
nested_router.register(r'pendingdeletion', views.ListingPendingDeletionViewSet, base_name='pendingdeletion')
nested_router.register(r'custom_field_value', views.CustomFieldValueViewSet, base_name='custom_field_value')
# TODO: nest these

router.register(r'listingtype', views.ListingTypeViewSet)
router.register(r'screenshot', views.ScreenshotViewSet)
router.register(r'tag', views.TagViewSet)

urlpatterns = [
    url(r'^', include(router.urls)),
    url(r'^', include(nested_router.urls)),
]
