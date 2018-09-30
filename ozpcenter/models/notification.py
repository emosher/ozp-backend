import json

from django.db import models

from ozpcenter import utils
from .agency import Agency
from .listing import Listing
from .profile import Profile


class NotificationManager(models.Manager):
    """
    Notification Manager
    """

    def apply_select_related(self, queryset):
        # select_related cut down db calls from 717 to 8
        queryset = queryset.select_related('author')
        queryset = queryset.select_related('author__user')
        queryset = queryset.select_related('listing')
        queryset = queryset.select_related('agency')
        return queryset

    def get_queryset(self):
        queryset = super(NotificationManager, self).get_queryset()
        return self.apply_select_related(queryset)


class Notification(models.Model):
    """
    A notification. Can optionally belong to a specific application

    Notifications that do not have an associated listing are assumed to be
    'system-wide', and thus will be sent to all users
    """
    # TODO: change this back after the database migration
    # created_date = models.DateTimeField(auto_now_add=True)
    created_date = models.DateTimeField(default=utils.get_now_utc)
    message = models.CharField(max_length=4096)
    expires_date = models.DateTimeField()
    author = models.ForeignKey(Profile, related_name='authored_notifications')
    dismissed_by = models.ManyToManyField(
        'Profile',
        related_name='dismissed_notifications',
        db_table='notification_profile'
    )
    listing = models.ForeignKey(Listing, related_name='notifications',
                                null=True, blank=True)
    agency = models.ForeignKey(Agency, related_name='agency_notifications',
                               null=True, blank=True)

    # Peer to Peer Notifications
    # 'peer_org' declaration causes a Segmentation Fault (core dumped) Error in Django Database Library Code
    # django/db/backends/sqlite3/base.py, line 316 in execute

    # peer_org = models.ForeignKey(Profile, related_name='peer_notifications', null=True)
    _peer = models.CharField(max_length=4096, null=True, blank=True, db_column='peer')

    # Notification Type
    SYSTEM = 'system'  # System-wide Notifications
    AGENCY = 'agency'  # Agency-wide Notifications
    AGENCY_BOOKMARK = 'agency_bookmark'  # Agency-wide Bookmark Notifications # Not requirement (erivera 20160621)
    LISTING = 'listing'  # Listing Notifications
    PEER = 'peer'  # Peer to Peer Notifications
    PEER_BOOKMARK = 'peer_bookmark'  # PEER.BOOKMARK - Peer to Peer Bookmark Notifications
    RESTORE_BOOKMARK = 'restore_bookmark'  # RESTORE.BOOKMARK - Self to Self Bookmark Restore
    SUBSCRIPTION = 'subscription'  # SUBSCRIPTION - Tag/Category Subscriptions

    NOTIFICATION_TYPE_CHOICES = (
        (SYSTEM, 'system'),
        (AGENCY, 'agency'),
        (AGENCY_BOOKMARK, 'agency_bookmark'),
        (LISTING, 'listing'),
        (PEER, 'peer'),
        (PEER_BOOKMARK, 'peer_bookmark'),
        (RESTORE_BOOKMARK, 'restore_bookmark'),
        (SUBSCRIPTION, 'subscription'),
    )
    notification_type = models.CharField(default=SYSTEM, max_length=24,
                                         choices=NOTIFICATION_TYPE_CHOICES)  # db_index=True)

    # Notification Subtype
    LISTING_NEW = 'listing_new'
    LISTING_REVIEW = 'listing_review'  # When a review is left on a listing
    LISTING_PRIVATE_STATUS = 'listing_private_status'  # When a listing is changed to private
    PENDING_DELETION_TO_OWNER = 'pending_deletion_to_owner'  # When a steward rejects an app deletion request
    PENDING_DELETION_TO_STEWARD = 'pending_deletion_to_steward'  # When an owner submits or cancels an app deletion request
    PENDING_DELETION_APPROVED = 'pending_deletion_approved'  # When a steward approves an app deletion request
    REVIEW_REQUEST = 'review_request'  # When an APP_STEWARD notifies ORG_STEWARDS to review their apps and makes sure they are up to date
    SUBSCRIPTION_CATEGORY = 'subscription_category'  # When there is a new app in a subscribed category
    SUBSCRIPTION_TAG = 'subscription_tag'  # When there is a new app in a subscribed tag

    NOTIFICATION_SUBTYPE_CHOICES = (
        (LISTING_NEW, 'listing_new'),
        (LISTING_REVIEW, 'listing_review'),
        (LISTING_PRIVATE_STATUS, 'listing_private_status'),
        (PENDING_DELETION_TO_OWNER, 'pending_deletion__to_owner'),
        (PENDING_DELETION_TO_STEWARD, 'pending_deletion_to_steward'),
        (PENDING_DELETION_APPROVED, 'pending_deletion_approved'),
        (REVIEW_REQUEST, 'review_request'),
        (SUBSCRIPTION_CATEGORY, 'subscription_category'),
        (SUBSCRIPTION_TAG, 'subscription_tag')
    )
    notification_subtype = models.CharField(default=SYSTEM, max_length=36, choices=NOTIFICATION_SUBTYPE_CHOICES,
                                            null=True)  # db_index=True)

    # User Target
    ALL = 'all'  # All users
    STEWARDS = 'stewards'
    APP_STEWARD = 'app_steward'
    ORG_STEWARD = 'org_steward'
    USER = 'user'
    OWNER = 'owner'

    GROUP_TARGET_CHOICES = (
        (ALL, 'all'),
        (STEWARDS, 'stewards'),
        (APP_STEWARD, 'app_steward'),
        (ORG_STEWARD, 'org_steward'),
        (USER, 'user'),
        (OWNER, 'owner'),
    )
    group_target = models.CharField(default=ALL, max_length=24, choices=GROUP_TARGET_CHOICES)  # db_index=True)

    # Depending on notification_type, it could be listing_id/agency_id/profile_user_id/category_id/tag_id
    entity_id = models.IntegerField(default=None, null=True, blank=True, db_index=True)

    objects = NotificationManager()

    @property
    def peer(self):
        if self._peer:
            return json.loads(self._peer)
        else:
            return None

    @peer.setter
    def peer(self, value):
        """
        Setter for peer variable

        {
            'user': {
                'username': str
            },
            '_bookmark_listing_ids': list[int],
            'folder_name': str,
            'deleted_folder': bool
        }

        Args:
            value (dict): dictionary
        """
        if value:
            assert isinstance(value, dict), 'Argument of wrong type is not a dict'

            temp = {}

            if 'user' in value:
                temp_user = {}
                current_user_dict = value['user']
                assert isinstance(current_user_dict, dict), 'Argument of wrong type is not a dict'

                if 'username' in current_user_dict:
                    temp_user['username'] = current_user_dict['username']

                temp['user'] = temp_user

            for entry_key in ['folder_name', '_bookmark_listing_ids']:
                if entry_key in value:
                    temp[entry_key] = value[entry_key]

            if 'deleted_folder' in value:
                temp['deleted_folder'] = True
            self._peer = json.dumps(temp)
        else:
            return None

    def __repr__(self):
        return '{0!s}: {1!s}'.format(self.author.user.username, self.message)

    def __str__(self):
        return '{0!s}: {1!s}'.format(self.author.user.username, self.message)
