import json
from datetime import timedelta
from typing import List

import pytest
from django.test import testcases
from django.utils import timezone

from ozpcenter.api.imports.service import ImportTask
from ozpcenter.models import ImageType, Agency, Category, ContactType, Contact, CustomFieldType
from ozpcenter.models import CustomField, Image, Intent, ListingType, Profile, Tag, Listing

from ozpcenter.util import Mappable, expect
from tests.cases import ModelAssertionsMixin
from tests.cases.factories import AffiliatedStoreFactory, ImageTypeFactory


@pytest.mark.integration
@pytest.mark.fast
class ImportTaskTest(ModelAssertionsMixin,
                     testcases.TestCase):

    @classmethod
    def setUpTestData(cls):
        cls.affiliated_store = AffiliatedStoreFactory()

        with open('tests/ozpcenter_api/imports/sample_export.json') as import_data_json:
            cls.import_data = json.load(import_data_json)

    def setUp(self):
        pass

    def test__import_task(self):
        with open('tests/ozpcenter_api/imports/single_listing_export.json') as import_data_json:
            preload_data = json.load(import_data_json)

        preload_task = ImportTask(preload_data, self.affiliated_store)
        result = preload_task.run()

        self.assertResultsCount(result, "errors", 0)

        self.assertResultsCount(result, "agencies", 1)
        self.assertResultsCount(result, "categories", 1)
        self.assertResultsCount(result, "contact_types", 1)
        self.assertResultsCount(result, "contacts", 1)
        self.assertResultsCount(result, "custom_field_types", 1)
        self.assertResultsCount(result, "custom_fields", 1)
        self.assertResultsCount(result, "image_types", 1)
        self.assertResultsCount(result, "images", 1)
        self.assertResultsCount(result, "intents", 1)
        self.assertResultsCount(result, "listing_types", 1)
        self.assertResultsCount(result, "profiles", 1)
        self.assertResultsCount(result, "tags", 1)

        self.assertResultsCount(result, "listings", 1)

        import_task = ImportTask(self.import_data, self.affiliated_store)

        result = import_task.run()

        self.assertResultsCount(result, "errors", 0)

        self.assertResultsCount(result, "agencies", 9)
        self.assertResultsCount(result, "categories", 15)
        self.assertResultsCount(result, "contact_types", 3)
        self.assertResultsCount(result, "contacts", 29)
        self.assertResultsCount(result, "custom_field_types", 2)
        self.assertResultsCount(result, "custom_fields", 2)
        self.assertResultsCount(result, "image_types", 8)
        self.assertResultsCount(result, "images", 1225)
        self.assertResultsCount(result, "intents", 2)
        self.assertResultsCount(result, "listing_types", 5)
        self.assertResultsCount(result, "profiles", 16)
        self.assertResultsCount(result, "tags", 371)

        self.assertResultsCount(result, "listings", 186)

        self.assertAffiliatedStore(result)

    def test__import_task__new_listing(self):
        import_task = ImportTask(self.import_data, self.affiliated_store)

        result = import_task.run()

        self.assertResultsCount(result, "errors", 0)

        expected = find_by_internal_id(self.import_data["listings"], 2)
        actual = find_by_external_id(result["listings"], 2)

        self.assertPropertyEqualValue(actual, "approval_status", "APPROVED")
        self.assertDateTimePropertyEqual(actual, expected, "approved_date")
        self.assertDateTimePropertyEqual(actual, expected, "edited_date")
        self.assertDateTimePropertyEqual(actual, expected, "featured_date")

        self.assertPropertyEqualValue(actual, "avg_rate", 3.2)

        self.assertReferenceHasImportMetadata(actual, expected, "agency")
        self.assertReferenceHasImportMetadata(actual, expected, "banner_icon")
        self.assertReferenceHasImportMetadata(actual, expected, "large_banner_icon")
        self.assertReferenceHasImportMetadata(actual, expected, "large_icon")
        self.assertReferenceHasImportMetadata(actual, expected, "small_icon")
        self.assertReferenceHasImportMetadata(actual, expected, "last_activity")
        self.assertReferenceHasImportMetadata(actual, expected, "required_listings")

        self.assertManyReferenceHaveImportMetadata(actual, expected, "categories")
        self.assertManyReferenceHaveImportMetadata(actual, expected, "contacts")
        self.assertManyReferenceHaveImportMetadata(actual, expected, "intents")
        self.assertManyReferenceHaveImportMetadata(actual, expected, "owners")
        self.assertManyReferenceHaveImportMetadata(actual, expected, "tags")

        self.assertEmbeddedListEqual(actual, expected, "doc_urls", self.assertDocUrlImport)
        self.assertEmbeddedListEqual(actual, expected, "reviews", self.assertReviewImport)
        self.assertEmbeddedListEqual(actual, expected, "screenshots", self.assertScreenshotImport)
        self.assertEmbeddedListEqual(actual, expected, "custom_fields", self.assertCustomFieldValueImport)

    def assertEmbeddedListEqual(self, actual, expected, property_name: str, comparator):
        actual_items = sorted(list(expect.prop_of(actual, property_name).all()),
                              key=lambda e: e.import_metadata.external_id)

        expected_items: List[dict] = sorted(expect.prop_of(expected, property_name),
                                            key=lambda e: e["id"])

        self.assertEqual(len(actual_items), len(expected_items))
        for i in range(0, len(expected_items)):
            comparator(actual_items[i], expected_items[i])

    def assertDocUrlImport(self, actual, expected):
        self.assertPropertyNotNone(actual, "id")
        self.assertPropertyEqual(actual, expected, "name")
        self.assertPropertyEqual(actual, expected, "url")
        self.assertPropertyEqualValue(actual, "listing", actual.listing)
        self.assertHasImportMetadata(actual, expected["id"])

    def assertReviewImport(self, actual, expected):
        self.assertPropertyNotNone(actual, "id")
        self.assertPropertyEqual(actual, expected, "text")
        self.assertPropertyEqual(actual, expected, "rate")
        self.assertDateTimePropertyEqual(actual, expected, "edited_date")
        self.assertDateTimePropertyEqual(actual, expected, "created_date")

        self.assertHasImportMetadata(actual, expected["id"])

        self.assertPropertyEqualValue(actual, "listing", actual.listing)

        self.assertHasImportMetadata(actual.author, expected["author"])

    def assertScreenshotImport(self, actual, expected):
        self.assertPropertyNotNone(actual, "id")
        self.assertPropertyEqual(actual, expected, "description")
        self.assertHasImportMetadata(actual, expected["id"])

        self.assertPropertyEqualValue(actual, "listing", actual.listing)

        self.assertHasImportMetadata(actual.small_image, expected["small_image"])
        self.assertHasImportMetadata(actual.large_image, expected["large_image"])

    def assertCustomFieldValueImport(self, actual, expected):
        self.assertPropertyNotNone(actual, "id")
        self.assertPropertyEqual(actual, expected, "value")
        self.assertHasImportMetadata(actual, expected["id"])

        self.assertPropertyEqualValue(actual, "listing", actual.listing)

        self.assertHasImportMetadata(actual.custom_field, expected["custom_field"])

    def assertReferenceHasImportMetadata(self, actual, expected, property_name: str):
        reference = expect.prop_of(actual, property_name)
        self.assertHasImportMetadata(reference, expected[property_name])

    def assertManyReferenceHaveImportMetadata(self, actual, expected, property_name: str):
        actual_refs = sorted(expect.prop_of(actual, property_name).all(),
                             key=lambda ref: ref.import_metadata.external_id)

        expected_refs = sorted(expect.prop_of(expected, property_name))

        self.assertEqual(len(actual_refs), len(expected_refs), "reference lists have same size")

        for i in range(0, len(expected_refs)):
            self.assertHasImportMetadata(actual_refs[i], expected_refs[i])

    def test__import_task__new_image_type(self):
        sample_data = {"image_types": [IMAGE_TYPE_1]}

        result = ImportTask(sample_data, self.affiliated_store).run()

        self.assertImageTypeImport(result["image_types"][0], IMAGE_TYPE_1)

    def test__import_task__new_image(self):
        sample_data = {
            "image_types": [IMAGE_TYPE_1],
            "images": [IMAGE_1]
        }

        result = ImportTask(sample_data, self.affiliated_store).run()

        self.assertImageImport(result["images"][0], IMAGE_1, IMAGE_TYPE_1)

    def test__import_task__new_image_type__invalid(self):
        sample_data = {"image_types": [IMAGE_TYPE_1_INVALID]}

        result = ImportTask(sample_data, self.affiliated_store).run()

        self.assertEqual(len(result["image_types"]), 0)
        self.assertEqual(len(result["errors"]), 1)

    def test__import_task__update_image_type(self):
        updated_date = timezone.now()
        initial_date = updated_date - timedelta(days=1)

        initial_data = {"image_types": [IMAGE_TYPE_1]}
        ImportTask(initial_data, self.affiliated_store, initial_date).run()

        updated_data = {"image_types": [IMAGE_TYPE_1_UPDATE]}
        result = ImportTask(updated_data, self.affiliated_store, updated_date).run()

        image_type = result["image_types"][0]

        self.assertImageTypeImport(image_type, IMAGE_TYPE_1_UPDATE)
        self.assertEqual(image_type.import_metadata.last_updated, updated_date)

    def test__import_task__existing_image_type(self):
        ImageTypeFactory(name="agency_icon")

        sample_data = {"image_types": [IMAGE_TYPE_1]}
        result = ImportTask(sample_data, self.affiliated_store).run()

        image_type = result["image_types"][0]

        self.assertImageTypeImport(image_type, IMAGE_TYPE_1)

        existing = ImageType.objects.internal_only().filter(name="agency_icon").first()
        self.assertNotEqual(existing.id, image_type.id)

        total = ImageType.objects.count()
        self.assertEqual(total, 2)

    def test__import_task__new_contact_type(self):
        sample_data = {"contact_types": [CONTACT_TYPE_1]}

        result = ImportTask(sample_data, self.affiliated_store).run()

        self.assertContactTypeImport(result["contact_types"][0], CONTACT_TYPE_1)

    def test__import_task__new_contact(self):
        sample_data = {
            "contact_types": [CONTACT_TYPE_1],
            "contacts": [CONTACT_1]
        }

        result = ImportTask(sample_data, self.affiliated_store).run()

        self.assertContactImport(result["contacts"][0], CONTACT_1, CONTACT_TYPE_1)

    def test__import_task__new_tag(self):
        sample_data = {"tags": [TAG_1]}

        result = ImportTask(sample_data, self.affiliated_store).run()

        self.assertTagImport(result["tags"][0], TAG_1)

    def test__import_task__new_category(self):
        sample_data = {"categories": [CATEGORY_1]}

        result = ImportTask(sample_data, self.affiliated_store).run()

        self.assertCategoryImport(result["categories"][0], CATEGORY_1)

    def test__import_task__new_agency(self):
        sample_data = {
            "image_types": [IMAGE_TYPE_1],
            "images": [IMAGE_1],
            "agencies": [AGENCY_1]
        }

        result = ImportTask(sample_data, self.affiliated_store).run()

        self.assertAgencyImport(result["agencies"][0], AGENCY_1)

    def test__import_task__new_custom_field_type(self):
        sample_data = {"custom_field_types": [CUSTOM_FIELD_TYPE_1]}

        result = ImportTask(sample_data, self.affiliated_store).run()

        self.assertCustomFieldTypeImport(result["custom_field_types"][0], CUSTOM_FIELD_TYPE_1)

    def test__import_task__new_custom_field(self):
        sample_data = {
            "custom_field_types": [CUSTOM_FIELD_TYPE_1],
            "custom_fields": [CUSTOM_FIELD_1]
        }

        result = ImportTask(sample_data, self.affiliated_store).run()

        self.assertCustomFieldImport(result["custom_fields"][0], CUSTOM_FIELD_1)

    def test__import_task__new_listing_type(self):
        sample_data = {"listing_types": [LISTING_TYPE_1]}

        result = ImportTask(sample_data, self.affiliated_store).run()

        self.assertListingTypeImport(result["listing_types"][0], LISTING_TYPE_1)

    def assertAffiliatedStore(self, result):
        self.assertModelCountForStore(Category, "categories", result)
        self.assertModelCountForStore(Agency, "agencies", result)
        self.assertModelCountForStore(ContactType, "contact_types", result)
        self.assertModelCountForStore(Contact, "contacts", result)
        self.assertModelCountForStore(CustomFieldType, "custom_field_types", result)
        self.assertModelCountForStore(CustomField, "custom_fields", result)
        self.assertModelCountForStore(ImageType, "image_types", result)
        self.assertModelCountForStore(Image, "images", result)
        self.assertModelCountForStore(Intent, "intents", result)
        self.assertModelCountForStore(ListingType, "listing_types", result)
        self.assertModelCountForStore(Profile, "profiles", result)
        self.assertModelCountForStore(Tag, "tags", result)

        self.assertModelCountForStore(Listing, "listings", result)

    def assertModelCountForStore(self, cls, key, result):
        savedModels = cls.objects.filter(import_metadata__affiliated_store=self.affiliated_store)
        self.assertEqual(len(result[key]), len(savedModels), "model has %d entries for store. result has %d entries" % (len(result[key]), len(savedModels)))

    def assertResultsCount(self, result, key, expected_count):
        self.assertTrue(key in result, "has %s key" % key)
        self.assertEqual(len(result[key]), expected_count, "expected key %s has count %d" % (key, expected_count))

    def assertImageTypeImport(self, actual: Mappable, expected: Mappable):
        self.assertPropertyNotNone(actual, "id")
        self.assertPropertyEqual(actual, expected, "name")
        self.assertPropertyEqual(actual, expected, "max_size_bytes")
        self.assertPropertyEqual(actual, expected, "max_width")
        self.assertPropertyEqual(actual, expected, "max_height")
        self.assertPropertyEqual(actual, expected, "min_width")
        self.assertPropertyEqual(actual, expected, "min_height")
        self.assertHasImportMetadata(actual, expected["id"])

    def assertImageImport(self, actual: Mappable, expected: Mappable, image_type: Mappable):
        self.assertPropertyNotNone(actual, "id")
        self.assertPropertyEqual(actual, expected, "uuid")
        self.assertPropertyEqual(actual, expected, "security_marking")
        self.assertPropertyEqual(actual, expected, "file_extension")
        self.assertHasImportMetadata(actual, expected["id"])

        self.assertPropertyEqual(actual, expected, "image_type",
                                 lambda a, e: self.assertImageTypeImport(a, image_type))

    def assertContactTypeImport(self, actual: Mappable, expected: Mappable):
        self.assertPropertyNotNone(actual, "id")
        self.assertPropertyEqual(actual, expected, "name")
        self.assertPropertyEqual(actual, expected, "required")
        self.assertHasImportMetadata(actual, expected["id"])

    def assertListingTypeImport(self, actual: Mappable, expected: Mappable):
        self.assertPropertyNotNone(actual, "id")
        self.assertPropertyEqual(actual, expected, "title")
        self.assertPropertyEqual(actual, expected, "description")
        self.assertHasImportMetadata(actual, expected["id"])

    def assertContactImport(self, actual: Mappable, expected: Mappable, contact_type: Mappable):
        self.assertPropertyNotNone(actual, "id")
        self.assertPropertyEqual(actual, expected, "secure_phone")
        self.assertPropertyEqual(actual, expected, "unsecure_phone")
        self.assertPropertyEqual(actual, expected, "email")
        self.assertPropertyEqual(actual, expected, "name")
        self.assertPropertyEqual(actual, expected, "organization")
        self.assertHasImportMetadata(actual, expected["id"])

        self.assertPropertyEqual(actual, expected, "contact_type",
                                 lambda a, e: self.assertContactTypeImport(a, contact_type))

    def assertAgencyImport(self, actual: Mappable, expected: Mappable):
        self.assertPropertyNotNone(actual, "id")
        self.assertPropertyEqual(actual, expected, "title")
        self.assertPropertyEqual(actual, expected, "short_name")
        self.assertHasImportMetadata(actual, expected["id"])

        icon = expect.prop_of(actual, "icon")
        self.assertHasImportMetadata(icon, expected["icon"])

    def assertCustomFieldTypeImport(self, actual: Mappable, expected: Mappable):
        self.assertPropertyNotNone(actual, "id")
        self.assertPropertyEqual(actual, expected, "name")
        self.assertPropertyEqual(actual, expected, "display_name")
        self.assertPropertyEqual(actual, expected, "media_type")
        self.assertHasImportMetadata(actual, expected["id"])

    def assertCustomFieldImport(self, actual: Mappable, expected: Mappable):
        self.assertPropertyNotNone(actual, "id")
        self.assertPropertyEqual(actual, expected, "section")
        self.assertPropertyEqual(actual, expected, "display_name")
        self.assertPropertyEqual(actual, expected, "label")
        self.assertPropertyEqual(actual, expected, "description")
        self.assertPropertyEqual(actual, expected, "tooltip")
        self.assertPropertyEqual(actual, expected, "is_required")
        self.assertPropertyEqual(actual, expected, "admin_only")
        self.assertPropertyEqual(actual, expected, "properties")
        self.assertPropertyEqual(actual, expected, "all_listing_types")
        self.assertHasImportMetadata(actual, expected["id"])

        field_type = expect.prop_of(actual, "type")
        self.assertHasImportMetadata(field_type, expected["type"])

    def assertCategoryImport(self, actual: Mappable, expected: Mappable):
        self.assertPropertyNotNone(actual, "id")
        self.assertPropertyEqual(actual, expected, "title")
        self.assertPropertyEqual(actual, expected, "description")
        self.assertHasImportMetadata(actual, expected["id"])

    def assertProfileImport(self, actual: Mappable, expected: Mappable):
        self.assertPropertyNotNone(actual, "id")
        self.assertPropertyEqual(actual, expected, "display_name")
        self.assertPropertyEqual(actual, expected, "bio")
        self.assertPropertyEqual(actual, expected, "dn")
        self.assertPropertyEqual(actual, expected, "issuer_dn")
        self.assertPropertyEqual(actual, expected, "auth_expires")
        self.assertPropertyEqual(actual, expected, "access_control")
        self.assertPropertyEqual(actual, expected, "center_tour_flag")
        self.assertPropertyEqual(actual, expected, "hud_tour_flag")
        self.assertPropertyEqual(actual, expected, "webtop_tour_flag")
        self.assertPropertyEqual(actual, expected, "email_notification_flag")
        self.assertPropertyEqual(actual, expected, "listing_notification_flag")
        self.assertPropertyEqual(actual, expected, "subscription_notification_flag")
        self.assertPropertyEqual(actual, expected, "leaving_ozp_warning_flag")
        self.assertHasImportMetadata(actual, expected["id"])

    def assertTagImport(self, actual: Mappable, expected: Mappable):
        self.assertPropertyNotNone(actual, "id")
        self.assertPropertyEqual(actual, expected, "name")
        self.assertHasImportMetadata(actual, expected["id"])

    def assertHasImportMetadata(self, actual: Mappable, external_id: int):
        metadata = expect.prop_of(actual, "import_metadata")

        self.assertPropertyEqualValue(metadata, "affiliated_store", self.affiliated_store)
        self.assertPropertyEqualValue(metadata, "external_id", external_id)
        self.assertPropertyNotNone(metadata, "last_updated")


