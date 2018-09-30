import pytest
from django.test import TestCase
from django.test import override_settings

from ozpcenter.models import ImportTaskResult
from tests.ozpcenter_api import fixtures


@pytest.mark.model_access
@override_settings(ES_ENABLED=False)
class ImportTaskResultTest(TestCase):

    @classmethod
    def setUpTestData(cls):
        cls.image_type = fixtures.create_image_type('large_icon')
        cls.image = fixtures.create_image(cls.image_type)

        cls.store1 = fixtures.create_affiliated_store("Store 1", "http://www.store1a.test", cls.image, True)
        cls.store2 = fixtures.create_affiliated_store("Store 2", "http://www.store2.test", cls.image, True)

        cls.task1 = fixtures.create_import_task("Task 1", "Entire", cls.store1)
        cls.task2 = fixtures.create_import_task("Task 2", "Entire", cls.store2)

        cls.task1_result1 = fixtures.create_import_task_result(cls.task1, "Result 1-1", "Pass")
        cls.task1_result2 = fixtures.create_import_task_result(cls.task1, "Result 1-2", "Fail")
        cls.task2_result1 = fixtures.create_import_task_result(cls.task2, "Result 2-1", "Pass")

    def setUp(self):
        pass

    def test__find_by_import_task_id(self):
        results = list(ImportTaskResult.objects.find_all_by_import_task(self.task1.id).order_by("id"))

        self.assertEqual(results, [self.task1_result1, self.task1_result2])
