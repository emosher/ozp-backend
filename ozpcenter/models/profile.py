import json
import logging

from django.conf import settings
from django.contrib import auth
from django.db import models

from ozpcenter import utils
from .agency import Agency
from .external_model import ExternalModel

logger = logging.getLogger('ozp-center.' + str(__name__))


class ProfileManager(models.Manager):

    def get_queryset(self):
        queryset = super(ProfileManager, self).get_queryset()
        queryset = queryset.select_related('user')
        return queryset

    def get_base_queryset(self):
        return super().get_queryset()


class Profile(ExternalModel):
    """
    A User (user's Profile) on OZP

    Note that some information (username, email, last_login, date_joined) is
    held in the associated Django User model. In addition, the user's role
    (USER, ORG_STEWARD, or APPS_MALL_STEWARD) is represented by the Group
    associated with the Django User model

    Notes on use of contrib.auth.models.User model:
        * first_name and last_name are not used
        * is_superuser is always set to False
        * is_staff is set to True for Org Stewards and Apps Mall Stewards
        * password is only used in development. On production, client SSL certs
            are used, and so password is set to TODO: TBD

    TODO: Auditing for create, update, delete
        https://github.com/ozone-development/ozp-backend/issues/61
    """

    USER_ROLE = "USER"
    BETA_USER_ROLE = "BETA_USER"
    ORG_STEWARD_ROLE = "ORG_STEWARD"
    AML_STEWARD_ROLE = "APPS_MALL_STEWARD"
    API_EXPORT_ROLE = "API_EXPORT"

    display_name = models.CharField(max_length=255)
    bio = models.CharField(max_length=1000, blank=True)
    # user's DN from PKI cert
    # ideally this wouldn't be here and in a system using PKI, the user's DN
    # would be the username. DNs can be longer than Django's User.username
    # allows (30 chars max) and can include characters not allowed in
    # User.username
    dn = models.CharField(max_length=1000)
    # need to keep track of this as well for making auth calls
    issuer_dn = models.CharField(max_length=1000, null=True, blank=True)
    # datetime when any authorization data becomes
    # TODO: change this back after the migration
    # auth_expires = models.DateTimeField(auto_now_add=True)
    auth_expires = models.DateTimeField(default=utils.get_now_utc)
    organizations = models.ManyToManyField(
        Agency,
        related_name='profiles',
        db_table='agency_profile')
    stewarded_organizations = models.ManyToManyField(
        Agency,
        related_name='stewarded_profiles',
        db_table='stewarded_agency_profile',
        blank=True)

    access_control = models.CharField(max_length=16384)

    # instead of overriding the builtin Django User model used
    # for authentication, we extend it
    # https://docs.djangoproject.com/en/1.8/topics/auth/customizing/#extending-the-existing-user-model
    user = models.OneToOneField(settings.AUTH_USER_MODEL, null=True, blank=True)

    # Preferences
    # center_tour_flag: True = Show Tour for center
    center_tour_flag = models.BooleanField(default=True)
    # hud_tour_flag: True = Show Tour for Hud
    hud_tour_flag = models.BooleanField(default=True)
    # webtop_tour_flag: True = Show Tour for Webtop
    webtop_tour_flag = models.BooleanField(default=True)
    # email_notification_flag: True = Send Emails out for notification
    email_notification_flag = models.BooleanField(default=True)
    # listing_notification_flag will disable/enable:
    #   ListingSubmissionNotification, PendingDeletionToStewardNotification, PendingDeletionToOwnerNotification,
    #  ListingPrivateStatusNotification, ListingReviewNotification, ListingNotification, Listing Change,
    #  PendingDeletionApprovedNotification
    listing_notification_flag = models.BooleanField(default=True)
    # subscription_notification_flag  will disable/enable:
    #    TagSubscriptionNotification, CategorySubscriptionNotification
    subscription_notification_flag = models.BooleanField(default=True)
    # leaving_ozp_warning_flag: True = Show warning modal when launching an app
    leaving_ozp_warning_flag = models.BooleanField(default=True)

    # TODO: on create, update, or delete, do the same for the related django_user
    objects = ProfileManager()

    def __repr__(self):
        if self.user is None:
            if self.id is None:
                return "Profile"
            return "Profile: id=%d" % self.id
        return 'Profile: {0!s}'.format(self.user.username)

    def __str__(self):
        return self.user.username

    @staticmethod
    def create_groups():
        """
        Groups are used as Roles, and as such are relatively static, hence
        their declaration here (NOTE that this must be invoked manually
        after the server has started)
        """
        # create the different Groups (Roles) of users
        auth.models.Group.objects.get_or_create(name=Profile.USER_ROLE)
        auth.models.Group.objects.get_or_create(name=Profile.ORG_STEWARD_ROLE)
        auth.models.Group.objects.get_or_create(name=Profile.AML_STEWARD_ROLE)
        auth.models.Group.objects.get_or_create(name=Profile.BETA_USER_ROLE)
        auth.models.Group.objects.get_or_create(name=Profile.API_EXPORT_ROLE)

    def highest_role(self):
        """
        APPS_MALL_STEWARD > ORG_STEWARD > USER
        """
        group_names = self._get_group_names()

        # No User or Groups?
        if len(group_names) == 0:
            return ''

        if Profile.AML_STEWARD_ROLE in group_names:
            return Profile.AML_STEWARD_ROLE
        elif Profile.ORG_STEWARD_ROLE in group_names:
            return Profile.ORG_STEWARD_ROLE
        elif Profile.USER_ROLE in group_names:
            return Profile.USER_ROLE
        else:
            # TODO: raise exception?
            logger.error('User {0!s} has invalid Group'.format(self.user.username))
            return ''

    def is_apps_mall_steward(self):
        return self.highest_role() == Profile.AML_STEWARD_ROLE

    def is_steward(self):
        return self.highest_role() in [Profile.AML_STEWARD_ROLE, Profile.ORG_STEWARD_ROLE]

    def is_user(self):
        return self.highest_role() == Profile.USER_ROLE

    def is_beta_user(self):
        return Profile.BETA_USER_ROLE in self._get_group_names()

    def _get_group_names(self):
        if self.user is None:
            return []

        return [group.name for group in self.user.groups.all()]

    @property
    def username(self):
        if self.user is None:
            return None
        return self.user.username

    @staticmethod
    def create_user(username, **kwargs):
        """
        Create a new User and Profile object

        kwargs:
            password
            email
            display_name
            bio
            access_control
            organizations (['org1_title', 'org2_title'])
            stewarded_organizations (['org1_title', 'org2_title'])
            groups (['group1_name', 'group2_name'])
            dn
            issuer_dn
        """
        # TODO: what to make default password?
        password = kwargs.get('password', 'password')
        email = kwargs.get('email', '')
        # create User object
        # if this user is an ORG_STEWARD or APPS_MALL_STEWARD, give them
        # access to the admin site
        groups = kwargs.get('groups', ['USER'])
        if 'ORG_STEWARD' in groups or 'APPS_MALL_STEWARD' in groups:
            user = auth.models.User.objects.create_superuser(
                username=username, email=email, password=password)
            user.save()
            # logger.warn('creating superuser: %s, password: %s' % (username, password))
        else:
            user = auth.models.User.objects.create_user(
                username=username, email=email, password=password)
            user.save()
            # logger.info('creating user: %s' % username)

        # add user to group(s) (i.e. Roles - USER, ORG_STEWARD,
        # APPS_MALL_STEWARD). If no specific Group is provided, we
        # will default to USER
        for i in groups:
            g = auth.models.Group.objects.get(name=i)
            user.groups.add(g)

        # get additional profile information
        display_name = kwargs.get('display_name', username)
        bio = kwargs.get('password', '')
        ac = kwargs.get('access_control', json.dumps({'clearances': ['U']}))
        access_control = ac
        dn = kwargs.get('dn', username)
        issuer_dn = kwargs.get('issuer_dn')

        # create the profile object and associate it with the User
        p = Profile(display_name=display_name,
                    bio=bio,
                    access_control=access_control,
                    user=user,
                    dn=dn,
                    issuer_dn=issuer_dn
                    )
        p.save()

        # add organizations
        organizations = kwargs.get('organizations', [])
        for i in organizations:
            org = Agency.objects.get(title=i)
            p.organizations.add(org)

        # add stewarded organizations
        organizations = kwargs.get('stewarded_organizations', [])
        for i in organizations:
            org = Agency.objects.get(title=i)
            p.stewarded_organizations.add(org)

        return p
