"""
Model access
"""
import datetime
import logging
import pytz

from django.db.models import Q
from django.db import transaction

from ozpcenter import errors

from ozpcenter.models import Notification
from ozpcenter.models import NotificationMailBox

from ozpcenter.api.notification import notifications

import ozpcenter.model_access as generic_model_access


logger = logging.getLogger('ozp-center.' + str(__name__))


def get_self(username):
    """
    Get Profile for username

    Args:
        username (str): current username

    Returns:
        Profile if username exist, None if username does not exist
    """
    return generic_model_access.get_profile(username)


def get_all_notifications():
    """
    Get all notifications (expired and un-expired notifications)

    Includes
    * Listing Notifications
    * Agency Notifications
    * System Notifications
    * Peer Notifications
    * Peer.Bookmark Notifications
    * Restore.Bookmark Notifications

    Returns:
        django.db.models.query.QuerySet(Notification): List of all notifications
    """
    return Notification.objects


def get_all_pending_notifications(for_user=False):
    """
    Gets all system-wide pending notifications
    V2

    if for_user:
        Includes
         * System Notifications
    else:
        Includes
         * System Notifications
         * Listing Notifications
         * Agency Notifications
         * Peer Notifications
         * Peer.Bookmark Notifications
         * Restore.Bookmark Notifications

    Returns:
        django.db.models.query.QuerySet(Notification): List of system-wide pending notifications
    """
    unexpired_system_notifications = Notification.objects.filter(
        expires_date__gt=datetime.datetime.now(pytz.utc)).order_by('-created_date')

    if for_user:
        unexpired_system_notifications = unexpired_system_notifications.filter(agency__isnull=True,
                                              listing__isnull=True,
                                              _peer__isnull=True).order_by('-created_date')

    return unexpired_system_notifications


def get_all_expired_notifications():
    """
    Get all expired notifications

    Includes
    * Listing Notifications
    * Agency Notifications
    * System Notifications
    * Peer Notifications
    * Peer.Bookmark Notifications
    * Restore.Bookmark Notifications

    Returns:
        django.db.models.query.QuerySet(Notification): List of system-wide pending notifications
    """
    expired_system_notifications = Notification.objects.filter(
        expires_date__lt=datetime.datetime.now(pytz.utc)).order_by('-created_date')
    return expired_system_notifications


def get_notification_by_id_mailbox(username, id, reraise=False):
    """
    Get Notification by id

    Args:
        id (int): id of notification
    """
    try:
        notifications_mailbox = NotificationMailBox.objects.filter(target_profile=get_self(username)).values_list('notification', flat=True)
        unexpired_notifications = Notification.objects.filter(pk__in=notifications_mailbox,
                                                    expires_date__gt=datetime.datetime.now(pytz.utc)).get(id=id)

        return unexpired_notifications
    except Notification.DoesNotExist as err:
        if reraise:
            raise err
        else:
            return None


def get_self_notifications_mailbox(username):
    """
    Get notifications for current user

    Args:
        username (str): current username to get notifications

    Returns:
        django.db.models.query.QuerySet(Notification): List of notifications for username
    """
    notifications_mailbox = NotificationMailBox.objects.filter(target_profile=get_self(username), notification__expires_date__gt=datetime.datetime.now(pytz.utc)).all()
    return notifications_mailbox


