"""
Tests for Recommendations ES
"""
import logging

from django.test import override_settings

from rest_framework import status
from tests.ozp.cases import APITestCase

from ozpcenter import model_access as generic_model_access
from ozpcenter.scripts import sample_data_generator as data_gen
from tests.ozpcenter.helper import APITestHelper
from ozpcenter.utils import shorthand_dict
from ozpcenter.api.listing import model_access_es
from ozpcenter.api.listing.elasticsearch_util import elasticsearch_factory
from ozpcenter.recommend.recommend import RecommenderDirectory


@override_settings(ES_ENABLED=False)
class ElasticsearchBaseRecommenderTest(APITestCase):

    @override_settings(ES_ENABLED=True)
    def setUp(self):
        """
        setUp is invoked before each test method
        """
        self.error_string = None
        self.es_failed = False
        try:
            elasticsearch_factory.check_elasticsearch()
        except Exception as err:
            self.error_string = str(err)
            self.es_failed = True

        if not self.es_failed:
            logging.getLogger('elasticsearch').setLevel(logging.CRITICAL)
            model_access_es.bulk_reindex()

    @classmethod
    def setUpTestData(cls):
        """
        Set up test data for the whole TestCase (only run once for the TestCase)
        """
        data_gen.run()

    @override_settings(ES_ENABLED=True)
    def test_recommendation_content_base(self):
        if self.es_failed:
            self.skipTest('Elasticsearch is not currently up: {}'.format(self.error_string))
        recommender_wrapper_obj = RecommenderDirectory()
        actual_result = recommender_wrapper_obj.recommend('elasticsearch_content_base')
        expected_result = {'Elasticsearch Content Filtering': {}}
        self.assertEquals(actual_result, expected_result)

        url = '/api/storefront/recommended/?randomize=False'
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200)

        title_scores = [{'title': listing['title'], '_score': listing['_score']} for listing in response.data['recommended']]
        # title_scores = sorted(title_scores, key=lambda k: (k['_score']['_sort_score'], k['title']))
        title_scores = shorthand_dict(title_scores)

        expected_result = [
            '(_score:(Elasticsearch Content Filtering:(raw_score:8.762,weight:0.9),_sort_score:7.886),title:Wolverine)',
            '(_score:(Elasticsearch Content Filtering:(raw_score:8.315,weight:0.9),_sort_score:7.483),title:Beast)',
            '(_score:(Elasticsearch Content Filtering:(raw_score:8.268,weight:0.9),_sort_score:7.441),title:Magneto)',
            '(_score:(Elasticsearch Content Filtering:(raw_score:8.213,weight:0.9),_sort_score:7.392),title:Jupiter)',
            '(_score:(Elasticsearch Content Filtering:(raw_score:8.112,weight:0.9),_sort_score:7.301),title:Pokemon Ruby and Sapphire)',
            '(_score:(Elasticsearch Content Filtering:(raw_score:8.096,weight:0.9),_sort_score:7.286),title:Cyclops)',
            '(_score:(Elasticsearch Content Filtering:(raw_score:8.094,weight:0.9),_sort_score:7.285),title:Barsoom)',
            '(_score:(Elasticsearch Content Filtering:(raw_score:8.088,weight:0.9),_sort_score:7.279),title:Blink)',
            '(_score:(Elasticsearch Content Filtering:(raw_score:8.08,weight:0.9),_sort_score:7.272),title:Clerks)',
            '(_score:(Elasticsearch Content Filtering:(raw_score:7.999,weight:0.9),_sort_score:7.199),title:Rogue)'
        ]

        # import json; print(json.dumps(title_scores, indent=4))
        self.assertEquals(expected_result, title_scores)

    @override_settings(ES_ENABLED=True)
    def test_recommendation_user_base(self):
        if self.es_failed:
            self.skipTest('Elasticsearch is not currently up: {}'.format(self.error_string))
        recommender_wrapper_obj = RecommenderDirectory()
        actual_result = recommender_wrapper_obj.recommend('elasticsearch_user_base')
        expected_result = {'Elasticsearch User Based Filtering': {}}

        self.assertEquals(actual_result, expected_result)

        url = '/api/storefront/recommended/?randomize=False'
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200)

        title_scores = [{'title': listing['title'], '_score': listing['_score']} for listing in response.data['recommended']]
        # title_scores = sorted(title_scores, key=lambda k: (k['_score']['_sort_score'], k['title']))
        title_scores = shorthand_dict(title_scores)

        expected_result = [
            '(_score:(Elasticsearch User Based Filtering:(raw_score:10.0,weight:1.0),_sort_score:10.0),title:Railroad)',
            '(_score:(Elasticsearch User Based Filtering:(raw_score:10.0,weight:1.0),_sort_score:10.0),title:Barsoom)',
            '(_score:(Elasticsearch User Based Filtering:(raw_score:10.0,weight:1.0),_sort_score:10.0),title:Snow)',
            '(_score:(Elasticsearch User Based Filtering:(raw_score:10.0,weight:1.0),_sort_score:10.0),title:Business Management System)',
            '(_score:(Elasticsearch User Based Filtering:(raw_score:10.0,weight:1.0),_sort_score:10.0),title:Tornado)',
            '(_score:(Elasticsearch User Based Filtering:(raw_score:8.333,weight:1.0),_sort_score:8.333),title:Pluto (Not a planet))',
            '(_score:(Elasticsearch User Based Filtering:(raw_score:8.333,weight:1.0),_sort_score:8.333),title:Project Management)',
            '(_score:(Elasticsearch User Based Filtering:(raw_score:8.333,weight:1.0),_sort_score:8.333),title:BeiDou Navigation Satellite System)',
            '(_score:(Elasticsearch User Based Filtering:(raw_score:8.333,weight:1.0),_sort_score:8.333),title:Satellite navigation)',
            '(_score:(Elasticsearch User Based Filtering:(raw_score:8.333,weight:1.0),_sort_score:8.333),title:Stop sign)'
        ]

        # import json; print(json.dumps(title_scores, indent=4))
        self.assertEquals(expected_result, title_scores)
