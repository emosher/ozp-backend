"""
Recommendations Engine
===============
Business Objective:
To recommend applications to users that they might find useful in their everyday objectives

Website Link: https://github.com/aml-development/ozp-documentation/wiki/Recommender-%282017%29

Data that could be used for recommendations
- Listing Bookmarked
- Keep track of folder apps

Recommendations are based on individual users

Assumptions:
    45,000 Users
    350 Listings

Worst Case Number of Recommendations = 15,750,000

Steps:
    - Load Data for each users
    - Process Data with recommendation algorthim
      - Produces a list of listing's id for each profile = Results
    - Iterate through the Results to call add_listing_to_user_profile function

Idea:
Jitting Result
"""
import logging
import time

import msgpack
from django.core.exceptions import ObjectDoesNotExist
from django.db.models import Count
from django.db import transaction
from django.conf import settings

from ozpcenter import models
from ozpcenter.pipe import pipes
from ozpcenter.pipe import pipeline
from ozpcenter.recommend import recommend_utils
from ozpcenter.recommend import recommend_es
from ozpcenter.recommend.graph_factory import GraphFactory
from ozpcenter.api.listing.elasticsearch_util import elasticsearch_factory


logger = logging.getLogger('ozp-center.' + str(__name__))


class ProfileResultSet(object):

    def __init__(self):
        """
        recommender_result_set: Dictionary with profile id, nested listing id with score pairs
        {
            profile_id#1: {
                listing_id#1: score#1,
                listing_id#2: score#2
            },
            profile_id#2: {
                listing_id#1: score#1,
                listing_id#2: score#2,
                listing_id#3: score#3,
            }
        }
        """
        self.recommender_result_set = {}

    def add_listing_to_user_profile(self, profile_id, listing_id, score, cumulative=False):
        score = float(score)
        if profile_id in self.recommender_result_set:
            if self.recommender_result_set[profile_id].get(listing_id):
                if cumulative:
                    self.recommender_result_set[profile_id][listing_id] = round(self.recommender_result_set[profile_id][listing_id] + score, 3)
                else:
                    self.recommender_result_set[profile_id][listing_id] = round(score, 3)
            else:
                self.recommender_result_set[profile_id][listing_id] = round(score, 3)
        else:
            self.recommender_result_set[profile_id] = {}
            self.recommender_result_set[profile_id][listing_id] = round(score, 3)


