import json

import requests
from django.test import TestCase

from ozpcenter.api.imports.service import ImportTask
from tests.cases.factories import AffiliatedStoreFactory


class ImportFromRemoteTest(TestCase):

    @classmethod
    def setUpTestData(cls):
        cls.affiliated_store = AffiliatedStoreFactory()

    def setUp(self):
        pass

    def test__get_export(self):
        url = "http://remote:8001/api/export/"
        result = requests.get(url, auth=('export', 'password'))

        self.assertEqual(result.status_code, 200)

        import_data = result.json()

        import_task = ImportTask(import_data, self.affiliated_store)

        result = import_task.run()

        self.assertResultsCount(result, "errors", 0)

        self.assertResultsCount(result, "agencies", 1)
        self.assertResultsCount(result, "categories", 1)
        self.assertResultsCount(result, "contact_types", 1)
        self.assertResultsCount(result, "contacts", 1)
        self.assertResultsCount(result, "custom_field_types", 1)
        self.assertResultsCount(result, "custom_fields", 1)
        self.assertResultsCount(result, "image_types", 8)
        self.assertResultsCount(result, "images", 9)
        self.assertResultsCount(result, "intents", 2)
        self.assertResultsCount(result, "listing_types", 1)
        self.assertResultsCount(result, "profiles", 1)
        self.assertResultsCount(result, "tags", 2)

        self.assertResultsCount(result, "listings", 1)

    def assertResultsCount(self, result, key, expected_count):
        self.assertTrue(key in result, "has %s key" % key)
        self.assertEqual(len(result[key]), expected_count, "expected key %s has count %d" % (key, expected_count))
