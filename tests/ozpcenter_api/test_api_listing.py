from django.test import override_settings
from rest_framework import status

import ozpcenter.api.listing.model_access as model_access
from ozpcenter import model_access as generic_model_access
from ozpcenter import models
from ozpcenter.scripts import sample_data_generator as data_gen
from ozpcenter.utils import shorthand_dict
from tests.ozp.cases import APITestCase
from tests.ozpcenter.helper import APITestHelper
from tests.ozpcenter.helper import ExceptionUnitTestHelper
from tests.ozpcenter.helper import validate_listing_map_keys
from tests.ozpcenter_api.api_client import ListingAPI


@override_settings(ES_ENABLED=False)
class ListingApiTest(APITestCase):

    @classmethod
    def setUpTestData(cls):
        data_gen.run()

        cls.profile_bigbrother = generic_model_access.get_profile("bigbrother")
        cls.profile_wsmith = generic_model_access.get_profile("wsmith")
        cls.profile_jones = generic_model_access.get_profile("jones")

    def setUp(self):
        self.maxDiff = None
        self.listing_api = ListingAPI(self.client)

    def test_create_listing_minimal(self):
        # create a new listing with minimal data (title)
        url = '/api/listing/'
        title = 'julias app'
        data = {'title': title, 'security_marking': 'UNCLASSIFIED'}
        response = APITestHelper.request(self, url, 'POST', data=data, username='julia', status_code=201)

        self.assertEqual(response.data['title'], title)
        self.assertEqual(response.data['is_bookmarked'], False)
        self.assertEqual(validate_listing_map_keys(response.data), [])

    def test_create_listing_minimal_bettafish(self):
        # create a new listing with minimal data (title)
        url = '/api/listing/'
        title = 'bettafish app'
        data = {'title': title, 'security_marking': 'UNCLASSIFIED'}

        response = APITestHelper.request(self, url, 'POST', data=data, username='bettafish', status_code=201)

        self.assertEqual(response.data['title'], title)
        self.assertEqual(validate_listing_map_keys(response.data), [])
        self.assertEqual(response.data['is_bookmarked'], False)

    def test_create_listing_no_title(self):
        # create a new listing with minimal data (title)
        url = '/api/listing/'
        data = {'description': 'text here'}

        response = APITestHelper.request(self, url, 'POST', data=data, username='julia', status_code=400)
        self.assertIsNotNone(response.data)

    # TODO: we have some strange inter-test dependency here. if  this test
    # doesn't run last (or after some other unknown test), it segfaults. Naming
    # the test 'test_z*' seems to make it run at the end. One could also run
    # the tests with the --reverse flag (but then you'd need to change this test
    # name to remove the _z)
    def test_z_create_listing_full(self):
        url = '/api/listing/'
        title = 'julias app'
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
            "is_exportable": "false",
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
                {"small_image": {"id": 1}, "large_image": {"id": 2}},
                {"small_image": {"id": 3}, "large_image": {"id": 4}}
            ]

        }
        response = APITestHelper.request(self, url, 'POST', data=data, username='julia', status_code=201)

        compare_keys_data_exclude = [
            {'key': 'title', 'exclude': []},
            {'key': 'description', 'exclude': []},
            {'key': 'launch_url', 'exclude': []},
            {'key': 'version_name', 'exclude': []},
            {'key': 'unique_name', 'exclude': []},
            {'key': 'what_is_new', 'exclude': []},
            {'key': 'description_short', 'exclude': []},
            {'key': 'usage_requirements', 'exclude': []},
            {'key': 'system_requirements', 'exclude': []},
            {'key': 'security_marking', 'exclude': []},
            {'key': 'listing_type', 'exclude': ['custom_fields', 'description', 'id', 'import_metadata']},
            {'key': 'small_icon', 'exclude': ['security_marking', 'url', 'import_metadata']},
            {'key': 'large_icon', 'exclude': ['security_marking', 'url', 'import_metadata']},
            {'key': 'banner_icon', 'exclude': ['security_marking', 'url', 'import_metadata']},
            {'key': 'large_banner_icon', 'exclude': ['security_marking', 'url', 'import_metadata']},
            {'key': 'contacts', 'exclude': ['id', 'organization', 'import_metadata']},
            {'key': 'categories', 'exclude': ['id', 'description', 'import_metadata']},
            {'key': 'tags', 'exclude': ['id', 'import_metadata']},
            {'key': 'owners', 'exclude': ['id', 'display_name', 'import_metadata']},
            {'key': 'intents', 'exclude': ['id', 'icon', 'label', 'media_type', 'import_metadata']},
            {'key': 'doc_urls', 'exclude': ['id', 'import_metadata']},
            {'key': 'screenshots', 'exclude': ['small_image.security_marking',
                                               'small_image.import_metadata',
                                               'small_image.url',
                                               'large_image.security_marking',
                                               'large_image.import_metadata',
                                               'large_image.url',
                                               'order', 'description', 'import_metadata']},
        ]

        for key_to_compare_dict in compare_keys_data_exclude:
            key_to_compare = key_to_compare_dict['key']
            key_exclude = key_to_compare_dict['exclude']

            response_key_value = shorthand_dict(response.data[key_to_compare], exclude_keys=key_exclude)
            data_expected_value = shorthand_dict(data[key_to_compare], exclude_keys=key_exclude)

            # Fix Order for Sqlite/Postgres diffrences
            if isinstance(response_key_value, list):
                response_key_value = sorted(response_key_value)

            if isinstance(data_expected_value, list):
                data_expected_value = sorted(data_expected_value)

            self.assertEqual(response_key_value, data_expected_value, 'Comparing {} key'.format(key_to_compare))

        # fields that should come back with default values
        self.assertEqual(response.data['approved_date'], None)
        self.assertEqual(response.data['approval_status'], models.Listing.IN_PROGRESS)
        self.assertEqual(response.data['is_enabled'], True)
        self.assertEqual(response.data['is_exportable'], False)
        self.assertEqual(response.data['is_featured'], False)
        self.assertEqual(response.data['avg_rate'], 0.0)
        self.assertEqual(response.data['total_votes'], 0)
        self.assertEqual(response.data['total_rate5'], 0)
        self.assertEqual(response.data['total_rate4'], 0)
        self.assertEqual(response.data['total_rate3'], 0)
        self.assertEqual(response.data['total_rate2'], 0)
        self.assertEqual(response.data['total_rate1'], 0)
        self.assertEqual(response.data['total_reviews'], 0)
        self.assertEqual(response.data['iframe_compatible'], True)
        self.assertEqual(response.data['required_listings'], None)
        self.assertTrue(response.data['edited_date'])
        self.assertEqual(response.data['is_bookmarked'], False)
        self.assertEqual(validate_listing_map_keys(response.data), [])

    def test_enable_exportable__allowed_for_aml_steward(self):
        listing_id = 6
        user_profile = self.profile_bigbrother

        status_code, listing = self.listing_api.get(listing_id, auth=user_profile)
        self.assertEqual(status_code, status.HTTP_200_OK)
        self.assertFalse(listing["is_exportable"])

        listing["is_exportable"] = True
        status_code, response = self.listing_api.update(listing_id, listing, auth=user_profile)

        self.assertEqual(status_code, status.HTTP_200_OK)
        self.assertTrue(response['is_exportable'])

    def test__enable_exportable__allowed_for_org_steward(self):
        listing_id = 1
        user_profile = self.profile_wsmith

        status_code, listing = self.listing_api.get(listing_id, auth=user_profile)
        self.assertEqual(status_code, status.HTTP_200_OK)
        self.assertFalse(listing["is_exportable"])

        listing["is_exportable"] = True
        status_code, response = self.listing_api.update(listing_id, listing, auth=user_profile)

        self.assertEqual(status_code, status.HTTP_200_OK)
        self.assertTrue(response['is_exportable'])

    def test__enable_exportable__allowed_for_owning_user(self):
        listing_id = 7
        user_profile = self.profile_jones

        status_code, listing = self.listing_api.get(listing_id, auth=user_profile)
        self.assertEqual(status_code, status.HTTP_200_OK)
        self.assertFalse(listing["is_exportable"])

        listing["is_exportable"] = True
        status_code, response = self.listing_api.update(listing_id, listing, auth=user_profile)

        self.assertEqual(status_code, status.HTTP_403_FORBIDDEN)
        self.assertEqual(response,
                         ExceptionUnitTestHelper.permission_denied(
                             "Only stewards can change is_exportable setting of a listing"))

    def test__enable_exportable__denied_for_nonowner_user(self):
        listing_id = 5
        user_profile = self.profile_jones

        status_code, listing = self.listing_api.get(listing_id, auth=user_profile)
        self.assertEqual(status_code, status.HTTP_200_OK)
        self.assertFalse(listing["is_exportable"])

        listing["is_exportable"] = True
        status_code, response = self.listing_api.update(listing_id, listing, auth=user_profile)

        self.assertEqual(status_code, status.HTTP_403_FORBIDDEN)
        self.assertEqual(response,
                         ExceptionUnitTestHelper.permission_denied(
                             "User (%s) is not an owner of this listing" % user_profile.user.username))

    def test_delete_listing(self):
        url = '/api/listing/1/'
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200)
        self.assertFalse(response.data.get('is_deleted'))
        self.assertEqual(validate_listing_map_keys(response.data), [])

        url = '/api/listing/1/'
        data = {'description': 'deleting listing'}
        response = APITestHelper.request(self, url, 'DELETE', data=data, username='wsmith', status_code=204)

        url = '/api/listing/1/'
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200)
        self.assertTrue(response.data.get('is_deleted'))
        self.assertEqual(validate_listing_map_keys(response.data), [])

    def test_delete_listing_permission_denied(self):
        url = '/api/listing/1/'
        data = {'description': 'deleting listing'}
        response = APITestHelper.request(self, url, 'DELETE', data=data, username='jones', status_code=403)

        self.assertEqual(response.data['error_code'], (ExceptionUnitTestHelper.permission_denied())['error_code'])

    def test_delete_listing_permission_denied_2nd_party(self):
        url = '/api/listing/1/'
        data = {'description': 'deleting listing'}
        response = APITestHelper.request(self, url, 'DELETE', data=data, username='johnson', status_code=403)

        self.assertEqual(response.data, ExceptionUnitTestHelper.permission_denied('Current profile does not have delete permissions'))

    def test_update_listing_partial(self):
        """
        This was added to catch the case where a listing that didn't previously
        have an icon was being updated, and the update method in the serializer
        was invoking instance.small_icon.id to get the old value for the
        change_details. There was no previous value, so accessing
        instance.small_icon.id raised an exception. The same problem could exist
        on any property that isn't a simple data type
        """
        listing = models.Listing.objects.get(id=1)
        listing.small_icon = None
        listing.large_icon = None
        listing.banner_icon = None
        listing.large_banner_icon = None
        listing.listing_type = None
        listing.save()

        # now make another change to the listing
        url = '/api/listing/1/'
        data = APITestHelper.request(self, url, 'GET', username='julia', status_code=200).data

        data['small_icon'] = {'id': 1}
        data['large_icon'] = {'id': 2}
        data['banner_icon'] = {'id': 3}
        data['large_banner_icon'] = {'id': 4}
        data['listing_type'] = {'title': 'Web Application'}
        # and another update
        response = APITestHelper.request(self, url, 'PUT', data=data, username='julia', status_code=200)

        self.assertTrue(response.data['edited_date'])
        self.assertEqual(response.data['small_icon']['id'], 1)
        self.assertEqual(response.data['large_icon']['id'], 2)
        self.assertEqual(response.data['banner_icon']['id'], 3)
        self.assertEqual(response.data['large_banner_icon']['id'], 4)
        self.assertEqual(response.data['is_bookmarked'], False)
        self.assertEqual(validate_listing_map_keys(response.data), [])

    def test_update_listing_full(self):
        url = '/api/listing/1/'
        title = 'julias app 2'
        data = {
            "title": title,
            "description": "description of app",
            "launch_url": "http://www.google.com/launch",
            "version_name": "2.1.8",
            "unique_name": "org.apps.julia-one",
            "what_is_new": "nothing is new",
            "description_short": "a shorter description",
            "usage_requirements": "Many new things",
            "system_requirements": "Good System",
            "is_private": "true",
            "is_exportable": "false",
            "is_enabled": "false",
            "is_featured": "false",
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
            "security_marking": "SECRET",
            "listing_type": {"title": "Widget"},
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
                {"name": "wiki", "url": "http://www.google.com/wiki2"},
                {"name": "guide", "url": "http://www.google.com/guide2"}
            ],
            "screenshots": [
                {"small_image": {"id": 1}, "large_image": {"id": 2}, "description": "Test Description"},
                {"small_image": {"id": 3}, "large_image": {"id": 4}, "description": "Test Description"}
            ]

        }

        # for checking Activity status later on
        user = generic_model_access.get_profile('julia').user
        self.client.force_authenticate(user=user)
        old_listing_data = self.client.get(url, format='json').data

        response = self.client.put(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)

        compare_keys_data_exclude = [
            {'key': 'title', 'exclude': []},
            {'key': 'description', 'exclude': []},
            {'key': 'launch_url', 'exclude': []},
            {'key': 'version_name', 'exclude': []},
            {'key': 'unique_name', 'exclude': []},
            {'key': 'what_is_new', 'exclude': []},
            {'key': 'description_short', 'exclude': []},
            {'key': 'usage_requirements', 'exclude': []},
            {'key': 'system_requirements', 'exclude': []},
            {'key': 'security_marking', 'exclude': []},
            {'key': 'listing_type', 'exclude': ['custom_fields', 'description', 'id', 'import_metadata']},
            {'key': 'small_icon', 'exclude': ['security_marking', 'url', 'import_metadata']},
            {'key': 'large_icon', 'exclude': ['security_marking', 'url', 'import_metadata']},
            {'key': 'banner_icon', 'exclude': ['security_marking', 'url', 'import_metadata']},
            {'key': 'large_banner_icon', 'exclude': ['security_marking', 'url', 'import_metadata']},
            {'key': 'contacts', 'exclude': ['id', 'organization', 'import_metadata']},
            {'key': 'categories', 'exclude': ['id', 'description', 'import_metadata']},
            {'key': 'tags', 'exclude': ['id', 'import_metadata']},
            {'key': 'owners', 'exclude': ['id', 'display_name', 'import_metadata']},
            {'key': 'intents', 'exclude': ['id', 'icon', 'label', 'media_type', 'import_metadata']},
            {'key': 'doc_urls', 'exclude': ['id', 'import_metadata']},
            {'key': 'screenshots', 'exclude': ['small_image.security_marking',
                                               'small_image.import_metadata',
                                               'small_image.url',
                                               'large_image.security_marking',
                                               'large_image.import_metadata',
                                               'large_image.url',
                                               'order', 'description', 'import_metadata']},
        ]

        for key_to_compare_dict in compare_keys_data_exclude:
            key_to_compare = key_to_compare_dict['key']
            key_exclude = key_to_compare_dict['exclude']

            response_key_value = shorthand_dict(response.data[key_to_compare], exclude_keys=key_exclude)
            data_expected_value = shorthand_dict(data[key_to_compare], exclude_keys=key_exclude)

            # Fix Order for Sqlite/Postgres diffrences
            if isinstance(response_key_value, list):
                response_key_value = sorted(response_key_value)

            if isinstance(data_expected_value, list):
                data_expected_value = sorted(data_expected_value)

            self.assertEqual(response_key_value, data_expected_value, 'Comparing {} key'.format(key_to_compare))

        self.assertEqual(response.data['is_private'], True)
        self.assertEqual(response.data['is_enabled'], False)
        self.assertEqual(response.data['is_featured'], False)
        self.assertEqual(response.data['approval_status'], models.Listing.APPROVED)
        self.assertEqual(response.data['avg_rate'], 3.0)
        self.assertEqual(response.data['total_votes'], 4)
        self.assertEqual(response.data['total_rate5'], 1)
        self.assertEqual(response.data['total_rate4'], 0)
        self.assertEqual(response.data['total_rate3'], 2)
        self.assertEqual(response.data['total_rate2'], 0)
        self.assertEqual(response.data['total_rate1'], 1)
        self.assertEqual(response.data['total_reviews'], 4)
        self.assertEqual(response.data['is_exportable'], False)
        self.assertEqual(response.data['iframe_compatible'], False)
        self.assertEqual(response.data['required_listings'], None)
        self.assertTrue(response.data['edited_date'])
        self.assertTrue(response.data['approved_date'])
        self.assertEqual(validate_listing_map_keys(response.data), [])

        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
        #                   verify change_details
        # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
        activity_url = url + 'activity/'
        activity_response = self.client.get(activity_url, format='json')
        activity_data = activity_response.data

        fields = ['title', 'description', 'description_short', 'version_name',
                  'usage_requirements', 'system_requirements', 'unique_name', 'what_is_new', 'launch_url',
                  'is_enabled', 'is_featured', 'is_private', 'is_exportable', 'feedback_score', 'doc_urls', 'contacts',
                  'screenshots', 'categories', 'owners', 'tags', 'small_icon',
                  'large_icon', 'banner_icon', 'large_banner_icon', 'security_marking',
                  'listing_type', 'approval_status', 'intents']

        changed_found_fields = []

        for activity in activity_data:
            if activity['action'] == 'MODIFIED':
                for change in activity['change_details']:
                    # Field Set 1
                    temp_change_fields = ['title', 'description', 'description_short',
                        'version_name', 'usage_requirements', 'system_requirements', 'what_is_new', 'unique_name', 'launch_url', 'feedback_score',
                                          'is_private', 'is_exportable', 'is_featured', 'listing_type', 'security_marking']

                    for temp_field in temp_change_fields:
                        if change['field_name'] == temp_field:
                            if temp_field == 'listing_type':
                                self.assertEqual(change['new_value'], data[temp_field]['title'], 'new_value assertion for {}'.format(temp_field))
                            else:
                                self.assertEqual(change['new_value'], data[temp_field], 'new_value assertion for {}'.format(temp_field))

                            if temp_field.startswith('is_'):
                                self.assertEqual(change['old_value'], model_access.bool_to_string(old_listing_data[temp_field]), 'old_value assertion for {}'.format(temp_field))
                            elif temp_field == 'listing_type':
                                self.assertEqual(change['old_value'], old_listing_data[temp_field]['title'], 'old_value assertion for {}'.format(temp_field))
                            else:
                                self.assertEqual(change['old_value'], old_listing_data[temp_field], 'old_value assertion for {}'.format(temp_field))
                            changed_found_fields.append(temp_field)

                    # Field Set 2
                    temp_change_fields = ['small_icon', 'large_icon', 'banner_icon', 'large_banner_icon']
                    for temp_field in temp_change_fields:
                        if change['field_name'] == temp_field:
                            self.assertEqual(change['new_value'], str(data[temp_field]['id']) + '.UNCLASSIFIED', 'new_value assertion for {}'.format(temp_field))
                            self.assertEqual(change['old_value'], str(old_listing_data[temp_field]['id']) + '.UNCLASSIFIED', 'old_value assertion for {}'.format(temp_field))
                            changed_found_fields.append(temp_field)

                    # Field Set 3
                    temp_change_fields = ['doc_urls', 'screenshots', 'contacts', 'intents', 'categories', 'tags', 'owners']
                    for temp_field in temp_change_fields:
                        if change['field_name'] == temp_field:
                            temp_field_function = getattr(model_access, '{}_to_string'.format(temp_field))
                            self.assertEqual(change['new_value'], temp_field_function(data[temp_field]))
                            self.assertEqual(change['old_value'], temp_field_function(old_listing_data[temp_field]))
                            changed_found_fields.append(temp_field)

        difference_in_fields = sorted(list(set(fields) - set(changed_found_fields)))  # TODO: Better way to do this
        self.assertEqual(difference_in_fields, ['approval_status', 'feedback_score', 'is_enabled', 'is_exportable', 'is_featured'])

    # TODO: def test_update_listing_full_access_control(self):

    def test_update_listing_full_2nd_party_request_user(self):
        user = generic_model_access.get_profile('johnson').user
        self.client.force_authenticate(user=user)
        url = '/api/listing/1/'
        title = 'julias app 2'
        data = {
            "title": title,
            "description": "description of app",
            "security_marking": "SECRET",
        }
        response = self.client.put(url, data, format='json')

        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertEqual(response.data['error_code'], (ExceptionUnitTestHelper.validation_error('Permissions are invalid for current profile'))['error_code'])

    def test_update_listing_full_2nd_party_owner(self):
        url = '/api/listing/1/'
        title = 'julias app 2'
        data = {
            "title": title,
            "description": "description of app",
            "launch_url": "http://www.google.com/launch",
            "version_name": "2.1.8",
            "unique_name": "org.apps.julia-one",
            "what_is_new": "nothing is new",
            "description_short": "a shorter description",
            "usage_requirements": "Many new things",
            "system_requirements": "Good System",
            "is_private": "true",
            "is_exportable": "true",
            "is_enabled": "false",
            "is_featured": "false",
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
            "security_marking": "SECRET",
            "listing_type": {"title": "Widget"},
            "small_icon": {"id": 1},
            "large_icon": {"id": 2},
            "banner_icon": {"id": 3},
            "large_banner_icon": {"id": 4},
            "categories": [
                {"title": "Bumake siness"},
                {"title": "Education"}
            ],
            "owners": [
                {"user": {"username": "johnson"}},
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
                {"name": "wiki", "url": "http://www.google.com/wiki2"},
                {"name": "guide", "url": "http://www.google.com/guide2"}
            ],
            "screenshots": [
                {"small_image": {"id": 1}, "large_image": {"id": 2}},
                {"small_image": {"id": 3}, "large_image": {"id": 4}}
            ]

        }

        user = generic_model_access.get_profile('julia').user
        self.client.force_authenticate(user=user)
        response = self.client.put(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)

        self.assertEqual(response.data['error_code'], (ExceptionUnitTestHelper.validation_error('Permissions are invalid for current owner profile'))['error_code'])

    def test_z_create_update(self):
        url = '/api/listing/'
        data = {
            "title": "test",
            "screenshots": [],
            "contacts": [
                {
                    "name": "test1",
                    "email": "test1@domain.com",
                    "secure_phone": "240-544-8777",
                    "contact_type": {
                        "name": "Civilian"
                    }
                },
                {
                    "name": "test2",
                    "email": "test2@domain.com",
                    "secure_phone": "240-888-7477",
                    "contact_type": {
                        "name": "Civilian"
                    }
                }
            ],
            "tags": [],
            "owners": [
                {
                    "display_name": "Big Brother",
                    "id": 4,
                    "user": {
                        "username": "bigbrother"
                    }
                }
            ],
            "agency": {
                "short_name": "Miniluv",
                "title": "Ministry of Love"
            },
            "categories": [
                {
                    "title": "Books and Reference"
                }
            ],
            "intents": [],
            "doc_urls": [],
            "security_marking": "UNCLASSIFIED",  # //FOR OFFICIAL USE ONLY//ABCDE
            "listing_type": {
                "title": "Web Application"
            },
            "last_activity": {
                "action": "APPROVED"
            },
            "required_listings": None
        }

        user = generic_model_access.get_profile('julia').user
        self.client.force_authenticate(user=user)
        response = self.client.post(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

        self.assertEqual(response.data['approval_status'], 'IN_PROGRESS')
        self.assertEqual(validate_listing_map_keys(response.data), [])
        listing_id = response.data['id']

        data = {
            "id": listing_id,
            "title": "test",
            "description": None,
            "description_short": None,
            "screenshots": [],
            "contacts": [
                {
                    "id": 4,
                    "contact_type": {
                        "name": "Government"
                    },
                    "secure_phone": "240-544-8777",
                    "unsecure_phone": None,
                    "email": "test1@domain.com",
                    "name": "test15",
                    "organization": None
                },
                {
                    "id": 5,
                    "contact_type": {
                        "name": "Civilian"
                    },
                    "secure_phone": "240-888-7477",
                    "unsecure_phone": None,
                    "email": "test2@domain.com",
                    "name": "test2",
                    "organization": None
                }
            ],
            "avg_rate": 0,
            "total_votes": 0,
            "feedback_score": 0,
            "tags": [],
            "usage_requirements": None,
            "system_requirements": None,
            "version_name": None,
            "launch_url": None,
            "what_is_new": None,
            "owners": [
                {
                    "display_name": "Big Brother",
                    "id": 4,
                    "user": {
                        "username": "bigbrother"
                    }
                }
            ],
            "agency": {
                "short_name": "Miniluv",
                "title": "Ministry of Love"
            },
            "is_enabled": True,
            "categories": [
                {
                    "title": "Books and Reference"
                }
            ],
            "intents": [],
            "doc_urls": [],
            "approval_status": "IN_PROGRESS",
            "is_featured": False,
            "is_private": False,
            "is_exportable": False,
            "security_marking": "UNCLASSIFIED//FOR OFFICIAL USE ONLY//ABCDE",
            "listing_type": {
                "title": "Web Application"
            },
            "unique_name": None,
            "last_activity": {
                "action": "APPROVED"
            },
            "required_listings": None
        }

        url = '/api/listing/{0!s}/'.format(listing_id)
        response = self.client.put(url, data, format='json')

        contacts = response.data['contacts']
        contact_types = [i['contact_type']['name'] for i in contacts]
        self.assertEqual(str(contact_types), str(['Civilian', 'Government']))
        self.assertEqual(validate_listing_map_keys(response.data), [])

    def test_update_listing_approval_status_deny_user(self):
        # a standard user cannot update the approval_status
        url = '/api/listing/'
        data = {
            "title": 'mr jones app',
            "approval_status": "APPROVED",
            "security_marking": "UNCLASSIFIED"
        }

        user = generic_model_access.get_profile('jones').user
        self.client.force_authenticate(user=user)
        response = self.client.post(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

        self.assertEqual(response.data['approval_status'], 'IN_PROGRESS')
        self.assertEqual(validate_listing_map_keys(response.data), [])

        data = response.data
        data['approval_status'] = models.Listing.APPROVED
        listing_id = data['id']

        url = '/api/listing/{0!s}/'.format(listing_id)
        response = self.client.put(url, data, format='json')
        self.assertEqual(response.data['error_code'], (ExceptionUnitTestHelper.permission_denied('Only an APPS_MALL_STEWARD can mark a listing as APPROVED')['error_code']))

        # double check that the status wasn't changed
        # TODO: listing doesn't exist?
        # url = '/api/listing/%s/' % listing_id
        # response = self.client.get(url, data, format='json')
        # self.assertEqual(response.data['approval_status'], models.Listing.IN_PROGRESS)

    def test_get_listings_with_query_params(self):
        """
        test_get_listings_with_query_params
        Supported query params: org (agency title), approval_status, enabled
        """
        url = '/api/listing/?approval_status=APPROVED&org=Minitrue&enabled=true'

        user = generic_model_access.get_profile('julia').user
        self.client.force_authenticate(user=user)
        response = self.client.get(url, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)

        self.assertTrue(len(response.data) > 5)
        # TODO: more tests

    def test_get_listings_with_query_params_owner(self):
        """
        test_get_listings_with_query_params
        """
        url = '/api/listing/?approval_status=APPROVED&org=Minitrue&enabled=true&owners_id=4'

        user = generic_model_access.get_profile('julia').user
        self.client.force_authenticate(user=user)
        response = self.client.get(url, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)

        for listing_record in response.data:
            if 'owners' in listing_record:
                owners_list = [owner_dict['id'] for owner_dict in listing_record['owners']]
                self.assertTrue(4 in owners_list)

    def test_counts_in_listings(self):
        """
        test_counts_in_listings
        Supported query params: org (agency title), approval_status, enabled
        """
        url = '/api/listing/'

        user = generic_model_access.get_profile('julia').user
        self.client.force_authenticate(user=user)
        response = self.client.get(url, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)

        data = response.data
        last_item = data[-1]

        expected_item = {"counts": {
            "APPROVED": 176,
            "APPROVED_ORG": 1,
            "DELETED": 0,
            "IN_PROGRESS": 0,
            "PENDING": 10,
            "PENDING_DELETION": 0,
            "enabled": 183,
            "REJECTED": 0,
            "organizations": {
                "1": 44,
                "2": 42,
                "3": 49,
                "4": 37,
                "5": 5,
                "6": 3,
                "7": 2,
                "8": 3,
                "9": 2
            },
            "total": 187
        }
        }
        self.assertEqual(last_item, expected_item)
    # TODO: test_counts_in_listings - 2ndparty

    def test_create_listing_with_different_agency(self):
        url = '/api/listing/'
        data = {'title': 'test app', 'security_marking': 'UNCLASSIFIED',
                'agency': {'title': 'Ministry of Plenty'}}

        user = generic_model_access.get_profile('julia').user
        self.client.force_authenticate(user=user)
        response = self.client.post(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

    def test_create_listing_with_invalid_agency(self):
        url = '/api/listing/'
        data = {'title': 'test app', 'security_marking': 'UNCLASSIFIED',
                'agency': {'title': 'Ministry of NONE'}}

        user = generic_model_access.get_profile('julia').user
        self.client.force_authenticate(user=user)
        response = self.client.post(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)

    def test_reject_listing_normal_user(self):
        url = '/api/listing/1/rejection/'

        user = generic_model_access.get_profile('jones').user
        self.client.force_authenticate(user=user)
        response = self.client.get(url, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)

        data = {'description': 'because it\'s not good'}
        response = self.client.post(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_reject_listing_org_steward(self):
        url = '/api/listing/1/rejection/'
        data = {'description': 'because it\'s not good'}

        user = generic_model_access.get_profile('wsmith').user
        self.client.force_authenticate(user=user)
        response = self.client.post(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

        url = '/api/listing/1/activity/'
        response = self.client.get(url, format='json')
        actions = [i['action'] for i in response.data]
        self.assertTrue('REJECTED' in actions)

        url = '/api/listing/1/'
        response = self.client.get(url, format='json')
        self.assertEqual(response.data['last_activity']['action'], 'REJECTED')
        current_rejection = response.data['current_rejection']
        self.assertEqual(current_rejection['author']['user']['username'], 'wsmith')
        self.assertTrue(current_rejection['description'])
        self.assertTrue(current_rejection['author']['display_name'])

    def test_gave_single_user_feedback_listing(self):
        """
        betafish user
        """
        # Create a positive feedback
        url = '/api/listing/1/feedback/'
        data = {"feedback": 1}

        user = generic_model_access.get_profile('bettafish').user
        self.client.force_authenticate(user=user)
        response = self.client.post(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

        url = '/api/listing/1/feedback/'
        response = self.client.get(url, format='json')
        self.assertEqual(response.data['feedback'], 1)

        url = '/api/listing/1/'
        response = self.client.get(url, format='json')
        self.assertEqual(response.data['feedback'], 1)
        self.assertEqual(response.data['feedback_score'], 1)

        # Login as betaraybill (no feedback given to listing #1)
        user = generic_model_access.get_profile('betaraybill').user
        self.client.force_authenticate(user=user)

        url = '/api/listing/1/'
        response = self.client.get(url, format='json')
        self.assertEqual(response.data['feedback'], 0)
        self.assertEqual(response.data['feedback_score'], 1)

    def test_gave_double_user_feedback_listing(self):
        """
        betafish user
        """
        # Create a positive feedback
        url = '/api/listing/1/feedback/'
        data = {"feedback": 1}

        user = generic_model_access.get_profile('bettafish').user
        self.client.force_authenticate(user=user)
        response = self.client.post(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

        url = '/api/listing/1/feedback/'
        response = self.client.get(url, format='json')
        self.assertEqual(response.data['feedback'], 1)

        url = '/api/listing/1/'
        response = self.client.get(url, format='json')
        self.assertEqual(response.data['feedback'], 1)
        self.assertEqual(response.data['feedback_score'], 1)

        # Login as betaraybill
        user = generic_model_access.get_profile('betaraybill').user
        self.client.force_authenticate(user=user)

        # Create a negative feedback
        url = '/api/listing/1/feedback/'
        data = {"feedback": -1}
        response = self.client.post(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

        url = '/api/listing/1/feedback/'
        response = self.client.get(url, format='json')
        self.assertEqual(response.data['feedback'], -1)

        url = '/api/listing/1/'
        response = self.client.get(url, format='json')
        self.assertEqual(response.data['feedback'], -1)
        self.assertEqual(response.data['feedback_score'], 0)

    def test_feedback_score_positive_then_negative(self):
        """
        betafish user
        """
        user = generic_model_access.get_profile('bettafish').user
        self.client.force_authenticate(user=user)

        # Create a positive feedback
        url = '/api/listing/1/feedback/'
        data = {"feedback": 1}
        response = self.client.post(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

        url = '/api/listing/1/feedback/'
        response = self.client.get(url, format='json')
        self.assertEqual(response.data['feedback'], 1)

        url = '/api/listing/1/'
        response = self.client.get(url, format='json')
        self.assertEqual(response.data['feedback'], 1)
        self.assertEqual(response.data['feedback_score'], 1)

        # Login as betaraybill
        user = generic_model_access.get_profile('betaraybill').user
        self.client.force_authenticate(user=user)

        # Create a negative feedback
        url = '/api/listing/1/feedback/'
        data = {"feedback": -1}
        response = self.client.post(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

        url = '/api/listing/1/feedback/'
        response = self.client.get(url, format='json')
        self.assertEqual(response.data['feedback'], -1)

        url = '/api/listing/1/'
        response = self.client.get(url, format='json')
        self.assertEqual(response.data['feedback'], -1)
        self.assertEqual(response.data['feedback_score'], 0)

        # Login as bettafish again
        user = generic_model_access.get_profile('bettafish').user
        self.client.force_authenticate(user=user)

        # Create a negative feedback
        url = '/api/listing/1/feedback/'
        data = {"feedback": -1}
        response = self.client.post(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

        url = '/api/listing/1/feedback/'
        response = self.client.get(url, format='json')
        self.assertEqual(response.data['feedback'], -1)

        url = '/api/listing/1/'
        response = self.client.get(url, format='json')
        self.assertEqual(response.data['feedback'], -1)
        self.assertEqual(response.data['feedback_score'], -2)

    def test_feedback_score_after_feedback_delete(self):
        """
        betafish user
        """
        user = generic_model_access.get_profile('bettafish').user
        self.client.force_authenticate(user=user)

        # Create a positive feedback
        url = '/api/listing/1/feedback/'
        data = {"feedback": 1}
        response = self.client.post(url, data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

        url = '/api/listing/1/feedback/'
        response = self.client.get(url, format='json')
        self.assertEqual(response.data['feedback'], 1)

        url = '/api/listing/1/'
        response = self.client.get(url, format='json')
        self.assertEqual(response.data['feedback'], 1)
        self.assertEqual(response.data['feedback_score'], 1)

        url = '/api/listing/1/feedback/1/'
        response = self.client.delete(url, format='json')
        self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)

        url = '/api/listing/1/'
        response = self.client.get(url, format='json')
        self.assertEqual(response.data['feedback'], 0)
        self.assertEqual(response.data['feedback_score'], 0)

    def test_listing_ordering(self):
        """
        betafish user
        """
        user = generic_model_access.get_profile('bettafish').user
        self.client.force_authenticate(user=user)

        # Last Modified
        url = '/api/listing/?ordering=-edited_date'
        response = self.client.get(url, format='json')
        results = [x for x in response.data if hasattr(x, 'edited_date')]
        sorted_results = sorted(results, key=lambda x: x['edited_date'], reverse=True)
        self.assertEqual(results, sorted_results)

        # Newest
        url = '/api/listing/?ordering=-approved_date'
        response = self.client.get(url, format='json')
        results = [x for x in response.data if hasattr(x, 'approved_date')]
        sorted_results = sorted(results, key=lambda x: x['approved_date'], reverse=True)
        self.assertEqual(results, sorted_results)

        # Title: A to Z
        url = '/api/listing/?ordering=title'
        response = self.client.get(url, format='json')
        results = [x for x in response.data if hasattr(x, 'title')]
        sorted_results = sorted(results, key=lambda x: x['title'])
        self.assertEqual(results, sorted_results)

        # Title: Z to A
        url = '/api/listing/?ordering=-title'
        response = self.client.get(url, format='json')
        results = [x for x in response.data if hasattr(x, 'title')]
        sorted_results = sorted(results, key=lambda x: x['title'], reverse=True)
        self.assertEqual(results, sorted_results)

        # Rating: High to Low
        url = '/api/listing/?ordering=avg_rate,total_votes'
        response = self.client.get(url, format='json')
        results = [x for x in response.data if hasattr(x, 'avg_rate') and hasattr(x, 'total_votes')]
        sorted_results = sorted(results, key=lambda x: (x['avg_rate'], x['total_votes']))
        self.assertEqual(results, sorted_results)

        # Rating: Low to High
        url = '/api/listing/?ordering=-avg_rate,-total_votes'
        response = self.client.get(url, format='json')
        results = [x for x in response.data if hasattr(x, 'avg_rate') and hasattr(x, 'total_votes')]
        sorted_results = sorted(results, key=lambda x: (x['avg_rate'], x['total_votes']), reverse=True)
        self.assertEqual(results, sorted_results)

    def test_feature_listing(self):
        """
        test_feature_listing
        Supported query params: is_featured, featured_date
        """
        LISTING_ID = 11
        USER_NAME = 'bigbrother'
        request_profile = generic_model_access.get_profile(USER_NAME)
        user = generic_model_access.get_profile(USER_NAME).user
        self.client.force_authenticate(user=user)

        # feature listing
        APITestHelper.edit_listing(self, LISTING_ID, {'is_featured': True}, USER_NAME)

        url = '/api/listing/{0!s}/'.format(LISTING_ID)
        response = self.client.get(url, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)

        self.assertEqual(response.data['is_featured'], True)
        self.assertIsNotNone(response.data['featured_date'])

    def test_unfeature_listing(self):
        """
        test_unfeature_listing
        Supported query params: is_featured, featured_date
        """
        LISTING_ID = 11
        USER_NAME = 'bigbrother'
        request_profile = generic_model_access.get_profile(USER_NAME)
        user = generic_model_access.get_profile(USER_NAME).user
        self.client.force_authenticate(user=user)

        # Un-feature listing
        APITestHelper.edit_listing(self, LISTING_ID, {'is_featured': False}, USER_NAME)

        url = '/api/listing/{0!s}/'.format(LISTING_ID)
        response = self.client.get(url, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)

        self.assertEqual(response.data['is_featured'], False)

    def test_featured_listings_order(self):
        """
        test_featured_listings_order
        Supported query params: is_featured, featured_date
        """
        LISTING_ID = 11
        USER_NAME = 'bigbrother'
        request_profile = generic_model_access.get_profile(USER_NAME)
        user = generic_model_access.get_profile(USER_NAME).user
        self.client.force_authenticate(user=user)

        # Get the targeted listing's data. (The listing to be featured)
        url = '/api/listing/{0!s}/'.format(LISTING_ID)
        response = self.client.get(url, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        target_listing_data = response.data
        target_listing_id = target_listing_data['id']

        # Un-feature target listing, if already featured (toggle)
        if (target_listing_data['is_featured']):
            APITestHelper.edit_listing(self, LISTING_ID, {'is_featured': False}, USER_NAME)

        # Get the 1st featured listing id
        url = '/api/storefront/featured/'
        self.client.force_authenticate(user=user)
        response = self.client.get(url, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        first_featured_listing_id = response.data['featured'][0]['id']

        #  Check  - The target listing is not 1st in the featured list
        self.assertNotEqual(first_featured_listing_id, target_listing_id)

        # Feature the target listing
        APITestHelper.edit_listing(self, LISTING_ID, {'is_featured': True}, USER_NAME)

        # Get the 1st featured listing id
        url = '/api/storefront/featured/'
        self.client.force_authenticate(user=user)
        response = self.client.get(url, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        first_featured_listing_id = response.data['featured'][0]['id']

        # Check - target featured listing is now the 1st featured listing
        self.assertEqual(first_featured_listing_id, target_listing_id)
