import pytest
from django.test import override_settings
from rest_framework import status

from tests.cases import APITestCase, ModelAssertionsMixin
from tests.ozpcenter_api import fixtures


@pytest.mark.integration
@pytest.mark.fast
@override_settings(ES_ENABLED=False)
class ImportTaskResultApiTest(ModelAssertionsMixin,
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

        cls.task1 = fixtures.create_import_task("Task 1", "Entire", cls.store1)
        cls.task2 = fixtures.create_import_task("Task 2", "Entire", cls.store2)

        cls.task1_result1 = fixtures.create_import_task_result(cls.task1, "Result 1-1", "Pass")
        cls.task1_result2 = fixtures.create_import_task_result(cls.task1, "Result 1-2", "Fail")
        cls.task2_result1 = fixtures.create_import_task_result(cls.task2, "Result 2-1", "Pass")

        cls.task1_results = [cls.task1_result1, cls.task1_result2]

    def setUp(self):
        pass

    def _list_import_task_results(self, task_id):
        return self.client.get("/api/import_task/%s/result/" % task_id, format="json")

    def _get_import_task_result(self, task_id, result_id):
        return self.client.get("/api/import_task/%s/result/%s/" % (task_id, result_id), format="json")

    def _create_import_task_result(self, task_id, data=None):
        return self.client.post("/api/import_task/%s/result/" % task_id, data, format="json")

    def _update_import_task_result(self, task_id, result_id, data=None):
        return self.client.put("/api/import_task/%s/result/%s/" % (task_id, result_id), data, format="json")

    def _patch_import_task_result(self, task_id, result_id, data=None):
        return self.client.patch("/api/import_task/%s/result/%s/" % (task_id, result_id), data, format="json")

    def _delete_import_task_result(self, task_id, result_id):
        return self.client.delete("/api/import_task/%s/result/%s/" % (task_id, result_id), format="json")

    def test_list_import_task_results_user(self):
        self.authenticate_as(self.user_profile)

        response = self._list_import_task_results(self.task1.id)

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_list_import_task_results_org_steward(self):
        self.authenticate_as(self.org_steward_profile)

        response = self._list_import_task_results(self.task1.id)

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_list_import_task_results_aml_steward(self):
        self.authenticate_as(self.aml_steward_profile)

        response = self._list_import_task_results(self.task1.id)

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertImportTaskResultsEqual(response.data, self.task1_results)

    def test_get_import_task_result_by_id_user(self):
        self.authenticate_as(self.user_profile)

        response = self._get_import_task_result(self.task1.id, self.task1_result1.id)

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_get_import_task_result_by_id_org_steward(self):
        self.authenticate_as(self.org_steward_profile)

        response = self._get_import_task_result(self.task1.id, self.task1_result1.id)

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_get_import_task_result_by_id_aml_steward(self):
        self.authenticate_as(self.aml_steward_profile)

        response = self._get_import_task_result(self.task1.id, self.task1_result1.id)

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertImportTaskResultEqual(response.data, self.task1_result1)

    def test_create_import_task_result_as_aml_steward(self):
        self.authenticate_as(self.aml_steward_profile)

        response = self._create_import_task_result(self.task1.id)

        self.assertEqual(response.status_code, status.HTTP_405_METHOD_NOT_ALLOWED)

    def test_create_import_task_result_as_org_steward_unauthorized(self):
        self.authenticate_as(self.org_steward_profile)

        response = self._create_import_task_result(self.task1.id)

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_create_import_task_result_as_user_unauthorized(self):
        self.authenticate_as(self.user_profile)

        response = self._create_import_task_result(self.task1.id)

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_update_import_task_result_as_aml_steward(self):
        self.authenticate_as(self.aml_steward_profile)

        response = self._update_import_task_result(self.task1.id, self.task1_result1.id)

        self.assertEqual(response.status_code, status.HTTP_405_METHOD_NOT_ALLOWED)

    def test_update_import_task_result_as_org_steward_unauthorized(self):
        self.authenticate_as(self.org_steward_profile)

        response = self._update_import_task_result(self.task1.id, self.task1_result1.id)

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_update_import_task_result_as_user_unauthorized(self):
        self.authenticate_as(self.user_profile)

        response = self._update_import_task_result(self.task1.id, self.task1_result1.id)

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_delete_import_task_result_as_steward(self):
        self.authenticate_as(self.aml_steward_profile)

        response = self._delete_import_task_result(self.task1.id, self.task1_result1.id)

        self.assertEqual(response.status_code, status.HTTP_405_METHOD_NOT_ALLOWED)

    def test_delete_import_task_result_as_org_steward_unauthorized(self):
        self.authenticate_as(self.org_steward_profile)

        response = self._delete_import_task_result(self.task1.id, self.task1_result1.id)

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_delete_import_task_result_as_user_unauthorized(self):
        self.authenticate_as(self.user_profile)

        response = self._delete_import_task_result(self.task1.id, self.task1_result1.id)

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)
