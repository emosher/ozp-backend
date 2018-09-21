import logging
import time

import msgpack
from django.core.exceptions import ObjectDoesNotExist
from django.db.models import Count
from django.db import transaction
from django.conf import settings

from ozpcenter import models
from ozpcenter.recommend import recommend_utils
from ozpcenter.recommend.graph_factory import GraphFactory
from ozpcenter.api.listing.elasticsearch_util import elasticsearch_factory


logger = logging.getLogger('ozp-center.' + str(__name__))


class ElasticsearchRecommender(object):
    """
    Elasticsearch methods to create mappings, populate data, and run core recommendation queries for both Content and
    Collaborative based recommendations.  This is meant to be in a fashion so that it will also allow for execution
    from outside in other classes.  Thus will then facilitate a realtime execution when needed.

    See link for information on methods that have content:
    https://github.com/aml-development/ozp-backend/wiki/Elasticsearch-Recommendation-Engine
    """
    # Static Contstant to get ratings greater than this value entered into ES User Profile Table:
    MIN_ES_RATING = 3.5
    WAIT_TIME = 30  # Wait time in Minutes before running recreation of index
    TIMESTAMP_INDEX_TYPE = 'custom_meta'

    @staticmethod
    def set_timestamp_record():
        """
        Method to set timestamp for creation and last update of ES Recommendation Table data
        """
        es_client = elasticsearch_factory.get_client()

        index_name = settings.ES_RECOMMEND_USER
        timestamp = time.time()
        result_es = None

        if es_client.indices.exists(index_name):
            result_es = es_client.create(
                index=settings.ES_RECOMMEND_USER,
                doc_type=ElasticsearchRecommender.TIMESTAMP_INDEX_TYPE,
                id=0,
                refresh=True,
                body={
                    "lastupdated": timestamp
                }
            )

        return result_es

    @staticmethod
    def is_data_old():
        """
        Method to determine if the ES Recommendation Table data is out of date and needs to be recreated
        """
        # time.time() returns time in seconds since epoch.  To convert wait time to seconds need to multiply
        # by 60.  REF: https://docs.python.org/3/library/time.html
        trigger_recreate = ElasticsearchRecommender.WAIT_TIME * 60
        es_client = elasticsearch_factory.get_client()

        query_es_date = {
            "query": {
                "term": {
                    "_type": "custom_meta"
                }
            }
        }

        if es_client.indices.exists(settings.ES_RECOMMEND_USER):
            result_es = es_client.search(
                index=settings.ES_RECOMMEND_USER,
                body=query_es_date
            )
        else:
            # There is no index created and need to create one, return True to do so:
            logger.debug("== ES Table Does not exist, create a new one ==")
            return True

        if result_es['hits']['total'] == 0:
            lastupdate = 0
        else:
            lastupdate = result_es['hits']['hits'][0]['_source']['lastupdated']
        currenttime = time.time()
        logger.debug("== ES Table Last Update: {}, Current Time: {}, Recreate Index: {} ==".format(currenttime, lastupdate, ((currenttime - lastupdate) > trigger_recreate)))
        if (currenttime - lastupdate) > trigger_recreate:
            return True
        else:
            return False

    @staticmethod
    def get_index_mapping():
        """
        Mapping to be used for Elasticsearch Table for both Content and Collaborative Recommendation Engines
        See: https://github.com/aml-development/ozp-backend/wiki/Elasticsearch-Recommendation-Engine
        """
        number_of_shards = settings.ES_NUMBER_OF_SHARDS
        number_of_replicas = settings.ES_NUMBER_OF_REPLICAS

        index_mapping = {
            "settings": {
                "number_of_shards": number_of_shards,
                "number_of_replicas": number_of_replicas,
                "analysis": {
                    "analyzer": {
                       "keyword_lowercase_analyzer": {
                         "tokenizer": "keyword",
                         "filter": ["lowercase"]
                       }
                     }
                }
            },
            "mappings": {
                "custom_meta": {
                    "dynamic": "strict",
                    "properties": {
                        "lastupdated": {
                            "type": "long"
                        }
                    }
                },
                "recommend": {
                    "dynamic": "strict",
                    "properties": {
                        "author_id": {
                            "type": "long"
                        },
                        "author": {
                            "type": "string",
                            "analyzer": "english"
                        },
                        "titles": {
                            "type": "string",
                            "analyzer": "english"
                        },
                        "descriptions": {
                            "type": "string",
                            "analyzer": "english"
                        },
                        "description_shorts": {
                            "type": "string",
                            "analyzer": "english"
                        },
                        "agency_name_list": {
                            "type": "string"
                        },
                        "tags_list": {
                            "type": "string"
                        },
                        "categories_text": {
                            "type": "string",
                            "analyzer": "keyword_lowercase_analyzer"
                        },
                        "ratings": {
                            "type": "nested",
                            "properties": {
                                "listing_id": {
                                    "type": "long"
                                },
                                "rate": {
                                    "type": "long",
                                    "boost": 1
                                },
                                "listing_categories": {
                                    "type": "string",
                                    "analyzer": "keyword_lowercase_analyzer"
                                },
                                "category_ids": {
                                    "type": "long"
                                }
                            }
                        },
                        "bookmark_ids": {
                            "type": "long"
                        },
                        "categories_id": {
                            "type": "long"
                        }
                    }
                }
            }
        }
        return index_mapping

    def initiate(self):
        """
        Make sure the Elasticsearch is up and running
        Making profiles for Elasticsearch Recommendations
        """
        elasticsearch_factory.check_elasticsearch()

        if ElasticsearchRecommender.is_data_old():
            elasticsearch_factory.recreate_index_mapping(settings.ES_RECOMMEND_USER, ElasticsearchRecommender.get_index_mapping())
            ElasticsearchRecommender.load_data_into_es_table()

    @staticmethod
    def load_data_into_es_table():
        """
        - Get Mapping for Elasticsearch Table
        - Cycle through all profiles:
            - For each profile:
                Get Reviewed Listings with Categories, Title, Description, and Description Short Text
                Get Bookmarked Listings with Categories, Title, Description, and Description Short Text
                Add information to Elasticsearch Table for profile
        - Set timestamp for data creation
        """
        es_client = elasticsearch_factory.get_client()

        all_profiles = models.Profile.objects.all()

        data_to_bulk_index = []
        for profile in all_profiles:
            profile_username = profile.user.username

            title_text_list = set()
            description_text_list = set()
            description_short_text_list = set()
            categories_text_list = set()
            category_id_list = set()
            tags_text_list = set()
            organizations_text_list = [agency.short_name for agency in profile.organizations.all()]
            # orgs_text_list = str(organizations_text_list).strip('[').strip(']')
            #
            # print("orig: ", organizations_text_list)
            # print("modi: ", orgs_text_list)

            profile_listings_review = []
            for review_object in models.Review.objects.filter(author=profile.user_id):
                listing_obj = review_object.listing

                if review_object.rate > ElasticsearchRecommender.MIN_ES_RATING:
                    title_text_list.add(listing_obj.title)
                    description_text_list.add(listing_obj.description)
                    description_short_text_list.add(listing_obj.description_short)

                for tagitem in listing_obj.tags.all():
                    tags_text_list.add(tagitem.name)

                listing_categories = set()
                listing_category_id_list = set()
                for cat_item in review_object.listing.categories.all():
                    listing_categories.add(cat_item.title)
                    listing_category_id_list.add(cat_item.id)
                    categories_text_list.add(cat_item.title)
                    category_id_list.add(cat_item.id)

                update_item = {"listing_id": review_object.listing_id,
                               "rate": review_object.rate,
                               "listing_categories": list(categories_text_list),
                               "category_ids": list(listing_category_id_list)}
                profile_listings_review.append(update_item)

            bookmarked_id_list = []
            for bookmark_item in models.ApplicationLibraryEntry.objects.for_user(profile.user.username):
                bookmarked_listing_obj = bookmark_item.listing
                bookmarked_id_list.append(bookmarked_listing_obj.id)
                title_text_list.add(bookmarked_listing_obj.title)
                description_text_list.add(bookmarked_listing_obj.description)
                description_short_text_list.add(bookmarked_listing_obj.description_short)

                for cat_item in bookmarked_listing_obj.categories.all():
                    categories_text_list.add(cat_item.title)

                for tagitem in bookmarked_listing_obj.tags.all():
                    tags_text_list.add(tagitem.name)

            data_to_bulk_index.append({"author_id": profile.user_id,
                "author": profile_username,
                "agency_name_list": organizations_text_list,
                "titles": list(title_text_list),
                "descriptions": list(description_text_list),
                "description_shorts": list(description_short_text_list),
                "tags_list": list(tags_text_list),
                "categories_text": list(categories_text_list),
                "bookmark_ids": list(bookmarked_id_list),
                "categories_id": list(category_id_list),
                "ratings": profile_listings_review})

        # TODO data_to_bulk_index = [1..19500] > [[1..5000],[5001..10000], .., [15001..19500]]
        bulk_data = []
        for record in data_to_bulk_index:
            op_dict = {
                "index": {
                    "_index": settings.ES_RECOMMEND_USER,
                    "_type": settings.ES_RECOMMEND_TYPE,
                    "_id": record['author_id']
                }
            }

            bulk_data.append(op_dict)
            bulk_data.append(record)

        # Bulk index the data
        logger.debug('Bulk indexing Users...')
        res = es_client.bulk(index=settings.ES_RECOMMEND_USER, body=bulk_data, refresh=True)
        if res.get('errors', True):
            logger.error('Error Bulk Recommendation Indexing')
        else:
            logger.debug('Bulk Recommendation Indexing Successful')

        logger.debug("Done Indexing")

        ElasticsearchRecommender.set_timestamp_record()