def create_notification(author_username=None,
                        expires_date=None,
                        message=None,
                        listing=None,
                        agency=None,
                        peer=None,
                        peer_profile=None,
                        group_target=Notification.ALL,
                        notification_type=None,
                        entities=None):
    """
    Create Notification

    Notifications Types:
        * System-Wide Notification is made up of [expires_date, author_username, message]
        * Agency-Wide Notification is made up of [expires_date, author_username, message, agency]
        * Listing-Specific Notification is made up of [expires_date, author_username, message, listing]

    Args:
        author_username (str): Username of author
        expires_date (datetime.datetime): Expires Date (datetime.datetime(2016, 6, 24, 1, 0, tzinfo=<UTC>))
        message (str): Message of notification
        listing (models.Listing)-Optional: Listing
        Agency (models.Agency)-Optional: Agency

    Return:
        Notification: Created Notification

    Raises:
        AssertionError: If author_username or expires_date or message is None
    """
    # TODO: Use get_notification_class instead of all the if statements
    entity_dict = {
        'listing': listing,
        'agency': agency,
        'peer_profile': peer_profile,
        'peer': peer,
        'entities': entities
    }

    if notification_type == 'ListingSubmissionNotification':
        notification_instance = notifications.ListingSubmissionNotification()
        notification_instance.set_sender_and_entity(author_username, entity_dict)

    elif notification_type == 'ListingReviewNotification':
        notification_instance = notifications.ListingReviewNotification()
        notification_instance.set_sender_and_entity(author_username, entity_dict)

    elif notification_type == 'ListingOwnerNotification':
        notification_instance = notifications.ListingOwnerNotification()
        notification_instance.set_sender_and_entity(author_username, entity_dict)

    elif notification_type == 'PendingDeletionToOwnerNotification':
        notification_instance = notifications.PendingDeletionToOwnerNotification()
        notification_instance.set_sender_and_entity(author_username, entity_dict)

    elif notification_type == 'PendingDeletionToStewardNotification':
        notification_instance = notifications.PendingDeletionToStewardNotification()
        notification_instance.set_sender_and_entity(author_username, entity_dict)

    elif notification_type == 'PendingDeletionApprovedNotification':
        notification_instance = notifications.PendingDeletionApprovedNotification()
        notification_instance.set_sender_and_entity(author_username, entity_dict)

    elif notification_type == 'CategorySubscriptionNotification':
        notification_instance = notifications.CategorySubscriptionNotification()
        notification_instance.set_sender_and_entity(author_username, entity_dict)

    elif notification_type == 'TagSubscriptionNotification':
        notification_instance = notifications.TagSubscriptionNotification()
        notification_instance.set_sender_and_entity(author_username, entity_dict)

    elif notification_type == 'StewardAppNotification':
        notification_instance = notifications.StewardAppNotification()
        notification_instance.set_sender_and_entity(author_username, entity_dict)

    elif listing is not None:
        notification_instance = notifications.ListingNotification()
        notification_instance.set_sender_and_entity(author_username, entity_dict)

    elif agency is not None:
        notification_instance = notifications.AgencyWideNotification()
        notification_instance.set_sender_and_entity(author_username, entity_dict)

    elif peer is not None:
        notification_instance = notifications.PeerNotification()
        try:
            if peer and 'deleted_folder' in peer:
                notification_instance = notifications.RestoreBookmarkNotification()
            elif peer and 'folder_name' in peer:
                notification_instance = notifications.PeerBookmarkNotification()
        except ValueError:
            # Ignore Value Errors
            pass
        notification_instance.set_sender_and_entity(author_username, entity_dict)
    else:
        notification_instance = notifications.SystemWideNotification()
        notification_instance.set_sender_and_entity(author_username, entity_dict)

    notification = notification_instance.notify(expires_date, message)
    return notification


def update_notification(author_username, notification_instance, expires_date):
    """
    Update Notification

    Args:
        notification_instance (Notification): notification_instance
        author_username (str): Username of author

    Return:
        Notification: Updated Notification
    """
    user = generic_model_access.get_profile(author_username)  # TODO: Check if user exist, if not throw Exception Error ?

    notifications.check_notification_permission(user, 'change', notification_instance.notification_type)

    notification_instance.expires_date = expires_date
    notification_instance.save()
    return notification_instance


def dismiss_notification_mailbox(notification_mailbox_instance, username):
    """
    Dismissed a Notification Mailbox entry

    It deletes the Mailbox Entry for user

    Args:
        notification_mailbox_instance (NotificationMailBox): notification_mailbox_instance
        username (string)

    Return:
        bool: Notification Mailbox Dismissed
    """
    profile_instance = get_self(username)
    NotificationMailBox.objects.filter(target_profile=profile_instance, pk=notification_mailbox_instance.id).delete()
    return True
