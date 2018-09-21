from rest_framework.test import APITestCase
from tests.ozp import task_runner


class APITestCase(APITestCase):

    def tasks(self):
        return task_runner.TaskRunner()
