from django.test import override_settings

from ozpcenter.scripts import sample_data_generator as data_gen
from tests.ozp.cases import APITestCase
from tests.ozpcenter.helper import APITestHelper


@override_settings(ES_ENABLED=False)
class ListingFeedbackApiTest(APITestCase):

    @classmethod
    def setUpTestData(cls):
        data_gen.run()

    def setUp(self):
        pass

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
        # Create a positive feedback
        url = '/api/listing/1/feedback/'
        data = {"feedback": 1}
        APITestHelper.request(self, url, 'POST', data=data, username='bettafish', status_code=201)

        # Check to see if created
        response = APITestHelper.request(self, url, 'GET', username='bettafish', status_code=200)
        self.assertEqual(response.data['feedback'], 1)

        # Create a positive feedback
        url = '/api/listing/1/feedback/'
        data = {"feedback": 1}
        APITestHelper.request(self, url, 'POST', data=data, username='betaraybill', status_code=201)

        # Check to see if created
        response = APITestHelper.request(self, url, 'GET', username='betaraybill', status_code=200)
        self.assertEqual(response.data['feedback'], 1)

    def test_two_user_negative_feedback_listing(self):
        # Create a negative feedback
        url = '/api/listing/1/feedback/'
        data = {"feedback": -1}
        APITestHelper.request(self, url, 'POST', data=data, username='bettafish', status_code=201)

        # Check to see if created
        response = APITestHelper.request(self, url, 'GET', username='bettafish', status_code=200)
        self.assertEqual(response.data['feedback'], -1)

        # Create a negative feedback
        url = '/api/listing/1/feedback/'
        data = {"feedback": -1}
        APITestHelper.request(self, url, 'POST', data=data, username='betaraybill', status_code=201)

        # Check to see if created
        response = APITestHelper.request(self, url, 'GET', username='betaraybill', status_code=200)
        self.assertEqual(response.data['feedback'], -1)

    def test_two_user_diff_feedback_listing(self):
        # Create a position feedback
        url = '/api/listing/1/feedback/'
        data = {"feedback": 1}
        APITestHelper.request(self, url, 'POST', data=data, username='bettafish', status_code=201)

        # Check to see if created
        response = APITestHelper.request(self, url, 'GET', username='bettafish', status_code=200)
        self.assertEqual(response.data['feedback'], 1)

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
