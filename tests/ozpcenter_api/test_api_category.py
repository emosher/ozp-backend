from django.test import override_settings

import ozpcenter.api.listing.model_access as listing_model_access
import ozpcenter.model_access as generic_model_access
from ozpcenter import models
from ozpcenter.scripts import sample_data_generator as data_gen
from ozpcenter.utils import shorthand_dict
from tests.ozp.cases import APITestCase
from tests.ozpcenter.helper import APITestHelper
from tests.ozpcenter.helper import ExceptionUnitTestHelper


@override_settings(ES_ENABLED=False)
class CategoryApiTest(APITestCase):

    @classmethod
    def setUpTestData(cls):
        data_gen.run()

    def setUp(self):
        self.expected_categories = [
            '(description:Accessories Description,title:Accessories)',
            '(description:Things made of paper,title:Books and Reference)',
            '(description:For making money,title:Business)',
            '(description:Moving info between people and things,title:Communication)',
            '(description:Educational in nature,title:Education)',
            '(description:For fun,title:Entertainment)',
            '(description:For managing money,title:Finance)',
            '(description:Be healthy, be fit,title:Health and Fitness)',
            '(description:Videos and media stuff,title:Media and Video)',
            '(description:Using your ears,title:Music and Audio)',
            "(description:What's happening where,title:News)",
            '(description:Do more in less time,title:Productivity)',
            '(description:For spending your money,title:Shopping)',
            '(description:Score more points than your opponent,title:Sports)',
            '(description:Tools and Utilities,title:Tools)',
            '(description:Get the temperature,title:Weather)']

    def test_get_categories_list(self):
        url = '/api/category/'
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200)
        shorten_data = shorthand_dict(response.data, exclude_keys=['id', 'import_metadata'])
        self.assertListEqual(shorten_data, self.expected_categories)

    def test_get_category(self):
        url = '/api/category/1/'
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200)
        shorten_data = shorthand_dict(response.data, exclude_keys=['id', 'import_metadata'])

        expected_results = '(description:Accessories Description,title:Accessories)'
        self.assertEqual(shorten_data, expected_results)

    def test_get_category_not_found(self):
        url = '/api/category/1000/'
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=404)
        self.assertEqual(response.data, ExceptionUnitTestHelper.not_found())

    def test_create_category_apps_mall_steward(self):
        url = '/api/category/'
        data = {'title': 'new category', 'description': 'category description'}
        response = APITestHelper.request(self, url, 'POST', data=data, username='bigbrother', status_code=201)
        shorten_data = shorthand_dict(response.data, exclude_keys=['id', 'import_metadata'])

        expected_results = '(description:category description,title:new category)'
        self.assertEqual(shorten_data, expected_results)

    def test_create_category_org_steward(self):
        url = '/api/category/'
        data = {'title': 'new category', 'description': 'category description'}
        response = APITestHelper.request(self, url, 'POST', data=data, username='wsmith', status_code=403)

        self.assertEqual(response.data, ExceptionUnitTestHelper.permission_denied())

    # TODO def test_create_category(self): test different user groups access control

    def test_update_category_apps_mall_steward(self):
        url = '/api/category/1/'
        data = {'title': 'updated category', 'description': 'updated description'}
        response = APITestHelper.request(self, url, 'PUT', data=data, username='bigbrother', status_code=200)
        shorten_data = shorthand_dict(response.data, exclude_keys=['id', 'import_metadata'])

        expected_results = '(description:updated description,title:updated category)'
        self.assertEqual(shorten_data, expected_results)

    def test_update_category_org_steward(self):
        url = '/api/category/1/'
        data = {'title': 'updated category', 'description': 'updated description'}
        response = APITestHelper.request(self, url, 'PUT', data=data, username='wsmith', status_code=403)

        self.assertEqual(response.data, ExceptionUnitTestHelper.permission_denied())

    # TODO def test_update_category(self): test different user groups access control

    def test_category_ordering(self):
        # Create new category
        url = '/api/category/'
        data = {'title': 'AAA new category', 'description': 'category description'}
        response = APITestHelper.request(self, url, 'POST', data=data, username='bigbrother', status_code=201)
        shorten_data = shorthand_dict(response.data, exclude_keys=['id', 'import_metadata'])

        expected_results = '(description:category description,title:AAA new category)'
        self.assertEqual(shorten_data, expected_results)

        # GET request
        url = '/api/category/'
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200)
        shorten_data = shorthand_dict(response.data, exclude_keys=['id', 'import_metadata'])
        expected_results = ['(description:category description,title:AAA new category)'] + self.expected_categories
        self.assertListEqual(shorten_data, expected_results)

    def test_delete_category_apps_mall_steward(self):
        url = '/api/category/1/'
        APITestHelper.request(self, url, 'DELETE', username='bigbrother', status_code=204)

    def test_delete_category_org_steward(self):
        url = '/api/category/1/'
        response = APITestHelper.request(self, url, 'DELETE', username='wsmith', status_code=403)

        self.assertEqual(response.data, ExceptionUnitTestHelper.permission_denied())

    def test_delete_category_with_existing_listings(self):
        author = generic_model_access.get_profile('wsmith')
        air_mail = models.Listing.objects.for_user(author.user.username).get(title='Air Mail')
        listing_model_access.create_listing(author, air_mail)

        air_mail = models.Listing.objects.for_user(author.user.username).get(title='Air Mail')
        self.assertEqual(air_mail.last_activity.action, models.ListingActivity.CREATED)
        self.assertEqual(air_mail.approval_status, models.Listing.IN_PROGRESS)

        # Air Mail Categories: Communication(4) & Productivity(12)
        url = '/api/category/4/'
        response = APITestHelper.request(self, url, 'DELETE', username='bigbrother', status_code=403)

    # TODO def test_delete_category(self): test different user groups access control

    def test_GET_bulk_category_listings_apps_mall_steward(self):
        expected_results = ['apocalypse',
                            'applied_ethics_inc.',
                            'beast',
                            'blink',
                            'cyclops',
                            'deadpool',
                            'diamond',
                            'harley-davidson_cvo',
                            'iron_man',
                            'jean_grey',
                            'magneto',
                            'rogue',
                            'ruby',
                            'sapphire',
                            'saturn',
                            'uranus',
                            'wolverine']

        # get list of listings containing category id {7}
        url = '/api/category/7/listing/'
        response = APITestHelper.request(self, url, 'GET', username='bigbrother', status_code=200)
        listing_names = ['{}'.format(i['unique_name']) for i in response.data]

        self.assertIsNotNone(response.data)
        self.assertListEqual(listing_names, expected_results)

    def test_GET_bulk_category_listings_org_steward(self):
        expected_results = ['harley-davidson_cvo', 'ruby']

        # get list of listings containing category id {7} within the org_steward's agencies.
        url = '/api/category/7/listing/'
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200)
        listing_names = ['{}'.format(i['unique_name']) for i in response.data]

        self.assertIsNotNone(response.data)
        self.assertListEqual(listing_names, expected_results)

    def test_GET_bulk_category_listings_owner(self):
        # The listing categories in these test case all have two or more category associations

        expected_results = ['apocalypse',
                            'beast',
                            'blink',
                            'cyclops',
                            'deadpool',
                            'iron_man',
                            'jean_grey',
                            'magneto',
                            'rogue',
                            'wolverine']

        # get list of listings containing category id {7} for this owner.
        url = '/api/category/7/listing/'
        response = APITestHelper.request(self, url, 'GET', username='syme', status_code=200)
        listing_names = ['{}'.format(i['unique_name']) for i in response.data]

        self.assertIsNotNone(response.data)
        self.assertListEqual(listing_names, expected_results)

    def _transform_categories(self, response_data):
        output = []
        for current_record in response_data:
            output_dict = {}
            output_dict['id'] = current_record['id']

            categories_output = []
            for current_category_dict in current_record['categories']:
                categories_output.append({'title': current_category_dict['title']})

            output_dict['categories'] = categories_output
            output.append(output_dict)

        return output

    def test_bulk_category_update_owner(self):
        # Update category listing by owner (test remove, add and validate)
        # POST url = '/api/category/{0!s}/listing/'.format(category_id)

        # Finance (id = 7)
        # Weather (id = 16)
        starting_list = [{"id": 6, "categories": [{"title": "Finance"}, {"title": "Weather"}]},
                         {"id": 16, "categories": [{"title": "Finance"}, {"title": "Weather"}]},
                         {"id": 19, "categories": [{"title": "Finance"}, {"title": "Weather"}]},
                         {"id": 41, "categories": [{"title": "Finance"}, {"title": "Weather"}]},
                         {"id": 42, "categories": [{"title": "Finance"}, {"title": "Weather"}]},
                         {"id": 77, "categories": [{"title": "Finance"}, {"title": "Weather"}]},
                         {"id": 81, "categories": [{"title": "Finance"}, {"title": "Weather"}]},
                         {"id": 100, "categories": [{"title": "Finance"}, {"title": "Weather"}]},
                         {"id": 135, "categories": [{"title": "Finance"}, {"title": "Weather"}]},
                         {"id": 187, "categories": [{"title": "Finance"}, {"title": "Weather"}]}
                         ]

        # test case: remove a category - Finance (id = 7)
        data_removed = [{"id": 6, "categories": [{"title": "Weather"}]},
                        {"id": 16, "categories": [{"title": "Weather"}]},
                        {"id": 19, "categories": [{"title": "Weather"}]},
                        {"id": 41, "categories": [{"title": "Weather"}]},
                        {"id": 42, "categories": [{"title": "Weather"}]},
                        {"id": 77, "categories": [{"title": "Weather"}]},
                        {"id": 81, "categories": [{"title": "Weather"}]},
                        {"id": 100, "categories": [{"title": "Weather"}]},
                        {"id": 135, "categories": [{"title": "Weather"}]},
                        {"id": 187, "categories": [{"title": "Weather"}]}
                        ]

        # test case: add a category - Accessories (id = 1)
        data_added = [{"id": 6, "categories": [{"title": "Accessories"}, {"title": "Weather"}]},
                      {"id": 16, "categories": [{"title": "Accessories"}, {"title": "Weather"}]},
                      {"id": 19, "categories": [{"title": "Accessories"}, {"title": "Weather"}]},
                      {"id": 41, "categories": [{"title": "Accessories"}, {"title": "Weather"}]},
                      {"id": 42, "categories": [{"title": "Accessories"}, {"title": "Weather"}]},
                      {"id": 77, "categories": [{"title": "Accessories"}, {"title": "Weather"}]},
                      {"id": 81, "categories": [{"title": "Accessories"}, {"title": "Weather"}]},
                      {"id": 100, "categories": [{"title": "Accessories"}, {"title": "Weather"}]},
                      {"id": 135, "categories": [{"title": "Accessories"}, {"title": "Weather"}]},
                      {"id": 187, "categories": [{"title": "Accessories"}, {"title": "Weather"}]}
                      ]

        # test case validation - Attempt to add more than three(3) categories or  Zero categories
        data_validated = [{"id": 6, "categories": [{"title": "Accessories"}, {"title": "News", }, {"title": "Shopping", }, {"title": "Weather"}]},
                          {"id": 16, "categories": [{}]},
                          {"id": 19, "categories": [{"title": "Accessories"}, {"title": "Weather"}]},
                          {"id": 41, "categories": [{"title": "Accessories"}, {"title": "Weather"}]},
                          {"id": 42, "categories": [{"title": "Accessories"}, {"title": "Weather"}]},
                          {"id": 77, "categories": [{"title": "Accessories"}, {"title": "Weather"}]},
                          {"id": 81, "categories": [{"title": "Accessories"}, {"title": "Weather"}]},
                          {"id": 100, "categories": [{"title": "Accessories"}, {"title": "Weather"}]},
                          {"id": 135, "categories": [{"title": "Accessories"}, {"title": "Weather"}]},
                          {"id": 187, "categories": [{"title": "Accessories"}, {"title": "Finance"}]}
                          ]

        # retrieve starting category listings for this owner
        url = '/api/category/7/listing/'
        response = APITestHelper.request(self, url, 'GET', username='syme', status_code=200)

        actual_data = self._transform_categories(response.data)
        self.assertListEqual(shorthand_dict(actual_data), shorthand_dict(starting_list))
        # ------------------------------------------------
        #    Test case # 1: Remove categories
        # ------------------------------------------------
        url = '/api/category/7/listing/'
        response = APITestHelper.request(self, url, 'POST', data=data_removed, username='syme', status_code=201)

        actual_data = self._transform_categories(response.data)
        self.assertListEqual(shorthand_dict(actual_data), shorthand_dict(data_removed))

        # retrieve updated category listings for this owner under Finance (id = 7)
        url = '/api/category/7/listing/'
        response = APITestHelper.request(self, url, 'GET', username='syme', status_code=200)

        actual_data = self._transform_categories(response.data)
        self.assertListEqual(shorthand_dict(actual_data), [])

        # retrieve updated category listings for this owner under Weather (id = 16)
        url = '/api/category/16/listing/'
        response = APITestHelper.request(self, url, 'GET', username='syme', status_code=200)

        actual_data = self._transform_categories(response.data)
        self.assertListEqual(shorthand_dict(actual_data), shorthand_dict(data_removed))

        # ------------------------------------------------
        #    Test case # 2:  Add categories
        # ------------------------------------------------
        url = '/api/category/1/listing/'
        response = APITestHelper.request(self, url, 'POST', data=data_added, username='syme', status_code=201)

        # retrieve updated category listings for this owner
        response = APITestHelper.request(self, url, 'GET', username='syme', status_code=200)

        actual_data = self._transform_categories(response.data)
        self.assertListEqual(shorthand_dict(actual_data), shorthand_dict(data_added))

        # ------------------------------------------------
        #    Test case # 3: Validate categories
        # ------------------------------------------------
        url = '/api/category/1/listing/'
        response = APITestHelper.request(self, url, 'POST', data=data_validated, username='syme', status_code=400)

        self.assertEquals(response.data['error'], True)
        self.assertEquals(response.data['error_code'], 'validation_error')
        self.assertEquals(response.data['detail'], "[{'non_field_errors': ['Can not add more than 3 categories for one listing']}, {'categories': [{'title': ['This field is required.']}]}, {}, {}, {}, {}, {}, {}, {}, {}]")
