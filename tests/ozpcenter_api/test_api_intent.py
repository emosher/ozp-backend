from django.test import override_settings

from ozpcenter.scripts import sample_data_generator as data_gen
from tests.ozp.cases import APITestCase
from tests.ozpcenter.helper import APITestHelper


@override_settings(ES_ENABLED=False)
class IntentApiTest(APITestCase):

    @classmethod
    def setUpTestData(cls):
        data_gen.run()

    def setUp(self):
        pass

    def test_get_intent_list(self):
        url = '/api/intent/'
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200)

        actions = [i['action'] for i in response.data]
        self.assertTrue('/application/json/view' in actions)
        self.assertTrue(response.data[0]['icon'] is not None)
        self.assertTrue(response.data[0]['media_type'] is not None)
        self.assertTrue(response.data[0]['label'] is not None)

    def test_get_intent(self):
        url = '/api/intent/1/'
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200)

        self.assertEqual(response.data['action'], '/application/json/view')

    def test_create_intent(self):
        url = '/api/intent/'
        data = {'action': '/application/test',
                'media_type': 'vnd.ozp-intent-v1+json.json', 'label': 'test',
                'icon': {'id': 1, 'security_marking': 'UNCLASSIFIED'}}

        response = APITestHelper.request(self, url, 'POST', data=data, username='bigbrother', status_code=201)
        self.assertEqual(response.data['action'], '/application/test')

    def test_update_intent(self):
        url = '/api/intent/1/'
        action = '/application/json/viewtest'
        media_type = 'vnd.ozp-intent-v2+json.json'
        label = 'mylabel'
        data = {'action': action,
                'media_type': media_type, 'label': label,
                'icon': {'id': 1, 'security_marking': 'UNCLASSIFIED'}}

        response = APITestHelper.request(self, url, 'PUT', data=data, username='bigbrother', status_code=200)

        self.assertEqual(response.data['action'], action)
        self.assertEqual(response.data['label'], label)
        self.assertEqual(response.data['media_type'], media_type)

    def test_delete_intent(self):
        url = '/api/intent/1/'
        APITestHelper.request(self, url, 'DELETE', username='bigbrother', status_code=204)
