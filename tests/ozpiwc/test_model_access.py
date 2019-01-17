from django.test import TestCase
from django.test import override_settings


@override_settings(ES_ENABLED=False)
class DataTest(TestCase):

    @classmethod
    def setUpTestData(cls):
        pass

    def setUp(self):
        pass

    def test_get_all_keys(self):
        # model_access.get_all_keys('wsmith')  # flake8: noqa
        pass
