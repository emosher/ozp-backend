from unittest import skip

from django.test import override_settings

from ozpcenter.scripts import sample_data_generator as data_gen
from ozpcenter.utils import shorthand_dict
from tests.ozp.cases import APITestCase
from tests.ozpcenter.helper import APITestHelper


@override_settings(ES_ENABLED=False)
class ListingReviewApiTest(APITestCase):

    @classmethod
    def setUpTestData(cls):
        data_gen.run()

    def setUp(self):
        self.maxDiff = None

    def test_get_all_review_for_listing(self):
        url = '/api/listing/1/review/'
        response = APITestHelper.request(self, url, 'GET', username='bigbrother', status_code=200)
        keys_to_include = ['author', 'author.user', 'author.user.username', 'rate', 'text',
                           'review_responses', 'review_responses[*]', 'review_responses[*].rate', 'review_responses[*].text']
        response_shorten = shorthand_dict(response.data, include_keys=keys_to_include, list_star=True)

        expected_data = [
            '(author:(user:(username:charrington)),rate:3,review_responses:[],text:I love the sound of acoustic guitars rock on)',
            '(author:(user:(username:syme)),rate:5,review_responses:[(rate:0,text:Review for syme loving acoustic guitars)],text:I love the sound of acoustic guitars)',
            '(author:(user:(username:wsmith)),rate:1,review_responses:[],text:I don\'t like the sound of acoustic guitars. I like electric guitars more)',
            '(author:(user:(username:bigbrother)),rate:3,review_responses:[],text:Favorite Instrument by far. BY. FAR.)'
        ]

        self.assertEqual(response_shorten, shorthand_dict(expected_data, include_keys=keys_to_include, list_star=True))

    def test_get_listing_review_by_id(self):
        url = '/api/listing/1/review/3/'
        response = APITestHelper.request(self, url, 'GET', username='bigbrother', status_code=200)

        expected_data = {
            "review_parent": None,
            "text": "I love the sound of acoustic guitars",
            "listing": 1,
            "rate": 5
        }

        self.assertEqual(response.data['review_parent'], expected_data['review_parent'])
        self.assertEqual(response.data['text'], expected_data['text'])
        self.assertEqual(response.data['listing'], expected_data['listing'])
        self.assertEqual(response.data['rate'], expected_data['rate'])

    def test_create_listing_review(self):
        url = '/api/listing/2/review/'
        data = {
            "rate": 5,
            "text": "This is a test review"
        }
        response = APITestHelper.request(self, url, 'POST', username='bigbrother', data=data, status_code=201)

    def test_create_listing_review_invalid_rate(self):
        url = '/api/listing/2/review/'
        data = {
            "rate": -1,
            "text": "This is a test review with a invalid rate"
        }
        response = APITestHelper.request(self, url, 'POST', username='bigbrother', data=data, status_code=400)
        # TODO: ExceptionUnitTestHelper

    def test_edit_listing_review(self):
        url = '/api/listing/1/review/3/'
        data = {
            "rate": 5,
            "text": "This is the updated review text"
        }
        response = APITestHelper.request(self, url, 'PUT', username='syme', data=data, status_code=200)

        expected_data = {
            "review_parent": None,
            "text": "This is the updated review text",
            "listing": 1,
            "rate": 5
        }
        self.assertEqual(response.data['review_parent'], expected_data['review_parent'])
        self.assertEqual(response.data['text'], expected_data['text'])
        self.assertEqual(response.data['listing'], expected_data['listing'])
        self.assertEqual(response.data['rate'], expected_data['rate'])

    @skip("TODO Add validation to review text field")
    def test_edit_listing_review_no_text(self):
        # TODO: Add validation on backend to require 20 characters or more for the text field
        # validation is currently being done on front, but users can just call a curl manually with anything
        url = '/api/listing/1/review/3/'
        data = {
            "rate": 5,
            "text": ""
        }
        response = APITestHelper.request(self, url, 'PUT', username='syme', data=data, status_code=400)
        # TODO: ExceptionUnitTestHelper

    def test_edit_listing_review_no_rate(self):
        url = '/api/listing/1/review/3/'
        data = {
            "text": "This is the updated review text"
        }
        response = APITestHelper.request(self, url, 'PUT', username='syme', data=data, status_code=400)
        # TODO: ExceptionUnitTestHelper

    def test_edit_different_user_listing_review(self):
        # Trying to edit 'syme' review as user, jones
        url = '/api/listing/1/review/3/'
        data = {
            "rate": 5,
            "text": "This is the updated review text"
        }
        response = APITestHelper.request(self, url, 'PUT', username='jones', data=data, status_code=403)
        # TODO: ExceptionUnitTestHelper

    def test_delete_listing_review(self):
        url = '/api/listing/1/review/3/'
        response = APITestHelper.request(self, url, 'DELETE', username='bigbrother', status_code=204)
