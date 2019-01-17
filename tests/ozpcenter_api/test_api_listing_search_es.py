import logging

from django.test import override_settings
from rest_framework import status

from ozpcenter.api.listing import model_access_es
from ozpcenter.api.listing.elasticsearch_util import elasticsearch_factory
from ozpcenter.scripts import sample_data_generator as data_gen
from tests.ozp.cases import APITestCase
from tests.ozpcenter.data_util import ListingFile
from tests.ozpcenter.helper import APITestHelper


@override_settings(ES_ENABLED=False)
class ListingESSearchApiTest(APITestCase):

    @classmethod
    def setUpTestData(cls):
        data_gen.run()

    @override_settings(ES_ENABLED=True)
    def setUp(self):
        self.error_string = None
        self.es_failed = False
        try:
            elasticsearch_factory.check_elasticsearch()
        except Exception as err:
            self.error_string = str(err)
            self.es_failed = True

        if not self.es_failed:
            logging.getLogger('elasticsearch').setLevel(logging.CRITICAL)
            model_access_es.bulk_reindex()

    @override_settings(ES_ENABLED=True)
    def test_essearch_categories_single_with_space(self):
        # TODO: Iterate through all categories in categories.yaml file, Deal with Private apps
        # TODO: TEST listing_title = Newspaper when is_private = True
        if self.es_failed:
            self.skipTest('Elasticsearch is not currently up: {}'.format(self.error_string))

        search_category = 'Health and Fitness'
        url = '/api/listings/essearch/?category={}'.format(search_category)
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200)

        titles = sorted([i['title'] for i in response.data['results']])
        listings_from_file = ListingFile.filter_listings(is_enabled=True,
                                                         approval_status='APPROVED',
                                                         categories__in=['Health and Fitness'])
        sorted_listings_from_file = sorted([listing['title'] for listing in listings_from_file])
        self.assertEqual(titles, sorted_listings_from_file)

    @override_settings(ES_ENABLED=True)
    def test_essearch_categories_multiple_with_space(self):
        # TODO: TEST listing_title = Newspaper when is_private = True
        if self.es_failed:
            self.skipTest('Elasticsearch is not currently up: {}'.format(self.error_string))
        url = '/api/listings/essearch/?category=Health and Fitness&category=Communication'
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200)

        titles = sorted([i['title'] for i in response.data['results']])
        listings_from_file = ListingFile.filter_listings(is_enabled=True,
                                                         approval_status='APPROVED',
                                                         categories__in=['Health and Fitness', 'Communication'])
        sorted_listings_from_file = sorted([listing['title'] for listing in listings_from_file])

        self.assertEqual(titles, sorted_listings_from_file)

    #
    # def test_search_text(self):
    #     user = generic_model_access.get_profile('wsmith').user
    #     self.client.force_authenticate(user=user)
    #     url = '/api/listings/search/?search=air mail'
    #     #  url = '/api/listings/search/?search=air ma'
    #     #  TODO: Figure out why 'air ma' returns
    #     # ['Sun',  'Barbecue',  'Wolf Finder',  'LIT RANCH',  'Navigation using Maps',
    #     #                     'Air Mail',  'Rogue',  'Cheese and Crackers',
    #     #                     'Double Heroides',  'KIAA0319',  'Karta GPS',  'Sir Baboon McGood']
    #     response = self.client.get(url, format='json')
    #     self.assertEqual(response.status_code, status.HTTP_200_OK)
    #
    #     titles = [i['title'] for i in response.data['results']]
    #     excepted_titles = ['Air Mail']
    #     self.assertEqual(titles, excepted_titles)
    #     for listing_map in response.data:
    #         self.assertEqual(validate_listing_map_keys(listing_map), [])
    #
    # @skip("TODO See Below todo (rivera 20170818)")
    # def test_search_text_partial(self):
    #     user = generic_model_access.get_profile('wsmith').user
    #     self.client.force_authenticate(user=user)
    #     url = '/api/listings/search/?search=air ma'
    #
    #     response = self.client.get(url, format='json')
    #     self.assertEqual(response.status_code, status.HTTP_200_OK)
    #
    #     titles = [i['title'] for i in response.data['results']]
    #     excepted_titles = ['Air Mail']
    #     #  TODO: Figure out why 'air ma' returns
    #     # ['Sun',  'Barbecue',  'Wolf Finder',  'LIT RANCH',  'Navigation using Maps',
    #     #                     'Air Mail',  'Rogue',  'Cheese and Crackers',
    #     #                     'Double Heroides',  'KIAA0319',  'Karta GPS',  'Sir Baboon McGood']
    #     self.assertEqual(titles, excepted_titles)
    #     for listing_map in response.data:
    #         self.assertEqual(validate_listing_map_keys(listing_map), [])
    #

    @override_settings(ES_ENABLED=True)
    def test_essearch_filter_type(self):
        # TODO: Iterate through all Listings types in listings_types.yaml file, Deal with Private apps
        if self.es_failed:
            self.skipTest('Elasticsearch is not currently up: {}'.format(self.error_string))

        url = '/api/listings/essearch/?type=Web Application'
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200)

        titles = sorted([i['title'] for i in response.data['results']])
        listings_from_file = ListingFile.filter_listings(is_enabled=True,
                                                         approval_status='APPROVED',
                                                         listing_type='Web Application')
        sorted_listings_from_file = sorted([listing['title'] for listing in listings_from_file])
        self.assertEqual(titles, sorted_listings_from_file)

    @override_settings(ES_ENABLED=True)
    def test_essearch_tags(self):
        if self.es_failed:
            self.skipTest('Elasticsearch is not currently up: {}'.format(self.error_string))

        url = '/api/listings/essearch/?search=demo_tag'
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200)

        titles = sorted([i['title'] for i in response.data['results']])
        expected_listing = ['Air Mail', 'Bread Basket', 'Chart Course', 'Chatter Box', 'Clipboard',
                            'Deadpool', 'Desktop Virtualization', 'Diamond', 'Dinosaur', 'Dragons', 'FrameIt',
                            'Harley-Davidson CVO', 'Hatch Latch', 'JotSpot', 'LocationAnalyzer', 'LocationLister',
                            'LocationViewer', 'Mini Dachshund', 'Monkey Finder', 'Personal Computer', 'Ruby on Rails',
                            'Skybox', 'Smart Phone', 'Taxonomy Classifier']

        self.assertEqual(titles, expected_listing)

    @override_settings(ES_ENABLED=True)
    def test_essearch_filter_tag(self):
        if self.es_failed:
            self.skipTest('Elasticsearch is not currently up: {}'.format(self.error_string))

        url = '/api/listings/essearch/?tag=demo_tag'
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200)

        titles = sorted([i['title'] for i in response.data['results']])
        listings_from_file = ListingFile.filter_listings(is_enabled=True,
                                                         approval_status='APPROVED',
                                                         tags__in=['demo_tag'])
        sorted_listings_from_file = sorted([listing['title'] for listing in listings_from_file])

        self.assertEqual(titles, sorted_listings_from_file)

    # def test_search_tags_startwith(self):
    #     user = generic_model_access.get_profile('wsmith').user
    #     self.client.force_authenticate(user=user)
    #     url = '/api/listings/search/?search=tag_'
    #     response = self.client.get(url, format='json')
    #     self.assertEqual(response.status_code, status.HTTP_200_OK)
    #
    #     titles = [i['title'] for i in response.data['results']]
    #     self.assertTrue('Air Mail' in titles)
    #     self.assertTrue(len(titles) == 1)
    #     for listing_map in response.data:
    #         self.assertEqual(validate_listing_map_keys(listing_map), [])
    #
    @override_settings(ES_ENABLED=True)
    def test_essearch_is_enable(self):
        # Elasticsearch Search should be independent from database(sqlite/postgresql)
        if self.es_failed:
            self.skipTest('Elasticsearch is not currently up: {}'.format(self.error_string))

        url = '/api/listings/essearch/?search=demo_tag&type=Web Application'
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200)

        titles_ids = [{'title': record.get('title'), 'id': record.get('id')} for record in response.data['results']]
        titles = sorted([i['title'] for i in titles_ids])
        expected_titles = ['Air Mail', 'Bread Basket', 'Chart Course', 'Chatter Box', 'Clipboard',
                           'FrameIt', 'Hatch Latch', 'JotSpot', 'LocationAnalyzer', 'LocationLister',
                           'LocationViewer', 'Monkey Finder', 'Skybox', 'Smart Phone', 'Taxonomy Classifier']

        self.assertEqual(titles, expected_titles)

        first_record = titles_ids[0]
        id_to_disable = first_record['id']

        replace_dict = {'title': '{}_disabled'.format(first_record['title']),
                        'is_enabled': False}

        # Disable one app
        APITestHelper.edit_listing(self, id_to_disable, replace_dict, 'bigbrother')

        elasticsearch_factory.wait_for_yellow_cluster_heath()

        # Check
        url = '/api/listings/essearch/?search=demo_tag&type=Web Application'
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200)

        titles_ids = [{'title': record.get('title'), 'id': record.get('id')} for record in response.data['results']]
        titles = sorted([i['title'] for i in titles_ids])
        expected_titles = ['Bread Basket', 'Chart Course', 'Chatter Box', 'Clipboard',
                           'FrameIt', 'Hatch Latch', 'JotSpot', 'LocationAnalyzer', 'LocationLister',
                           'LocationViewer', 'Monkey Finder', 'Skybox', 'Smart Phone', 'Taxonomy Classifier']

        self.assertEqual(titles, expected_titles)

    #
    # def test_search_agency(self):
    #     user = generic_model_access.get_profile('wsmith').user
    #     self.client.force_authenticate(user=user)
    #     url = '/api/listings/search/?agency=Minipax&agency=Miniluv'
    #     response = self.client.get(url, format='json')
    #     self.assertEqual(response.status_code, status.HTTP_200_OK)
    #
    #     titles = [i['title'] for i in response.data['results']]
    #     self.assertTrue('Chatter Box' in titles)
    #     for listing_map in response.data:
    #         self.assertEqual(validate_listing_map_keys(listing_map), [])
    #
    # def test_search_limit(self):
    #     user = generic_model_access.get_profile('wsmith').user
    #     self.client.force_authenticate(user=user)
    #     url = '/api/listings/search/?limit=1'
    #     response = self.client.get(url, format='json')
    #     self.assertEqual(response.status_code, status.HTTP_200_OK)
    #
    #     titles = [i['title'] for i in response.data['results']]
    #     # TODO: Not predictable, This will change every time listing.yaml changes
    #     self.assertTrue('Global Navigation Grid Code' in titles)
    #     self.assertEqual(len(titles), 1)
    #     for listing_map in response.data['results']:
    #         self.assertEqual(validate_listing_map_keys(listing_map), [])
    #
    # def test_search_offset_limit(self):
    #     user = generic_model_access.get_profile('wsmith').user
    #     self.client.force_authenticate(user=user)
    #     url = '/api/listings/search/?offset=1&limit=1'
    #     response = self.client.get(url, format='json')
    #     self.assertEqual(response.status_code, status.HTTP_200_OK)
    #
    #     titles = [i['title'] for i in response.data['results']]
    #     # TODO: Not predictable, This will change every time listing.yaml changes
    #     self.assertTrue('Map of the world' in titles)
    #     self.assertEqual(len(titles), 1)
    #     for listing_map in response.data['results']:
    #         self.assertEqual(validate_listing_map_keys(listing_map), [])

    @override_settings(ES_ENABLED=True)
    def test_essearch_create(self):
        if self.es_failed:
            self.skipTest('Elasticsearch is not currently up: {}'.format(self.error_string))

        url = '/api/listings/essearch/?tag=demo_tag'
        response = APITestHelper.request(self, url, 'POST', username='wsmith', status_code=501)

        self.assertEqual(response.status_code, status.HTTP_501_NOT_IMPLEMENTED)
        self.assertEqual(response.data['error_code'].lower(), 'not_implemented')
        self.assertEqual(response.data['detail'].lower(), 'http verb not supported')

    @override_settings(ES_ENABLED=True)
    def test_essearch_destroy(self):
        if self.es_failed:
            self.skipTest('Elasticsearch is not currently up: {}'.format(self.error_string))

        url = '/api/listings/essearch/1/?tag=demo_tag'
        response = APITestHelper.request(self, url, 'DELETE', username='wsmith', status_code=501)

        self.assertEqual(response.status_code, status.HTTP_501_NOT_IMPLEMENTED)
        self.assertEqual(response.data['error_code'].lower(), 'not_implemented')
        self.assertEqual(response.data['detail'].lower(), 'http verb not supported')

    # Just for testing, test method_not_allowed
    @override_settings(ES_ENABLED=True)
    def test_essearch_destroy_method_not_allowed(self):
        if self.es_failed:
            self.skipTest('Elasticsearch is not currently up: {}'.format(self.error_string))

        url = '/api/listings/essearch/?tag=demo_tag'
        response = APITestHelper.request(self, url, 'DELETE', username='wsmith', status_code=405)

        self.assertEqual(response.status_code, status.HTTP_405_METHOD_NOT_ALLOWED)
        self.assertEqual(response.data['error_code'].lower(), 'method_not_allowed')

    @override_settings(ES_ENABLED=True)
    def test_essearch_partial_update(self):
        if self.es_failed:
            self.skipTest('Elasticsearch is not currently up: {}'.format(self.error_string))

        url = '/api/listings/essearch/1/?tag=demo_tag'
        # response = APITestHelper.request(self, url, 'PATCH', username='wsmith', status_code=501)
        response = APITestHelper.request(self, url, 'PATCH', username='wsmith', status_code=501)

        self.assertEqual(response.status_code, status.HTTP_501_NOT_IMPLEMENTED)
        self.assertEqual(response.data['error_code'].lower(), 'not_implemented')
        self.assertEqual(response.data['detail'].lower(), 'http verb not supported')

    @override_settings(ES_ENABLED=True)
    def test_essearch_update(self):
        if self.es_failed:
            self.skipTest('Elasticsearch is not currently up: {}'.format(self.error_string))

        url = '/api/listings/essearch/1/?tag=demo_tag'
        response = APITestHelper.request(self, url, 'PUT', username='wsmith', status_code=501)

        self.assertEqual(response.status_code, status.HTTP_501_NOT_IMPLEMENTED)
        self.assertEqual(response.data['error_code'].lower(), 'not_implemented')
        self.assertEqual(response.data['detail'].lower(), 'http verb not supported')

    @override_settings(ES_ENABLED=True)
    def test_essearch_retrieve(self):
        if self.es_failed:
            self.skipTest('Elasticsearch is not currently up: {}'.format(self.error_string))

        url = '/api/listings/essearch/1/?tag=demo_tag'
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=501)

        self.assertNotEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.status_code, status.HTTP_501_NOT_IMPLEMENTED)
        self.assertEqual(response.data['error_code'].lower(), 'not_implemented')
        self.assertEqual(response.data['detail'].lower(), 'http verb not supported')
