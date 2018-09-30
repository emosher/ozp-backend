from unittest.mock import MagicMock

from django.test import TestCase
from django.test import override_settings

import ozpcenter.api.storefront.model_access as model_access
from ozpcenter import models
from ozpcenter.scripts import sample_data_generator as data_gen


@override_settings(ES_ENABLED=False)
class StorefrontTest(TestCase):

    @classmethod
    def setUpTestData(cls):
        data_gen.run()

    def setUp(self):
        pass

    def test_get_storefront(self):
        """
        test for model_access.get_storefront()

        TODO: test for correct fields returned, number of entries returned,
            and ordering. Might want to use factories here (instead of the
            sample data generator)

        """
        request = MagicMock()
        request.user = 'wsmith'
        request.query_params.get.side_effect = lambda *arg: True

        data, extra_data = model_access.get_storefront(request)

        # test that only APPROVED listings are returned
        for i in data['recommended']:
            self.assertEqual(i.approval_status, models.Listing.APPROVED)

        for i in data['featured']:
            self.assertEqual(i.approval_status, models.Listing.APPROVED)

        for i in data['recent']:
            self.assertEqual(i.approval_status, models.Listing.APPROVED)

        for i in data['most_popular']:
            self.assertEqual(i.approval_status, models.Listing.APPROVED)

    def test_get_metadata(self):
        """
        test for model_access.get_metadata()
        """
        metadata = model_access.get_metadata('wsmith')
        categories = metadata['categories']
        keys = list(categories[0].keys()).sort()
        expected_keys = ['description', 'id', 'title'].sort()
        self.assertEqual(keys, expected_keys)

        agencies = metadata['agencies']
        keys = list(agencies[0].keys()).sort()
        expected_keys = ['short_name', 'title', 'icon', 'listing_count'].sort()
        self.assertEqual(keys, expected_keys)

        contact_types = metadata['contact_types']
        keys = list(contact_types[0].keys()).sort()
        expected_keys = ['required', 'name'].sort()
        self.assertEqual(keys, expected_keys)

        intents = metadata['intents']
        keys = list(intents[0].keys()).sort()
        expected_keys = ['label', 'action', 'media_type', 'icon'].sort()
        self.assertEqual(keys, expected_keys)

        listing_types = metadata['listing_types']
        keys = list(listing_types[0].keys()).sort()
        expected_keys = ['title', 'description'].sort()
        self.assertEqual(keys, expected_keys)

    # TODO: Fails on postgres
    # def test_get_sql_statement(self):
    #     sql = model_access.get_sql_statement()

    # def test_get_user_listings(self):
    #     request = MagicMock()
    #     request.user = 'wsmith'
    #     request.query_params.get.side_effect = lambda *arg: True

    #     data = model_access.get_user_listings(request.user, request)
    # TODO: Finish test
