import pytest
from django.db import connection
from django.test import override_settings
from django.test.utils import CaptureQueriesContext
from rest_framework import status

from ozpcenter.models import ListingActivity
from tests.cases import APITestCase, ModelAssertionsMixin
from tests.cases.factories import CategoryFactory
from tests.cases.factories import ContactFactory
from tests.cases.factories import DocUrlFactory
from tests.cases.factories import IntentFactory
from tests.cases.factories import ListingActivityFactory
from tests.cases.factories import ListingFactory
from tests.cases.factories import ScreenshotFactory
from tests.cases.factories import TagFactory
from tests.ozpcenter_api import fixtures


@pytest.mark.integration
@pytest.mark.fast
@override_settings(ES_ENABLED=False)
class ExportApiTest(ModelAssertionsMixin,
                    APITestCase):

    @classmethod
    def setUpTestData(cls):
        cls.aml_steward_profile = fixtures.create_steward()
        cls.org_steward_profile = fixtures.create_org_steward()
        cls.user_profile = fixtures.create_user_profile()
        cls.export_profile = fixtures.create_export_profile()

        cls.listing1 = ListingFactory(is_exportable=True, reviews=3)
        cls.listing2 = ListingFactory(is_exportable=True, reviews=2)
        cls.listing3 = ListingFactory(is_exportable=True, reviews=1)
        cls.listing4 = ListingFactory(is_exportable=True, reviews=2)
        cls.listing5 = ListingFactory(is_exportable=False, reviews=1)
        cls.listing6 = ListingFactory(is_exportable=True, is_private=True)
        cls.listings = [cls.listing1, cls.listing2, cls.listing3, cls.listing4, cls.listing5, cls.listing6]

        cls.contacts = ContactFactory.create_batch(3)
        cls.categories = CategoryFactory.create_batch(3)
        cls.intents = IntentFactory.create_batch(2)
        cls.tags = TagFactory.create_batch(3)

        for listing in cls.listings[0:2]:
            listing.owners.add(cls.org_steward_profile)
            listing.contacts.add(*cls.contacts[0:1])
            listing.categories.add(*cls.categories[0:2])
            listing.tags.add(cls.tags[0])

        for listing in cls.listings[1:3]:
            listing.tags.add(cls.tags[1])

        for listing in cls.listings[2:5]:
            listing.owners.add(cls.user_profile)
            listing.contacts.add(cls.contacts[2])
            listing.categories.add(*cls.categories[1:3])
            listing.tags.add(cls.tags[2])

        for listing in cls.listings:
            listing.intents.add(*cls.intents)

        cls.activities = ListingActivityFactory.create_batch(3, listing=cls.listing1, author=cls.org_steward_profile,
                                                             change_details=3)
        cls.rejection = ListingActivityFactory(listing=cls.listing1, author=cls.org_steward_profile,
                                               action=ListingActivity.REJECTED, change_details=1)

        cls.listing1.last_activity = cls.activities[2]
        cls.listing1.current_rejection = cls.rejection
        cls.listing1.save()

        DocUrlFactory.create_batch(3, listing=cls.listing2)

        ScreenshotFactory.create_batch(3, listing=cls.listing4)

        cls.listing3.required_listings = cls.listing1
        cls.listing3.save()

    def setUp(self):
        pass

    def test__export(self):
        self.authenticate_as(self.export_profile)

        with CaptureQueriesContext(connection) as context:
            response = self.client.get('/api/export/', format='json')

        # print(json.dumps(response.data))
        # print(context.captured_queries)

        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(len(response.data["listings"]), 4)

    def test__export__contains_screenshots(self):
        self.authenticate_as(self.export_profile)

        response = self.client.get('/api/export/', format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)

        screenshots = response.data["listings"][3]["screenshots"]
        self.assertTrue(len(screenshots), 3)

    def test__export__contains_screenshot_images(self):
        self.authenticate_as(self.export_profile)

        response = self.client.get('/api/export/', format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)

        screenshots = response.data["listings"][3]["screenshots"]
        small_image_ids = [ss["small_image"] for ss in screenshots]
        large_image_ids = [ss["large_image"] for ss in screenshots]
        screenshot_image_ids = sorted(small_image_ids + large_image_ids)

        exported_image_ids = sorted([image["id"] for image in response.data["images"]])

        for screenshot_image_id in screenshot_image_ids:
            self.assertIn(screenshot_image_id, exported_image_ids)

    def test__export__as_aml_steward__is_allowed(self):
        self.authenticate_as(self.aml_steward_profile)

        response = self.client.get('/api/export/', format='json')

        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test__export__org_steward__is_forbidden(self):
        self.authenticate_as(self.org_steward_profile)

        response = self.client.get('/api/export/', format='json')

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)

    def test__export__as_user__is_forbidden(self):
        self.authenticate_as(self.user_profile)

        response = self.client.get('/api/export/', format='json')

        self.assertEqual(response.status_code, status.HTTP_403_FORBIDDEN)
