"""
************************************WARNING************************************
Many of the unit tests depend on data set in this script. Always
run the unit tests (python manage.py test) after making any changes to this
data!!
************************************WARNING************************************

Creates test data

Performance as 9/29/2017
--Loading Files
-----Took: 2819.659423828125 ms
--Recreate Index Mapping
-----Took: 0.201171875 ms
--Creating Groups
-----Took: 39.802490234375 ms
---Database Calls: 10
--Creating Categories
-----Took: 38.673583984375 ms
---Database Calls: 17
--Creating Contact Types and Contacts
-----Took: 63.4443359375 ms
---Database Calls: 103
--Creating Listing Types
-----Took: 11.817138671875 ms
---Database Calls: 6
--Creating Image Types
-----Took: 12.355224609375 ms
---Database Calls: 9
--Creating Intents
-----Took: 22.01318359375 ms
---Database Calls: 5
--Creating Organizations
-----Took: 133.14892578125 ms
---Database Calls: 28
--Creating Tags
-----Took: 10.674560546875 ms
---Database Calls: 3
--Creating Profiles
-----Took: 810.586181640625 ms
---Database Calls: 259
--Creating System Notifications
-----Took: 75.64794921875 ms
---Database Calls: 113
--Creating Listings
-----Took: 24917.27197265625 ms
---Database Calls: 11842
--Creating Reviews
-----Took: 3434.453369140625 ms
---Database Calls: 4236
--Creating Library
-----Took: 1062.648681640625 ms
---Database Calls: 731
--Creating Recommendations
-----Took: 3525.688720703125 ms
---Database Calls: 1322
Sample Data Generator took: 36984.35693359375 ms
"""
from PIL import Image
import datetime
import json
import os
import time
import pytz
import sys
import yaml

from collections import deque

sys.path.insert(0, os.path.realpath(os.path.join(os.path.dirname(__file__), '../../')))
from django.conf import settings
from django.db import transaction
from django.core.management import call_command

from ozpcenter import models
from ozpcenter.api.notification import model_access as notification_model_access
from ozpcenter.recommend.recommend import RecommenderDirectory
import ozpcenter.api.listing.model_access as listing_model_access
import ozpcenter.api.listing.model_access_es as model_access_es

TEST_BASE_PATH = os.path.realpath(os.path.join(os.path.dirname(__file__)))
TEST_IMG_PATH = os.path.join(TEST_BASE_PATH, 'test_images') + '/'
TEST_DATA_PATH = os.path.join(TEST_BASE_PATH, 'test_data')
DEMO_APP_ROOT = settings.OZP['DEMO_APP_ROOT']

FAST_MODE = bool(os.getenv('FAST_MODE', False))


def time_ms():
    return time.time() * 1000.0


def create_listing_review_batch(listing, review_list, object_cache):
    """
    Create Listing

    Args:
        listing
        review_list
            [
                {
                  "text": "This app is great - well designed and easy to use",
                  "author": "charrington",
                  "rate": 5,
                  "date_delta":  0  // -1  for -1 days ,  5 - for 5 days from date
                },{
                  "text": "This app is great - well designed and easy to use",
                  "author": "bigbrother",
                  "rate": 5:,
                  "review":true
                }
            ]

    """
    current_listing = listing

    previous_review = None

    for review_entry in review_list:
        profile_obj = object_cache['Profile.{}'.format(review_entry['author'])]
        current_rating = review_entry.get('rate', 0)
        current_text = review_entry['text']
        current_review_parent = None
        current_date_delta = review_entry.get('day_delta', None)

        current_review_parent_flag = review_entry.get('review', False)
        if current_review_parent_flag:
            current_review_parent = previous_review

        previous_review = listing_model_access.create_listing_review(profile_obj.user.username,
                            current_listing,
                            current_rating,
                            text=current_text,
                            review_parent=current_review_parent,
                            create_day_delta=current_date_delta)


