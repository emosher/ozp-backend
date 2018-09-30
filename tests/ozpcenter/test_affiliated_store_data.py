from django.test import TestCase
from django.test import override_settings

from ozpcenter import models
from ozpcenter.scripts import affiliated_store_data as generator
from ozpcenter.scripts.model_schema import AGENCY_ICON


@override_settings(ES_ENABLED=False)
class AffiliatedStoreDataTest(TestCase):

    @classmethod
    def setUpTestData(cls):
        generator.run()

    def setUp(self):
        pass

    def test__agencies(self):
        agencies = list(models.Agency.objects.all())
        self.assertEqual(len(agencies), 1)

    def test__agency(self):
        agency: models.Agency = models.Agency.objects.filter(title="Starfleet Command").first()
        self.assertEqual(agency.title, "Starfleet Command")
        self.assertEqual(agency.short_name, "Starfleet")
        self.assertEqual(agency.icon.image_type.name, AGENCY_ICON)

    def test__categories(self):
        categories = list(models.Category.objects.all())
        self.assertEqual(len(categories), 1)

    def test__contacts(self):
        contacts = list(models.Contact.objects.all())
        self.assertEqual(len(contacts), 1)

    def test__image_types(self):
        image_types = list(models.ImageType.objects.all())
        self.assertEqual(len(image_types), 8)

    def test__intents(self):
        intents = list(models.Intent.objects.all())
        self.assertEqual(len(intents), 2)

    def test__listing_types(self):
        listing_types = list(models.ListingType.objects.all())
        self.assertEqual(len(listing_types), 1)

    def test__tags(self):
        tags = list(models.Tag.objects.all())
        self.assertEqual(len(tags), 2)

    def test__profiles(self):
        profiles = list(models.Profile.objects.all())
        self.assertEqual(len(profiles), 1)

    def test__profile(self):
        profile = models.Profile.objects.filter(display_name="Jean-Luc Picard").first()

        self.assertEqual(profile.username, "jpicard")
        self.assertEqual(profile.display_name, "Jean-Luc Picard")

        agencies = [org.title for org in profile.organizations.all()]
        self.assertListEqual(agencies, ["Starfleet Command"])
