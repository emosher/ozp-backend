"""
Notifications URLs
"""
from django.conf.urls import url, include
from rest_framework_nested import routers

import ozpcenter.api.subscription.views as views

router = routers.SimpleRouter()
router.register(r'subscription', views.SubscriptionViewSet, base_name='subscription')
router.register(r'self/subscription', views.UserSubscriptionViewSet, base_name='self_subscription')

urlpatterns = [
    url(r'^', include(router.urls)),
]
