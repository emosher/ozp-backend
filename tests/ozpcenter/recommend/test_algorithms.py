from django.test import TestCase
from django.test import override_settings

from ozpcenter.recommend.graph_factory import GraphFactory
from ozpcenter.scripts import sample_data_generator as data_gen


@override_settings(ES_ENABLED=False)
class GraphTest(TestCase):

    @classmethod
    def setUpTestData(cls):
        data_gen.run()

    def setUp(self):
        pass

    def test_graph_recommendation(self):
        graph = GraphFactory.load_sample_profile_listing_graph()
        results = graph.algo().recommend_listings_for_profile('p-1')

        expected_results = [('l-5', 2), ('l-8', 1), ('l-7', 1), ('l-6', 1), ('l-4', 1)]

        self.assertEqual(results, expected_results)

    def test_graph_recommendation_db(self):
        graph = GraphFactory.load_db_into_graph()
        results = graph.algo().recommend_listings_for_profile('p-1')  # bigbrother

        expected_results = [('l-2', 2), ('l-96', 1), ('l-90', 1), ('l-9', 1),
                            ('l-82', 1), ('l-81', 1), ('l-77', 1), ('l-70', 1),
                            ('l-69', 1), ('l-68', 1), ('l-63', 1),
                            ('l-47', 1), ('l-44', 1), ('l-147', 1), ('l-14', 1),
                            ('l-101', 1), ('l-10', 1)]

        self.assertEqual(results, expected_results)
