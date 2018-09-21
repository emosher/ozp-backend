"""
Storefront and Metadata Model Access
"""
import logging

from django.core.urlresolvers import reverse
from django.db import connection
from django.db.models import Count
from django.db.models.functions import Lower
from django.db.models import F

import msgpack

# import ozpcenter.api.listing.serializers as listing_serializers
from ozpcenter.utils import str_to_bool
from ozpcenter import models
from ozpcenter.pipe import pipes
from ozpcenter.pipe import pipeline
from ozpcenter.recommend import recommend_utils
from ozpcenter.recommend.recommend import RecommenderProfileResultSet


logger = logging.getLogger('ozp-center.' + str(__name__))

# TODO: Finish in future to increase speed
# def dictfetchall(cursor):
#     "Returns all rows from a cursor as a dict"
#     desc = cursor.description
#     return [
#         dict(zip([col[0] for col in desc], row))
#         for row in cursor.fetchall()
#     ]
#
#
# def get_sql_statement():
#     schema_class_str = str(connection.SchemaEditorClass)
#     is_deleted = None
#     is_enabled = None
#
#     if 'sqlite' in schema_class_str:
#         is_deleted = '0'
#         is_enabled = '1'
#     elif 'postgres' in schema_class_str:
#         is_deleted = 'False'
#         is_enabled = 'True'
#     else:
#         raise Exception('Get SQL Statment ENGINE Error')
#
#     sql_statement = '''
#
#     '''.format(is_enabled, is_deleted)
#     return sql_statement
#
#
# def get_user_listings(username, request, exclude_orgs=None):
#     """
#     Get User listings
#
#     Returns:
#         Python object of listings
#     """
#     exclude_orgs = exclude_orgs or []
#
#     mapping_dict = {}
#
#     cursor = connection.cursor()
#
#     cursor.execute(get_sql_statement())
#     rows = dictfetchall(cursor)
#
#     categories_set = set()
#     tags_set = set()
#     contacts_set = set()
#     profile_set = set()
#     intents_set = set()
#
#     for row in rows:
#         if row['id'] not in mapping_dict:
#             mapping_dict[row['id']] = {
#                 "id": row['id'],
#                 "unique_name": row['unique_name'],
#                 "is_enabled": row['is_enabled'],
#                 "is_private": row['is_private'],
#
#                 "required_listings_id": row['required_listings_id'],
#
#                 "total_rate1": row['total_rate1'],
#                 "total_rate2": row['total_rate2'],
#                 "total_rate3": row['total_rate3'],
#                 "total_rate4": row['total_rate4'],
#                 "total_rate5": row['total_rate5'],
#                 "avg_rate": row['avg_rate'],
#                 "total_reviews": row['total_reviews'],
#                 "total_votes": row['total_votes'],
#                 "feedback_score": row['feedback_score'],
#
#                 "approved_date": row['approved_date'],
#
#                 "usage_requirements": row['usage_requirements'],
#                 "system_requirements": row['system_requirements'],
#                 "iframe_compatible": row['iframe_compatible'],
#
#                 "what_is_new": row['what_is_new'],
#
#                 "is_deleted": row['is_deleted'],
#                 "security_marking": row['security_marking'],
#                 "version_name": row['version_name'],
#                 "approval_status": row['approval_status'],
#                 "current_rejection_id": row['current_rejection_id'],
#                 "is_featured": row['is_featured'],
#                 "title": row['title'],
#                 "description_short": row['description_short'],
#
#
#                 "launch_url": row['launch_url'],
#                 "edited_date": row['edited_date'],
#                 "description": row['description'],
#
#                 # One to One
#                 "listing_type": {"title": row['listing_type_title']},
#
#                 "agency": {'title': row['agency_title'],
#                            'short_name': row['agency_short_name']},
#
#                 "small_icon": {"id": row['small_icon_id'],
#                                'url': request.build_absolute_uri(reverse('image-detail', args=[row['small_icon_id']])),
#                                "security_marking": row['small_icon_security_marking']},
#
#                 "large_icon": {"id": row['large_icon_id'],
#                                'url': request.build_absolute_uri(reverse('image-detail', args=[row['large_icon_id']])),
#                                "security_marking": row['large_icon_security_marking']},
#
#                 "banner_icon": {"id": row['banner_icon_id'],
#                                 'url': request.build_absolute_uri(reverse('image-detail', args=[row['banner_icon_id']])),
#                                 "security_marking": row['banner_icon_security_marking']},
#
#                 "large_banner_icon": {"id": row['large_banner_icon_id'],
#                                       'url': request.build_absolute_uri(reverse('image-detail', args=[row['large_banner_icon_id']])),
#                                       "security_marking": row['large_banner_icon_security_marking']},
#
#                 "last_activity_id": row['last_activity_id']
#
#             }
#
#         # Many to Many
#         # Categorys
#
#         if not mapping_dict[row['id']].get('categories'):
#             mapping_dict[row['id']]['categories'] = {}
#         if row['category_id']:
#             current_data = {'title': row['category_title'], 'description': row['category_description']}
#             categories_set.add(row['category_id'])
#
#             if row['category_id'] not in mapping_dict[row['id']]['categories']:
#                 mapping_dict[row['id']]['categories'][row['category_id']] = current_data
#
#         # Tags
#         if not mapping_dict[row['id']].get('tags'):
#             mapping_dict[row['id']]['tags'] = {}
#         if row['tag_id']:
#             current_data = {'name': row['tag_name']}
#             tags_set.add(row['tag_id'])
#
#             if row['tag_id'] not in mapping_dict[row['id']]['tags']:
#                 mapping_dict[row['id']]['tags'][row['tag_id']] = current_data
#
#         # Contacts
#         if not mapping_dict[row['id']].get('contacts'):
#             mapping_dict[row['id']]['contacts'] = {}
#         if row['contact_id']:
#             current_data = {'id': row['contact_id'],
#                             'secure_phone': row['contact_secure_phone'],
#                             'unsecure_phone': row['contact_unsecure_phone'],
#                             'email': row['contact_email'],
#                             'name': row['contact_name'],
#                             'organization': row['contact_organization'],
#                             'contact_type': {'name': row['contact_type_name']}}
#             contacts_set.add(row['contact_id'])
#
#             if row['contact_id'] not in mapping_dict[row['id']]['contacts']:
#                 mapping_dict[row['id']]['contacts'][row['contact_id']] = current_data
#
#         # Profile
#         if not mapping_dict[row['id']].get('owners'):
#             mapping_dict[row['id']]['owners'] = {}
#         if row['profile_id']:
#             current_data = {'display_name': row['owner_display_name'],
#                 'user': {'username': row['owner_username']}}
#             profile_set.add(row['profile_id'])
#
#             if row['profile_id'] not in mapping_dict[row['id']]['owners']:
#                 mapping_dict[row['id']]['owners'][row['profile_id']] = current_data
#
#         # Intent
#         if not mapping_dict[row['id']].get('intents'):
#             mapping_dict[row['id']]['intents'] = {}
#         if row['intent_id']:
#             intents_set.add(row['intent_id'])
#             if row['intent_id'] not in mapping_dict[row['id']]['intents']:
#                 mapping_dict[row['id']]['intents'][row['intent_id']] = None
#
#     for profile_key in mapping_dict:
#         profile_map = mapping_dict[profile_key]
#         profile_map['owners'] = [profile_map['owners'][p_key] for p_key in profile_map['owners']]
#         profile_map['tags'] = [profile_map['tags'][p_key] for p_key in profile_map['tags']]
#         profile_map['categories'] = [profile_map['categories'][p_key] for p_key in profile_map['categories']]
#         profile_map['contacts'] = [profile_map['contacts'][p_key] for p_key in profile_map['contacts']]
#         profile_map['intents'] = [profile_map['intents'][p_key] for p_key in profile_map['intents']]
#
#     output_list = []
#
#     for listing_id in mapping_dict:
#         listing_values = mapping_dict[listing_id]
#
#         if listing_values['is_private'] is True:
#             if listing_values['agency']['title'] not in exclude_orgs:
#                 output_list.append(listing_values)
#         else:
#             output_list.append(listing_values)
#
#     return output_list
# def get_storefront_new(username, request):
#     """
#     Returns data for /storefront api invocation including:
#         * recommended listings (max=10)
#         * featured listings (max=12)
#         * recent (new) listings (max=24)
#         * most popular listings (max=36)

