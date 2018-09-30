from django.db import models


class ImportMetadataManager(models.Manager):
    pass


class ImportMetadata(models.Model):
    affiliated_store = models.ForeignKey("AffiliatedStore", verbose_name="affiliated store")

    external_id = models.IntegerField()

    last_updated = models.DateTimeField()
