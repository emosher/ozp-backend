import pytest
from django.test import TestCase
from django.test import override_settings

import ozpcenter.api.agency.model_access as model_access
from ozpcenter.models import Agency
from tests.cases.factories import AgencyFactory


@pytest.mark.model_access
@override_settings(ES_ENABLED=False)
class AgencyTest(TestCase):

    @classmethod
    def setUpTestData(cls):
        cls.agencies = AgencyFactory.create_default_agencies()

    def setUp(self):
        pass

    def test__get_all_agencies(self):
        results = list(model_access.get_all_agencies().order_by("id"))

        self.assertListEqual(results, self.agencies)

    def test__get_agency_by_id__not_found(self):
        result = model_access.get_agency_by_id(0)

        self.assertIsNone(result)

    def test__get_agency_by_id__not_found_raises_error(self):
        with self.assertRaises(Agency.DoesNotExist):
            model_access.get_agency_by_id(0, True)

    def test__get_agency_by_title__not_found(self):
        result = model_access.get_agency_by_title("Non Existent")

        self.assertIsNone(result)

    def test__get_agency_by_title__not_found_raises_error(self):
        with self.assertRaises(Agency.DoesNotExist):
            model_access.get_agency_by_title("Not Existent", True)