#     Args:
#         username

#     Returns:
#         {
#             'recommended': [Listing],
#             'featured': [Listing],
#             'recent': [Listing],
#             'most_popular': [Listing]
#         }
#     """
#     extra_data = {}
#     profile = models.Profile.objects.get(user__username=username)

#     if profile.highest_role() == 'APPS_MALL_STEWARD':
#         exclude_orgs = []
#     elif profile.highest_role() == 'ORG_STEWARD':
#         user_orgs = profile.stewarded_organizations.all()
#         user_orgs = [i.title for i in user_orgs]
#         exclude_orgs = [agency.title for agency in models.Agency.objects.exclude(title__in=user_orgs)]
#     else:
#         user_orgs = profile.organizations.all()
#         user_orgs = [i.title for i in user_orgs]
#         exclude_orgs = [agency.title for agency in models.Agency.objects.exclude(title__in=user_orgs)]

#     current_listings = get_user_listings(username, request, exclude_orgs)

#     # Get Recommended Listings for owner
#     if profile.is_beta_user():
#         recommendation_listing_ids, recommended_entry_data = get_recommendation_listing_ids(profile)
#         listing_ids_list = set(recommendation_listing_ids)

#         recommended_listings_raw = []
#         for current_listing in current_listings:
#             if current_listing['id'] in listing_ids_list:
#                 recommended_listings_raw.append(current_listing)

