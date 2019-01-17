from django.db import models

from .import_metadata import ImportMetadata


class ExternalModel(models.Model):
    class Meta:
        abstract = True

    import_metadata = models.OneToOneField(ImportMetadata, null=True, blank=True, on_delete=models.SET_NULL)

    @property
    def is_external(self):
        return self.import_metadata_id is not None
