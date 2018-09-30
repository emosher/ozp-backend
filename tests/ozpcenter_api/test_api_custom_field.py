import pytest
from django.test import override_settings
from rest_framework import status
from ozpcenter.models import CustomField
from tests.cases import APITestCase, ModelAssertionsMixin
from tests.ozpcenter_api import fixtures
from ozpcenter.api.custom_field.model_access import get_custom_field_by_id

@pytest.mark.integration
@pytest.mark.fast
@override_settings(ES_ENABLED=False)
class CustomFieldApiTest(ModelAssertionsMixin,
                              APITestCase):

    @classmethod
    def setUpTestData(cls):
        cls.aml_steward_profile = fixtures.create_steward()
        cls.org_steward_profile = fixtures.create_org_steward()
        cls.user_profile = fixtures.create_user_profile()

        cls.type1 = fixtures.create_custom_field_type("Type 1", "Type 1", "text/html")
        cls.type2 = fixtures.create_custom_field_type("JSON Type", "JSON", "application/json")
        
        cls.field1 = fixtures.create_custom_field(cls.type1, 'Custom Field 1', 'Custom Field Label 1')
        cls.field2 = fixtures.create_custom_field(cls.type1, 'Custom Field 2', 'Custom Field Label 2')
        cls.field3 = fixtures.create_custom_field(cls.type1, 'Custom Field 2', 'Custom Field Label 2')

        cls.fields_ordered = [cls.field1, cls.field2, cls.field3]

    def setUp(self):
        pass

    def _list_custom_fields(self):
        return self.client.get("/api/custom_field/", format="json")

    def _get_custom_field(self, field_id):
        return self.client.get("/api/custom_field/%s/" % field_id, format="json")

    def _create_custom_field(self, data=None):
        return self.client.post("/api/custom_field/", data, format="json")

    def _update_custom_field(self, field_id, data=None):
        return self.client.put("/api/custom_field/%s/" % field_id, data, format="json")

    def _patch_custom_field(self, field_id, data=None):
        return self.client.patch("/api/custom_field/%s/" % field_id, data, format="json")

    def _delete_custom_field(self, field_id):
        return self.client.delete("/api/custom_field/%s/" % field_id, format="json")

    def test_list_custom_fields_user(self):
        self.authenticate_as(self.user_profile)

        response = self._list_custom_fields()

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertCustomFieldsEqual(response.data, self.fields_ordered)

    def test_list_custom_fields_org_steward(self):
        self.authenticate_as(self.org_steward_profile)

        response = self._list_custom_fields()

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertCustomFieldsEqual(response.data, self.fields_ordered)

    def test_list_custom_fields_aml_steward(self):
        self.authenticate_as(self.aml_steward_profile)

        response = self._list_custom_fields()

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertCustomFieldsEqual(response.data, self.fields_ordered)

    def test_get_custom_field_by_id_user(self):
        self.authenticate_as(self.user_profile)

        response = self._get_custom_field(self.field1.id)

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertCustomFieldEqual(response.data, self.field1)

    def test_get_custom_field_by_id_org_steward(self):
        self.authenticate_as(self.org_steward_profile)

        response = self._get_custom_field(self.field1.id)

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertCustomFieldEqual(response.data, self.field1)

    def test_get_custom_field_by_id_aml_steward(self):
        self.authenticate_as(self.aml_steward_profile)

        response = self._get_custom_field(self.field1.id)

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertCustomFieldEqual(response.data, self.field1)

    def test_create_custom_field_as_aml_steward(self):
        self.authenticate_as(self.aml_steward_profile)

        request = self._custom_field_create_request()

        response = self._create_custom_field(request)

        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertCustomFieldEqual(response.data, request)

    def test_create_custom_field_as_org_steward_unauthorized(self):
        self.authenticate_as(self.org_steward_profile)

        response = self._create_custom_field(self.field1.id)

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_create_custom_field_as_user_unauthorized(self):
        self.authenticate_as(self.user_profile)

        response = self._create_custom_field(self.field1.id)

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_update_custom_field_as_aml_steward(self):
        self.authenticate_as(self.aml_steward_profile)

        response = self._update_custom_field(self.field1.id, self._custom_field_update_request())

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertCustomFieldEqual(response.data, self._custom_field_update_request())

    def test_update_custom_field_as_org_steward_unauthorized(self):
        self.authenticate_as(self.org_steward_profile)

        response = self._update_custom_field(self.field1.id)

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_update_custom_field_as_user_unauthorized(self):
        self.authenticate_as(self.user_profile)

        response = self._update_custom_field(self.field1.id)

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_delete_custom_field_as_steward(self):
        self.authenticate_as(self.aml_steward_profile)

        response = self._delete_custom_field(self.field1.id)

        self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)

        with self.assertRaises(CustomField.DoesNotExist):
            get_custom_field_by_id(1, True)

    def test_delete_custom_field_as_org_steward_unauthorized(self):
        self.authenticate_as(self.org_steward_profile)

        response = self._delete_custom_field(self.field1.id)

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_delete_custom_field_as_user_unauthorized(self):
        self.authenticate_as(self.user_profile)

        response = self._delete_custom_field(self.field1.id)

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def _custom_field_create_request(self):
        return {
            'display_name': 'Field 4',
            'label': 'Custom Text Field',
            'type': self.type1.id,
            'section': 'Section',
            'description': 'Description',
            'tooltip': 'Tooltip',
            'properties': 'Properties',
            'is_required': False,
            'admin_only': True,
            'all_listing_types': False
        }

    def _custom_field_update_request(self):
        return {
            'id': self.field1.id,
            'type': self.type2.id,
            'display_name': 'New Field 1',
            'label': 'New Field Label 1',
            'section': 'Section',
            'description': 'Description',
            'tooltip': 'Tooltip',
            'properties': 'Properties',
            'is_required': False,
            'admin_only': True,
            'all_listing_types': False
        }
