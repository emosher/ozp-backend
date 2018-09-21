"""
Tests for listing endpoints
"""
from django.test import override_settings
from rest_framework import status
from tests.ozp.cases import APITestCase

from tests.ozpcenter.helper import APITestHelper
from ozpcenter import model_access as generic_model_access
from ozpcenter.scripts import sample_data_generator as data_gen
from tests.ozpcenter.helper import validate_listing_map_keys


@override_settings(ES_ENABLED=False)
class ListingUserApiTest(APITestCase):

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

    def test_self_listing(self):
        url = '/api/self/listing/'
        response = APITestHelper.request(self, url, 'GET', username='julia', status_code=200)

        titles = [i['title'] for i in response.data]
        self.assertTrue('Bread Basket' in titles)
        self.assertTrue('Chatter Box' in titles)
        self.assertTrue('Air Mail' not in titles)
        for listing_map in response.data:
            self.assertEqual(validate_listing_map_keys(listing_map), [])

    def test_self_deleted_listing(self):
        url = '/api/self/listing/'
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200)

        titles = [i['id'] for i in response.data]
        self.assertTrue('1' not in titles)
        for listing_map in response.data:
            self.assertEqual(validate_listing_map_keys(listing_map), [])
