from django.test import override_settings

from ozpcenter.scripts import sample_data_generator as data_gen
from tests.ozp.cases import APITestCase
from tests.ozpcenter.helper import APITestHelper


@override_settings(ES_ENABLED=False)
class RootApiTest(APITestCase):

    @classmethod
    def setUpTestData(cls):
        data_gen.run()

    def setUp(self):
        pass

    def test_get_version(self):
        url = '/api/version/'
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200)
        self.assertIsNotNone(response.data)