#         recommended_listings = pipeline.Pipeline(recommend_utils.ListIterator(recommended_listings_raw),
#                                             [pipes.JitterPipe(),
#                                              pipes.ListingDictPostSecurityMarkingCheckPipe(username),
#                                              pipes.LimitPipe(10)]).to_list()
#     else:
#         recommended_listings = []

#     # Get Featured Listings
#     featured_listings = pipeline.Pipeline(recommend_utils.ListIterator(current_listings),
#                                       [pipes.ListingDictPostSecurityMarkingCheckPipe(username, featured=True),
#                                        pipes.LimitPipe(12)]).to_list()
#     # Get Recent Listings
#     recent_listings = pipeline.Pipeline(recommend_utils.ListIterator(current_listings),
#                                       [pipes.ListingDictPostSecurityMarkingCheckPipe(username),
#                                        pipes.LimitPipe(24)]).to_list()

#     most_popular_listings = pipeline.Pipeline(recommend_utils.ListIterator(sorted(current_listings, key=lambda k: (k['avg_rate'], ['total_reviews']), reverse=True)),
#                                       [pipes.ListingDictPostSecurityMarkingCheckPipe(username),
#                                        pipes.LimitPipe(36)]).to_list()
#     # TODO 2PI filtering
#     data = {
#         'recommended': recommended_listings,
#         'featured': featured_listings,
#         'recent': recent_listings,
#         'most_popular': most_popular_listings
#     }

#     return data, extra_data


def get_storefront_recommended(request_profile, pre_fetch=True, randomize_recommended=True, ):
    """
    Get Recommended Listings for storefront

    from ozpcenter.api.storefront.model_access import get_storefront_recommended
    get_storefront_recommended(Profile.objects.first())
    from ozpcenter import models
    listing_ids_list = [1,5,6,7]
    request_profile = Profile.objects.first()
    """
    recommender_profile_result_set = RecommenderProfileResultSet.from_profile_instance(request_profile, randomize_recommended)
    recommender_profile_result_set.process()
    recommended_listings = recommender_profile_result_set.recommended_listings

    extra_data = {}
    extra_data['recommender_profile_result_set'] = recommender_profile_result_set
    return recommended_listings, extra_data


def get_storefront_featured(request_profile, pre_fetch=True):
    """
    Get Featured Listings for storefront
    """
    username = request_profile.user.username
    # Get Featured Listings
    featured_listings_raw = models.Listing.objects.for_user_organization_minus_security_markings(
        username).filter(
            is_featured=True,
            approval_status=models.Listing.APPROVED,
            is_enabled=True,
            is_deleted=False).order_by(F('featured_date').desc(nulls_last=True))

    featured_listings = pipeline.Pipeline(recommend_utils.ListIterator([listing for listing in featured_listings_raw]),
                           [pipes.ListingPostSecurityMarkingCheckPipe(username)]).to_list()
    return featured_listings


def get_storefront_recent(request_profile, pre_fetch=True):
    """
    Get Recent Listings for storefront
    """
    username = request_profile.user.username
    # Get Recent Listings
    recent_listings_raw = models.Listing.objects.for_user_organization_minus_security_markings(
        username).order_by('-approved_date').filter(
        approval_status=models.Listing.APPROVED,
        is_enabled=True,
        is_deleted=False)

    recent_listings = pipeline.Pipeline(recommend_utils.ListIterator([listing for listing in recent_listings_raw]),
                                      [pipes.ListingPostSecurityMarkingCheckPipe(username),
                                       pipes.LimitPipe(24)]).to_list()
    return recent_listings


