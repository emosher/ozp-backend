"""
Category tests
"""
from django.test import override_settings
from django.test import TestCase

from ozpcenter.scripts import sample_data_generator as data_gen
import ozpcenter.api.category.model_access as model_access
from ozpcenter import errors
import ozpcenter.model_access as generic_model_access
from ozpcenter import models


@override_settings(ES_ENABLED=False)
class CategoryTest(TestCase):

    def setUp(self):
        """
        setUp is invoked before each test method
        """
        pass

    @classmethod
    def setUpTestData(cls):
        """
        Set up test data for the whole TestCase (only run once for the TestCase)
        """
        data_gen.run()

    def test_get_non_existent_category_by_title(self):
        category = model_access.get_category_by_title('Non Existent Category')
        self.assertIsNone(category)

    def test_get_non_existent_category_by_title_err(self):
        self.assertRaises(models.Category.DoesNotExist, model_access.get_category_by_title, 'Not Existent', True)

    def test_get_non_existent_category_by_id(self):
        category = model_access.get_category_by_id(0)
        self.assertIsNone(category)

    def test_get_non_existent_category_by_id_err(self):
        self.assertRaises(models.Category.DoesNotExist, model_access.get_category_by_id, 0, True)