def create_library_entries(library_entries, object_cache):
    """
    Create Bookmarks for users

    Args:
        library_entries:
            [{'folder': None, 'listing_id': 8, 'owner': 'wsmith', 'position': 0},
             {'folder': None, 'listing_id': 5, 'owner': 'hodor', 'position': 0},...]
    """
    for current_entry in library_entries:
        current_profile = object_cache['Profile.{}'.format(current_entry['owner'])]
        current_listing = current_entry['listing_obj']
        library_entry = models.ApplicationLibraryEntry(
            owner=current_profile,
            listing=current_listing,
            folder=current_entry['folder'],
            position=current_entry['position'])
        library_entry.save()
        # print('--[{}] creating bookmark for listing [{}]'.format(current_profile.user.username, current_listing.title))


def create_listing_icons(listing_builder_dict, object_cache):
    """
    Create Listing Helper Function
    """
    listing_data = listing_builder_dict['listing']
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    #                           Icons
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    small_icon = models.Image.create_image(
        Image.open(TEST_IMG_PATH + listing_data['small_icon']['filename']),
        file_extension=listing_data['small_icon']['filename'].split('.')[-1],
        security_marking=listing_data['small_icon']['security_marking'],
        image_type_obj=object_cache['ImageType.small_icon'])

    object_cache['Listing[{}].small_icon'.format(listing_data['title'])] = small_icon

    large_icon = models.Image.create_image(
        Image.open(TEST_IMG_PATH + listing_data['large_icon']['filename']),
        file_extension=listing_data['large_icon']['filename'].split('.')[-1],
        security_marking=listing_data['large_icon']['security_marking'],
        image_type_obj=object_cache['ImageType.large_icon'])

    object_cache['Listing[{}].large_icon'.format(listing_data['title'])] = large_icon

    banner_icon = models.Image.create_image(
        Image.open(TEST_IMG_PATH + listing_data['banner_icon']['filename']),
        file_extension=listing_data['banner_icon']['filename'].split('.')[-1],
        security_marking=listing_data['banner_icon']['security_marking'],
        image_type_obj=object_cache['ImageType.banner_icon'])

    object_cache['Listing[{}].banner_icon'.format(listing_data['title'])] = banner_icon

    large_banner_icon = models.Image.create_image(
        Image.open(TEST_IMG_PATH + listing_data['large_banner_icon']['filename']),
        file_extension=listing_data['large_banner_icon']['filename'].split('.')[-1],
        security_marking=listing_data['large_banner_icon']['security_marking'],
        image_type_obj=object_cache['ImageType.large_banner_icon'])

    object_cache['Listing[{}].large_banner_icon'.format(listing_data['title'])] = large_banner_icon


