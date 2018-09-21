from __future__ import absolute_import, unicode_literals
from celery.utils.log import get_task_logger
from celery import shared_task
from django.core import mail
from django.template import Context
from django.template import Template
from django.conf import settings

from ozpcenter import models
from ozpcenter.utils import millis

logger = get_task_logger(__name__)


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
