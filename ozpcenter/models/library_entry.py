import logging

from django.core.cache import cache
from django.db import models
from django.db.models.signals import post_delete
from django.db.models.signals import post_save
from django.dispatch import receiver

from plugins.plugin_manager import system_has_access_control
from .listing import Listing
from .profile import Profile
from .util import get_user_excluded_orgs

logger = logging.getLogger('ozp-center.' + str(__name__))


class AccessControlApplicationLibraryEntryManager(models.Manager):
    """
    Use a custom manager to control access to Library
    """

    def apply_select_related(self, queryset):
        queryset = queryset.select_related('listing')
        queryset = queryset.select_related('listing__agency')
        queryset = queryset.select_related('listing__listing_type')
        queryset = queryset.select_related('listing__small_icon')
        queryset = queryset.select_related('listing__large_icon')
        queryset = queryset.select_related('listing__banner_icon')
        queryset = queryset.select_related('listing__large_banner_icon')
        queryset = queryset.select_related('listing__required_listings')
        queryset = queryset.select_related('listing__last_activity')
        queryset = queryset.select_related('listing__current_rejection')
        queryset = queryset.select_related('owner')
        queryset = queryset.select_related('owner__user')
        return queryset

    def get_queryset(self):
        queryset = super(AccessControlApplicationLibraryEntryManager, self).get_queryset()
        return self.apply_select_related(queryset)

    def for_user(self, username):
        objects = super(AccessControlApplicationLibraryEntryManager, self).get_queryset()
        profile_instance = Profile.objects.get(user__username=username)
        # filter out private listings
        exclude_orgs = get_user_excluded_orgs(profile_instance)

        objects = objects.filter(owner__user__username=username)
        objects = objects.filter(listing__is_enabled=True)
        objects = objects.filter(listing__is_deleted=False)
        objects = objects.exclude(listing__is_private=True, listing__agency__in=exclude_orgs)
        objects = self.apply_select_related(objects)
        # Filter out listings by user's access level
        ids_to_exclude = []
        for i in objects:
            if not i.listing.security_marking:
                logger.debug('Listing {0!s} has no security_marking'.format(i.listing.title))
            if not system_has_access_control(username, i.listing.security_marking):
                ids_to_exclude.append(i.listing.id)
        objects = objects.exclude(listing__pk__in=ids_to_exclude)
        return objects

    def for_user_organization_minus_security_markings(self, username, filter_for_user=False):
        objects = super(AccessControlApplicationLibraryEntryManager, self).get_queryset()
        profile_instance = Profile.objects.get(user__username=username)
        # filter out private listings
        exclude_orgs = get_user_excluded_orgs(profile_instance)

        objects = objects.exclude(listing__is_private=True,
                                  listing__agency__in=exclude_orgs)

        if filter_for_user:
            objects = objects.filter(owner__user__username=username)
            objects = objects.filter(listing__is_enabled=True)
            objects = objects.filter(listing__is_deleted=False)

        return objects


class ApplicationLibraryEntry(models.Model):
    """
    A Listing that a user (Profile) has in their 'application library'/bookmarks

    TODO: Auditing for create, update, delete
    TODO: folder seems HUD-specific
    TODO: should we allow multiple bookmarks of the same listing (perhaps in different folders)?
    """
    folder = models.CharField(max_length=255, blank=True, null=True)
    owner = models.ForeignKey(Profile, related_name='application_library_entries')
    listing = models.ForeignKey(Listing, related_name='application_library_entries')
    position = models.PositiveIntegerField(default=0)

    objects = AccessControlApplicationLibraryEntryManager()

    def __str__(self):
        return '{0!s}:{1!s}:{2!s}:{3!s}'.format(self.folder, self.owner.user.username, self.listing.title,
                                                self.position)

    def __repr__(self):
        return '{0!s}:{1!s}:{2!s}:{3!s}'.format(self.folder, self.owner.user.username, self.listing.title,
                                                self.position)

    class Meta:
        verbose_name_plural = "application library entries"


@receiver(post_save, sender=ApplicationLibraryEntry)
def post_save_application_library_entry(sender, instance, created, **kwargs):
    cache.delete_pattern('library_self-*')


@receiver(post_delete, sender=ApplicationLibraryEntry)
def post_delete_application_library_entry(sender, instance, **kwargs):
    cache.delete_pattern('library_self-*')
