import pytest
from django.test import override_settings
from rest_framework import status

from ozpcenter.models import AffiliatedStore
from tests.cases import APITestCase, ModelAssertionsMixin
from tests.ozpcenter_api import fixtures


@pytest.mark.integration
@pytest.mark.fast
@override_settings(ES_ENABLED=False)
class AffiliatedStoreApiTest(ModelAssertionsMixin,
                             APITestCase):

    @classmethod
    def setUpTestData(cls):
        cls.aml_steward_profile = fixtures.create_steward()
        cls.org_steward_profile = fixtures.create_org_steward()
        cls.user_profile = fixtures.create_user_profile()

        cls.image_type = fixtures.create_image_type('large_icon')
        cls.image = fixtures.create_image(cls.image_type)

        cls.store1 = fixtures.create_affiliated_store("Store 1", "http://www.store1a.test", cls.image, True)
        cls.store2 = fixtures.create_affiliated_store("Store 2", "http://www.store2.test", cls.image, True)
        cls.store3 = fixtures.create_affiliated_store("Store 3", "http://www.store3.test", cls.image, True)
        cls.all_stores = [cls.store1, cls.store2, cls.store3]

    def setUp(self):
        pass

    def test_get_affiliated_stores(self):
        self.authenticate_as(self.user_profile)

        response = self.client.get('/api/affiliated_store/', format='json')

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertStoresEqual(response.data, self.all_stores)

    def test_get_affiliated_store_by_id(self):
        self.authenticate_as(self.user_profile)

        response = self.client.get('/api/affiliated_store/1/', format='json')

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertStoreEqual(response.data, self.store1)

    def test_create_affiliated_store_as_steward(self):
        self.authenticate_as(self.aml_steward_profile)

        request = self._affiliated_store_create_request()

        response = self.client.post('/api/affiliated_store/', request, format='json')

        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertStoreEqual(response.data, request)

        created = AffiliatedStore.objects.find_by_id(response.data['id'])
        self.assertIsNotNone(created)

    def test_create_affiliated_store_as_org_steward_is_unauthorized(self):
        self.authenticate_as(self.org_steward_profile)

        request = self._affiliated_store_create_request()

        response = self.client.post('/api/affiliated_store/', request, format='json')

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_create_affiliated_store_as_user_is_unauthorized(self):
        self.authenticate_as(self.user_profile)

        request = self._affiliated_store_create_request()

        response = self.client.post('/api/affiliated_store/', request, format='json')

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_update_affiliated_store_as_steward(self):
        self.authenticate_as(self.aml_steward_profile)

        request = self._affiliated_store_update_request()

        response = self.client.put('/api/affiliated_store/1/', request, format='json')

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertStoreEqual(response.data, request)

        updated = AffiliatedStore.objects.find_by_id(1)
        self.assertEqual(updated.title, request['title'])
        self.assertEqual(updated.is_enabled, request['is_enabled'])

    def test_update_affiliated_store_as_org_steward_is_unauthorized(self):
        self.authenticate_as(self.org_steward_profile)

        request = self._affiliated_store_update_request()

        response = self.client.put('/api/affiliated_store/1/', request, format='json')

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_update_affiliated_store_as_user_is_unauthorized(self):
        self.authenticate_as(self.user_profile)

        request = self._affiliated_store_update_request()

        response = self.client.put('/api/affiliated_store/1/', request, format='json')

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_delete_affiliated_store_as_steward(self):
        self.authenticate_as(self.aml_steward_profile)

        response = self.client.delete('/api/affiliated_store/1/', format='json')

        self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)

        with self.assertRaises(AffiliatedStore.DoesNotExist):
            AffiliatedStore.objects.find_by_id(1)

    def test_delete_affiliated_store_as_org_steward_is_forbidden(self):
        self.authenticate_as(self.org_steward_profile)

        response = self.client.delete('/api/affiliated_store/1/', format='json')

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_delete_affiliated_store_as_user_is_forbidden(self):
        self.authenticate_as(self.user_profile)

        response = self.client.delete('/api/affiliated_store/1/', format='json')

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def _affiliated_store_create_request(self):
        return {
            'title': 'Store 4',
            'server_url': 'http://www.store4.test',
            'icon': self.image.id,
            'is_enabled': True
        }

    def _affiliated_store_update_request(self):
        return {
            'id': self.store1.id,
            'title': 'New Store 1',
            'server_url': self.store1.server_url,
            'icon': self.store1.icon.id,
            'is_enabled': False
        }
