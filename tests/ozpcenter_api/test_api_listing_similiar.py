"""
Tests for listing endpoints
"""
from django.test import override_settings
from tests.ozp.cases import APITestCase
from rest_framework import status

from ozpcenter import model_access as generic_model_access
from ozpcenter.scripts import sample_data_generator as data_gen


@override_settings(ES_ENABLED=False)
class ListingSimilarApiTest(APITestCase):

    def setUp(self):
        """
        setUp is invoked before each test method
        """
        self.maxDiff = None

    @classmethod
    def setUpTestData(cls):
        """
        Set up test data for the whole TestCase (only run once for the TestCase)
        """
        data_gen.run()

    def test_get_similar_list_1_categories(self):
        user = generic_model_access.get_profile('wsmith').user
        self.client.force_authenticate(user=user)

        url = '/api/listing/1/similar/'
        response = self.client.get(url, format='json')

        self.assertEqual(response.status_code, status.HTTP_200_OK)

        titles = ['{}'.format(i['title']) for i in response.data]

        expected_results = ['Acoustic Guitar',
                            'Bleach',
                            'Electric Guitar',
                            'Electric Piano',
                            'Piano',
                            'Rutebok for Norge',
                            'Sheet music',
                            'Sound Mixer',
                            'Superunknown',
                            'Ten']

        self.assertListEqual(titles, expected_results)

    def test_get_similar_list_2_categories(self):
        user = generic_model_access.get_profile('wsmith').user
        self.client.force_authenticate(user=user)

        url = '/api/listing/2/similar/'
        response = self.client.get(url, format='json')

        self.assertEqual(response.status_code, status.HTTP_200_OK)

        titles = ['{}'.format(i['title']) for i in response.data]

        expected_results = ['Air Mail',
                            'Barsoom',
                            'Bass Fishing',
                            'BeiDou Navigation Satellite System',
                            'Bombardier Transportation',
                            'Bourbon',
                            'Cable ferry',
                            'Chain boat navigation',
                            'Chatter Box',
                            'Desktop Virtualization']

        self.assertListEqual(titles, expected_results)
