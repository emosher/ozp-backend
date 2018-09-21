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
class RecommenderTest(APITestCase):

    def setUp(self):
        """
        setUp is invoked before each test method
        """
        self.maxDiff = None

    @classmethod
    def setUpTestData(cls):
        """
        Set up test data for the whole TestCase (only run once for the TestCase)
        """
        data_gen.run()

    def test_recommendation_baseline_graph(self):
        recommender_wrapper_obj = RecommenderDirectory()
        actual_result = recommender_wrapper_obj.recommend('baseline,graph_cf')
        expected_result = {'Baseline': {}, 'Bookmark Collaborative Filtering': {}}
        self.assertEquals(actual_result, expected_result)

        url = '/api/storefront/recommended/?randomize=False'
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200)

        title_scores = [{'title': listing['title'], '_score': listing['_score']} for listing in response.data['recommended']]
        title_scores = sorted(title_scores, key=lambda k: (k['_score']['_sort_score'], k['title']))  # Order can change between postgres and sqlite
        title_scores = shorthand_dict(title_scores)

        expected_result = [
            '(_score:(Baseline:(raw_score:8.0,weight:1.0),Bookmark Collaborative Filtering:(raw_score:1.0,weight:5.0),_sort_score:13.0),title:White Horse)',
            '(_score:(Baseline:(raw_score:8.2,weight:1.0),Bookmark Collaborative Filtering:(raw_score:1.0,weight:5.0),_sort_score:13.2),title:Navigation)',
            '(_score:(Baseline:(raw_score:8.5,weight:1.0),Bookmark Collaborative Filtering:(raw_score:1.0,weight:5.0),_sort_score:13.5),title:Bleach)',
            '(_score:(Baseline:(raw_score:9.0,weight:1.0),Bookmark Collaborative Filtering:(raw_score:1.0,weight:5.0),_sort_score:14.0),title:Informational Book)',
            '(_score:(Baseline:(raw_score:9.0,weight:1.0),Bookmark Collaborative Filtering:(raw_score:1.0,weight:5.0),_sort_score:14.0),title:JotSpot)',
            '(_score:(Baseline:(raw_score:9.0,weight:1.0),Bookmark Collaborative Filtering:(raw_score:1.0,weight:5.0),_sort_score:14.0),title:LocationLister)',
            '(_score:(Baseline:(raw_score:9.0,weight:1.0),Bookmark Collaborative Filtering:(raw_score:1.0,weight:5.0),_sort_score:14.0),title:Stop sign)',
            '(_score:(Baseline:(raw_score:10.5,weight:1.0),Bookmark Collaborative Filtering:(raw_score:1.0,weight:5.0),_sort_score:15.5),title:Killer Whale)',
            '(_score:(Baseline:(raw_score:11.5,weight:1.0),Bookmark Collaborative Filtering:(raw_score:1.0,weight:5.0),_sort_score:16.5),title:Wolf Finder)',
            '(_score:(Baseline:(raw_score:11.5,weight:1.0),Bookmark Collaborative Filtering:(raw_score:2.0,weight:5.0),_sort_score:21.5),title:Chart Course)'
        ]
        # import pprint
        # print(pprint.pprint(title_scores))
        self.assertEquals(expected_result, title_scores)

        sorted_scores = [listing['_score']['_sort_score'] for listing in response.data['recommended']]
        self.assertEquals(sorted(sorted_scores, reverse=True), sorted_scores)

    def test_recommendation_baseline(self):
        recommender_wrapper_obj = RecommenderDirectory()
        actual_result = recommender_wrapper_obj.recommend('baseline')
        expected_result = {'Baseline': {}}
        self.assertEquals(actual_result, expected_result)

        url = '/api/storefront/recommended/?randomize=False'
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200)

        title_scores = [{'title': listing['title'], '_score': listing['_score']} for listing in response.data['recommended']]
        title_scores = sorted(title_scores, key=lambda k: (k['_score']['_sort_score'], k['title']))  # Order can change between postgres and sqlite
        title_scores = shorthand_dict(title_scores)

        expected_result = [
            '(_score:(Baseline:(raw_score:9.0,weight:1.0),_sort_score:9.0),title:Bass Fishing)',
            '(_score:(Baseline:(raw_score:9.0,weight:1.0),_sort_score:9.0),title:Dragons)',
            '(_score:(Baseline:(raw_score:9.0,weight:1.0),_sort_score:9.0),title:House Targaryen)',
            '(_score:(Baseline:(raw_score:9.0,weight:1.0),_sort_score:9.0),title:Informational Book)',
            '(_score:(Baseline:(raw_score:9.0,weight:1.0),_sort_score:9.0),title:JotSpot)',
            '(_score:(Baseline:(raw_score:9.0,weight:1.0),_sort_score:9.0),title:LocationLister)',
            '(_score:(Baseline:(raw_score:9.0,weight:1.0),_sort_score:9.0),title:Stop sign)',
            '(_score:(Baseline:(raw_score:10.5,weight:1.0),_sort_score:10.5),title:Killer Whale)',
            '(_score:(Baseline:(raw_score:11.5,weight:1.0),_sort_score:11.5),title:Chart Course)',
            '(_score:(Baseline:(raw_score:11.5,weight:1.0),_sort_score:11.5),title:Wolf Finder)'
        ]
        # import pprint
        # print(pprint.pprint(title_scores))
        self.assertEquals(expected_result, title_scores)

        sorted_scores = [listing['_score']['_sort_score'] for listing in response.data['recommended']]
        self.assertEquals(sorted(sorted_scores, reverse=True), sorted_scores)

    def test_recommendation_graph(self):
        recommender_wrapper_obj = RecommenderDirectory()
        actual_result = recommender_wrapper_obj.recommend('graph_cf')
        expected_result = {'Bookmark Collaborative Filtering': {}}
        self.assertEquals(actual_result, expected_result)

        url = '/api/storefront/recommended/?randomize=False'
        response = APITestHelper.request(self, url, 'GET', username='wsmith', status_code=200)

        title_scores = [{'title': listing['title'], '_score': listing['_score']} for listing in response.data['recommended']]
        title_scores = sorted(title_scores, key=lambda k: (k['_score']['_sort_score'], k['title']))  # Order can change between postgres and sqlite
        title_scores = shorthand_dict(title_scores)

        expected_result = [
            '(_score:(Bookmark Collaborative Filtering:(raw_score:1.0,weight:5.0),_sort_score:5.0),title:Acoustic Guitar)',
            '(_score:(Bookmark Collaborative Filtering:(raw_score:1.0,weight:5.0),_sort_score:5.0),title:Bleach)',
            '(_score:(Bookmark Collaborative Filtering:(raw_score:1.0,weight:5.0),_sort_score:5.0),title:Bourbon)',
            '(_score:(Bookmark Collaborative Filtering:(raw_score:1.0,weight:5.0),_sort_score:5.0),title:India Pale Ale)',
            '(_score:(Bookmark Collaborative Filtering:(raw_score:1.0,weight:5.0),_sort_score:5.0),title:Informational Book)',
            '(_score:(Bookmark Collaborative Filtering:(raw_score:1.0,weight:5.0),_sort_score:5.0),title:Internet meme)',
            '(_score:(Bookmark Collaborative Filtering:(raw_score:1.0,weight:5.0),_sort_score:5.0),title:Killer Whale)',
            '(_score:(Bookmark Collaborative Filtering:(raw_score:1.0,weight:5.0),_sort_score:5.0),title:Screamin Eagle CVO)',
            '(_score:(Bookmark Collaborative Filtering:(raw_score:1.0,weight:5.0),_sort_score:5.0),title:Snow)',
            '(_score:(Bookmark Collaborative Filtering:(raw_score:2.0,weight:5.0),_sort_score:10.0),title:Chart Course)'
        ]
        # import pprint
        # print(pprint.pprint(title_scores))
        self.assertEquals(expected_result, title_scores)

        sorted_scores = [listing['_score']['_sort_score'] for listing in response.data['recommended']]
        self.assertEquals(sorted(sorted_scores, reverse=True), sorted_scores)