class RecommenderProfileResultSet(object):

    def __init__(self, profile_id):
        """
        Usage:
            from ozpcenter.api.storefront.model_access import RecommenderProfileResultSet;RecommenderProfileResultSet.from_profile_instance(Profile.objects.first()).process()

        Data:
            profile_id: integer
            recommender_result_set:
            {
                recommender_friendly_name#1:{
                    recommendations:{
                        listing_id#1: score#1,
                        listing_id#2: score#2
                    }
                    weight: 1.0,
                    ms_took: 3000
                },
                recommender_friendly_name#2:{
                    recommendations:{
                        listing_id#1: score#1,
                        listing_id#2: score#2,
                        listing_id#3: score#3,
                    }
                    weight: 1.0
                    ms_took: 5050
                }
            }
        """
        self.profile_instance = None
        self.profile_id = profile_id
        self.recommender_result_set = {}

    @staticmethod
    def from_profile_instance(profile_instance, randomize_recommended=True):
        """
        Factory Method to create a RecommenderProfileResultSet from the database
        """
        recommender_profile_result_set = RecommenderProfileResultSet(profile_instance.id)
        recommender_profile_result_set.profile_instance = profile_instance
        recommender_profile_result_set.randomize_recommended = randomize_recommended

        # Get Recommended Listings for owner
        target_profile_recommended_entry = models.RecommendationsEntry.objects.filter(target_profile=profile_instance).first()

        if target_profile_recommended_entry:
            recommendation_data = target_profile_recommended_entry.recommendation_data
            if recommendation_data:
                # Deserialize msgpack object into python object
                recommended_entry_data = msgpack.unpackb(bytearray(recommendation_data), encoding='utf-8')

                # Convert old format into new for backwards-compatibility
                if isinstance(recommended_entry_data, dict):
                    old_format = False
                    for current_recommender_friendly_name in recommended_entry_data:
                        current_recommender_friendly_name_value = recommended_entry_data[current_recommender_friendly_name]
                        if isinstance(current_recommender_friendly_name_value, dict) and 'recommendations' in current_recommender_friendly_name_value:
                            current_recommendations = current_recommender_friendly_name_value['recommendations']
                            if isinstance(current_recommendations, list):
                                replace_dict = {}
                                old_format = True
                                for current_recommendation_tuple in current_recommendations:
                                    if isinstance(current_recommendation_tuple, list) and len(current_recommendation_tuple) == 2:
                                        replace_dict[current_recommendation_tuple[0]] = current_recommendation_tuple[1]
                                current_recommender_friendly_name_value['recommendations'] = replace_dict

                    if old_format:
                        logger.warn('User [{}][{}] has old format for RecommendationsEntry data'.format(profile_instance, profile_instance.id))

                recommender_profile_result_set.recommender_result_set = recommended_entry_data

        return recommender_profile_result_set

    def _combine_recommendations(self):
        """
        responsible of combining different recommendation algorthims into one dictionary

        recommendation_combined_dict:
        {
            listing_id#1: average of scores between different algorthims,
            listing_id#2: average of scores between different algorthims
        }
        """
        recommendation_combined_dict = {}

        for recommender_friendly_name in self.recommender_result_set:
            recommender_name_data = self.recommender_result_set[recommender_friendly_name]
            recommender_name_weight = recommender_name_data['weight']
            recommender_name_recommendations = recommender_name_data['recommendations']

            for recommendation_listing_key in recommender_name_recommendations:
                current_listing_id = recommendation_listing_key
                current_listing_score = recommender_name_recommendations[current_listing_id]

                if current_listing_id in recommendation_combined_dict:
                    recommendation_combined_dict[current_listing_id] = recommendation_combined_dict[current_listing_id] + (current_listing_score * recommender_name_weight)
                else:
                    recommendation_combined_dict[current_listing_id] = current_listing_score * recommender_name_weight

        self.recommendation_combined_dict = recommendation_combined_dict

    def _sort_combined_recommendations(self):
        """
        Sort combined recommendations
        """
        # sorted_recommendations_combined_list = [[11, 8.5], [112, 8.0], [85, 7.0], [86, 7.0], [87, 7.0],
        #    [88, 7.0], [89, 7.0], [90, 7.0], [81, 6.0], [62, 6.0],
        #    [21, 5.5], [1, 5.0], [113, 5.0], [111, 5.0], [114, 5.0], [64, 4.0], [66, 4.0], [68, 4.0], [70, 4.0], [72, 4.0]]
        self.sorted_recommendations_combined_list = recommend_utils.get_top_n_score(self.recommendation_combined_dict, 40)
        self.sorted_recommendation_listing_ids = [entry[0] for entry in self.sorted_recommendations_combined_list]
        self.sorted_recommendations_combined_dict = {item[0]: item[1] for item in self.sorted_recommendations_combined_list}

    def _filter_listings(self):
        """
        Filter Listings out
        """
        self.filter_dict = {}
        # Retrieve negative feedback and remove from recommendation list
        self.filter_dict['negative_feedback'] = []

        recommendation_feedback_query = models.RecommendationFeedback.objects.filter(target_profile=self.profile_instance, feedback=-1)
        for recommendation_feedback in recommendation_feedback_query:
            self.filter_dict['negative_feedback'].append(recommendation_feedback.target_listing.id)

        # Retrieve Profile Bookmarks and remove bookmarked from recommendation list
        self.filter_dict['bookmarked_apps'] = []
        profile_username = self.profile_instance.user.username
        application_library_entry_query = (models.ApplicationLibraryEntry.objects
                                                 .for_user_organization_minus_security_markings(profile_username, True))

        for listing_entry in application_library_entry_query:
            self.filter_dict['bookmarked_apps'].append(listing_entry.listing.id)

        # Unique Listing Ids
        listing_id_set = set()

        for filter_name in self.filter_dict:
            for sub_listing_id in self.filter_dict[filter_name]:
                listing_id_set.add(sub_listing_id)

        self.filter_listing_ids = list(listing_id_set)

    def _get_listing_queryset(self):
        """
        Get new recommendation listing objects list minus filtered listing
        """
        profile_username = self.profile_instance.user.username
        self.recommended_listings_queryset = (models.Listing.objects
                                              .for_user_organization_minus_security_markings(profile_username)
                                              .filter(pk__in=self.sorted_recommendation_listing_ids,
                                                      approval_status=models.Listing.APPROVED,
                                                      is_enabled=True,
                                                      is_deleted=False)
                                         .exclude(id__in=self.filter_listing_ids)
                                         .all())

    def _fix_recommendation_order(self):
        # Fix Order of Recommendations based of score
        listing_id_object_mapper = {}
        for listing_object in self.recommended_listings_queryset:
            listing_id_object_mapper[listing_object.id] = listing_object

        self.recommended_listings_raw = []
        for listing_id in self.sorted_recommendation_listing_ids:
            if listing_id in listing_id_object_mapper:
                self.recommended_listings_raw.append(listing_id_object_mapper[listing_id])

    def _get_recommended_listings(self):
        profile_username = self.profile_instance.user.username

        # Post security_marking check - lazy loading
        pipeline_list = [pipes.ListingPostSecurityMarkingCheckPipe(profile_username), pipes.LimitPipe(10)]

        if self.randomize_recommended:
            pipeline_list.insert(0, pipes.JitterPipe())

        recommended_listings_iterator = recommend_utils.ListIterator(self.recommended_listings_raw)
        self.recommended_listings = pipeline.Pipeline(recommended_listings_iterator, pipeline_list).to_list()
        self.recommended_listings_ids = [listing.id for listing in self.recommended_listings]

    def process(self):
        self._combine_recommendations()
        self._sort_combined_recommendations()
        self._filter_listings()
        self._get_listing_queryset()
        self._fix_recommendation_order()
        self._get_recommended_listings()
        self._get_score_mapper_dict()

    def _get_score_mapper_dict(self):
        """
        Score mapper dictionary

        {listing_id#1 :
            {
            friendly_name#1: {'raw_score': score#1, 'weight': weight#1}
            friendly_name#2: {'raw_score': score#1, 'weight': weight#1}
            "_sort_score": 21.2,
            }, ...
        }
        """
        listing_recommend_data = {}

        for friendly_name in self.recommender_result_set:
            current_weight = self.recommender_result_set[friendly_name]['weight']
            recommendations = self.recommender_result_set[friendly_name]['recommendations']

            for current_listing in recommendations:
                current_score = recommendations[current_listing]

                if current_listing in listing_recommend_data:
                    listing_recommend_data[current_listing][friendly_name] = {'raw_score': current_score, 'weight': current_weight}
                else:
                    listing_recommend_data[current_listing] = {}
                    listing_recommend_data[current_listing][friendly_name] = {'raw_score': current_score, 'weight': current_weight}

        for current_listing in listing_recommend_data:
            if current_listing in self.sorted_recommendations_combined_dict:
                # TODO: Why is above if statement needed
                listing_recommend_data[current_listing]['_sort_score'] = round(self.sorted_recommendations_combined_dict[current_listing], 3)

        self.listing_recommend_data = listing_recommend_data

    def merge(self, recommender_friendly_name, recommendation_weight, current_recommendations, recommendations_time):
        """
        Purpose is to merge all of the different Recommender's algorthim recommender result together.
        This function is responsible for merging the results of the other Recommender recommender_result_set diction into self recommender_result_set

        Args:
            friendly_name: Recommender friendly name
            recommendation_weight: Recommender weight
            profile_result_set(ProfileResultSet): Recommender results
            recommendations_time: Recommender time
        """
        if recommender_friendly_name not in self.recommender_result_set:
            self.recommender_result_set[recommender_friendly_name] = {
                'recommendations': current_recommendations,
                'weight': recommendation_weight,
                'ms_took': recommendations_time
            }

    def debug_dict(self):
        return {
            "1. recommender_result_set": self.recommender_result_set,
            "2. recommendation_combined_dict": self.recommendation_combined_dict,
            "3. sorted_recommendations_combined_list": self.sorted_recommendations_combined_list,
            "4. filter_dict": self.filter_dict,
            "5. filter_listing_id": self.filter_listing_ids,
            "6. recommended_listings_ids": self.recommended_listings_ids
        }

    def __repr__(self):
        return str(self.recommender_result_set)


