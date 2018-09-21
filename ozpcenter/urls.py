"""
URLs for all resources - will be placed under /api route by the project level
"""
from django.conf.urls import url, include

from ozpcenter import views
from rest_framework_jwt.views import obtain_jwt_token

urlpatterns = [
    url(r'', include('ozpcenter.api.agency.urls')),
    url(r'', include('ozpcenter.api.category.urls')),
    url(r'', include('ozpcenter.api.contact_type.urls')),
    url(r'', include('ozpcenter.api.image.urls')),
    url(r'', include('ozpcenter.api.intent.urls')),
    url(r'', include('ozpcenter.api.library.urls')),
    url(r'', include('ozpcenter.api.listing.urls')),
    url(r'', include('ozpcenter.api.notification.urls')),
    url(r'', include('ozpcenter.api.profile.urls')),
    url(r'', include('ozpcenter.api.storefront.urls')),
    url(r'', include('ozpcenter.api.subscription.urls')),
    url(r'^version/', views.version_view),
    url(r'^token-auth/', obtain_jwt_token),
]
