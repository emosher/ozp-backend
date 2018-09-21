"""
Test Utility Helper

Function to help unit tests
"""
import os
import yaml

from rest_framework import status

from ozpcenter import model_access as generic_model_access

TEST_BASE_PATH = os.path.realpath(os.path.join(os.path.dirname(__file__), '..', '..', 'ozpcenter', 'scripts'))
TEST_DATA_PATH = os.path.join(TEST_BASE_PATH, 'test_data')


def patch_environ(new_environ=None, clear_orig=False):
    """
    https://stackoverflow.com/questions/2059482/python-temporarily-modify-the-current-processs-environment/34333710#34333710
    """
    if not new_environ:
        new_environ = dict()

    def actual_decorator(func):
        from functools import wraps

        @wraps(func)
        def wrapper(*args, **kwargs):
            original_env = dict(os.environ)

            if clear_orig:
                os.environ.clear()

            os.environ.update(new_environ)
            try:
                result = func(*args, **kwargs)
            except:
                raise
            finally:  # restore even if Exception was raised
                os.environ = original_env

            return result

        return wrapper

    return actual_decorator


class ExceptionUnitTestHelper(object):
    """
    This class returns dictionaries of exceptions to compare with response data
    """

    # HTTP_400
    @staticmethod
    def validation_error(detailmsg=None):
        detail = detailmsg or 'Invalid input.'
        return {'detail': detail,
                'error': True,
                'error_code': 'validation_error'}

    # HTTP_400
    @staticmethod
    def parse_error(detailmsg=None):
        detail = detailmsg or 'Malformed request.'
        return {'detail': detail,
                'error': True,
                'error_code': 'parse_error'}

    # HTTP_400
    @staticmethod
    def request_error(detailmsg=None):
        detail = detailmsg or 'Invalid input.'
        return {'detail': detail,
                'error': True,
                'error_code': 'request'}

    # HTTP_401
    @staticmethod
    def authorization_failure(detailmsg=None):
        detail = detailmsg or 'Not authorized to view.'
        # 'Incorrect authentication credentials'
        return {'detail': detail,
                'error': True,
                'error_code': 'authorization_failed'}

    # HTTP_401
    @staticmethod
    def not_authenticated(detailmsg=None):
        detail = detailmsg or 'Authentication credentials were not provided.'
        return {'detail': detail,
                'error': True,
                'error_code': 'not_authenticated'}
        # 'error_code': 'authorization_failure'}

    # HTTP_403
    @staticmethod
    def permission_denied(detailmsg=None):
        detail = detailmsg or 'You do not have permission to perform this action.'
        return {'detail': detail,
                'error': True,
                'error_code': 'permission_denied'}

    # HTTP_404
    @staticmethod
    def not_found(detailmsg=None):
        detail = detailmsg or 'Not found.'
        return {'detail': detail,
                'error': True,
                'error_code': 'not_found'}

    # HTTP_405
    @staticmethod
    def method_not_allowed(detailmsg=None):
        detail = detailmsg or 'Method < > not allowed.'
        return {'detail': detail,
                'error': True,
                'error_code': 'method_not_allowed'}

    # HTTP_406
    @staticmethod
    def not_acceptable(detailmsg=None):
        detail = detailmsg or 'Could not satisfy the request Accept header.'
        return {'detail': detail,
                'error': True,
                'error_code': 'not_acceptable'}

    # HTTP_416
    @staticmethod
    def unsupported_media_type(detailmsg=None):
        detail = detailmsg or 'Unsupported media type < > in request.'
        return {'detail': detail,
                'error': True,
                'error_code': 'unsupported_media_type'}

    # HTTP_429
    @staticmethod
    def too_many_requests(detailmsg=None):
        detail = detailmsg or 'Request was throttled.'
        return {'detail': detail,
                'error': True,
                'error_code': 'throttled'}


