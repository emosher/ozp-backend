"""
Contact Type tests
"""
from django.test import override_settings
from django.test import TestCase

from ozpcenter.scripts import sample_data_generator as data_gen
import ozpcenter.api.contact_type.model_access as model_access
from ozpcenter import errors
import ozpcenter.model_access as generic_model_access
from ozpcenter import models


@override_settings(ES_ENABLED=False)
class ContactTypeTest(TestCase):

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

    def test_get_non_existent_contact_type_by_name(self):
        contact_type = model_access.get_contact_type_by_name('Not Existent', False)
        self.assertIsNone(contact_type)

    def test_get_non_existent_contact_type_by_name_err(self):
        self.assertRaises(models.ContactType.DoesNotExist, model_access.get_contact_type_by_name, 'Not Existent')
