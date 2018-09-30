from django.db import models

from .profile import Profile


class Subscription(models.Model):
    target_profile = models.ForeignKey(Profile, related_name='subscription_profiles')

    # Entity Type
    CATEGORY = 'category'
    TAG = 'tag'

    ENTITY_TYPE_CHOICES = (
        (CATEGORY, 'category'),
        (TAG, 'tag'),
    )
    entity_type = models.CharField(default=None, max_length=12, choices=ENTITY_TYPE_CHOICES, db_index=True)

    # Depending on entity_type, it could be category_id/agency_id/tag_id
    entity_id = models.IntegerField(default=None, db_index=True)

    def __repr__(self):
        return '{0!s}: {1!s}: {2!s}'.format(self.target_profile.user.username, self.entity_type, self.entity_id)

    def __str__(self):
        return '{0!s}: {1!s}: {2!s}'.format(self.target_profile.user.username, self.entity_type, self.entity_id)
