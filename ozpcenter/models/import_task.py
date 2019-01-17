from django.db import models
from django.core.validators import RegexValidator

# from django_celery_beat.models import IntervalSchedule


class ImportTaskManager(models.Manager):

    def get_queryset(self):
        return super().get_queryset() \
            .select_related('last_run_result')

    def find_all(self):
        return self.all()

    def find_enabled(self):
        return self.filter(enabled=True)

    def find_by_id(self, id):
        return self.get(id=id)


class ImportTask(models.Model):
    """
    Import Task

    Represents the import of listings from an affiliated store
    """

    class Meta:
        db_table = 'import_task'

    objects = ImportTaskManager()

    IMPORT_TYPE_FULL = 'Entire'
    IMPORT_TYPE_DELTA = 'Partial'

    UPDATE_TYPE_CHOICES = (
        (IMPORT_TYPE_FULL, 'Entire'),
        (IMPORT_TYPE_DELTA, 'Partial'),
    )
    affiliated_store = models.ForeignKey('AffiliatedStore', null=True)
    name = models.CharField(max_length=50, unique=True)
    update_type = models.CharField(max_length=7, choices=UPDATE_TYPE_CHOICES, null=True, blank=True)
    cron_exp = models.CharField(max_length=255, null=True, blank=True)
    exec_interval = models.ForeignKey('django_celery_beat.IntervalSchedule', null=True)
    url = models.CharField(max_length=2083, null=True,
                           validators=[RegexValidator(regex='^(https|http)://.*$',
                                                             code='invalid url',
                                                             message='Please enter a valid url')])
    extra_url_params = models.CharField(max_length=512, null=True, blank=True)
    enabled = models.BooleanField(default=True)
    keystore_path = models.CharField(max_length=2048, null=True, blank=True)
    keystore_pass = models.CharField(max_length=2048, null=True, blank=True)
    truststore_path = models.CharField(max_length=2048, null=True, blank=True)
    last_run_result = models.ForeignKey('ImportTaskResult', null=True, blank=True, related_name="+",
                                        on_delete=models.deletion.SET_NULL)

    def __repr__(self):
        return '{0!s} - {1!s}: {2!s}'.format(self.id, self.name, self.update_type)

    def __str__(self):
        return '{0!s} - {1!s}: {2!s}'.format(self.id, self.name, self.update_type)

    def set_exec_interval(self, value, unit):
        switch = {
            'minutes': 1,
            'hours': 60,
            'days': 1440
        }
        mult_factor = switch.get(unit, 0)
        if mult_factor == 0:
            raise ValueError("ImportTask units must be one of 'minutes', 'hours', or 'days'")
        else:
            self._exec_interval = value * mult_factor
