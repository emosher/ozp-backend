import pytest
from django.test import override_settings
from rest_framework import status

from tests.cases import APITestCase, ModelAssertionsMixin
from tests.ozpcenter_api import fixtures
from ozpcenter.models import CustomFieldValue

@pytest.mark.integration
@pytest.mark.fast
@override_settings(ES_ENABLED=False)
class CustomFieldValueApiTest(ModelAssertionsMixin,
                             APITestCase):

    @classmethod
    def setUpTestData(cls):
        cls.aml_steward_profile = fixtures.create_steward()
        cls.org_steward_profile = fixtures.create_org_steward()
        cls.user_profile = fixtures.create_user_profile()

        cls.custom_field_type1 = fixtures.create_custom_field_type("Type 1", "type 1", "application/json")
        cls.custom_field1 = fixtures.create_custom_field(cls.custom_field_type1, "Custom Field 1", "Field 1")
        cls.custom_field2 = fixtures.create_custom_field(cls.custom_field_type1, "Custom Field 2", "Field 2")
        cls.custom_field3 = fixtures.create_custom_field(cls.custom_field_type1, "Custom Field 3", "Field 3")

        cls.agency = fixtures.create_agency('Agency 1', 'Agency 1')

        cls.listing1 = fixtures.create_minimal_listing("Min Listing", "UNCLASSIFIED", cls.agency)
        cls.field_value1 = fixtures.create_custom_field_value(cls.listing1, cls.custom_field2, "Field Value 1")
        cls.field_value2 = fixtures.create_custom_field_value(cls.listing1, cls.custom_field2, "Field Value 3")
        cls.listing1.save()

        cls.listing1_fields = [cls.field_value1, cls.field_value2]

    def setUp(self):
        pass

    def _list_custom_field_values(self, listing_id):
        return self.client.get("/api/listing/%s/custom_field_value/" % listing_id, format="json")

    def _get_custom_field_value(self, listing_id: int, value_id: int):
        return self.client.get("/api/listing/%s/custom_field_value/%s/" % (listing_id, value_id), format="json")

    def _create_custom_field_value(self, listing_id: int, data: dict = None):
        return self.client.post("/api/listing/%s/custom_field_value/" % listing_id, data, format="json")

    def _update_custom_field_value(self, listing_id: int, value_id: int, data: dict = None):
        return self.client.put("/api/listing/%s/custom_field_value/%s/" % (listing_id, value_id), data, format="json")

    def _patch_custom_field_value(self, listing_id: int, value_id, data: dict = None):
        return self.client.patch("/api/listing/%s/custom_field_value/%s/" % (listing_id, value_id), data, format="json")

    def _delete_custom_field_value(self, listing_id: int, value_id: int):
        return self.client.delete("/api/listing/%s/custom_field_value/%s/" % (listing_id, value_id), format="json")

    def test__list_custom_field_values(self):
        self.authenticate_as(self.user_profile)

        response = self._list_custom_field_values(self.listing1.id)

        self.assertEqual(response.status_code, status.HTTP_200_OK)

        self.assertCustomFieldValuesEqual(response.data, self.listing1_fields)

    def test__get_custom_field_value(self):
        self.authenticate_as(self.user_profile)

        response = self._get_custom_field_value(self.listing1.id, self.field_value2.id)

        self.assertEqual(response.status_code, status.HTTP_200_OK)

        self.assertCustomFieldValueEqual(response.data, self.field_value2)

    def test__create_custom_field_value__as_aml_steward(self):
        self.authenticate_as(self.aml_steward_profile)

        request = self._custom_field_value_create_request()

        response = self._create_custom_field_value(self.listing1.id, request)

        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertCustomFieldValueEqual(response.data, request)

    def test__create_custom_field_value__as_org_steward(self):
        self.authenticate_as(self.org_steward_profile)

        request = self._custom_field_value_create_request()

        response = self._create_custom_field_value(self.listing1.id, request)

        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertCustomFieldValueEqual(response.data, request)

    def test__create_custom_field_value__as_user__is_unauthorized(self):
        self.authenticate_as(self.user_profile)

        request = self._custom_field_value_create_request()

        response = self._create_custom_field_value(self.listing1.id, request)

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test__update_custom_field_value__as_aml_steward(self):
        self.authenticate_as(self.aml_steward_profile)

        request = self._custom_field_value_update_request()

        response = self._update_custom_field_value(self.listing1.id, self.field_value1.id, request)

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertCustomFieldValueEqual(response.data, request)

        updated = CustomFieldValue.objects.find_by_id(self.field_value1.id)
        self.assertEqual(updated.value, request['value'])
        self.assertEqual(updated.custom_field.id, request['custom_field'])

    def test__update_custom_field_value__as_org_steward(self):
        self.authenticate_as(self.org_steward_profile)

        request = self._custom_field_value_update_request()

        response = self._update_custom_field_value(self.listing1.id, self.field_value1.id, request)

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertCustomFieldValueEqual(response.data, request)

        updated = CustomFieldValue.objects.find_by_id(self.field_value1.id)
        self.assertEqual(updated.value, request['value'])
        self.assertEqual(updated.custom_field.id, request['custom_field'])

    def test__update_custom_field_value__as_user__is_unauthorized(self):
        self.authenticate_as(self.user_profile)

        request = self._custom_field_value_update_request()

        response = self._update_custom_field_value(self.listing1.id, self.field_value1.id, request)

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test__delete_custom_field_value__as_aml_steward(self):
        self.authenticate_as(self.aml_steward_profile)

        response = self._delete_custom_field_value(self.listing1.id, self.field_value1.id)

        self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)

    def test__delete_custom_field_value__as_org_steward(self):
        self.authenticate_as(self.org_steward_profile)

        response = self._delete_custom_field_value(self.listing1.id, self.field_value1.id)

        self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)

    def test__delete_custom_field_value__as_user__is_unauthorized(self):
        self.authenticate_as(self.user_profile)

        response = self._delete_custom_field_value(self.listing1.id, self.field_value1.id)

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def _custom_field_value_create_request(self):
        return {
            'listing': self.listing1.id,
            'value': 'Custom Field 4',
            'custom_field': self.custom_field3.id
        }

    def _custom_field_value_update_request(self):
        return {
            'id': self.field_value1.id,
            'listing': self.listing1.id,
            'value': 'abc',
            'custom_field': self.custom_field3.id
        }
