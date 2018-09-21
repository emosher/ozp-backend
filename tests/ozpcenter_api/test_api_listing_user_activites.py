"""
Tests for listing endpoints
"""
from django.test import override_settings
from tests.ozp.cases import APITestCase

from ozpcenter.scripts import sample_data_generator as data_gen


@override_settings(ES_ENABLED=False)
class ListingUserActivitiesApiTest(APITestCase):

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
        pass
        # data_gen.run()