class ElasticsearchContentBaseRecommender(ElasticsearchRecommender):
    """
    Elasticsearch Content based recommendation engine
    Steps:
    - Initialize Mappings by calling common Utils command to create table if it has not already been created recently
    - Import listings into main Elasticsearch table (if not already created recently)
        - Cycle through all reviews and add information to table (including text)
            - Add rating that the user given
        - Add all users that have bookmarked the app to the table
        - Go through User tables and add text to each record of a User Table
    - Perform calculations via query on data
    See: https://github.com/aml-development/ozp-backend/wiki/Elasticsearch-Recommendation-Engine
    """
    friendly_name = 'Elasticsearch Content Filtering'
    recommendation_weight = 0.9  # Weighting is based on rebasing the results
    result_size = 20  # Get only the top 50 results
    min_new_score = 4  # Min value to set for rebasing of results
    max_new_score = 9  # Max value to rebase results to so that values
    content_norm_factor = 0.05  # Amount to increase the max value found so that saturation does not occur.

    def es_content_based_recommendation(self, profile_id, result_size):
        """
        Recommendation Logic for Content Based Recommendations:

        Recommendation logic
        - Take profile passed in and SIZE of result set requested
        - Get information from profile to match against listings
        - Exclude apps that are already in the profile
        - Perform search based on queries and return results
        - Return list of recommended items back to calling method for the profile
        """
        es_client = elasticsearch_factory.get_client()

        query = {
            "query": {
                "bool": {
                    "must": [
                        {"term": {"author_id": profile_id}}
                    ]
                }
            }
        }

        es_profile_result = es_client.search(
            index=settings.ES_RECOMMEND_USER,
            body=query
        )

        if len(es_profile_result['hits']['hits']) >= 1:
            each_profile_source = es_profile_result['hits']['hits'][0]['_source']
        else:
            return {'hits': {'total': 0}}

        # each_profile_source_keys = ['titles', 'author', 'tags_list', 'categories_id',
        # 'categories_text', 'descriptions', 'author_id',
        # 'bookmark_ids', 'agency_name_list', 'ratings', 'description_shorts']

        query_object = []

        agency_text_query = str(each_profile_source['agency_name_list']).strip('[').strip(']')
        # TODO: Figure out if agency_text_query should be below results, str(?)
        # agency_text_query = 'Minitrue' / 'Minitrue', 'Minipax', 'Miniluv'
        agency_to_query = {
            "query": {
                "bool": {
                    "should": [
                        {"match": {"agency_short_name": agency_text_query}}
                    ]
                }
            }
        }
        query_object.append(agency_to_query)
        # TODO: Figure out if each_profile_source['categories_id'] should be below results
        # each_profile_source['categories_id'] = [3, 4, 5, 6, 8, 10, 12, 14, 15, 16] / [6] / []
        categories_to_query = {
            "nested": {
                "path": "categories",
                "query": {
                    "bool": {
                        "should": [
                            {"terms": {"categories.id": each_profile_source['categories_id']}}
                        ]
                    }
                }
            }
        }
        query_object.append(categories_to_query)
        # TODO: Figure out if each_profile_source['tags_list'] should be below results
        # each_profile_source['tags_list'] = [] / ['tag_0', 'demo', 'demo_tag', 'example']
        tags_to_query = {
            "nested": {
                "path": "tags",
                "query": {
                    "bool": {
                        "should": [
                            {"terms": {"tags.name_string": each_profile_source['tags_list']}}
                        ]
                    }
                }
            }
        }
        query_object.append(tags_to_query)

        title_list = {}
        for items in each_profile_source['titles']:
            title_list = {
                "multi_match": {
                    "query": items,
                    "type": "cross_fields",
                    "fields": ["title", "description", "description_short"],
                    "minimum_should_match": "20%"
                }
            }
            query_object.append(title_list)

        description_list = {}
        for items in each_profile_source['descriptions']:
            description_list = {
                "multi_match": {
                    "query": items,
                    "type": "cross_fields",
                    "fields": ["title", "description", "description_short"],
                    "minimum_should_match": "20%"
                }
            }
            query_object.append(description_list)

        description_short_list = {}
        for items in each_profile_source['description_shorts']:
            description_short_list = {
                "multi_match": {
                    "query": items,
                    "type": "cross_fields",
                    "fields": ["title", "description", "description_short"],
                    "minimum_should_match": "20%"
                }
            }
            query_object.append(description_short_list)

        rated_apps_list = list([rate['listing_id'] for rate in each_profile_source['ratings']])

        query_compare = {
            "size": result_size,
            "_source": ["id", "title"],
            "query": {
                "bool": {
                    "must_not": [
                        # id is the id of the listing when it searches the listings:
                        {"terms": {"id": each_profile_source['bookmark_ids']}},
                        {"terms": {"id": rated_apps_list}}
                    ],
                    "should": [
                        query_object
                    ]
                }
            }
        }

        es_query_result = es_client.search(
            index=settings.ES_INDEX_NAME,
            body=query_compare
        )

        # es_query_result = {'took':9,'timed_out':False,'hits':{ 'max_score':6.6793613, 'hits':[
        #  {'_type':'listings',
        #     '_source':{ 'title':'LocationAnalyzer','id':95},'_index':'appsmall', '_id':'95',
        #     '_score':6.6793613},....],'total':185}}
        return es_query_result

    def new_user_return_list(self, result_size):
        """
        This procedure is a uses all profile contents to create recommendations for a new user.
        RETURN: The procedure will return a query results of applications matching query of result_size to be used for
                populating new user recommendations.
        See: https://github.com/aml-development/ozp-backend/wiki/Elasticsearch-Recommendation-Engine
        """
        es_client = elasticsearch_factory.get_client()
        title_to_search_list = []

        content_search_term = {
            "size": 0,
            "aggs": {
                "most_common_titles": {
                    "significant_terms": {
                        "field": "titles"
                    }
                }
            }
        }

        es_content_init = es_client.search(
            index=settings.ES_RECOMMEND_USER,
            body=content_search_term
        )

        for item_key in es_content_init['aggregations']['most_common_titles']['buckets']:
            title_to_search_list_item = {
                "multi_match": {
                    "query": item_key['key'],
                    "type": "cross_fields",
                    "fields": ["title", "description", "description_short"],
                    "minimum_should_match": "20%"
                }
            }
            title_to_search_list.append(title_to_search_list_item)

        query_compare = {
            "size": result_size,
            "_source": ["id", "title"],
            "query": {
                "bool": {
                    "should": title_to_search_list
                }
            }
        }

        es_query_result = es_client.search(
            index=settings.ES_INDEX_NAME,
            body=query_compare
        )

        return es_query_result

    def recommendation_logic(self):
        """
        Recommendation logic is where the use of Collaborative vs Content differ.  Both use the User Profile to get
        infromation on the user, but with Content, it takes the content from user profiles on apps based on criteria
        that is implemented in the calling method and gets a recommended list of apps to return to the user as
        recommendations.
        The list is then normalized and added to the recommendations database.
        """
        all_profiles = models.Profile.objects.all()
        all_profiles_count = len(all_profiles)

        performed_search_request = False
        new_user_return_list = []
        current_profile_count = 0

        for profile in all_profiles:
            start_ms = time.time() * 1000.0
            current_profile_count = current_profile_count + 1
            profile_id = profile.id
            es_query_result = self.es_content_based_recommendation(profile_id, self.result_size)

            # Check if results returned are returned or if it is empty (New User):
            if es_query_result['hits']['total'] == 0:
                if not performed_search_request:
                    new_user_return_list = self.new_user_return_list(int(self.result_size / 2))
                    performed_search_request = True

                recommended_items = new_user_return_list['hits']['hits']
                max_score_es_content = new_user_return_list['hits']['max_score'] + self.content_norm_factor * new_user_return_list['hits']['max_score']
            else:
                recommended_items = es_query_result['hits']['hits']
                max_score_es_content = es_query_result['hits']['max_score'] + self.content_norm_factor * es_query_result['hits']['max_score']

            for indexitem in recommended_items:
                score = recommend_utils.map_numbers(indexitem['_score'], 0, max_score_es_content, self.min_new_score, self.max_new_score)
                itemtoadd = indexitem['_source']['id']
                self.profile_result_set.add_listing_to_user_profile(profile_id, itemtoadd, score, False)

            end_ms = time.time() * 1000.0
            logger.debug('Calculated Profile {}/{}, took {} ms'.format(current_profile_count, all_profiles_count, round(end_ms - start_ms, 3)))


