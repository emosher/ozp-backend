"""
Purpose:
    To send Emails to users that have Notifications that has not been emailed yet

Pull Request that refactored Notifications Tables to be able to do emails
https://github.com/aml-development/ozp-backend/pull/272

Steps to send out emails:
Open connection to stmp email server

Iterate all profiles
    Validate to make sure user has emailed, if not continue to next user

Development Setup:
setting.py
    EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
    EMAIL_PORT = 1025

In a terminal
    make run_debug_email_server

Note:
    To run this script, celery work needs to be running
"""
import sys
import os
import logging

sys.path.insert(0, os.path.realpath(os.path.join(os.path.dirname(__file__), '../../')))

from ozpcenter import tasks
from ozpcenter.models import Profile
from ozpcenter.utils import millis

CHUNK_SIZE = 3

logger = logging.getLogger('ozp-center.' + str(__name__))

task_times = []


def on_raw_message(body):
    """
    Aync receiving messages and logging results

    Result format:
        {'message': '?', 'time': 9, 'error': False}
    """
    event_task_id = body.get('task_id')

    traceback = body.get('traceback')
    if traceback:
        logger.error(traceback)

    results = body.get('result', [])

    for result in results:
        if result.get('error'):
            logger.error('{} - {} [{}]'.format(event_task_id, result.get('message'), result.get('time')))
        else:
            logger.info('{} - {} [{}]'.format(event_task_id, result.get('message'), result.get('time')))
            if result.get('time'):
                task_times.append(result.get('time'))


def run():
    """
    Send Emails for notifications entry point
    """
    start_time = millis()
    profile_list = Profile.objects.values_list('id').all()
    create_email_task = tasks.create_email.chunks(profile_list, CHUNK_SIZE)
    group_results = create_email_task.apply_async()

    logger.info('Email Notification Group Results: {}'.format(group_results))
    group_results.get(on_message=on_raw_message)
    logger.info('Email Notification Aync tasks took {}'.format(millis() - start_time))
    logger.info('Sum of task times: {}'.format(sum(task_times)))