def create_listing(listing_builder_dict, object_cache):
    """
    Create Listing Helper Function

    10-01-2017 - Total Database Calls: 11842
    10-02-2017 - Total Database Calls: 7737
    """
    listing_data = listing_builder_dict['listing']

    listing = models.Listing(
        title=listing_data['title'],
        agency=object_cache['Agency.{}'.format(listing_data['agency'])],
        listing_type=object_cache['ListingType.{}'.format(listing_data['listing_type'])],
        description=listing_data['description'],
        launch_url=listing_data['launch_url'].format_map({'DEMO_APP_ROOT': DEMO_APP_ROOT}),
        version_name=listing_data['version_name'],
        unique_name=listing_data['unique_name'],
        small_icon=object_cache['Listing[{}].small_icon'.format(listing_data['title'])],
        large_icon=object_cache['Listing[{}].large_icon'.format(listing_data['title'])],
        banner_icon=object_cache['Listing[{}].banner_icon'.format(listing_data['title'])],
        large_banner_icon=object_cache['Listing[{}].large_banner_icon'.format(listing_data['title'])],
        what_is_new=listing_data['what_is_new'],
        description_short=listing_data['description_short'],
        usage_requirements=listing_data['usage_requirements'],
        system_requirements=listing_data['system_requirements'],
        is_enabled=listing_data['is_enabled'],
        is_private=listing_data['is_private'],
        is_featured=listing_data['is_featured'],
        iframe_compatible=listing_data['iframe_compatible'],
        security_marking=listing_data['security_marking']
    )
    listing.save()

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    #                           Contacts
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    for current_contact in listing_data['contacts']:
        listing.contacts.add(object_cache['Contact.{}'.format(current_contact)])

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    #                           Owners
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    for current_owner in listing_data['owners']:
        listing.owners.add(object_cache['Profile.{}'.format(current_owner)])

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    #                           Categories
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    for current_category in listing_data['categories']:
        listing.categories.add(models.Category.objects.get(title=current_category))
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    #                           Tags
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    for current_tag in listing_data['tags']:
        if object_cache.get('Tag.{}'.format(current_tag)):
            current_tag_obj = object_cache['Tag.{}'.format(current_tag)]
        else:
            current_tag_obj, created = models.Tag.objects.get_or_create(name=current_tag)
        listing.tags.add(current_tag_obj)
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    #                           Screenshots
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    for current_screenshot_entry in listing_data['screenshots']:
        small_image = models.Image.create_image(
            Image.open(TEST_IMG_PATH + current_screenshot_entry['small_image']['filename']),
            file_extension=current_screenshot_entry['small_image']['filename'].split('.')[-1],
            security_marking=current_screenshot_entry['small_image']['security_marking'],
            image_type=object_cache['ImageType.small_screenshot'].name)

        large_image = models.Image.create_image(
            Image.open(TEST_IMG_PATH + current_screenshot_entry['large_image']['filename']),
            file_extension=current_screenshot_entry['large_image']['filename'].split('.')[-1],
            security_marking=current_screenshot_entry['large_image']['security_marking'],
            image_type=object_cache['ImageType.large_screenshot'].name)

        screenshot = models.Screenshot(small_image=small_image,
                                       large_image=large_image,
                                       listing=listing,
                                       description=current_screenshot_entry['description'],
                                       order=current_screenshot_entry['order'])
        screenshot.save()

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    #                           Document URLs
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    for current_doc_url_entry in listing_data['doc_urls']:
        current_doc_url_obj = models.DocUrl(name=current_doc_url_entry['name'], url=current_doc_url_entry['url'], listing=listing)
        current_doc_url_obj.save()

    # listing_activity
    for listing_activity_entry in listing_builder_dict['listing_activity']:
        listing_activity_action = listing_activity_entry['action']
        listing_activity_author = object_cache['Profile.{}'.format(listing_activity_entry['author'])]

        if listing_activity_action == 'CREATED':
            listing_model_access.create_listing(listing_activity_author, listing)
        elif listing_activity_action == 'SUBMITTED':
            listing_model_access.submit_listing(listing_activity_author, listing)
        elif listing_activity_action == 'APPROVED_ORG':
            listing_model_access.approve_listing_by_org_steward(listing_activity_author, listing)
        elif listing_activity_action == 'APPROVED':
            listing_model_access.approve_listing(listing_activity_author, listing)

    return listing


def show_db_calls(db_connection, print_queries=False):
    number_of_calls = len(db_connection.queries)
    if print_queries:
        [print(query) for query in db_connection.queries]

    db_connection.queries_log.clear()
    return number_of_calls


def load_yaml_file(filename):
    with open(os.path.join(TEST_DATA_PATH, filename), 'r') as stream:
        try:
            # TODO: Use Stream API ?
            return yaml.load(stream)
        except yaml.YAMLError as exc:
            raise exc


def parse_sqlite_dump(filename):
    sql_statement = open(os.path.join(TEST_DATA_PATH, filename), 'r').readlines()
    all_sql = []
    temp_string = []
    for letter in sql_statement:
        temp_string.append(letter)
        if letter.strip().endswith(';'):
            all_sql.append(''.join(temp_string))
            temp_string = []
    return all_sql


def load_data_from_sql(db_connection, filename):
    sql_statements = parse_sqlite_dump(filename)
    with db_connection.cursor() as cursor:
        for sql_statement in sql_statements:
            sql_statement = sql_statement.strip()

            # ignore_lines = ['BEGIN TRANSACTION;',
            #                 'COMMIT;',
            #                 'CREATE UNIQUE INDEX',
            #                 'CREATE INDEX',
            #                 'CREATE TABLE',
            #                 'DELETE FROM',
            #                 'INSERT INTO "django_migrations"',
            #                 "INSERT INTO \"auth_group\" VALUES(5,'BETA_USER');"
            #                 'INSERT INTO "django_content_type" ']
            #
            # ignore_line = False
            #
            # for ignore_str in ignore_lines:
            #     if sql_statement.startswith(ignore_str):
            #         ignore_line = True
            #
            # if not ignore_line:
            #     print(sql_statement)
            cursor.execute(sql_statement)


