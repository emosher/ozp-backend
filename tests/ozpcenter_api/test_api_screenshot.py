from django.test import override_settings

from tests.ozp.cases import APITestCase


@override_settings(ES_ENABLED=False)
class ListingScreenshotApiTest(APITestCase):

    def setUp(self):
        pass

    @classmethod
    def setUpTestData(cls):
        pass
