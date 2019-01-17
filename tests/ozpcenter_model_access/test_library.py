from django.test import TestCase
from django.test import override_settings

import ozpcenter.api.library.model_access as model_access
from ozpcenter.scripts import sample_data_generator as data_gen


@override_settings(ES_ENABLED=False)
class LibraryTest(TestCase):

    @classmethod
    def setUpTestData(cls):
        data_gen.run()

    def setUp(self):
        pass

    def test_get_all_library_entries(self):
        results = model_access.get_all_library_entries()
        self.assertEquals(len(results), 54)

    def test_get_library_entry_by_id(self):
        results = model_access.get_library_entry_by_id(1)
        self.assertIsNotNone(results)

    def test_get_library_entry_by_id_object_does_not_exist(self):
        results = model_access.get_library_entry_by_id(100)
        self.assertIsNone(results)

    def test_get_self_application_library(self):
        results = model_access.get_self_application_library('bigbrother')
        self.assertEquals(len(results), 21)

        folder_names = []
        for application_library_entry in results:
            if application_library_entry.folder:
                folder_names.append(application_library_entry.folder)
        self.assertEquals(len(folder_names), 15)

        results = model_access.get_self_application_library('bigbrother', folder_name=folder_names[0])
        self.assertEquals(len(results), 3)

        results = model_access.get_self_application_library('DoesNotExistUser')
        self.assertIsNone(results)

        results = model_access.get_self_application_library('bigbrother', listing_type='Web Application')
        self.assertEquals(len(results), 18)

    def test_create_self_user_library_entry_exception(self):
        with self.assertRaisesRegex(Exception, 'Listing or user not found') as err:
            results = model_access.create_self_user_library_entry('not_exist_user', 3)

    def test_create_self_user_library_entry(self):
        results = model_access.create_self_user_library_entry('bigbrother', 1)
        self.assertIsNotNone(results)

        results = model_access.create_self_user_library_entry('bigbrother', 1, position=3)
        self.assertIsNotNone(results)

        model_access.create_self_user_library_entry('bigbrother', 33)
        results = model_access.get_self_application_library('bigbrother')
        self.assertEquals(results.reverse()[0].listing.id, 33)

    def test_create_batch_library_entries(self):
        data = [
            {
                "listing": {
                    "id": 1
                },
                "folder": "newFolderTest",
                "position": 2
            },
            {
                "listing": {
                    "id": 3
                },
                "folder": "newFolderTest",
                "position": 1
            },
            {
                "listing": {
                    "id": 4
                },
                "folder": "newFolderTest"
            },
            {
                "listing": {
                    "id": 5
                }
            },
            {
                "listing": {
                    "id": 2
                },
                "position": 'wrong'
            },
            {
                "position": 5
            },
            {
                "listing": {
                    "id": 52001
                }
            },
        ]

        results = model_access.create_batch_library_entries('bigbrother', data)
        self.assertEquals(len(results), 5)

        results = model_access.create_batch_library_entries('not_exist_user', data)
        self.assertEquals(len(results), 0)

    def test_batch_update_user_library_entry(self):
        self.skipTest('TODO: test_batch_update_user_library_entry')
