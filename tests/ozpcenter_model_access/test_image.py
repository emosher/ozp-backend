import pytest
from django.test import TestCase
from django.test import override_settings

import ozpcenter.api.image.model_access as model_access
from tests.cases.factories import ImageFactory


@pytest.mark.model_access
@override_settings(ES_ENABLED=False)
class ImageTest(TestCase):

    @classmethod
    def setUpTestData(cls):
        cls.images = ImageFactory.create_batch(5)

    def setUp(self):
        pass

    def test__get_all_images(self):
        results = list(model_access.get_all_images().order_by("id"))

        self.assertListEqual(results, self.images)

    def test__get_image_by_id__not_found(self):
        result = model_access.get_image_by_id(0)

        self.assertIsNone(result)
