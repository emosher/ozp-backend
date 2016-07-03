"""
Tests for access control utility functions
"""
import json

from django.test import TestCase

from plugins.default_access_control.main import PluginMain


class AccessControlTest(TestCase):

    def setUp(self):
        """
        setUp is invoked before each test method
        """
        self.access_control_instance = PluginMain()
        # TODO: Import

    @classmethod
    def setUpTestData(cls):
        """
        Set up test data for the whole TestCase (only run once for the TestCase)
        """
        pass

    def test_split_tokens(self):
        marking = 'UNCLASSIFIED//FOUO//ABC'
        tokens = self.access_control_instance._split_tokens(marking)

        actual_value = str(tokens)
        expected_value = '[ClassificationToken(Unclassified), DisseminationControlToken(FOR OFFICIAL USE ONLY), UnknownToken(ABC)]'

        self.assertEquals(actual_value, expected_value)

        marking = 'UNCLASSIFIED'
        tokens = self.access_control_instance._split_tokens(marking)

        actual_value = str(tokens)
        expected_value = '[ClassificationToken(Unclassified)]'

        self.assertEquals(actual_value, expected_value)

        marking = 'UNcLaSsIfied'
        tokens = self.access_control_instance._split_tokens(marking)

        actual_value = str(tokens)
        expected_value = '[ClassificationToken(Unclassified)]'

        self.assertEquals(actual_value, expected_value)

    def test_validate_marking(self):
        marking = 'UNCLASSIFIED'
        validated = self.access_control_instance.validate_marking(marking)
        self.assertTrue(validated)

        marking = 'UNCLASSIFIED//FOUO//ABC'
        validated = self.access_control_instance.validate_marking(marking)
        self.assertTrue(validated)

        marking = 'Invalid//FOUO//ABC'
        validated = self.access_control_instance.validate_marking(marking)
        self.assertFalse(validated)

        marking = ''
        validated = self.access_control_instance.validate_marking(marking)
        self.assertFalse(validated)

        marking = None
        validated = self.access_control_instance.validate_marking(marking)
        self.assertFalse(validated)
