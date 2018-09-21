"""
Notifications URLs
"""
from django.conf.urls import url, include
from rest_framework_nested import routers

import ozpcenter.api.notification.views as views

router = routers.SimpleRouter()
router.register(r'notification', views.NotificationViewSet, base_name='notification')
router.register(r'self/notification', views.UserNotificationViewSet, base_name='notification')

urlpatterns = [
    url(r'^', include(router.urls)),
    url(r'^notifications/pending/$', views.PendingNotificationView.as_view()),
    url(r'^notifications/expired/$', views.ExpiredNotificationView.as_view())
]