class RecommenderResultSet(object):

    def __init__(self):
        """
        {
            profile_id#1: RecommenderProfileResultSet(),
            profile_id#2: RecommenderProfileResultSet(),
        }

        recommender_result_set serialized
        {
            profile_id#1: {
                recommender_friendly_name#1:{
                    recommendations:[
                        [listing_id#1, score#1],
                        [listing_id#2, score#2]
                    ]
                    weight: 1.0
                    ms_took: 5050
                },
                recommender_friendly_name#2:{
                    recommendations:[
                        [listing_id#1, score#1],
                        [listing_id#2, score#2]
                    ]
                    weight: 2.0
                    ms_took: 5050
                }
            },
            profile_id#2: {
                recommender_friendly_name#1:{
                    recommendations:[
                        [listing_id#1, score#1],
                        [listing_id#2, score#2]
                    ]
                    weight: 1.0,
                    ms_took: 5050
                },
                recommender_friendly_name#2:{
                    recommendations:[
                        [listing_id#1, score#1],
                        [listing_id#2, score#2]
                    ]
                    weight: 1.0
                    ms_took: 5050
                }
            }
        }
        """
        self.recommender_result_set = {}

    def __repr__(self):
        return str(self.recommender_result_set)

    def merge(self, recommender_friendly_name, recommendation_weight, profile_result_set, recommendations_time):
        """
        Purpose is to merge all of the different Recommender's algorthim recommender result together.
        This function is responsible for merging the results of the other Recommender recommender_result_set diction into self recommender_result_set

        Args:
            friendly_name: Recommender friendly name
            recommendation_weight: Recommender weight
            profile_result_set(ProfileResultSet): Recommender results
            recommendations_time: Recommender time
        """
        for profile_id in profile_result_set.recommender_result_set:
            if profile_id not in self.recommender_result_set:
                self.recommender_result_set[profile_id] = RecommenderProfileResultSet(profile_id)
            current_recommendations = profile_result_set.recommender_result_set[profile_id]
            self.recommender_result_set[profile_id].merge(recommender_friendly_name, recommendation_weight, current_recommendations, recommendations_time)


