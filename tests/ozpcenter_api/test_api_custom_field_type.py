import pytest
from django.test import override_settings
from rest_framework import status
from ozpcenter.models import CustomFieldType
from tests.cases import APITestCase, ModelAssertionsMixin
from tests.ozpcenter_api import fixtures
from ozpcenter.api.custom_field_type.model_access import get_custom_field_type_by_id

@pytest.mark.integration
@pytest.mark.fast
@override_settings(ES_ENABLED=False)
class CustomFieldTypeApiTest(ModelAssertionsMixin,
                              APITestCase):

    @classmethod
    def setUpTestData(cls):
        cls.aml_steward_profile = fixtures.create_steward()
        cls.org_steward_profile = fixtures.create_org_steward()
        cls.user_profile = fixtures.create_user_profile()

        cls.type1 = fixtures.create_custom_field_type("Type 1", "Type 1", "text/html")
        cls.type2 = fixtures.create_custom_field_type("JSON Type", "JSON", "application/json")
        cls.type3 = fixtures.create_custom_field_type("Type 3", "Type 3", "text/html")

        cls.types_ordered = [cls.type2, cls.type1, cls.type3]

    def setUp(self):
        pass

    def _list_custom_field_types(self):
        return self.client.get("/api/custom_field_type/", format="json")

    def _get_custom_field_type(self, type_id):
        return self.client.get("/api/custom_field_type/%s/" % type_id, format="json")

    def _create_custom_field_type(self, data=None):
        return self.client.post("/api/custom_field_type/", data, format="json")

    def _update_custom_field_type(self, type_id, data=None):
        return self.client.put("/api/custom_field_type/%s/" % type_id, data, format="json")

    def _patch_custom_field_type(self, type_id, data=None):
        return self.client.patch("/api/custom_field_type/%s/" % type_id, data, format="json")

    def _delete_custom_field_type(self, type_id):
        return self.client.delete("/api/custom_field_type/%s/" % type_id, format="json")

    def test_list_custom_field_types_user(self):
        self.authenticate_as(self.user_profile)

        response = self._list_custom_field_types()

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertCustomFieldTypesEqual(response.data, self.types_ordered)

    def test_list_custom_field_types_org_steward(self):
        self.authenticate_as(self.org_steward_profile)

        response = self._list_custom_field_types()

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertCustomFieldTypesEqual(response.data, self.types_ordered)

    def test_list_custom_field_types_aml_steward(self):
        self.authenticate_as(self.aml_steward_profile)

        response = self._list_custom_field_types()

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertCustomFieldTypesEqual(response.data, self.types_ordered)

    def test_get_custom_field_type_by_id_user(self):
        self.authenticate_as(self.user_profile)

        response = self._get_custom_field_type(self.type1.id)

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertCustomFieldTypeEqual(response.data, self.type1)

    def test_get_custom_field_type_by_id_org_steward(self):
        self.authenticate_as(self.org_steward_profile)

        response = self._get_custom_field_type(self.type1.id)

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertCustomFieldTypeEqual(response.data, self.type1)

    def test_get_custom_field_type_by_id_aml_steward(self):
        self.authenticate_as(self.aml_steward_profile)

        response = self._get_custom_field_type(self.type1.id)

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertCustomFieldTypeEqual(response.data, self.type1)

    def test_create_custom_field_type_as_aml_steward(self):
        self.authenticate_as(self.aml_steward_profile)

        request = self._custom_field_type_create_request()

        response = self._create_custom_field_type(request)

        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertCustomFieldTypeEqual(response.data, request)

    def test_create_custom_field_type_as_org_steward_unauthorized(self):
        self.authenticate_as(self.org_steward_profile)

        response = self._create_custom_field_type(self.type1.id)

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_create_custom_field_type_as_user_unauthorized(self):
        self.authenticate_as(self.user_profile)

        response = self._create_custom_field_type(self.type1.id)

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_update_custom_field_type_as_aml_steward(self):
        self.authenticate_as(self.aml_steward_profile)

        response = self._update_custom_field_type(self.type1.id, self._custom_field_type_update_request())

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertCustomFieldTypeEqual(response.data, self._custom_field_type_update_request())

    def test_update_custom_field_type_as_org_steward_unauthorized(self):
        self.authenticate_as(self.org_steward_profile)

        response = self._update_custom_field_type(self.type1.id)

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_update_custom_field_type_as_user_unauthorized(self):
        self.authenticate_as(self.user_profile)

        response = self._update_custom_field_type(self.type1.id)

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_delete_custom_field_type_as_steward(self):
        self.authenticate_as(self.aml_steward_profile)

        response = self._delete_custom_field_type(self.type1.id)

        self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)

        with self.assertRaises(CustomFieldType.DoesNotExist):
            get_custom_field_type_by_id(1, True)

    def test_delete_custom_field_type_as_org_steward_unauthorized(self):
        self.authenticate_as(self.org_steward_profile)

        response = self._delete_custom_field_type(self.type1.id)

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_delete_custom_field_type_as_user_unauthorized(self):
        self.authenticate_as(self.user_profile)

        response = self._delete_custom_field_type(self.type1.id)

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def _custom_field_type_create_request(self):
        return {
            'name': 'Type 4',
            'display_name': 'Type 4',
            'media_type': 'application/json',
            'options': 'abc'
        }

    def _custom_field_type_update_request(self):
        return {
            'id': self.type1.id,
            'name': 'New Type 1',
            'display_name': 'New Type 1',
            'media_type': 'application/json',
            'options': 'abc'
        }