def find_by_internal_id(iterable, internal_id):
    for item in iterable:
        if expect.prop_of(item, "id") == internal_id:
            return item
    return None


def find_by_external_id(iterable, external_id):
    for item in iterable:
        if item.import_metadata.external_id == external_id:
            return item
    return None


IMAGE_TYPE_1 = {
    "id": 1,
    "name": "agency_icon",
    "max_size_bytes": 2097152,
    "max_width": 2048,
    "max_height": 2048,
    "min_width": 16,
    "min_height": 16
}

IMAGE_TYPE_1_INVALID = {
    "name": "agency_icon",
    "max_size_bytes": 2097152,
    "max_width": 2048,
    "max_height": 2048,
    "min_width": 16,
    "min_height": 16
}

IMAGE_TYPE_1_UPDATE = {
    "id": 1,
    "name": "agency_icon2",
    "max_size_bytes": 2097152,
    "max_width": 2048,
    "max_height": 2048,
    "min_width": 16,
    "min_height": 16
}

IMAGE_1 = {
    "id": 3,
    "uuid": "fe006cd2-8d02-4f38-a3c2-336b807dd341",
    "security_marking": "UNCLASSIFIED",
    "file_extension": "png",
    "image_type": 1
}

CONTACT_TYPE_1 = {
    "id": 1,
    "name": "Civilian",
    "required": False
}

