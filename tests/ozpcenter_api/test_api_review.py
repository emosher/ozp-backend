"""
Tests for listing endpoints
"""
from django.test import override_settings
from rest_framework import status
from tests.ozp.cases import APITestCase

from ozpcenter import model_access as generic_model_access
from ozpcenter import models
from ozpcenter.scripts import sample_data_generator as data_gen
from tests.ozpcenter.helper import validate_listing_map_keys
from tests.ozpcenter.helper import APITestHelper
from tests.ozpcenter.helper import ExceptionUnitTestHelper


@override_settings(ES_ENABLED=False)
class ListingReviewApiTest(APITestCase):

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

    def test_get_reviews(self):
        air_mail_id = models.Listing.objects.get(title='Air Mail').id
        url = '/api/listing/{0!s}/review/'.format(air_mail_id)
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200)
        self.assertEqual(4, len(response.data))

    def test_get_single_review(self):
        air_mail_id = models.Listing.objects.get(title='Air Mail').id
        review_ids = [review.id for review in models.Review.objects.filter(listing=air_mail_id).all()]

        url = '/api/listing/{0!s}/review/{1!s}/'.format(air_mail_id, review_ids[0])  # 4/5/6/7
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200)

        self.assertTrue('rate' in response.data)
        self.assertTrue('text' in response.data)
        self.assertTrue('author' in response.data)
        self.assertTrue('listing' in response.data)

    def test_create_review(self):
        """
        test_create_review
        """
        # create a new review
        air_mail_id = models.Listing.objects.get(title='Air Mail').id
        url = '/api/listing/{0!s}/review/'.format(air_mail_id)
        data = {'rate': 4, 'text': 'winston test review'}

        user = generic_model_access.get_profile('wsmith').user
        self.client.force_authenticate(user=user)
        response = self.client.post(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

        created_id = response.data['id']
        new_review = models.Review.objects.get(id=created_id)
        self.assertEqual(created_id, new_review.id)

        # test the listing/<id>/activity endpoint
        url = '/api/listing/{0!s}/activity/'.format(air_mail_id)
        response = self.client.get(url, format='json')
        activiy_actions = [i['action'] for i in response.data]
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertTrue(models.ListingActivity.REVIEWED in activiy_actions)

        # creating a duplicate review should fail
        # http://stackoverflow.com/questions/21458387/transactionmanagementerror-you-cant-execute-queries-until-the-end-of-the-atom
        # try:
        #     with transaction.atomic():
        #         response = self.client.post(url, data, format='json')
        #         # self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        #         self.assertTrue(0, 'Duplicate question allowed.')
        # except IntegrityError:
        #     pass

    def test_create_review_not_found(self):
        """
        test_create_review_not_found
        Creating a review for an app this user cannot see should fail
        """
        bread_basket_id = models.Listing.objects.get(title='Bread Basket').id
        url = '/api/listing/{0!s}/review/'.format(bread_basket_id)
        data = {'rate': 4, 'text': 'rutherford test review'}

        user = generic_model_access.get_profile('rutherford').user
        self.client.force_authenticate(user=user)
        response = self.client.post(url, data, format='json')

        self.assertEqual(response.data, ExceptionUnitTestHelper.not_found('Object Not found.'))

    def test_create_review_no_text(self):
        # test_create_review_no_text
        air_mail_id = models.Listing.objects.get(title='Air Mail').id
        url = '/api/listing/{0!s}/review/'.format(air_mail_id)
        data = {'rate': 3}

        user = generic_model_access.get_profile('julia').user
        self.client.force_authenticate(user=user)
        response = self.client.post(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

        created_id = response.data['id']
        new_review = models.Review.objects.get(id=created_id)
        self.assertEqual(created_id, new_review.id)

    def test_update_review(self):
        """
        test_update_review
        Also tests the listing/<id>/activity endpoint
        """
        # create a new review
        air_mail_id = models.Listing.objects.get(title='Air Mail').id
        url = '/api/listing/{0!s}/review/'.format(air_mail_id)
        data = {'rate': 4, 'text': 'winston test review'}

        user = generic_model_access.get_profile('wsmith').user
        self.client.force_authenticate(user=user)
        response = self.client.post(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

        review_id = response.data['id']

        # now update it
        url = '/api/listing/{0!s}/review/{1!s}/'.format(air_mail_id, review_id)
        data = {'rate': 4, 'text': 'winston test review'}
        response = self.client.put(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(4, response.data['rate'])

        # test the listing/<id>/activity endpoint
        url = '/api/listing/{0!s}/activity/'.format(air_mail_id)
        response = self.client.get(url, format='json')
        activiy_actions = [i['action'] for i in response.data]

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertTrue(models.ListingActivity.REVIEW_EDITED in activiy_actions)

        # try to edit a review from another user - should fail
        url = '/api/listing/{0!s}/review/1/'.format(air_mail_id)
        data = {'rate': 4, 'text': 'winston test review'}
        response = self.client.put(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_simple_delete_review(self):
        # test_simple_delete_review
        air_mail_id = models.Listing.objects.get(title='Air Mail').id
        url = '/api/listing/{0!s}/review/'.format(air_mail_id)
        data = {'rate': 4, 'text': 'rutherford test review'}

        user = generic_model_access.get_profile('rutherford').user
        self.client.force_authenticate(user=user)
        response = self.client.post(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

        review_id = response.data['id']

        # now delete it
        url = '/api/listing/{0!s}/review/{1!s}/'.format(air_mail_id, review_id)
        response = self.client.delete(url, format='json')
        self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)

        # test the listing/<id>/activity endpoint
        url = '/api/listing/{0!s}/activity/'.format(air_mail_id)
        response = self.client.get(url, format='json')
        activiy_actions = [i['action'] for i in response.data]
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertTrue(models.ListingActivity.REVIEW_DELETED in activiy_actions)

    def test_delete_review(self):
        # test_delete_review
        air_mail_id = models.Listing.objects.get(title='Air Mail').id
        url = '/api/listing/{0!s}/review/'.format(air_mail_id)
        data = {'rate': 4, 'text': 'winston test review'}

        user = generic_model_access.get_profile('wsmith').user
        self.client.force_authenticate(user=user)
        response = self.client.post(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

        review_id = response.data['id']

        # trying to delete it as a different user should fail...
        url = '/api/listing/{0!s}/review/{1!s}/'.format(air_mail_id, review_id)
        user = generic_model_access.get_profile('jones').user
        self.client.force_authenticate(user=user)
        response = self.client.delete(url, format='json')
        self.assertEqual(response.data, ExceptionUnitTestHelper.permission_denied("Cannot update another user's review"))

        # ... unless that user is an org steward or apps mall steward
        user = generic_model_access.get_profile('julia').user
        self.client.force_authenticate(user=user)
        response = self.client.delete(url, format='json')
        self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)

        # Check listing history
        url = '/api/listing/{0!s}/'.format(air_mail_id)
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200)
        data = response.data

        self.assertEqual(validate_listing_map_keys(data), [])
        self.assertEqual(data['last_activity']['author']['user']['username'], 'julia')
        self.assertEqual(data['last_activity']['action'], 'REVIEW_DELETED')
        self.assertEqual(data['last_activity']['listing']['id'], air_mail_id)

    def test_rating_updates(self):
        """
        test_rating_updates
        Tests that reviews are updated
        """
        # get a listing with no reviews
        title = 'Hatch Latch'
        listing = models.Listing.objects.get(title=title)

        self.assertEqual(listing.avg_rate, 0.0)
        self.assertEqual(listing.total_votes, 0)
        self.assertEqual(listing.total_reviews, 0)
        self.assertEqual(listing.total_rate1, 0)
        self.assertEqual(listing.total_rate2, 0)
        self.assertEqual(listing.total_rate3, 0)
        self.assertEqual(listing.total_rate4, 0)
        self.assertEqual(listing.total_rate5, 0)

        # add one review
        url = '/api/listing/{0!s}/review/'.format(listing.id)
        data = {'rate': 1, 'text': 'winston test review'}

        user = generic_model_access.get_profile('wsmith').user
        self.client.force_authenticate(user=user)
        response = self.client.post(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

        # check calculations
        listing = models.Listing.objects.get(title=title)
        self.assertEqual(listing.avg_rate, 1.0)
        self.assertEqual(listing.total_votes, 1)
        self.assertEqual(listing.total_reviews, 1)
        self.assertEqual(listing.total_rate1, 1)
        self.assertEqual(listing.total_rate2, 0)
        self.assertEqual(listing.total_rate3, 0)
        self.assertEqual(listing.total_rate4, 0)
        self.assertEqual(listing.total_rate5, 0)

        # add a review
        url = '/api/listing/{0!s}/review/'.format(listing.id)
        data = {'rate': 2, 'text': 'julia test review'}

        user = generic_model_access.get_profile('julia').user
        self.client.force_authenticate(user=user)
        response = self.client.post(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

        # add a review
        url = '/api/listing/{0!s}/review/'.format(listing.id)
        data = {'rate': 3, 'text': 'charrington test review'}

        user = generic_model_access.get_profile('charrington').user
        self.client.force_authenticate(user=user)
        response = self.client.post(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

        # add a review
        url = '/api/listing/{0!s}/review/'.format(listing.id)
        data = {'rate': 4, 'text': 'jones test review'}

        user = generic_model_access.get_profile('jones').user
        self.client.force_authenticate(user=user)
        response = self.client.post(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

        # add a review
        url = '/api/listing/{0!s}/review/'.format(listing.id)
        data = {'rate': 5, 'text': 'rutherford test review'}

        user = generic_model_access.get_profile('rutherford').user
        self.client.force_authenticate(user=user)
        response = self.client.post(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

        # add a review
        url = '/api/listing/{0!s}/review/'.format(listing.id)
        data = {'rate': 5, 'text': 'syme test review'}

        user = generic_model_access.get_profile('syme').user
        self.client.force_authenticate(user=user)
        response = self.client.post(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

        syme_review_id = response.data['id']

        # and one without a review
        url = '/api/listing/{0!s}/review/'.format(listing.id)
        data = {'rate': 4}

        user = generic_model_access.get_profile('tparsons').user
        self.client.force_authenticate(user=user)
        response = self.client.post(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

        tparsons_review_id = response.data['id']

        # check calculations
        listing = models.Listing.objects.get(title=title)
        # (2*5 + 2*4 + 1*3 + 1*2 + 1*1)/7 = (24)/7 = 3.429
        self.assertEqual(listing.avg_rate, 3.4)
        self.assertEqual(listing.total_votes, 7)
        self.assertEqual(listing.total_reviews, 6)
        self.assertEqual(listing.total_rate1, 1)
        self.assertEqual(listing.total_rate2, 1)
        self.assertEqual(listing.total_rate3, 1)
        self.assertEqual(listing.total_rate4, 2)
        self.assertEqual(listing.total_rate5, 2)

        # update an existing review (tparsons)
        url = '/api/listing/{0!s}/review/{1!s}/'.format(listing.id, tparsons_review_id)
        data = {'rate': 2}

        user = generic_model_access.get_profile('tparsons').user
        self.client.force_authenticate(user=user)
        response = self.client.put(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)

        # check calculations
        listing = models.Listing.objects.get(title=title)
        # (2*5 + 1*4 + 1*3 + 2*2 + 1*1)/7 = (22)/7 = 3.14
        self.assertEqual(listing.avg_rate, 3.1)
        self.assertEqual(listing.total_votes, 7)
        self.assertEqual(listing.total_reviews, 6)
        self.assertEqual(listing.total_rate1, 1)
        self.assertEqual(listing.total_rate2, 2)
        self.assertEqual(listing.total_rate3, 1)
        self.assertEqual(listing.total_rate4, 1)
        self.assertEqual(listing.total_rate5, 2)

        # delete an existing review (syme)
        url = '/api/listing/{0!s}/review/{1!s}/'.format(listing.id, syme_review_id)

        user = generic_model_access.get_profile('syme').user
        self.client.force_authenticate(user=user)
        response = self.client.delete(url, format='json')
        self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)

        # check calculations
        listing = models.Listing.objects.get(title=title)
        # (1*5 + 1*4 + 1*3 + 2*2 + 1*1)/6 = (17)/6 = 2.83
        self.assertEqual(listing.avg_rate, 2.8)
        self.assertEqual(listing.total_votes, 6)
        self.assertEqual(listing.total_reviews, 5)
        self.assertEqual(listing.total_rate1, 1)
        self.assertEqual(listing.total_rate2, 2)
        self.assertEqual(listing.total_rate3, 1)
        self.assertEqual(listing.total_rate4, 1)
        self.assertEqual(listing.total_rate5, 1)
