import pytest
from django.test import override_settings
from rest_framework import status

from ozpcenter.models import ImportTask
from tests.cases import APITestCase, ModelAssertionsMixin
from tests.ozpcenter_api import fixtures


@pytest.mark.integration
@pytest.mark.fast
@override_settings(ES_ENABLED=False)
class ImportTaskApiTest(ModelAssertionsMixin,
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

        cls.import_task1 = fixtures.create_import_task("Task 1", "Entire", cls.store1)
        cls.import_task2 = fixtures.create_import_task("ABC Task 2", "Entire", cls.store2)
        cls.import_task3 = fixtures.create_import_task("Task 3", "Entire", cls.store3)
        cls.import_tasks_ordered = [cls.import_task2, cls.import_task1, cls.import_task3]

    def setUp(self):
        pass

    def test_get_import_tasks_user(self):
        self.authenticate_as(self.user_profile)

        response = self.client.get('/api/import_task/', format='json')

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_get_import_tasks_org_steward(self):
        self.authenticate_as(self.org_steward_profile)

        response = self.client.get('/api/import_task/', format='json')

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_get_import_tasks_aml_steward(self):
        self.authenticate_as(self.aml_steward_profile)

        response = self.client.get('/api/import_task/', format='json')

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertImportTasksEqual(response.data, self.import_tasks_ordered)

    def test_get_import_task_by_id_user(self):
        self.authenticate_as(self.user_profile)

        response = self.client.get('/api/import_task/1/', format='json')

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_get_import_task_by_id_org_steward(self):
        self.authenticate_as(self.org_steward_profile)

        response = self.client.get('/api/import_task/1/', format='json')

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_get_import_task_by_id_aml_steward(self):
        self.authenticate_as(self.aml_steward_profile)

        response = self.client.get('/api/import_task/1/', format='json')

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertImportTaskEqual(response.data, self.import_task1)

    def test_create_import_task_as_aml_steward(self):
        self.authenticate_as(self.aml_steward_profile)

        request = self._import_task_create_request()

        response = self.client.post('/api/import_task/', request, format='json')

        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertImportTaskEqual(response.data, request)

    def test_create_import_task_as_org_steward_unauthorized(self):
        self.authenticate_as(self.org_steward_profile)

        request = self._import_task_create_request()

        response = self.client.post('/api/import_task/', request, format='json')

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_create_import_task_as_user_unauthorized(self):
        self.authenticate_as(self.user_profile)

        request = self._import_task_create_request()

        response = self.client.post('/api/import_task/', request, format='json')

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_update_import_task_as_aml_steward(self):
        self.authenticate_as(self.aml_steward_profile)

        request = self._import_task_update_request()

        response = self.client.put('/api/import_task/1/', request, format='json')

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertImportTaskEqual(response.data, request)

        updated = ImportTask.objects.find_by_id(1)
        self.assertEqual(updated.name, request['name'])
        self.assertEqual(updated.update_type, request['update_type'])
        self.assertEqual(updated.enabled, request['enabled'])
        self.assertEqual(updated.affiliated_store.id, request['affiliated_store'])

    def test_update_import_task_as_org_steward_unauthorized(self):
        self.authenticate_as(self.org_steward_profile)

        request = self._import_task_update_request()

        response = self.client.put('/api/import_task/1/', request, format='json')

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_update_import_task_as_user_unauthorized(self):
        self.authenticate_as(self.user_profile)

        request = self._import_task_update_request()

        response = self.client.put('/api/import_task/1/', request, format='json')

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_delete_import_task_as_steward(self):
        self.authenticate_as(self.aml_steward_profile)

        response = self.client.delete('/api/import_task/1/', format='json')

        self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)

        with self.assertRaises(ImportTask.DoesNotExist):
            ImportTask.objects.find_by_id(1)

    def test_delete_import_task_as_org_steward_unauthorized(self):
        self.authenticate_as(self.org_steward_profile)

        response = self.client.delete('/api/import_task/1/', format='json')

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_delete_import_task_as_user_unauthorized(self):
        self.authenticate_as(self.user_profile)

        response = self.client.delete('/api/import_task/1/', format='json')

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def _import_task_create_request(self):
        return {
            'name': 'Import Task 4',
            'update_type': 'Partial',
            'enabled': True,
            'affiliated_store': self.store1.id
        }

    def _import_task_update_request(self):
        return {
            'id': self.import_task1.id,
            'name': 'New Import Task 1',
            'update_type': 'Partial',
            'enabled': False,
            'affiliated_store': self.store2.id
        }
