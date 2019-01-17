from rest_framework import status

import ozpcenter.model_access as generic_model_access
from ozpcenter.scripts import sample_data_generator as data_gen
from tests.ozp.cases import APITestCase


class SystemApiTest(APITestCase):

    @classmethod
    def setUpTestData(cls):
        data_gen.run()

    def setUp(self):
        pass

    def test_get_listings(self):
        user = generic_model_access.get_profile('wsmith').user
        self.client.force_authenticate(user=user)
        # url = '/iwc-api/profile/{0!s}/application/'.format(user.id)
        url = '/iwc-api/self/application/'
        response = self.client.get(url, format='json')

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertTrue('_links' in response.data)
        self.assertTrue('_embedded' in response.data)
        # self.assertTrue('item' in response.data)make
        # self.assertTrue(len(response.data['item']) > 3)

    def test_get_listing(self):
        user = generic_model_access.get_profile('wsmith').user
        self.client.force_authenticate(user=user)
        url = '/iwc-api/listing/1/'
        response = self.client.get(url, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertTrue('_links' in response.data)
        self.assertTrue('_embedded' in response.data)
        self.assertTrue('id' in response.data)
        self.assertTrue('title' in response.data)
        self.assertTrue('unique_name' in response.data)
        self.assertTrue('intents' in response.data)

    def test_get_system(self):
        user = generic_model_access.get_profile('wsmith').user
        self.client.force_authenticate(user=user)
        url = '/iwc-api/system/'
        response = self.client.get(url, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertTrue('_links' in response.data)
        self.assertTrue('_embedded' in response.data)
        self.assertTrue('version' in response.data)
        self.assertTrue('name' in response.data)