def get_storefront_most_popular(request_profile, pre_fetch=True):
    """
    Get Most Popular Listings for storefront
    """
    username = request_profile.user.username
    # Get most popular listings via a weighted average
    most_popular_listings_raw = models.Listing.objects.for_user_organization_minus_security_markings(
        username).filter(
            approval_status=models.Listing.APPROVED,
            is_enabled=True,
            is_deleted=False).order_by('-avg_rate', '-total_reviews')

    most_popular_listings = pipeline.Pipeline(recommend_utils.ListIterator([listing for listing in most_popular_listings_raw]),
                                      [pipes.ListingPostSecurityMarkingCheckPipe(username),
                                       pipes.LimitPipe(36)]).to_list()
    return most_popular_listings


def get_storefront(request, pre_fetch=False, section=None):
    """
    Returns data for /storefront api invocation including:
        * recommended listings (max=10)
        * featured listings (no limit)
        * recent (new) listings (max=24)
        * most popular listings (max=36)

    NOTE: think about adding Bookmark status to this later on

    Args:
        username
        pre_fetch
        section(str): recommended, featured, recent, most_popular, all

    Returns:
        {
            'recommended': [Listing],
            'featured': [Listing],
            'recent': [Listing],
            'most_popular': [Listing]
        }
    """
    try:
        request_profile = models.Profile.objects.get(user__username=request.user)

        randomize_recommended = str_to_bool(request.query_params.get('randomize', True))

        section = section or 'all'

        data = {}
        extra_data = {}

        if section == 'all' or section == 'recommended':
            recommended_listings, extra_data = get_storefront_recommended(request_profile,
                                                                          pre_fetch,
                                                                          randomize_recommended)
            data['recommended'] = recommended_listings
        else:
            data['recommended'] = []

        if section == 'all' or section == 'featured':
            data['featured'] = get_storefront_featured(request_profile, pre_fetch)
        else:
            data['featured'] = []

        if section == 'all' or section == 'recent':
            data['recent'] = get_storefront_recent(request_profile, pre_fetch)
        else:
            data['recent'] = []

        if section == 'all' or section == 'most_popular':
            data['most_popular'] = get_storefront_most_popular(request_profile, pre_fetch)
        else:
            data['most_popular'] = []

    except Exception:
        # raise Exception({'error': True, 'msg': 'Error getting storefront: {0!s}'.format(str(e))})
        raise  # Should be catch in the django framwork
    return data, extra_data


def values_query_set_to_dict(vqs):
    return [item for item in vqs]


def get_metadata(username):
    """
    Returns metadata including:
        * categories
        * organizations (agencies)
        * listing types
        * intents
        * contact types

    Key: metadata
    """
    try:
        data = {}
        data['categories'] = values_query_set_to_dict(models.Category.objects.all().values(
            'id', 'title', 'description').order_by(Lower('title')))

        data['listing_types'] = values_query_set_to_dict(models.ListingType.objects.all().values(
            'title', 'description'))

        data['contact_types'] = values_query_set_to_dict(models.ContactType.objects.all().values(
            'name', 'required'))

        data['intents'] = values_query_set_to_dict(models.Intent.objects.all().values(
            'action', 'media_type', 'label', 'icon', 'id'))

        agency_listing_count_queryset = models.Listing.objects.for_user(username).filter(approval_status=models.Listing.APPROVED, is_enabled=True)
        agency_listing_count_queryset = agency_listing_count_queryset.values('agency__id',
                                                                        'agency__title',
                                                                        'agency__short_name',
                                                                        'agency__icon').annotate(listing_count=Count('agency__id')).order_by('agency__short_name')

        data['agencies'] = [{'id': record['agency__id'],
                            'title': record['agency__title'],
                            'short_name': record['agency__short_name'],
                            'icon': record['agency__icon'],
                            'listing_count': record['listing_count']} for record in agency_listing_count_queryset]

        for i in data['intents']:
            # i['icon'] = models.Image.objects.get(id=i['icon']).image_url()
            i['icon'] = '/TODO'

        return data
    except Exception as e:
        return {'error': True, 'msg': 'Error getting metadata: {0!s}'.format(str(e))}