class BaselineRecommender(object):
    """
    Baseline Recommender

    Assumptions:
    - Listing has ratings and possible not to have ratings
    - Listing can be featured
    - User bookmark Listings
    - User have bookmark folder, a collection of listing in a folder.
    - Listing has total_reviews field

    Requirements:
    - Recommendations should be explainable and believable
    - Must respect private apps
    - Does not have to repect security_marking while saving to db
    """
    friendly_name = 'Baseline'
    recommendation_weight = 1.0

    def initiate(self):
        """
        Initiate any variables needed for recommendation_logic function
        """
        pass

    def recommendation_logic(self):
        """
        Sample Recommendations for all users
        """
        all_profiles = models.Profile.objects.all()
        all_profiles_count = len(all_profiles)

        current_profile_count = 0
        for profile in all_profiles:
            start_ms = time.time() * 1000.0
            current_profile_count = current_profile_count + 1

            profile_id = profile.id
            profile_username = profile.user.username
            # Get Featured Listings
            featured_listings = models.Listing.objects.for_user_organization_minus_security_markings(
                profile_username).order_by('-approved_date').filter(
                    is_featured=True,
                    approval_status=models.Listing.APPROVED,
                    is_enabled=True,
                    is_deleted=False)

            for current_listing in featured_listings:
                self.profile_result_set.add_listing_to_user_profile(profile_id, current_listing.id, 3.0, True)

            # Get Recent Listings
            recent_listings = models.Listing.objects.for_user_organization_minus_security_markings(
                profile_username).order_by(
                    '-approved_date').filter(
                        is_featured=False,
                        approval_status=models.Listing.APPROVED,
                        is_enabled=True,
                        is_deleted=False)

            for current_listing in recent_listings:
                self.profile_result_set.add_listing_to_user_profile(profile_id, current_listing.id, 2.0, True)

            # Get most popular listings via a weighted average
            most_popular_listings = models.Listing.objects.for_user_organization_minus_security_markings(
                profile_username).filter(
                    approval_status=models.Listing.APPROVED,
                    is_enabled=True,
                    is_deleted=False).order_by('-avg_rate', '-total_reviews')

            for current_listing in most_popular_listings:
                if current_listing.avg_rate != 0:
                    self.profile_result_set.add_listing_to_user_profile(profile_id, current_listing.id, current_listing.avg_rate, True)

            # Get most popular bookmarked apps for all users
            # Would it be faster it this code was outside the loop for profiles?
            library_entries = models.ApplicationLibraryEntry.objects.for_user_organization_minus_security_markings(profile_username)
            library_entries = library_entries.filter(listing__is_enabled=True)
            library_entries = library_entries.filter(listing__is_deleted=False)
            library_entries = library_entries.filter(listing__approval_status=models.Listing.APPROVED)
            library_entries_group_by_count = library_entries.values('listing_id').annotate(count=Count('listing_id')).order_by('-count')
            # [{'listing_id': 1, 'count': 1}, {'listing_id': 2, 'count': 1}]

            # Calculation of Min and Max new scores dynamically.  This will increase the values that are lower
            # to a range within 2 and 5, but will not cause values higher than new_min and new_max to become even
            # larger.
            old_min = 1
            old_max = 1
            new_min = 2
            new_max = 5

            for entry in library_entries_group_by_count:
                count = entry['count']
                if count == 0:
                    continue
                if count > old_max:
                    old_max = count
                if count < old_min:
                    old_min = count

            for entry in library_entries_group_by_count:
                listing_id = entry['listing_id']
                count = entry['count']

                calculation = recommend_utils.map_numbers(count, old_min, old_max, new_min, new_max)
                self.profile_result_set.add_listing_to_user_profile(profile_id, listing_id, calculation, True)

            end_ms = time.time() * 1000.0
            logger.debug('Calculated Profile {}/{}, took {} ms'.format(current_profile_count, all_profiles_count, round(end_ms - start_ms, 3)))


