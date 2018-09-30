from ozpcenter import model_access as generic_model_access
from ozpcenter.scripts import sample_data_generator as data_gen
from tests.ozp.cases import APITestCase


class IntentApiTest(APITestCase):

    @classmethod
    def setUpTestData(cls):
        data_gen.run()

    def setUp(self):
        pass

    def test_intent_api(self):
        user = generic_model_access.get_profile('wsmith').user
        self.client.force_authenticate(user=user)

        # get intent url from root endpoint
        url = '/iwc-api/'
        root_api_resp = self.client.get(url, format='json')

        url = root_api_resp.data['_links']['ozp:intent']['href']
        # test the list endpoint
        intent_list_resp = self.client.get(url, format='json')
        # now get the first intent in the list
        url = intent_list_resp.data['_links']['item'][0]['href']
        intent = self.client.get(url, format='json').data
        expected_fields = ['id', 'icon', 'action', 'media_type', 'label']
        for i in expected_fields:
            self.assertTrue(i in intent)