CONTACT_1 = {
    "id": 8,
    "secure_phone": "741-774-7414",
    "unsecure_phone": "321-123-7894",
    "email": "osha@stark.com",
    "name": "Osha",
    "organization": "House Stark",
    "contact_type": 1
}

CATEGORY_1 = {
    "id": 10,
    "title": "Music and Audio",
    "description": "Using your ears"
}

TAG_1 = {
    "id": 3,
    "name": "acoustic"
}

AGENCY_1 = {
    "id": 2,
    "title": "Ministry of Peace",
    "short_name": "Minipax",
    "icon": 3
}

LISTING_TYPE_1 = {
    "id": 3,
    "title": "Web Application",
    "description": "web applications"
    # "custom_fields": []
}

CUSTOM_FIELD_TYPE_1 = {
    "id": 1,
    "name": "CustomFieldType 1",
    "display_name": "CustomFieldType 1",
    "media_type": "text/plain",
    "options": "{}"
}

CUSTOM_FIELD_1 = {
    "id": 1,
    "type": 1,
    "section": "overview",
    "display_name": "CustomField 1",
    "label": "CustomField 1",
    "description": "Description 1",
    "tooltip": "Tooltip 1",
    "is_required": True,
    "admin_only": False,
    "properties": "{\"max_size\": 10}",
    "all_listing_types": True
}
