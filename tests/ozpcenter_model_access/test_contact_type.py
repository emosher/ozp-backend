import pytest
from django.test import TestCase
from django.test import override_settings

import ozpcenter.api.contact_type.model_access as model_access
from ozpcenter.models import ContactType
from tests.cases.factories import ContactTypeFactory


@pytest.mark.model_access
@override_settings(ES_ENABLED=False)
class ContactTypeTest(TestCase):

    @classmethod
    def setUpTestData(cls):
        cls.contact_types = ContactTypeFactory.create_batch(5)

    def setUp(self):
        pass

    def test__get_all_contact_types(self):
        results = list(model_access.get_all_contact_types().order_by("id"))

        self.assertListEqual(results, self.contact_types)

    def test__get_contact_type_by_name(self):
        expected = self.contact_types[0]

        result = model_access.get_contact_type_by_name(expected.name)

        self.assertEqual(result, expected)

    def test__get_contact_type_by_name__not_found(self):
        contact_type = model_access.get_contact_type_by_name('Not Existent', False)

        self.assertIsNone(contact_type)

    def test__get_contact_type_by_name__not_found_raises_error(self):
        with self.assertRaises(ContactType.DoesNotExist):
            model_access.get_contact_type_by_name('Not Existent')