class APITestHelper(object):

    @staticmethod
    def _delete_bookmark_folder(test_case_instance, username, folder_id, status_code=201):
        url = '/api/self/library/{0!s}/delete_folder/'.format(folder_id)

        user = generic_model_access.get_profile(username).user
        test_case_instance.client.force_authenticate(user=user)
        response = test_case_instance.client.delete(url, format='json')

        if response:
            if status_code == 204:
                test_case_instance.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)
            elif status_code == 400:
                test_case_instance.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
            else:
                raise Exception('status code is not supported')

        return response

    @staticmethod
    def _import_bookmarks(test_case_instance, username, bookmark_notification_id, status_code=201):
        url = '/api/self/library/import_bookmarks/'
        data = {'bookmark_notification_id': bookmark_notification_id}

        user = generic_model_access.get_profile(username).user
        test_case_instance.client.force_authenticate(user=user)
        response = test_case_instance.client.post(url, data, format='json')

        if response:
            if status_code == 201:
                test_case_instance.assertEqual(response.status_code, status.HTTP_201_CREATED)
            elif status_code == 400:
                test_case_instance.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
            else:
                raise Exception('status code is not supported')

        return response

    @staticmethod
    def create_bookmark(test_case_instance, username, listing_id, folder_name=None, status_code=200):
        """
        Create Bookmark Helper Function

        Args:
            test_case_instance
            username
            listing_id
            folder_name(optional)
            status_code

        Returns:
            response
        """
        url = '/api/self/library/'
        data = {'listing': {'id': listing_id}, 'folder': folder_name}

        user = generic_model_access.get_profile(username).user
        test_case_instance.client.force_authenticate(user=user)
        response = test_case_instance.client.post(url, data, format='json')

        if response:
            if status_code == 201:
                test_case_instance.assertEqual(response.status_code, status.HTTP_201_CREATED)
            elif status_code == 400:
                test_case_instance.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
            else:
                raise Exception('status code is not supported')

        return response

    @staticmethod
    def edit_listing(test_case_instance, id, input_data, default_user='bigbrother'):
        """
        Helper Method to modify a listing

        Args:
            test_case_instance
            id
            input_data
            default_user(optional)

        Return:
            response
        """
        url = '/api/listing/{0!s}/'.format(id)

        user = generic_model_access.get_profile(default_user).user
        test_case_instance.client.force_authenticate(user=user)
        data = test_case_instance.client.get(url, format='json').data

        for current_key in input_data:
            if current_key in data:
                data[current_key] = input_data[current_key]

        # PUT the Modification
        response = test_case_instance.client.put(url, data, format='json')
        test_case_instance.assertEqual(response.status_code, status.HTTP_200_OK)
        return response

    @staticmethod
    def request(test_case_instance, url, method, data=None, username='bigbrother', status_code=200, validator=None, format_str=None):
        user = generic_model_access.get_profile(username).user
        test_case_instance.client.force_authenticate(user=user)

        format_str = format_str or 'json'

        response = None

        if method.upper() == 'GET':
            response = test_case_instance.client.get(url, format=format_str)
        elif method.upper() == 'POST':
            response = test_case_instance.client.post(url, data, format=format_str)
        elif method.upper() == 'PUT':
            response = test_case_instance.client.put(url, data, format=format_str)
        elif method.upper() == 'DELETE':
            response = test_case_instance.client.delete(url, data, format=format_str)
        elif method.upper() == 'PATCH':
            response = test_case_instance.client.patch(url, format=format_str)
        else:
            raise Exception('method is not supported')

        if response:
            if status_code == 200:
                test_case_instance.assertEqual(response.status_code, status.HTTP_200_OK)
            elif status_code == 201:
                test_case_instance.assertEqual(response.status_code, status.HTTP_201_CREATED)
            elif status_code == 204:
                test_case_instance.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)
            elif status_code == 400:
                test_case_instance.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
            elif status_code == 403:
                test_case_instance.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)
            elif status_code == 404:
                test_case_instance.assertEqual(response.status_code, status.HTTP_404_NOT_FOUND)
            elif status_code == 405:
                test_case_instance.assertEqual(response.status_code, status.HTTP_405_METHOD_NOT_ALLOWED)
            elif status_code == 501:
                test_case_instance.assertEqual(response.status_code, status.HTTP_501_NOT_IMPLEMENTED)
            else:
                raise Exception('status code is not supported')

        try:
            if validator:
                validator(response.data, test_case_instance=test_case_instance)
        except Exception as err:
            # print(response.data)
            raise err

        return response


def validate_listing_map_keys_list(response_data, test_case_instance=None):
    for listing_map in response_data:
        test_case_instance.assertEqual(validate_listing_map_keys(listing_map), [])


def validate_listing_search_keys_list(response_data, test_case_instance=None):
    for listing_map in response_data['results']:
        test_case_instance.assertEqual(validate_listing_map_keys(listing_map), [])


def validate_listing_map_keys(listing_map, test_case_instance=None):
    """
    Used to validate the keys of a listing
    """
    if not isinstance(listing_map, dict):
        raise Exception('listing_map is not type dict, it is {0!s}'.format(type(listing_map)))

    listing_map_default_keys = ['id', 'is_bookmarked', 'screenshots',
                                'doc_urls', 'owners', 'categories', 'tags', 'contacts', 'intents',
                                'small_icon', 'large_icon', 'banner_icon', 'large_banner_icon',
                                'agency', 'last_activity', 'current_rejection', 'listing_type',
                                'title', 'approved_date', 'edited_date', 'featured_date', 'description', 'launch_url',
                                'version_name', 'unique_name', 'what_is_new', 'description_short',
                                'usage_requirements', 'system_requirements', 'approval_status', 'is_enabled', 'is_featured',
                                'is_deleted', 'avg_rate', 'total_votes', 'total_rate5', 'total_rate4',
                                'total_rate3', 'total_rate2', 'total_rate1', 'total_reviews',
                                'iframe_compatible', 'security_marking', 'is_private',
                                'required_listings']

    listing_keys = [k for k, v in listing_map.items()]

    invalid_key_list = []

    for current_key in listing_map_default_keys:
        if current_key not in listing_keys:
            invalid_key_list.append(current_key)

    return invalid_key_list
