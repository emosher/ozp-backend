from django.contrib import admin
from ozpcenter import models
from django.conf.urls import url
from django.utils.html import format_html
from django.core.urlresolvers import reverse
from django.http import HttpResponseRedirect
from ozpcenter.tasks import run_import_task

#IMPORT job definition
import logging
logger = logging.getLogger('ozp-center.' + str(__name__))

@admin.register(models.ImportTask)
class ImportTaskAdmin(admin.ModelAdmin):

    list_display    = (
        'name',
        'affiliated_store',
        'url',
        # 'update_type',
        'exec_interval',
        'enabled',
        'last_run_result',
        'run_import'
    )

    search_fields = ('name', 'affiliated_store')

    list_filter = ('enabled', 'affiliated_store')

    readonly_fields= ('last_run_result', )

    exclude = ('update_type', 'cron_exp', 'keystore_path', 'keystore_pass', 'truststore_path')

    def get_urls(self):
        urls = super().get_urls()
        custom_urls = [
            url(
                r'^(?P<id>.+)/runjob/$',
                self.admin_site.admin_view(self.run_import_task_now),
                name="run-import"
            )
        ]
        return custom_urls + urls

    def run_import_task_now(self, request, id, *args, **kwargs):

        self.message_user(request, "Import task has been scheduled to run")
        logger.info("Run Import Task: id=%s" % id)
        run_import_task.delay(id)
        return HttpResponseRedirect("../")

    def run_import(self, obj):
        return format_html(
            '<a class="button" href="{}">Run Import</a>&nbsp;',
            reverse('admin:run-import', args=[obj.pk]),
        )
    run_import.short_description = ""
    run_import.allow_tags = True