class ElasticsearchUserBaseRecommender(ElasticsearchRecommender):
    """
    Elasticsearch User based recommendation engine
    Steps:
       - Perform aggregations on data to obtain recommendation list
       - Need to ensure that user apps and bookmarked apps are not in list
       - Output with query and put into recommendation table:
    See: https://github.com/aml-development/ozp-backend/wiki/Elasticsearch-Recommendation-Engine
    """
    friendly_name = 'Elasticsearch User Based Filtering'
    recommendation_weight = 1.0  # Weight that the overall results are multiplied against.  The rating for user based is less than 1.
    min_new_score = 5  # Min value to set for rebasing of results
    max_new_score = 10  # Max value to rebase results to so that values

    def es_user_based_recommendation(self, profile_id):
        """
        Recommendation Logic for Collaborative/User Based Recommendations:
        Recommendation logic
        - Take profile id passed in
        - Get User Profile information based on id
        - Get Categories, Bookmarks, Rated Apps (all and ones only greater than MIN_ES_RATING)
        - Compose Query to match profile of bookmarked and rated apps, but remove apps that have been
          identified by user already.
        - Perform ES Query and get the aggregations that have all of the apps already identified by the user
          removed.
        - Return list of recommended items back to calling method
        See: https://github.com/aml-development/ozp-backend/wiki/Elasticsearch-Recommendation-Engine
        """
        AGG_LIST_SIZE = 50  # Default is 10 if parameter is left out of query.

        es_client = elasticsearch_factory.get_client()
        es_profile_search = {
            "query": {
                "bool": {
                    "must": [
                        {"term": {"author_id": profile_id}}
                    ],
                }
            }
        }

        es_search_result = es_client.search(
            index=settings.ES_RECOMMEND_USER,
            body=es_profile_search
        )

        agg_query_term = {}

        if len(es_search_result['hits']['hits']) == 0:
            logger.warn('es_user_based_recommendation, profile_id[{}] returned no results'.format(profile_id))
            return []

        categories_to_match = es_search_result['hits']['hits'][0]['_source']['categories_id']
        tags_to_match = es_search_result['hits']['hits'][0]['_source']['tags_list']
        bookmarks_to_match = es_search_result['hits']['hits'][0]['_source']['bookmark_ids']
        rated_apps_list = list([rate['listing_id'] for rate in es_search_result['hits']['hits'][0]['_source']['ratings']])
        rated_apps_list_match = list([rate['listing_id'] for rate in es_search_result['hits']['hits'][0]['_source']['ratings'] if rate['rate'] > ElasticsearchRecommender.MIN_ES_RATING])
        agency_to_match = str(es_search_result['hits']['hits'][0]['_source']['agency_name_list'])

        agg_query_term = {
            "constant_score": {
                "filter": {
                    "bool": {
                        "should": [
                            {"terms": {"bookmark_ids": bookmarks_to_match}},
                            {"terms": {"categories": categories_to_match}},
                            {"terms": {"tags_list": tags_to_match}},
                            {"term": {"agency_name_list": agency_to_match}},
                            {
                                "nested": {
                                    "path": "ratings",
                                    "query": {
                                        "bool": {
                                            "should": [
                                                {"terms": {"ratings.listing_id": bookmarks_to_match}},
                                                {"terms": {"ratings.listing_id": rated_apps_list_match}}
                                            ]
                                        }
                                    }
                                }
                            }
                        ]
                    }
                }
            }
        }

        agg_search_query = {
            "size": 0,
            "query": agg_query_term,
            "aggs": {
                "the_listing": {
                    "nested": {
                        "path": "ratings"
                    },
                    "aggs": {
                        "listings": {
                            "filter": {
                                "range": {
                                    "ratings.rate": {
                                        "gte": ElasticsearchRecommender.MIN_ES_RATING
                                    }
                                }
                            }
                        },
                        "aggs": {
                            "significant_terms": {
                                "field": "ratings.listing_id",
                                "exclude": bookmarks_to_match + rated_apps_list,
                                "min_doc_count": 1,
                                "size": AGG_LIST_SIZE
                            }
                        }
                    }
                }
            }
        }

        es_query_result = es_client.search(
            index=settings.ES_RECOMMEND_USER,
            body=agg_search_query
        )

        recommended_items = es_query_result['aggregations']['the_listing']['aggs']['buckets']

        return recommended_items

    def recommendation_logic(self):
        """
        Recommendation logic is where the use of Collaborative vs Content differ.  Both use the User Profile to get
        infromation on the user, but with Collaborative, it then matches against other users that have similar profiles to
        return a recommendation.

        Recommendation logic
        - Cycle through each profile:
            - Call ESRecommendUtils method to get User based Recommendations
            - Take max score from results for profile and rebase all results while adding them to the recommendation list
            - For each recommendation add it to the list while rescalling the score based on the max score returned
        """
        # Retreive all of the profiles from database:
        all_profiles = models.Profile.objects.all()
        all_profiles_count = len(all_profiles)

        current_profile_count = 0
        for profile in all_profiles:
            start_ms = time.time() * 1000.0
            current_profile_count = current_profile_count + 1

            profile_id = profile.id
            recommended_items = self.es_user_based_recommendation(profile_id)

            # recommended_item = [{'key_as_string': '154', 'doc_count': 3, 'score': 0.025898896404414385, 'bg_count': 3, 'key': 154},
            #  {'key_as_string': '1', 'doc_count': 3, 'score': 0.025898896404414385, 'bg_count': 3, 'key': 1},
            #  {'key_as_string': '173', 'doc_count': 2, 'score': 0.017265930936276253, 'bg_count': 2, 'key': 173}, ...]

            # If a recommendaiton list is returned then get the max score,
            # otherwise it is a new user or there is no profile to base recommendations on:
            if recommended_items:
                max_score_es_user = recommended_items[0]['score']

            for indexitem in recommended_items:
                score = recommend_utils.map_numbers(indexitem['score'], 0, max_score_es_user, self.min_new_score, self.max_new_score)
                self.profile_result_set.add_listing_to_user_profile(profile_id, indexitem['key'], score, False)

            end_ms = time.time() * 1000.0
            logger.debug('Calculated Profile {}/{}, took {} ms'.format(current_profile_count, all_profiles_count, round(end_ms - start_ms, 3)))
