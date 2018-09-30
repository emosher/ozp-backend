from unittest import skip

from django.test import override_settings

from ozpcenter.scripts import sample_data_generator as data_gen
from tests.ozp.cases import APITestCase
from tests.ozpcenter.data_util import ListingFile
from tests.ozpcenter.helper import APITestHelper
from tests.ozpcenter.helper import validate_listing_map_keys
from tests.ozpcenter.helper import validate_listing_map_keys_list
from tests.ozpcenter.helper import validate_listing_search_keys_list


@override_settings(ES_ENABLED=False)
class ListingSearchApiTest(APITestCase):

    @classmethod
    def setUpTestData(cls):
        data_gen.run()

    def setUp(self):
        pass

    def test_search_categories_single_with_space(self):
        url = '/api/listings/search/?category={}'.format('Health and Fitness')
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200, validator=validate_listing_map_keys_list)

        titles = sorted([i['title'] for i in response.data])
        listings_from_file = ListingFile.filter_listings(is_enabled=True,
                                                         approval_status='APPROVED',
                                                         categories__in=['Health and Fitness'])
        sorted_listings_from_file = sorted([listing['title'] for listing in listings_from_file])
        # TODO: TEST listing_title = Newspaper when is_private = True
        self.assertEqual(titles, sorted_listings_from_file)

    def test_search_categories_multiple_with_space(self):
        url = '/api/listings/search/?category=Health and Fitness&category=Communication'
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200, validator=validate_listing_map_keys_list)

        titles = sorted([i['title'] for i in response.data])
        listings_from_file = ListingFile.filter_listings(is_enabled=True,
                                                         approval_status='APPROVED',
                                                         categories__in=['Health and Fitness', 'Communication'])
        sorted_listings_from_file = sorted([listing['title'] for listing in listings_from_file])

        self.assertEqual(titles, sorted_listings_from_file)
        # TODO: TEST listing_title = Newspaper when is_private = True (Private apps)

    def test_search_text(self):
        url = '/api/listings/search/?search=air mail'
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200, validator=validate_listing_map_keys_list)

        titles = [i['title'] for i in response.data]
        excepted_titles = ['Air Mail']
        self.assertEqual(titles, excepted_titles)

    @skip("TODO See Below todo (rivera 20170818)")
    def test_search_text_partial(self):
        url = '/api/listings/search/?search=air ma'
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200, validator=validate_listing_map_keys_list)

        titles = [i['title'] for i in response.data]
        excepted_titles = ['Air Mail']
        #  TODO: Figure out why 'air ma' returns
        # ['Sun',  'Barbecue',  'Wolf Finder',  'LIT RANCH',  'Navigation using Maps',
        #                     'Air Mail',  'Rogue',  'Cheese and Crackers',
        #                     'Double Heroides',  'KIAA0319',  'Karta GPS',  'Sir Baboon McGood']
        self.assertEqual(titles, excepted_titles)

    def test_search_type(self):
        url = '/api/listings/search/?type=Web Application'
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200, validator=validate_listing_map_keys_list)

        titles = sorted([i['title'] for i in response.data])
        listings_from_file = ListingFile.filter_listings(is_enabled=True,
                                                         approval_status='APPROVED',
                                                         listing_type='Web Application')
        sorted_listings_from_file = sorted([listing['title'] for listing in listings_from_file])
        self.assertEqual(titles, sorted_listings_from_file)

    def test_search_tags(self):
        url = '/api/listings/search/?search=demo_tag'
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200, validator=validate_listing_map_keys_list)

        titles = sorted([i['title'] for i in response.data])
        listings_from_file = ListingFile.filter_listings(is_enabled=True,
                                                         approval_status='APPROVED',
                                                         tags__in=['demo_tag'])
        sorted_listings_from_file = sorted([listing['title'] for listing in listings_from_file])

        self.assertEqual(titles, sorted_listings_from_file)

    def test_search_tags_startwith(self):
        url = '/api/listings/search/?search=tag_'
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200, validator=validate_listing_map_keys_list)

        titles = [i['title'] for i in response.data]
        self.assertTrue('Air Mail' in titles)
        self.assertTrue(len(titles) == 1)

    def test_search_is_enable(self):
        url = '/api/listings/search/?search=demo_tag&type=Web Application'
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200, validator=validate_listing_map_keys_list)

        titles_ids = [[record.get('title'), record.get('id')] for record in response.data]
        titles = sorted([i[0] for i in titles_ids])
        expected_titles = ['Air Mail', 'Bread Basket', 'Chart Course', 'Chatter Box', 'Clipboard',
                           'FrameIt', 'Hatch Latch', 'JotSpot', 'LocationAnalyzer',
                           'LocationLister', 'LocationViewer', 'Monkey Finder', 'Skybox']

        self.assertEqual(titles, expected_titles)

        # Disable one app
        url = '/api/listing/{}/'.format(titles_ids[0][1])
        title = 'JotSpot_disabled'

        data = {
            "title": title,
            "description": "description of app",
            "launch_url": "http://www.google.com/launch",
            "version_name": "1.0.0",
            "unique_name": "org.apps.julia-one",
            "what_is_new": "nothing is new",
            "description_short": "a shorter description",
            "usage_requirements": "None",
            "system_requirements": "None",
            "is_private": "true",
            "is_enable": "false",
            "feedback_score": 0,
            "contacts": [
                {"email": "a@a.com", "secure_phone": "111-222-3434",
                 "unsecure_phone": "444-555-4545", "name": "me",
                 "contact_type": {"name": "Government"}
                 },
                {"email": "b@b.com", "secure_phone": "222-222-3333",
                 "unsecure_phone": "555-555-5555", "name": "you",
                 "contact_type": {"name": "Military"}
                 }
            ],
            "security_marking": "UNCLASSIFIED",
            "listing_type": {"title": "Web Application"},
            "small_icon": {"id": 1},
            "large_icon": {"id": 2},
            "banner_icon": {"id": 3},
            "large_banner_icon": {"id": 4},
            "categories": [
                {"title": "Business"},
                {"title": "Education"}
            ],
            "owners": [
                {"user": {"username": "wsmith"}},
                {"user": {"username": "julia"}}
            ],
            "tags": [
                {"name": "demo"},
                {"name": "map"}
            ],
            "intents": [
                {"action": "/application/json/view"},
                {"action": "/application/json/edit"}
            ],
            "doc_urls": [
                {"name": "wiki", "url": "http://www.google.com/wiki"},
                {"name": "guide", "url": "http://www.google.com/guide"}
            ],
            "screenshots": [
                {"small_image": {"id": 1}, "large_image": {"id": 2}, "description": "Test Description"},
                {"small_image": {"id": 3}, "large_image": {"id": 4}, "description": "Test Description"}
            ]

        }

        response = APITestHelper.request(self, url, 'PUT', username='bigbrother', data=data, status_code=200, validator=validate_listing_map_keys)

        # Check
        url = '/api/listings/search/?search=demo_tag&type=Web Application'
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200, validator=validate_listing_map_keys_list)

        titles_ids = [[record.get('title'), record.get('id')] for record in response.data]
        titles = sorted([i[0] for i in titles_ids])

        expected_titles = ['Air Mail', 'Bread Basket', 'Chart Course', 'Chatter Box', 'Clipboard',
                           'FrameIt', 'Hatch Latch', 'LocationAnalyzer',
                           'LocationLister', 'LocationViewer', 'Monkey Finder', 'Skybox']

        self.assertEqual(titles, expected_titles)

    def test_search_agency(self):
        url = '/api/listings/search/?agency=Minipax&agency=Miniluv'
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200, validator=validate_listing_map_keys_list)

        titles = [i['title'] for i in response.data]
        self.assertTrue('Chatter Box' in titles)

    def test_search_limit(self):
        """
        test_search_limit

        testing for limit
        """
        # TODO rivera-20171026: Titles not predictable, This will change every time
        # url = '/api/listings/search/'
        # response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200, validator=validate_listing_map_keys_list)
        # all_titles = [i['title'] for i in response.data]

        for limit_number in [1, 5, 10]:
            url = '/api/listings/search/?limit={}'.format(limit_number)
            response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200, validator=validate_listing_search_keys_list)
            titles = [i['title'] for i in response.data['results']]
            self.assertEqual(len(titles), limit_number)
            # self.assertEqual(titles, all_titles[:limit_number])

    def test_search_offset_limit(self):
        # TODO rivera-20171026: Figure out how to make sure offset is working
        for limit_number in [1, 5, 10]:
            url = '/api/listings/search/?offset=1&limit={}'.format(limit_number)
            response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200, validator=validate_listing_search_keys_list)
            titles = [i['title'] for i in response.data['results']]
            self.assertEqual(len(titles), limit_number)
