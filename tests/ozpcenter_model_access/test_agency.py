"""
Agency tests
"""
from django.test import override_settings
from django.test import TestCase

from ozpcenter.scripts import sample_data_generator as data_gen
import ozpcenter.api.agency.model_access as model_access
from ozpcenter import errors
import ozpcenter.model_access as generic_model_access
from ozpcenter import models


@override_settings(ES_ENABLED=False)
class AgencyTest(TestCase):

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

    def test_get_non_existent_agency_by_title(self):
        agency = model_access.get_agency_by_title('Non Existent')
        self.assertIsNone(agency)

    def test_get_non_existent_agency_by_title_err(self):
        self.assertRaises(models.Agency.DoesNotExist, model_access.get_agency_by_title, 'Not Existent', True)

    def test_get_non_existent_agency_by_id(self):
        agency = model_access.get_agency_by_id(0)
        self.assertIsNone(agency)

    def test_get_non_existent_agency_by_id_err(self):
        self.assertRaises(models.Agency.DoesNotExist, model_access.get_agency_by_id, 0, True)
