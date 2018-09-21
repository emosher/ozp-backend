"""
Tests for listing endpoints
"""
from django.test import override_settings
from tests.ozp.cases import APITestCase

from ozpcenter import model_access as generic_model_access
from ozpcenter.scripts import sample_data_generator as data_gen
from tests.ozpcenter.helper import APITestHelper


@override_settings(ES_ENABLED=False)
class RootApiTest(APITestCase):

    def setUp(self):
        """
        setUp is invoked before each test method
        """
        pass

    @classmethod
    def setUpTestData(cls):
        """
        Set up test data for the whole TestCase (only run once for the TestCase)
        """
        data_gen.run()

    def test_get_version(self):
        url = '/api/version/'
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200)
        self.assertIsNotNone(response.data)
