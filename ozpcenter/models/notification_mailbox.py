from django.db import models

from .notification import Notification
from .profile import Profile


class NotificationMailBoxManager(models.Manager):
    """
    NotificationMailBox Manager
    """

    def apply_select_related(self, queryset):
        queryset = queryset.select_related('target_profile')
        queryset = queryset.select_related('notification')
        return queryset

    def get_queryset(self):
        queryset = super(NotificationMailBoxManager, self).get_queryset()
        return self.apply_select_related(queryset)


class NotificationMailBox(models.Model):
    """
    Notification MailBox
    Represents all the notifications for all users

    Fields:
        target_profile: Mailbox Profile ID
        notification: notification ForeignKey
        emailed_status: If it has been emailed. then make value true
        read_status: Read Flag
        acknowledged_status: Acknowledged Flag
    """
    target_profile = models.ForeignKey(Profile, related_name='mailbox_profiles')
    notification = models.ForeignKey(Notification, related_name='mailbox_notifications')
    emailed_status = models.BooleanField(default=False)
    read_status = models.BooleanField(default=False)
    acknowledged_status = models.BooleanField(default=False)

    objects = NotificationMailBoxManager()

    def __repr__(self):
        return '{0!s}: {1!s}'.format(self.target_profile.user.username, self.notification.pk)

    def __str__(self):
        return '{0!s}: {1!s}'.format(self.target_profile.user.username, self.notification.pk)
