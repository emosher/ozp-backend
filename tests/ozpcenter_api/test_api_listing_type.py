"""
Tests for listing type endpoints
"""
import pytest
from django.test import TestCase
from django.test import override_settings

import ozpcenter.api.listing.model_access as model_access
from rest_framework import status
from ozpcenter.models import ListingType, Listing
from ozpcenter.api.listing.model_access import get_listing_type_by_id, get_listing_by_id
from tests.cases import APITestCase, ModelAssertionsMixin
from tests.ozpcenter_api import fixtures

@pytest.mark.integration
@pytest.mark.fast
@override_settings(ES_ENABLED=False)
class ListingTypeApiTest(ModelAssertionsMixin,
                        APITestCase):

    @classmethod
    def setUpTestData(cls):
        """
        Set up test data for the whole TestCase (only run once for the TestCase)
        """
        cls.aml_steward_profile = fixtures.create_steward()
        cls.org_steward_profile = fixtures.create_org_steward()
        cls.user_profile = fixtures.create_user_profile()

        cls.custom_field_type1 = fixtures.create_custom_field_type('Type 1', 'Type 1', 'application/json')
        cls.custom_field1 = fixtures.create_custom_field(cls.custom_field_type1, 'Custom Field', 'Custom Field')

        cls.listing_type1 = fixtures.create_listing_type("Listing Type 1", "Description 1")
        cls.listing_type2 = fixtures.create_listing_type("Listing Type 2", "Description 2")
        cls.listing_type3 = fixtures.create_listing_type("Listing Type 3", "Description 3")

        cls.listing_type1.custom_fields.add(cls.custom_field1)
        cls.listing_types_ordered = [cls.listing_type1, cls.listing_type2, cls.listing_type3]

    def setUp(self):
        """
        setUp is invoked before each test method
        """
        pass

    def _list_listing_types(self):
        return self.client.get("/api/listingtype/", format="json")

    def _get_listing_type(self, listing_type_id):
        return self.client.get("/api/listingtype/%s/" % listing_type_id, format="json")

    def _create_listing_type(self, data=None):
        return self.client.post("/api/listingtype/", data, format="json")

    def _update_listing_type(self, listing_type_id, data=None):
        return self.client.put("/api/listingtype/%s/" % listing_type_id, data, format="json")

    def _patch_listing_type(self, listing_type_id, data=None):
        return self.client.patch("/api/listingtype/%s/" % listing_type_id, data, format="json")

    def _delete_listing_type(self, listing_type_id, data=None):
        return self.client.delete("/api/listingtype/%s/" % listing_type_id, data, format="json")

    def _create_listing(self, data=None):
        return self.client.post("/api/listing/", data, format="json")

    def test_listing_types_user(self):
        self.authenticate_as(self.user_profile)

        response = self._list_listing_types()

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertListingTypesEqual(response.data, self.listing_types_ordered)

    def test_list_listing_types_org_steward(self):
        self.authenticate_as(self.org_steward_profile)

        response = self._list_listing_types()

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertListingTypesEqual(response.data, self.listing_types_ordered)

    def test_list_listing_types_aml_steward(self):
        self.authenticate_as(self.aml_steward_profile)

        response = self._list_listing_types()

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertListingTypesEqual(response.data, self.listing_types_ordered)

    def test_get_listing_type_by_id_user(self):
        self.authenticate_as(self.user_profile)

        response = self._get_listing_type(self.listing_type1.id)

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertListingTypeEqual(response.data, self.listing_type1)

    def test_get_listing_type_by_id_org_steward(self):
        self.authenticate_as(self.org_steward_profile)

        response = self._get_listing_type(self.listing_type1.id)

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertListingTypeEqual(response.data, self.listing_type1)

    def test_get_listing_type_by_id_aml_steward(self):
        self.authenticate_as(self.aml_steward_profile)

        response = self._get_listing_type(self.listing_type1.id)

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertListingTypeEqual(response.data, self.listing_type1)

    def test_create_listing_type_as_aml_steward(self):
        self.authenticate_as(self.aml_steward_profile)

        request = self._listing_type_create_request()

        response = self._create_listing_type(request)

        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

    def test_create_listing_type_as_org_steward_unauthorized(self):
        self.authenticate_as(self.org_steward_profile)

        request = self._listing_type_create_request()

        response = self._create_listing_type(request)

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_create_listing_type_as_user_unauthorized(self):
        self.authenticate_as(self.user_profile)

        request = self._listing_type_create_request()

        response = self._create_listing_type(request)

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_update_listing_type_as_aml_steward(self):
        self.authenticate_as(self.aml_steward_profile)

        response = self._update_listing_type(self.listing_type1.id, self._listing_type_update_request())

        print(response.data)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertListingTypeEqual(response.data, self._listing_type_update_request())

    def test_update_listing_type_as_org_steward_forbidden(self):
        self.authenticate_as(self.org_steward_profile)

        response = self._update_listing_type(self.listing_type1.id, self._listing_type_update_request())

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_update_listing_type_as_user_unauthorized(self):
        self.authenticate_as(self.user_profile)

        response = self._update_listing_type(self.listing_type1.id, self._listing_type_update_request())

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_delete_listing_type_as_aml_steward(self):
        self.authenticate_as(self.aml_steward_profile)

        response = self._delete_listing_type(self.listing_type1.id)

        self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)

        with self.assertRaises(ListingType.DoesNotExist):
            get_listing_type_by_id(1, True)

    def test_delete_listing_type_as_org_steward_unauthorized(self):
        self.authenticate_as(self.org_steward_profile)

        response = self._delete_listing_type(self.listing_type1.id)

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_delete_listing_type_as_user_unauthorized(self):
        self.authenticate_as(self.user_profile)

        response = self._delete_listing_type(self.listing_type1.id)

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test_create_delete_basic_listing_as_aml_steward(self):
        self.authenticate_as(self.aml_steward_profile)

        request = self._basic_listing_without_listing_type_request()

        response = self._create_listing(request)

        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

        new_listing_id = response.data['id']
        response = self._delete_listing_type(self.listing_type1.id)

        self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)

        with self.assertRaises(ListingType.DoesNotExist):
            get_listing_type_by_id(self.listing_type1.id, True)

    def test_create_delete_detailed_listing_as_aml_steward_no_confirmation(self):
        self.authenticate_as(self.aml_steward_profile)

        request = self._basic_listing_with_listing_type_request()

        response = self._create_listing(request)

        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

        response = self._delete_listing_type(self.listing_type1.id)

        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)

    def test_create_delete_detailed_listing_as_aml_steward_with_confirmation(self):
        self.authenticate_as(self.aml_steward_profile)

        request = self._basic_listing_with_listing_type_request()

        response = self._create_listing(request)

        new_listing_id = response.data['id']

        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

        data = {'delete_associated_listings': True}
        response = self._delete_listing_type(self.listing_type1.id, data)

        self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)

        with self.assertRaises(ListingType.DoesNotExist):
            get_listing_type_by_id(self.listing_type1.id, True)

        with self.assertRaises(Listing.DoesNotExist):
            get_listing_by_id('bigbrother', new_listing_id, True)

    def _basic_listing_without_listing_type_request(self):
        return {
        	"title": "New Listing",
        	"security_marking": "UNCLASSIFIED",
        }

    def _basic_listing_with_listing_type_request(self):
        return {
        	"title": "New Listing",
        	"security_marking": "UNCLASSIFIED",
        	"listing_type": {"title": "Listing Type 1"}
        }

    def _listing_type_create_request(self):
        return {
            'title': 'New Listing 4',
            'description': 'Description 4',
            'custom_fields': [self.custom_field1.id]
        }

    def _listing_type_update_request(self):
        return {
            'id': self.listing_type1.id,
            'title': 'New Listing Type 1',
            'description': 'New Description 1',
            'custom_fields': [self.custom_field1.id]
        }
