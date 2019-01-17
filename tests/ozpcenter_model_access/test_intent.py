import pytest
from django.test import TestCase
from django.test import override_settings

import ozpcenter.api.intent.model_access as model_access
from ozpcenter.models import Intent
from tests.cases.factories import IntentFactory


@pytest.mark.model_access
@override_settings(ES_ENABLED=False)
class IntentTest(TestCase):

    @classmethod
    def setUpTestData(cls):
        cls.intents = IntentFactory.create_batch(5)

    def setUp(self):
        pass

    def test__get_all_intents(self):
        results = list(model_access.get_all_intents().order_by("id"))

        self.assertListEqual(results, self.intents)

    def test__get_intent_by_id__not_found(self):
        result = model_access.get_intent_by_id(0)

        self.assertIsNone(result)

    def test__get_intent_by_id__not_found_raises_error(self):
        with self.assertRaises(Intent.DoesNotExist):
            model_access.get_intent_by_id(0, True)

    def test__get_intent_by_action__not_found(self):
        result = model_access.get_intent_by_action("Does not exist")

        self.assertIsNone(result)

    def test__get_intent_by_action__not_found_raises_error(self):
        with self.assertRaises(Intent.DoesNotExist):
            model_access.get_intent_by_action("Does not exist", True)
