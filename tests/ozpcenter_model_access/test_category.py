import pytest
from django.test import TestCase
from django.test import override_settings

import ozpcenter.api.category.model_access as model_access
from ozpcenter.models import Category
from tests.cases.factories import CategoryFactory


@pytest.mark.model_access
@override_settings(ES_ENABLED=False)
class CategoryTest(TestCase):

    @classmethod
    def setUpTestData(cls):
        cls.categories = CategoryFactory.create_batch(5)

    def setUp(self):
        pass

    def test__get_all_categories(self):
        results = list(model_access.get_all_categories().order_by("id"))

        self.assertListEqual(results, self.categories)

    def test__get_category_by_id__not_found(self):
        category = model_access.get_category_by_id(0)

        self.assertIsNone(category)

    def test__get_category_by_id__not_found_raises_error(self):
        with self.assertRaises(Category.DoesNotExist):
            model_access.get_category_by_id(0, True)

    def test__get_category_by_title__not_found(self):
        category = model_access.get_category_by_title('Non Existent')

        self.assertIsNone(category)

    def test__get_category_by_title__not_found_raises_error(self):
        with self.assertRaises(Category.DoesNotExist):
            model_access.get_category_by_title('Non Existent', True)
