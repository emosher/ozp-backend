from __future__ import absolute_import, unicode_literals

import os
from celery import Celery

# set the default Django settings module for the 'celery' program.
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'ozp.settings')

app = Celery('ozp')
# Using a string here means the worker doesn't have to serialize
# the configuration object to child processes.
# - namespace='CELERY' means all celery-related configuration keys
#   should have a `CELERY_` prefix.
app.config_from_object('django.conf:settings', namespace='CELERY')

# Load task modules from all registered Django app configs.
app.autodiscover_tasks()


@app.task(bind=True)
def debug_task(self):
    print('Request: {0!r}'.format(self.request))


# from ozp.celery import app
# # Set the worker up to run in-place instead of using a pool
# app.conf.CELERYD_CONCURRENCY = 1
# app.conf.CELERYD_POOL = 'solo'
#
# # Code to start the worker
# def run_worker():
#     app.worker_main()
#
# # Create a thread and run the worker in it
# import threading
# t = threading.Thread(target=run_worker)
# t.setDaemon(True)
# t.start()
