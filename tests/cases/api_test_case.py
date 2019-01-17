import rest_framework.test

from ozpcenter.models import Profile
from tests.ozp import task_runner


class APITestCase(rest_framework.test.APITestCase):

    def tasks(self):
        return task_runner.TaskRunner()

    def authenticate_as(self, profile: Profile):
        self.client.force_authenticate(user=profile.user)
