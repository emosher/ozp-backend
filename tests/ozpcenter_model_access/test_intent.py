"""
Intent tests
"""
from django.test import override_settings
from django.test import TestCase

from ozpcenter import models
from ozpcenter.scripts import sample_data_generator as data_gen
import ozpcenter.api.intent.model_access as model_access


@override_settings(ES_ENABLED=False)
class IntentTest(TestCase):

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

    def test_get_intent_by_non_existent_action(self):
        intent = model_access.get_intent_by_action('Does not exist')
        self.assertIsNone(intent)

    def test_get_intent_by_non_existent_id(self):
        intent = model_access.get_intent_by_id(0)
        self.assertIsNone(intent)

    def test_get_intent_by_non_existent_action_err(self):
        self.assertRaises(models.Intent.DoesNotExist, model_access.get_intent_by_action, 'Does not exist', True)

    def test_get_intent_by_non_existent_id_err(self):
        self.assertRaises(models.Intent.DoesNotExist, model_access.get_intent_by_id, 0, True)
