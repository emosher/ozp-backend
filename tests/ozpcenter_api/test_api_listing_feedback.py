"""
Tests for listing feedback
"""
from django.test import override_settings
from rest_framework import status
from tests.ozp.cases import APITestCase

from ozpcenter import model_access as generic_model_access
from ozpcenter import models
from ozpcenter.scripts import sample_data_generator as data_gen
import ozpcenter.api.listing.model_access as model_access
from tests.ozpcenter.helper import validate_listing_map_keys
from tests.ozpcenter.helper import APITestHelper


@override_settings(ES_ENABLED=False)
class ListingFeedbackApiTest(APITestCase):

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

    def test_no_feedback_listing(self):
        url = '/api/listing/1/feedback/'
        response = APITestHelper.request(self, url, 'GET', username='bettafish', status_code=404)

        self.assertEqual(response.data['feedback'], 0)

    def test_positive_feedback_listing(self):
        # Create a positive feedback
        url = '/api/listing/1/feedback/'
        data = {"feedback": 1}
        APITestHelper.request(self, url, 'POST', data=data, username='bettafish', status_code=201)

        # Check to see if created
        response = APITestHelper.request(self, url, 'GET', username='bettafish', status_code=200)
        self.assertEqual(response.data['feedback'], 1)

        # Check with a different beta group user to see if feedback exists for said user
        response = APITestHelper.request(self, url, 'GET', username='betaraybill', status_code=404)
        self.assertEqual(response.data['feedback'], 0)

    def test_negative_feedback_listing(self):
        # Create a negative feedback
        url = '/api/listing/1/feedback/'
        data = {"feedback": -1}
        APITestHelper.request(self, url, 'POST', data=data, username='bettafish', status_code=201)

        # Check to see if created
        response = APITestHelper.request(self, url, 'GET', username='bettafish', status_code=200)
        self.assertEqual(response.data['feedback'], -1)

        # Check with a different beta group user to see if feedback exists for said user
        response = APITestHelper.request(self, url, 'GET', username='betaraybill', status_code=404)
        self.assertEqual(response.data['feedback'], 0)

    def test_two_user_positive_feedback_listing(self):
        """
        test_two_user_positive_feedback_listing
        bettafish user
        """
        # Create a positive feedback
        url = '/api/listing/1/feedback/'
        data = {"feedback": 1}
        APITestHelper.request(self, url, 'POST', data=data, username='bettafish', status_code=201)

        # Check to see if created
        response = APITestHelper.request(self, url, 'GET', username='bettafish', status_code=200)
        self.assertEqual(response.data['feedback'], 1)

        """
        betaraybill user
        """
        # Create a positive feedback
        url = '/api/listing/1/feedback/'
        data = {"feedback": 1}
        APITestHelper.request(self, url, 'POST', data=data, username='betaraybill', status_code=201)

        # Check to see if created
        response = APITestHelper.request(self, url, 'GET', username='betaraybill', status_code=200)
        self.assertEqual(response.data['feedback'], 1)

    def test_two_user_negative_feedback_listing(self):
        """
        test_two_user_negative_feedback_listing
        bettafish user
        """
        # Create a negative feedback
        url = '/api/listing/1/feedback/'
        data = {"feedback": -1}
        APITestHelper.request(self, url, 'POST', data=data, username='bettafish', status_code=201)

        # Check to see if created
        response = APITestHelper.request(self, url, 'GET', username='bettafish', status_code=200)
        self.assertEqual(response.data['feedback'], -1)

        """
        betaraybill user
        """
        # Create a negative feedback
        url = '/api/listing/1/feedback/'
        data = {"feedback": -1}
        APITestHelper.request(self, url, 'POST', data=data, username='betaraybill', status_code=201)

        # Check to see if created
        response = APITestHelper.request(self, url, 'GET', username='betaraybill', status_code=200)
        self.assertEqual(response.data['feedback'], -1)

    def test_two_user_diff_feedback_listing(self):
        """
        test_two_user_diff_feedback_listing
        bettafish user
        """
        # Create a position feedback
        url = '/api/listing/1/feedback/'
        data = {"feedback": 1}
        APITestHelper.request(self, url, 'POST', data=data, username='bettafish', status_code=201)

        # Check to see if created
        response = APITestHelper.request(self, url, 'GET', username='bettafish', status_code=200)
        self.assertEqual(response.data['feedback'], 1)

        """
        betaraybill user
        """
        # Create a negative feedback
        url = '/api/listing/1/feedback/'
        data = {"feedback": -1}
        APITestHelper.request(self, url, 'POST', data=data, username='betaraybill', status_code=201)

        # Check to see if created
        response = APITestHelper.request(self, url, 'GET', username='betaraybill', status_code=200)
        self.assertEqual(response.data['feedback'], -1)

    def test_delete_listing_feedback(self):
        # Create a position feedback
        url = '/api/listing/1/feedback/'
        data = {"feedback": 1}
        APITestHelper.request(self, url, 'POST', data=data, username='bettafish', status_code=201)

        # Check to see if created
        response = APITestHelper.request(self, url, 'GET', username='bettafish', status_code=200)
        self.assertEqual(response.data['feedback'], 1)

        # DELETE
        url = '/api/listing/1/feedback/1/'
        APITestHelper.request(self, url, 'DELETE', username='bettafish', status_code=204)

        # VERIFY
        url = '/api/listing/1/feedback/'
        response = APITestHelper.request(self, url, 'GET', username='bettafish', status_code=404)

        self.assertEqual(response.data['feedback'], 0)

    def test_delete_listing_non_existing_feedback(self):
        url = '/api/listing/1/feedback/1/'
        response = APITestHelper.request(self, url, 'DELETE', username='bettafish', status_code=404)
        # TODO ExceptionUnitTestHelper
