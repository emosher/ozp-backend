from django.test import override_settings

from tests.ozp.cases import APITestCase


@override_settings(ES_ENABLED=False)
class ListingUserActivitiesApiTest(APITestCase):

    @classmethod
    def setUpTestData(cls):
        pass

    def setUp(self):
        pass