class GraphCollaborativeFilteringBaseRecommender(object):
    """
    Graph Collaborative Filtering based on Bookmarkes
    """
    friendly_name = 'Bookmark Collaborative Filtering'
    recommendation_weight = 5.0

    def initiate(self):
        """
        Initiate any variables needed for recommendation_logic function
        """
        self.graph = GraphFactory.load_db_into_graph()
        self.all_profiles = models.Profile.objects.all()
        self.all_profiles_count = len(self.all_profiles)

    def recommendation_logic(self):
        """
        Recommendation logic
        """
        current_profile_count = 0
        for profile in self.all_profiles:
            start_ms = time.time() * 1000.0

            profile_id = profile.id
            current_profile_count = current_profile_count + 1

            results = self.graph.algo().recommend_listings_for_profile('p-{}'.format(profile_id))

            for current_tuple in results:
                listing_raw = current_tuple[0]  # 'l-#'
                listing_id = int(listing_raw.split('-')[1])
                score = current_tuple[1]
                # No need to rebase since results are within the range of others based on testing:
                self.profile_result_set.add_listing_to_user_profile(profile_id, listing_id, score)

            end_ms = time.time() * 1000.0
            logger.debug('Calculated Profile {}/{}, took {} ms'.format(current_profile_count, self.all_profiles_count, round(end_ms - start_ms, 3)))


# Method is decorated with @transaction.atomic to ensure all logic is executed in a single transaction
@transaction.atomic
def bulk_recommendations_saver(recommendation_entries):
    # Loop over each store and invoke save() on each entry
    for recommendation_entry in recommendation_entries:
        target_profile = recommendation_entry['target_profile']
        recommendation_data = recommendation_entry['recommendation_data']

        # models.RecommendationsEntry.objects.filter(target_profile__in=profile_query).delete() occured
        # try:
        #     obj = models.RecommendationsEntry.objects.get(target_profile=target_profile)
        #     obj.recommendation_data = recommendation_data
        #     obj.save()
        # except models.RecommendationsEntry.DoesNotExist:
        recommendation_entry_obj = models.RecommendationsEntry(target_profile=target_profile, recommendation_data=recommendation_data)
        recommendation_entry_obj.save()


