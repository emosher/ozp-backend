from django.test import override_settings
from django.test import TestCase

from tests.ozpcenter import data_util


@override_settings(ES_ENABLED=False)
class DataUtilTest(TestCase):

    def setUp(self):
        """
        setUp is invoked before each test method
        """
        pass

    def test_file_query_load_yaml_profile(self):
        query = data_util.FileQuery()
        query = query.load_yaml_file('profile.yaml').key('display_name')
        query_to_list = query.to_list()

        self.assertEqual(22, len(query_to_list))

    def test_file_query_load_yaml(self):
        query = data_util.FileQuery()
        query = query.load_yaml_file()

        self.assertEqual(188, query.count())

    def test_file_query_load_yaml_key(self):
        query = data_util.FileQuery().load_yaml_file().key('listing').key('title')

        listing_title = query.to_list()

        self.assertEqual(188, len(listing_title))
