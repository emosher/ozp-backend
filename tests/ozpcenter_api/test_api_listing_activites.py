import json

from django.test import override_settings

from ozpcenter import models
from ozpcenter.scripts import sample_data_generator as data_gen
from tests.ozp.cases import APITestCase
from tests.ozpcenter.helper import APITestHelper


@override_settings(ES_ENABLED=False)
class ListingActivitiesApiTest(APITestCase):

    @classmethod
    def setUpTestData(cls):
        data_gen.run()

    def setUp(self):
        pass

    def test_listing_activities(self):
        action_log = []
        # CREATED
        url = '/api/listing/'
        data = {
            'title': 'mr jones app',
            'security_marking': 'UNCLASSIFIED'
        }

        response = APITestHelper.request(self, url, 'POST', data=data, username='jones', status_code=201)
        app_id = response.data['id']
        data = response.data

        # VERIFY that is was created
        url = '/api/listing/{0!s}/activity/'.format(app_id)
        response = APITestHelper.request(self, url, 'GET', username='jones', status_code=200)

        activity_actions = [i['action'] for i in response.data]
        self.assertEqual(len(activity_actions), 1)
        action_log.insert(0, models.ListingActivity.CREATED)
        self.assertEqual(activity_actions, action_log)
        activity_agency = [i['listing']['agency'] for i in response.data]
        self.assertEqual(json.dumps(activity_agency[0]), '{"title": "Ministry of Truth", "short_name": "Minitrue"}')

        # MODIFIED
        data['title'] = "mr jones mod app"
        url = '/api/listing/{0!s}/'.format(app_id)
        response = APITestHelper.request(self, url, 'PUT', data=data, username='jones', status_code=200)
        data = response.data

        # VERIFY that is was modified
        url = '/api/listing/{0!s}/activity/'.format(app_id)
        response = APITestHelper.request(self, url, 'GET', username='jones', status_code=200)

        activity_actions = [i['action'] for i in response.data]
        self.assertEqual(len(activity_actions), 2)
        action_log.insert(0, models.ListingActivity.MODIFIED)
        self.assertEqual(activity_actions, action_log)
        activity_agency = [i['listing']['agency'] for i in response.data]
        self.assertEqual(json.dumps(activity_agency[0]), '{"title": "Ministry of Truth", "short_name": "Minitrue"}')

        # SUBMITTED
        data['approval_status'] = models.Listing.PENDING
        url = '/api/listing/{0!s}/'.format(app_id)
        response = APITestHelper.request(self, url, 'PUT', data=data, username='jones', status_code=200)

        # Verify that is was submitted
        url = '/api/listing/{0!s}/activity/'.format(app_id)
        response = APITestHelper.request(self, url, 'GET', username='jones', status_code=200)

        activity_actions = [i['action'] for i in response.data]
        self.assertEqual(len(activity_actions), 3)
        action_log.insert(0, models.ListingActivity.SUBMITTED)
        self.assertEqual(activity_actions, action_log)
        self.assertTrue(models.ListingActivity.SUBMITTED in activity_actions)
        activity_agency = [i['listing']['agency'] for i in response.data]
        self.assertEqual(json.dumps(activity_agency[0]), '{"title": "Ministry of Truth", "short_name": "Minitrue"}')

        # APPROVED_ORG

        # APPROVED

        # DISABLE
        data['is_enabled'] = False
        url = '/api/listing/{0!s}/'.format(app_id)
        response = APITestHelper.request(self, url, 'PUT', data=data, username='jones', status_code=200)

        # Verify that it was disabled
        url = '/api/listing/{0!s}/activity/'.format(app_id)
        response = APITestHelper.request(self, url, 'GET', username='jones', status_code=200)
        activity_actions = [i['action'] for i in response.data]
        self.assertEqual(len(activity_actions), 4)
        action_log.insert(0, models.ListingActivity.DISABLED)
        self.assertEqual(activity_actions, action_log)
        activity_agency = [i['listing']['agency'] for i in response.data]
        self.assertEqual(json.dumps(activity_agency[0]), '{"title": "Ministry of Truth", "short_name": "Minitrue"}')

        # ENABLED
        data['is_enabled'] = True
        url = '/api/listing/{0!s}/'.format(app_id)
        response = APITestHelper.request(self, url, 'PUT', data=data, username='jones', status_code=200)

        # Verify that it was enabled
        url = '/api/listing/{0!s}/activity/'.format(app_id)
        response = APITestHelper.request(self, url, 'GET', username='jones', status_code=200)
        activity_actions = [i['action'] for i in response.data]
        self.assertEqual(len(activity_actions), 5)
        action_log.insert(0, models.ListingActivity.ENABLED)
        self.assertEqual(activity_actions, action_log)
        activity_agency = [i['listing']['agency'] for i in response.data]
        self.assertEqual(json.dumps(activity_agency[0]), '{"title": "Ministry of Truth", "short_name": "Minitrue"}')

    def test_get_all_listing_activities(self):
        """
        All stewards should be able to access this endpoint (not std users)

        Make sure org stewards of one org can't access activity for private
        listings of another org.
        """
        url = '/api/listings/activity/'
        expected_titles = ['Air Mail', 'Bread Basket', 'Chart Course', 'Chatter Box', 'Clipboard']

        # Ensure that Standard Users can not access /api/listing/activity
        APITestHelper.request(self, url, 'GET', username='jones', status_code=403)

        # Ensure that ORG_STEWARDS can access endpoint
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200)

        titles = [i['listing']['title'] for i in response.data]
        counter = 0
        for i in expected_titles:
            self.assertTrue(i in titles)
            counter += 1
        self.assertEqual(counter, len(expected_titles))

        # Ensure that APP_MALL_STEWARD access endpoint
        response = APITestHelper.request(self, url, 'GET', username='bigbrother', status_code=200)

        titles = [i['listing']['title'] for i in response.data]
        counter = 0
        for i in expected_titles:
            # Bread Basket is a private app, and bigbrother is not in that
            # organization
            if i != 'Bread Basket':
                self.assertTrue(i in titles)
                counter += 1
        self.assertEqual(counter, len(expected_titles) - 1)

    def test_get_self_listing_activities(self):
        """
        Returns activity for listings owned by current user
        """
        url = '/api/self/listings/activity/'
        expected_titles = ['Bread Basket', 'Chatter Box']
        response = APITestHelper.request(self, url, 'GET', username='julia', status_code=200)

        titles = [i['listing']['title'] for i in response.data]
        counter = 0
        for i in expected_titles:
            self.assertTrue(i in titles)
            counter += 1
        self.assertEqual(counter, len(expected_titles))

    def test_get_listing_activities_offset_limit(self):
        url = '/api/listings/activity/?offset=0&limit=24'
        response = APITestHelper.request(self, url, 'GET', username='bigbrother', status_code=200)

        data = response.data
        self.assertTrue('count' in data)
        self.assertTrue('previous' in data)
        self.assertTrue('next' in data)
        self.assertTrue('results' in data)
        self.assertTrue('/api/listings/activity/?limit=24&offset=24' in data.get('next'))
        self.assertEqual(data.get('previous'), None)
        self.assertTrue(len(data.get('results')) >= 1)

    def test_get_self_listing_activities_offset_limit(self):
        url = '/api/self/listings/activity/?offset=0&limit=24'
        response = APITestHelper.request(self, url, 'GET', username='aaronson', status_code=200)

        data = response.data
        self.assertTrue('count' in data)
        self.assertTrue('previous' in data)
        self.assertTrue('next' in data)
        self.assertTrue('results' in data)
        self.assertTrue('/api/self/listings/activity/?limit=24&offset=24' in data.get('next'))
        self.assertEqual(data.get('previous'), None)
        self.assertTrue(len(data.get('results')) >= 0)
