from django.db import models

from ozpcenter.utils import get_now_utc
from .import_task import ImportTask


class ImportTaskResultManager(models.Manager):

    def get_queryset(self):
        return super().get_queryset()

    def find_all(self):
        return self.all()

    def find_by_id(self, id):
        return self.get(id=id)

    def find_all_by_import_task(self, import_task_pk):
        return self.filter(import_task=import_task_pk)

    def create_result(self, import_task_id, result, message):
        result = self.create(import_task_id=import_task_id, result=result, message=message)
        ImportTask.objects.filter(id=import_task_id).update(last_run_result=result.id)
        return result


class ImportTaskResult(models.Model):
    """
    Import Task Result

    Represents the results of an import task that has been run previously
    """

    class Meta:
        db_table = 'import_task_result'

    objects = ImportTaskResultManager()

    RESULT_PASS = 'Pass'
    RESULT_FAIL = 'Fail'

    RESULT_CHOICES = (
        (RESULT_PASS, 'Pass'),
        (RESULT_FAIL, 'Fail'),
    )
    import_task = models.ForeignKey(ImportTask, related_name="results")
    run_date = models.DateTimeField(default=get_now_utc)
    result = models.CharField(max_length=4, choices=RESULT_CHOICES)
    message = models.CharField(max_length=4000, null=False)


    def __repr__(self):
        return '{0!s} | Date: {1!s} | Result: {2!s}'.format(self.import_task, self.run_date, self.result)

    def __str__(self):
        return '{0!s} | Date: {1!s} | Result: {2!s}'.format(self.import_task, self.run_date, self.result)
