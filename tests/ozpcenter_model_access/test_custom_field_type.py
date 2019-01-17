import pytest
from django.test import TestCase
from django.test import override_settings

import ozpcenter.api.custom_field_type.model_access as model_access
from ozpcenter.models import CustomFieldType
from tests.ozpcenter_api import fixtures


@pytest.mark.integration
@pytest.mark.fast
@override_settings(ES_ENABLED=False)
class CustomFieldTypeTest(TestCase):

    @classmethod
    def setUpTestData(cls):
        cls.type1 = fixtures.create_custom_field_type("Type 1", "Type 1", "text/html")
        cls.type2 = fixtures.create_custom_field_type("JSON Type", "JSON", "application/json")
        cls.type3 = fixtures.create_custom_field_type("Type 3", "Type 3", "text/html")

        cls.types_ordered = [cls.type2, cls.type1, cls.type3]

    def setUp(self):
        pass

    def test_find_by_import_task_id(self):
        result = model_access.get_custom_field_type_by_id(self.type1.id)

        self.assertIsNotNone(result)
        self.assertEqual(result.id, self.type1.id)
        self.assertEqual(result.name, self.type1.name)
        self.assertEqual(result.display_name, self.type1.display_name)
        self.assertEqual(result.options, self.type1.options)
        self.assertEqual(result.media_type, self.type1.media_type)

    def test_get_non_existent_category_by_id_err(self):
        with self.assertRaises(CustomFieldType.DoesNotExist):
            model_access.get_custom_field_type_by_id(0, True)
