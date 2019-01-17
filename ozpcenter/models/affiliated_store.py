from django.core.validators import RegexValidator
from django.db import models

from .image import Image


class AffiliatedStoreManager(models.Manager):

    def get_queryset(self):
        return super().get_queryset() \
            .select_related('icon') \
            .select_related('icon__image_type')

    def find_all(self):
        return self.all()

    def find_by_id(self, id):
        return self.get(id=id)


class AffiliatedStore(models.Model):
    class Meta:
        db_table = 'affiliated_store'

    objects = AffiliatedStoreManager()

    title = models.CharField(max_length=255)

    server_url = models.CharField(max_length=2083,
                                  validators=[RegexValidator(regex='^(https|http)://.*$',
                                                             code='invalid url',
                                                             message='server_url must be a url')])

    icon = models.ForeignKey(Image, related_name='+', null=True, blank=True)

    is_enabled = models.BooleanField(default=True)

    def __repr__(self):
        return 'AffiliatedStore(id={0!s}, title="{1!s}")'.format(self.id, self.title)

    def __str__(self):
        return repr(self)
