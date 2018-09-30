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

    def test_load_db_into_graph(self):
        graph = GraphFactory.load_db_into_graph()
        self.assertEqual(str(graph), 'Graph(vertices: 222, edges: 529)')

        bigbrother_dict = graph.query().v('p-1').to_dict().next()
        expected_dict = {'highest_role': 'APPS_MALL_STEWARD', 'username': 'bigbrother'}
        self.assertEqual(bigbrother_dict, expected_dict)

        bigbrother_bookmarks = graph.query().v('p-1').out('bookmarked').id().to_list()
        expected_bookmarks = ['l-108', 'l-122', 'l-127',
                              'l-154', 'l-156', 'l-158',
                              'l-169', 'l-175', 'l-180',
                              'l-186', 'l-1', 'l-23', 'l-29',
                              'l-30', 'l-49', 'l-50', 'l-59',
                              'l-73', 'l-87', 'l-93', 'l-94']
        self.assertEqual(sorted(bigbrother_bookmarks), sorted(expected_bookmarks))