def run():
    """
    Creates basic sample data
    """
    total_start_time = time_ms()

    db_connection = transaction.get_connection()
    db_connection.queries_limit = 100000
    db_connection.queries_log = deque(maxlen=db_connection.queries_limit)

    ############################################################################
    #                           Fast Mode
    ############################################################################
    if FAST_MODE:
        section_file_start_time = time_ms()

        load_data_from_sql(db_connection, 'dump_sqlite3.sql')

        print('-----Took: {} ms'.format(time_ms() - section_file_start_time))
        print('---Database Calls: {}'.format(show_db_calls(db_connection, False)))

        return

    ############################################################################
    #                           Security Markings
    ############################################################################
    unclass = 'UNCLASSIFIED'  # noqa: F841
    secret = 'SECRET'    # noqa: F841
    secret_n = 'SECRET//NOVEMBER'    # noqa: F841
    ts = 'TOP SECRET'    # noqa: F841
    ts_s = 'TOP SECRET//SIERRA'    # noqa: F841
    ts_st = 'TOP SECRET//SIERRA//TANGO'    # noqa: F841
    ts_stgh = 'TOP SECRET//SIERRA//TANGO//GOLF//HOTEL'    # noqa: F841

    ts_n = 'TOP SECRET//NOVEMBER'    # noqa: F841
    ts_sn = 'TOP SECRET//SIERRA//NOVEMBER'    # noqa: F841
    ts_stn = 'TOP SECRET//SIERRA//TANGO//NOVEMBER'    # noqa: F841
    ts_stghn = 'TOP SECRET//SIERRA//TANGO//GOLF//HOTEL//NOVEMBER'    # noqa: F841

    ############################################################################
    #                           Loading Data Files
    ############################################################################
    object_cache = {}

    print('--Loading Files')
    section_file_start_time = time_ms()

    categories_data = load_yaml_file('categories.yaml')
    contact_data = load_yaml_file('contacts.yaml')
    profile_data = load_yaml_file('profile.yaml')
    listings_data = load_yaml_file('listings.yaml')
    listing_types = load_yaml_file('listing_types.yaml')
    image_types = load_yaml_file('image_types.yaml')

    agency_data = [
        {'short_name': 'Minitrue',
         'title': 'Ministry of Truth',
         'icon.filename': 'ministry_of_truth.jpg'},
        {'short_name': 'Minipax',
        'title': 'Ministry of Peace',
        'icon.filename': 'ministry_of_peace.png'},
        {'short_name': 'Miniluv',
        'title': 'Ministry of Love',
        'icon.filename': 'ministry_of_love.jpeg'},
        {'short_name': 'Miniplen',
        'title': 'Ministry of Plenty',
        'icon.filename': 'ministry_of_plenty.png'},
        {'short_name': 'Test',
        'title': 'Test',
        'icon.filename': 'ministry_of_plenty.png'},
        {'short_name': 'Test 1',
        'title': 'Test 1',
        'icon.filename': 'ministry_of_plenty.png'},
        {'short_name': 'Test2',
        'title': 'Test 2',
        'icon.filename': 'ministry_of_plenty.png'},
        {'short_name': 'Test 3',
        'title': 'Test 3',
        'icon.filename': 'ministry_of_plenty.png'},
        {'short_name': 'Test 4',
        'title': 'Test 4',
        'icon.filename': 'ministry_of_plenty.png'}
    ]

    print('-----Took: {} ms'.format(time_ms() - section_file_start_time))

    ############################################################################
    #                           Recreate Index Mapping
    ############################################################################
    print('--Recreate Index Mapping')
    section_file_start_time = time_ms()

    model_access_es.recreate_index_mapping()
    print('-----Took: {} ms'.format(time_ms() - section_file_start_time))

    print('--flushing database')
    call_command('flush', '--noinput')  # Used to make postgresql work in unittest
    ############################################################################
    #                           Groups
    ############################################################################
    print('--Creating Groups')
    section_file_start_time = time_ms()
    models.Profile.create_groups()

    print('-----Took: {} ms'.format(time_ms() - section_file_start_time))
    show_db_calls(db_connection)

    ############################################################################
    #                           Categories
    ############################################################################
    print('--Creating Categories')
    section_start_time = time_ms()

    with transaction.atomic():
        for current_category in categories_data['categories']:
            current_category_obj = models.Category(title=current_category['title'], description=current_category['description'])
            current_category_obj.save()

    print('-----Took: {} ms'.format(time_ms() - section_start_time))
    print('---Database Calls: {}'.format(show_db_calls(db_connection, False)))

    ############################################################################
    #                           Contact Types and Contacts
    ############################################################################
    print('--Creating Contact Types and Contacts')
    section_start_time = time_ms()
    with transaction.atomic():
        for contact_type in contact_data['contact_types']:
            current_contact_type_obj = models.ContactType(name=contact_type)
            current_contact_type_obj.save()

            object_cache['ContactType.{}'.format(contact_type)] = current_contact_type_obj

        for current_contact in contact_data['contacts']:
            if not models.Contact.objects.filter(email=current_contact['email']).exists():
                current_contact_obj = models.Contact(name=current_contact['name'],
                                                     organization=current_contact['organization'],
                                                     contact_type=object_cache['ContactType.{}'.format(current_contact['contact_type'])],
                    email=current_contact['email'],
                    unsecure_phone=current_contact['unsecure_phone'],
                    secure_phone=current_contact['secure_phone'])
                current_contact_obj.save()

                object_cache['Contact.{}'.format(current_contact['email'])] = current_contact_obj

    print('-----Took: {} ms'.format(time_ms() - section_start_time))
    print('---Database Calls: {}'.format(show_db_calls(db_connection, False)))

    ############################################################################
    #                           Listing Types
    ############################################################################
    print('--Creating Listing Types')
    section_start_time = time_ms()
    with transaction.atomic():
        for listing_type in listing_types['listing_types']:
            listing_type_object = models.ListingType(title=listing_type['title'], description=listing_type['description'])
            listing_type_object.save()
            object_cache['ListingType.{}'.format(listing_type['title'])] = listing_type_object

    print('-----Took: {} ms'.format(time_ms() - section_start_time))
    print('---Database Calls: {}'.format(show_db_calls(db_connection, False)))

    ############################################################################
    #                           Image Types
    ############################################################################
    # Note: these image sizes do not represent those that should be used in production
    print('--Creating Image Types')
    section_start_time = time_ms()
    with transaction.atomic():
        for image_type in image_types['image_types']:
            image_type_obj = models.ImageType(name=image_type['name'], max_size_bytes=image_type['max_size_bytes'])
            image_type_obj.save()
            object_cache['ImageType.{}'.format(image_type['name'])] = image_type_obj

    print('-----Took: {} ms'.format(time_ms() - section_start_time))
    print('---Database Calls: {}'.format(show_db_calls(db_connection, False)))

    ############################################################################
    #                           Intents
    ############################################################################
    # TODO: more realistic data
    print('--Creating Intents')
    section_start_time = time_ms()
    with transaction.atomic():
        img = Image.open(TEST_IMG_PATH + 'android.png')
        icon = models.Image.create_image(img, file_extension='png',
            security_marking='UNCLASSIFIED', image_type=object_cache['ImageType.intent_icon'].name)
        i = models.Intent(action='/application/json/view',
            media_type='vnd.ozp-intent-v1+json.json',
            label='view',
            icon=icon)
        i.save()

        i = models.Intent(action='/application/json/edit',
            media_type='vnd.ozp-intent-v1+json.json',
            label='edit',
            icon=icon)
        i.save()

    print('-----Took: {} ms'.format(time_ms() - section_start_time))
    print('---Database Calls: {}'.format(show_db_calls(db_connection, False)))

    ############################################################################
    #                           Organizations
    ############################################################################
    print('--Creating Organizations')
    section_start_time = time_ms()
    with transaction.atomic():
        for agency_record in agency_data:
            img = Image.open(TEST_IMG_PATH + agency_record['icon.filename'])
            icon = models.Image.create_image(img,
                file_extension=agency_record['icon.filename'].split(".")[-1],
                security_marking=agency_record.get('icon.security_marking', 'UNCLASSIFIED'),
                image_type=object_cache['ImageType.agency_icon'])
            agency_object = models.Agency(title=agency_record['title'], short_name=agency_record['short_name'], icon=icon)
            agency_object.save()
            object_cache['Agency.{}'.format(agency_record['short_name'])] = agency_object

    print('-----Took: {} ms'.format(time_ms() - section_start_time))
    print('---Database Calls: {}'.format(show_db_calls(db_connection, False)))

    ############################################################################
    #                               Tags
    ############################################################################
    print('--Creating Tags')
    section_start_time = time_ms()
    with transaction.atomic():
        tag_names = ['demo', 'example']

        for tag_name in tag_names:
            tag_object = models.Tag(name=tag_name)
            tag_object.save()
            object_cache['Tag.{}'.format(tag_name)] = tag_object

    print('-----Took: {} ms'.format(time_ms() - section_start_time))
    print('---Database Calls: {}'.format(show_db_calls(db_connection, False)))

    ############################################################################
    #                               Profiles
    ############################################################################
    print('--Creating Profiles')
    section_start_time = time_ms()
    with transaction.atomic():
        for current_profile_data in profile_data:
            access_control = json.dumps(current_profile_data['access_control'])
            profile_obj = models.Profile.create_user(current_profile_data['username'],  # noqa: F841
                email=current_profile_data['email'],
                display_name=current_profile_data['display_name'],
                bio=current_profile_data['bio'],
                access_control=access_control,
                organizations=current_profile_data['organizations'],
                stewarded_organizations=current_profile_data['stewarded_organizations'],
                groups=current_profile_data['groups'],
                dn=current_profile_data['dn']
            )
            object_cache['Profile.{}'.format(current_profile_data['username'])] = profile_obj

    print('-----Took: {} ms'.format(time_ms() - section_start_time))
    print('---Database Calls: {}'.format(show_db_calls(db_connection, False)))

    # -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
    ############################################################################
    #                           System Notifications
    ############################################################################
    print('--Creating System Notifications')
    section_start_time = time_ms()
    with transaction.atomic():
        # create some notifications that expire next week
        next_week = datetime.datetime.now() + datetime.timedelta(days=7)
        eastern = pytz.timezone('US/Eastern')
        next_week = eastern.localize(next_week)
        n1 = notification_model_access.create_notification(object_cache['Profile.{}'.format('wsmith')],  # noqa: F841
                                                           next_week,
                                                           'System will be going down for approximately 30 minutes on X/Y at 1100Z')

        n2 = notification_model_access.create_notification(object_cache['Profile.{}'.format('julia')],  # noqa: F841
                                                           next_week,
                                                           'System will be functioning in a degredaded state between 1800Z-0400Z on A/B')

        # create some expired notifications
        last_week = datetime.datetime.now() - datetime.timedelta(days=7)
        last_week = eastern.localize(last_week)

        n1 = notification_model_access.create_notification(object_cache['Profile.{}'.format('wsmith')],  # noqa: F841
                                                           last_week,
                                                           'System will be going down for approximately 30 minutes on C/D at 1700Z')

        n2 = notification_model_access.create_notification(object_cache['Profile.{}'.format('julia')],  # noqa: F841
                                                           last_week,
                                                           'System will be functioning in a degredaded state between 2100Z-0430Z on F/G')

    print('-----Took: {} ms'.format(time_ms() - section_start_time))
    print('---Database Calls: {}'.format(show_db_calls(db_connection, False)))
    # -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
    # ===========================================================================
    #                           Listings Icons
    # ===========================================================================
    library_entries = []
    review_entries = []

    print('--Creating Listings Icons')
    listing_db_call_total = 0

    section_start_time = time_ms()
    with transaction.atomic():  # Maybe too large of a transaction
        for current_listing_data in listings_data:
            listing_obj = create_listing_icons(current_listing_data, object_cache)
            db_calls = show_db_calls(db_connection, False)
            listing_db_call_total = listing_db_call_total + db_calls

    print('---Took: {} ms'.format(time_ms() - section_start_time))
    print('---Total Database Calls: {}'.format(listing_db_call_total))

    # ===========================================================================
    #                           Listings
    # ===========================================================================
    print('--Creating Listings')
    listing_db_call_total = 0
    temp_counter = 0

    section_start_time = time_ms()
    with transaction.atomic():  # Maybe too large of a transaction
        for current_listing_data in listings_data:
            temp_counter = temp_counter + 1
            listing_obj = create_listing(current_listing_data, object_cache)

            if current_listing_data['listing_review_batch']:
                review_entry = {}
                review_entry['listing_obj'] = listing_obj
                review_entry['listing_review_batch'] = current_listing_data['listing_review_batch']
                review_entries.append(review_entry)

            listing_id = listing_obj.id
            listing_library_entries = current_listing_data['library_entries']

            if listing_library_entries:
                for listing_library_entry in listing_library_entries:
                    listing_library_entry['listing_obj'] = listing_obj
                    library_entries.append(listing_library_entry)

            db_calls = show_db_calls(db_connection, False)
            listing_db_call_total = listing_db_call_total + db_calls
            print('----{} \t DB Calls: {}'.format(current_listing_data['listing']['title'], db_calls))

    print('--Creating {} Listings took: {} ms'.format(temp_counter, time_ms() - section_start_time))
    print('---Total Database Calls: {}'.format(listing_db_call_total))

    ############################################################################
    #                           Reviews
    ############################################################################
    print('--Creating Reviews')
    section_start_time = time_ms()
    with transaction.atomic():
        for review_entry in review_entries:
            create_listing_review_batch(review_entry['listing_obj'], review_entry['listing_review_batch'], object_cache)

    print('-----Took: {} ms'.format(time_ms() - section_start_time))
    print('---Database Calls: {}'.format(show_db_calls(db_connection, False)))

    ############################################################################
    #                           Library (bookmark listings)
    ############################################################################
    print('--Creating Library')
    section_start_time = time_ms()
    with transaction.atomic():
        create_library_entries(library_entries, object_cache)

        for library_entry in library_entries:
            current_listing = library_entry['listing_obj']
            current_listing_owner = current_listing.owners.first()

            #  print('={} Creating Notification for {}='.format(current_listing_owner.user.username, current_listing.title))
            listing_notification = notification_model_access.create_notification(current_listing_owner,  # noqa: F841
                                                                          next_week,
                                                                          '{} update next week'.format(current_listing.title),
                                                                          listing=current_listing)
    print('-----Took: {} ms'.format(time_ms() - section_start_time))
    print('---Database Calls: {}'.format(show_db_calls(db_connection, False)))
    ############################################################################
    #                           Subscription
    ############################################################################
    # Categories
    # ['Books and Reference', 'Business', 'Communication', 'Education', 'Entertainment', 'Finance',
    #  'Health and Fitness', 'Media and Video', 'Music and Audio', 'News',
    #  'Productivity', 'Shopping', 'Sports', 'Tools', 'Weather']
    # Tags
    # ['demo', 'example', 'tag_0', 'tag_1', 'tag_2', 'tag_3',
    #  'tag_4', 'tag_5', 'tag_6', 'tag_7', 'tag_8', 'tag_9']
    # Usernames
    # ['bigbrother', 'bigbrother2', 'khaleesi', 'wsmith', 'julia', 'obrien', 'aaronson',
    #  'pmurt', 'hodor', 'jones', 'tammy', 'rutherford', 'noah', 'syme', 'abe',
    #  'tparsons', 'jsnow', 'charrington', 'johnson']

    subscriptions = [  # flake8: noqa
        ['bigbrother', 'category', 'Books and Reference'],
        ['bigbrother', 'category', 'Business']
    ]
    ############################################################################
    #                           Recommendations
    ############################################################################
    print('--Creating Recommendations')
    section_start_time = time_ms()
    sample_data_recommender = RecommenderDirectory()
    sample_data_recommender.recommend('baseline,graph_cf')
    print('-----Took: {} ms'.format(time_ms() - section_start_time))
    print('---Database Calls: {}'.format(show_db_calls(db_connection, False)))

    ############################################################################
    #                           End of script
    ############################################################################
    total_end_time = time_ms()
    print('Sample Data Generator took: {} ms'.format(total_end_time - total_start_time))


if __name__ == "__main__":
    run()
