from django.test import override_settings

from ozpcenter.scripts import sample_data_generator as data_gen
from ozpcenter.utils import shorthand_dict
from tests.ozp.cases import APITestCase
from tests.ozpcenter.helper import APITestHelper
from tests.ozpcenter.helper import ExceptionUnitTestHelper


@override_settings(ES_ENABLED=False)
class AgencyApiTest(APITestCase):

    @classmethod
    def setUpTestData(cls):
        data_gen.run()

    def setUp(self):
        pass

    def test_get_agencies_list(self):
        url = '/api/agency/'
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200)
        shorten_data = shorthand_dict(response.data, exclude_keys=['id'])

        expected_results = [
            '(short_name:Miniluv,title:Ministry of Love)',
            '(short_name:Minipax,title:Ministry of Peace)',
            '(short_name:Miniplen,title:Ministry of Plenty)',
            '(short_name:Minitrue,title:Ministry of Truth)',
            '(short_name:Test,title:Test)',
            '(short_name:Test 1,title:Test 1)',
            '(short_name:Test2,title:Test 2)',
            '(short_name:Test 3,title:Test 3)',
            '(short_name:Test 4,title:Test 4)']

        self.assertEqual(shorten_data, expected_results)

    def test_get_agency(self):
        url = '/api/agency/1/'
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200)
        shorten_data = shorthand_dict(response.data, exclude_keys=['id'])

        expected_results = '(short_name:Minitrue,title:Ministry of Truth)'
        self.assertEqual(shorten_data, expected_results)

    def test_create_agency_apps_mall_steward(self):
        url = '/api/agency/'
        data = {'title': 'new agency', 'short_name': 'orgname'}
        response = APITestHelper.request(self, url, 'POST', data=data, username='bigbrother', status_code=201)
        shorten_data = shorthand_dict(response.data, exclude_keys=['id'])

        self.assertEqual(shorten_data, '(short_name:orgname,title:new agency)')

    def test_create_agency_org_steward(self):
        url = '/api/agency/'
        data = {'title': 'new agency', 'short_name': 'orgname'}
        response = APITestHelper.request(self, url, 'POST', data=data, username='wsmith', status_code=403)

        self.assertEqual(response.data, ExceptionUnitTestHelper.permission_denied())

    # TODO def test_create_agency(self): test different user groups access control

    def test_update_agency_apps_mall_steward(self):
        url = '/api/agency/1/'
        data = {'title': 'updated agency', 'short_name': 'uporg'}
        response = APITestHelper.request(self, url, 'PUT', data=data, username='bigbrother', status_code=200)

        self.assertEqual(response.data['title'], data['title'])
        self.assertEqual(response.data['short_name'], data['short_name'])

    def test_update_agency_org_steward(self):
        url = '/api/agency/1/'
        data = {'title': 'updated agency', 'short_name': 'uporg'}
        response = APITestHelper.request(self, url, 'PUT', data=data, username='wsmith', status_code=403)

        self.assertEqual(response.data, ExceptionUnitTestHelper.permission_denied())

    # TODO def test_update_agency(self): test different user groups access control

    def test_delete_agency_apps_mall_steward(self):
        url = '/api/agency/1/'
        APITestHelper.request(self, url, 'DELETE', username='bigbrother', status_code=204)

    def test_delete_agency_org_steward(self):
        url = '/api/agency/1/'
        response = APITestHelper.request(self, url, 'DELETE', username='wsmith', status_code=403)

        self.assertEqual(response.data, ExceptionUnitTestHelper.permission_denied())

    # TODO def test_delete_agency(self): test different user groups access control