class RecommenderDirectory(object):
    """
    Wrapper for all Recommenders
    """

    def __init__(self):
        self.recommender_classes = {
            'elasticsearch_user_base': recommend_es.ElasticsearchUserBaseRecommender,
            'elasticsearch_content_base': recommend_es.ElasticsearchContentBaseRecommender,
            'baseline': BaselineRecommender,
            'graph_cf': GraphCollaborativeFilteringBaseRecommender,
        }
        self.recommender_result_set_obj = RecommenderResultSet()

    def _iterate_recommenders(self, recommender_string):
        """
        Convert recommender string into Recommender instances
        """
        for current_recommender in recommender_string.split(','):
            current_recommender_string = current_recommender.strip()

            if current_recommender_string in self.recommender_classes:
                current_recommender_obj = self.recommender_classes[current_recommender_string]()
                current_recommender_obj.profile_result_set = ProfileResultSet()

                current_recommender_class = current_recommender_obj.__class__
                friendly_name = current_recommender_class.__name__

                if hasattr(current_recommender_class, 'friendly_name'):
                    friendly_name = current_recommender_class.friendly_name

                recommendation_weight = 1.0
                if hasattr(current_recommender_class, 'recommendation_weight'):
                    recommendation_weight = current_recommender_class.recommendation_weight

                yield current_recommender_obj, friendly_name, recommendation_weight
            else:
                logger.warn('Recommender Engine [{}] Not Found'.format(current_recommender))

    def recommend(self, recommender_string):
        """
        Creates Recommender Object, and execute the recommend

        Args:
            recommender_string: Comma Delimited list of Recommender Engine to execute
        """
        results = {}

        start_ms = time.time() * 1000.0
        stat_times = []

        for recommender_obj, friendly_name, recommendation_weight in self._iterate_recommenders(recommender_string):
            logger.info('=={}=='.format(friendly_name))
            results[friendly_name] = {}

            initiation_start_ms = time.time() * 1000.0

            if hasattr(recommender_obj, 'initiate'):
                # initiate - Used for initiating variables, classes, objects, connecting to service
                recommender_obj.initiate()

            initiation_end_ms = time.time() * 1000.0
            initiation_time = initiation_end_ms - initiation_start_ms

            recommendations_start_ms = time.time() * 1000.0

            if not hasattr(recommender_obj, 'recommendation_logic'):
                raise Exception('Recommender instance needs recommendation_logic method')

            recommender_obj.recommendation_logic()

            profile_result_set = recommender_obj.profile_result_set
            logger.debug(profile_result_set)

            recommendations_end_ms = time.time() * 1000.0
            recommendations_time = recommendations_end_ms - recommendations_start_ms
            stat_times.append((friendly_name, initiation_time, recommendations_time))
            logger.debug('Merging {} into results'.format(friendly_name, recommendations_time))
            self.recommender_result_set_obj.merge(friendly_name, recommendation_weight, profile_result_set, recommendations_time)

        logger.info('==Statistics==')
        for stat_time in stat_times:
            logger.info('[{}] took [{}] to initiate and [{}] for recommendation logic'.format(stat_time[0], round(stat_time[1], 3), round(stat_time[2], 3)))

        logger.info('==Start saving recommendations into database==')
        start_db_ms = time.time() * 1000.0
        self.save_to_db()
        end_db_ms = time.time() * 1000.0
        logger.info('Save to database took: {} ms'.format(round(end_db_ms - start_db_ms, 3)))
        logger.info('Whole Process: {} ms'.format(round(end_db_ms - start_ms, 3)))

        return results

    def save_to_db(self):
        """
        This function is responsible for storing the recommendations into the database

        # Pre-refactor - Save to database took: 2477.896240234375 ms, Database Calls: 1178
        # Post-refactor - Save to database took: 101.677978515625 ms, Database Calls: 584

        Performance:
            transaction.atomic() - 430 ms
            Without Atomic and Batch - 1400 ms
        """
        recommender_result_set = self.recommender_result_set_obj.recommender_result_set

        batch_list = []

        # Get all profiles in recommender_result_set
        profile_id_list = list(set([profile_id for profile_id in recommender_result_set]))

        logger.info('Generated Recommendations for the following profile ids:{}'.format(sorted(profile_id_list)))

        profile_query = models.Profile.objects.filter(id__in=profile_id_list)
        profile_dict = {profile.id: profile for profile in profile_query}
        listing_dict = {listing.id: listing for listing in models.Listing.objects.all()}

        # Delete RecommendationsEntry Entries for profiles
        profile_query = models.Profile.objects.filter(id__in=profile_id_list)
        models.RecommendationsEntry.objects.filter(target_profile__in=profile_query).delete()

        for profile_id in recommender_result_set:
            # print('*-*-*-*-'); import json; print(json.dumps(self.recommender_result_set[profile_id])); print('*-*-*-*-')
            profile = profile_dict.get(profile_id)

            if profile:
                batch_list.append({'target_profile': profile,
                                   'recommendation_data': msgpack.packb(recommender_result_set[profile_id].recommender_result_set)})

                if len(batch_list) >= 500:
                    bulk_recommendations_saver(batch_list)
                    batch_list = []

        if batch_list:
            bulk_recommendations_saver(batch_list)
