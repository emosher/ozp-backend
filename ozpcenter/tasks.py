from __future__ import absolute_import, unicode_literals
import requests
from celery.utils.log import get_task_logger
from celery import shared_task, task
from django.core import mail
from django.template import Context
from django.template import Template
from django.conf import settings

from ozpcenter import models
from ozpcenter.utils import millis

logger = get_task_logger(__name__)


## Import Task

from ozpcenter.api.imports.service import ImportTask as ImportTaskService
from django_celery_beat.models import PeriodicTask, IntervalSchedule
import json


@shared_task
def collect_and_schedule_import_tasks():
    """
    Collect all import_task (enabled/disabled)
    This is scheduled in settings.py
    """

    all_tasks = models.ImportTask.objects.find_all().values()
    all_tasks = [task for task in all_tasks]

    update_create_scheduled_tasks(all_tasks)


@shared_task
def update_create_scheduled_tasks(tasks):
    """
    Schedule/update all tasks 
    """

    if not tasks:
        return logger.info("No tasks to schedule")

    for task in tasks:
        name     = task['name']
        task_id  = task['id']

        try:
            schedule = IntervalSchedule.objects.get(id=task['exec_interval_id'])
            PeriodicTask.objects.update_or_create(
                name="Name: %s ImportTask ID: %s" % (name, task_id),
                defaults = {
                    "interval": schedule,
                    "task": 'ozpcenter.tasks.run_import_task',
                    "kwargs": json.dumps({
                        "import_task_id": task_id,
                    }),
                    "enabled": task['enabled'],
                }
            )
            logger.info("\nPeriod Task: %s - Updated" % name)

        except Exception as e:
            logger.info("Exception(Task Scheduler): Task: %s Exception: %s" % (name, e))


@task(name='ozpcenter.tasks.run_import_task')
def run_import_task(import_task_id):
    """
    Run import task
    """
    try: 
        task = models.ImportTask.objects.find_by_id(import_task_id)
        import_data = get_import_data(task)
        result = ImportTaskService(import_data.json(), task.affiliated_store).run()
        errors = result['errors']
        empty_result = all(value == [] for value in result.values())

        if empty_result:
            models.ImportTaskResult.objects.create_result(import_task_id, 'Pass', 'Empty Result')
        
        if len(errors) == 0:
            models.ImportTaskResult.objects.create_result(import_task_id, 'Pass', 'Import Successful')

        else:
            models.ImportTaskResult.objects.create_result(import_task_id, 'Fail',
                                                        "Errors Found: %s" % (
                                                        errors))

    except Exception as e:
        models.ImportTaskResult.objects.create_result(import_task_id, 'Fail',
                                                    "Exception(Import Task): Task_ID: %s Exception: %s" %
                                                    (import_task_id, e))
        logger.info("Exception(Import Task): Task_ID: %s Exception: %s" % (import_task_id, e))
        print("Exception: %s" % e)


def get_import_data(task):
    """
    Retrieve import data 
    """
    url_params = task.extra_url_params
    url = task.url
    if url_params:
        url = url + url_params
        
    result = requests.get(url, timeout=180)

    if result.status_code != 200:
        msg = "Connection Error: Expected status code 200, but received {}".format(result.status_code)
        logger.info("Exception(Get Import Data): TASK_ID: %s Failed: %s" % (task.id, msg))
        raise requests.ConnectionError(msg)

    if result.status_code == 200:
        if settings.DEBUG:
            print(result.json())
        return result


# End Import Task 


def create_email_object(current_profile_email, notifications_mailbox_non_email_count):
    """
    Create Email Object
    """
    template_context = Context({'non_emailed_count': notifications_mailbox_non_email_count})

    subject_line_template = Template(settings.EMAIL_SUBJECT_FIELD_TEMPLATE)
    body_template = Template(settings.EMAIL_BODY_FIELD_TEMPLATE)

    current_email = mail.EmailMessage(
        subject_line_template.render(template_context),
        body_template.render(template_context),
        settings.EMAIL_FROM_FIELD,
        [current_profile_email],
    )
    current_email.content_subtype = 'html'  # Main content is now text/html
    return current_email


# TODO: Convert to class base task
@shared_task(bind=True)
def create_email(self, profile_id):
    """
    Create Email Task

    Args:
        profile_id: integer
    """
    results = {'error': False}
    start_time = millis()
    try:
        # TODO: profile_id to profile_id_list
        if not str(profile_id).isdigit():
            results['message'] = 'Profile id is not integer'
            results['error'] = True
            results['time'] = millis() - start_time
            return results

        # Check track of all the emails to send
        email_batch_list = []

        # Validate to make sure user exists and has email notifications flag enabled
        current_profile = models.Profile.objects.filter(id=profile_id, email_notification_flag=True).first()
        if not current_profile:
            results['message'] = 'Error Finding Profile [id: {}]'.format(profile_id)
            results['error'] = True
            results['time'] = millis() - start_time
            return results

        profile_email = current_profile.user.email

        if not profile_email:
            results['message'] = 'Error Finding Profile Email [id: {}]'.format(profile_id)
            results['error'] = True
            results['time'] = millis() - start_time
            return results

        # Retrieve All the Notifications for 'current_profile' that are not emailed yet
        notifications_mailbox_non_email = models.NotificationMailBox.objects.filter(target_profile=current_profile, emailed_status=False).all()
        notifications_mailbox_non_email_count = len(notifications_mailbox_non_email)

        if notifications_mailbox_non_email_count >= 1:
            # Construct messages
            current_email = create_email_object(profile_email, notifications_mailbox_non_email_count)

            email_batch_list.append(current_email)

            results['message'] = '{} New Notifications for username: {}'.format(notifications_mailbox_non_email_count, current_profile.user.username)
        else:
            results['message'] = 'No New Notifications for username: {}'.format(current_profile.user.username)

        logger.info(results['message'])

        if email_batch_list:
            try:
                # TODO: When coverted to class base, have connection handled by init
                connection = mail.get_connection()
                connection.open()

                connection.send_messages(email_batch_list)
                # After Sending Email to user, mark those Notifications as emailed
                for current_notification in notifications_mailbox_non_email:
                    current_notification.emailed_status = True
                    current_notification.save()
            finally:
                # The connection was already open so send_messages() doesn't close it.
                # We need to manually close the connection.
                connection.close()
                logger.info('create_email connection closed')
    except Exception as err:
        results['message'] = str(err)
        results['error'] = True
        results['time'] = millis() - start_time
    results['time'] = millis() - start_time
    return results
