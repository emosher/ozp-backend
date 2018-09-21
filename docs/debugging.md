## Tracing REST Call
This section describes the life of a REST call.    
Developer should have knownledge of

* [Django's URL Dispatcher](https://docs.djangoproject.com/es/1.9/topics/http/urls/)
* [Django Rest Framework's Viewsets](http://www.django-rest-framework.org/api-guide/viewsets/)
* [Django Rest Framework's Serializer](http://www.django-rest-framework.org/api-guide/serializers/)

Example trace for a GET Request for getting a user's profile for an authenticated user     
`GET /api/self/profile`

* Entry Point for all REST Calls - ozp/urls.py. All /api/* calls get re-routed to ozpcenter/urls.py file    
* ozpcenter/urls.py add REST access points for all the views for the resources (agency, category, etc...)    
    * This line of code `url(r'', include('ozpcenter.api.profile.urls'))` adds endpoints related to profile REST Calls
* ozpcenter/api/profile/user.py - 'self/profile/' route points to current user's profile (Using CurrentUserViewSet in ozpcenter/api/profile/views.py)
* ozpcenter/api/profile/views.py - For GET Request for this route it will call the 'retrieve' method
    * Before allowing user to access the endpoint it will make sure user is authenticated and has the correct role using 'permission_classes = (permissions.IsUser,)'

## Performance Debugging
We check the performance of a Database model using shell_plus command for manage.py.
````shell
python manage.py shell_plus --print-sql
````
````python
# Shell Plus Model Imports
from corsheaders.models import CorsModel
from django.contrib.admin.models import LogEntry
from django.contrib.auth.models import Group, Permission, User
from django.contrib.contenttypes.models import ContentType
from django.contrib.sessions.models import Session
from ozpcenter.models import Agency, ApplicationLibraryEntry, Category, ChangeDetail, Contact, ContactType, DocUrl, Image, ImageType, Intent, Listing, ListingActivity, ListingType, Notification, Profile, Review, Screenshot, Tag
from ozpiwc.models import DataResource
# Shell Plus Django Imports
from django.utils import timezone
from django.conf import settings
from django.core.cache import cache
from django.core.urlresolvers import reverse
from django.db.models import Avg, Count, F, Max, Min, Sum, Q, Prefetch
from django.db import transaction
Python 3.4.3 (default, Feb 25 2016, 10:08:19)
[GCC 4.8.2] on linux
Type "help", "copyright", "credits" or "license" for more information.
(InteractiveConsole)
>>>
````

## Getting all Profiles (without any optimizations)
````python
>>> Profile.objects.all()
QUERY = 'SELECT "ozpcenter_profile"."id", "ozpcenter_profile"."display_name", "ozpcenter_profile"."bio", "ozpcenter_profile"."center_tour_flag", "ozpcenter_profile"."hud_tour_flag", "ozpcenter_profile"."webtop_tour_flag", "ozpcenter_profile"."dn", "ozpcenter_profile"."issuer_dn", "ozpcenter_profile"."auth_expires", "ozpcenter_profile"."access_control", "ozpcenter_profile"."user_id" FROM "ozpcenter_profile" LIMIT 21' - PARAMS = ()

Execution time: 0.000324s [Database: default]

QUERY = 'SELECT "auth_user"."id", "auth_user"."password", "auth_user"."last_login", "auth_user"."is_superuser", "auth_user"."username", "auth_user"."first_name", "auth_user"."last_name", "auth_user"."email", "auth_user"."is_staff", "auth_user"."is_active", "auth_user"."date_joined" FROM "auth_user" WHERE "auth_user"."id" = %s' - PARAMS = (1,)

Execution time: 0.000207s [Database: default]

QUERY = 'SELECT "auth_user"."id", "auth_user"."password", "auth_user"."last_login", "auth_user"."is_superuser", "auth_user"."username", "auth_user"."first_name", "auth_user"."last_name", "auth_user"."email", "auth_user"."is_staff", "auth_user"."is_active", "auth_user"."date_joined" FROM "auth_user" WHERE "auth_user"."id" = %s' - PARAMS = (2,)

Execution time: 0.000203s [Database: default]

QUERY = 'SELECT "auth_user"."id", "auth_user"."password", "auth_user"."last_login", "auth_user"."is_superuser", "auth_user"."username", "auth_user"."first_name", "auth_user"."last_name", "auth_user"."email", "auth_user"."is_staff", "auth_user"."is_active", "auth_user"."date_joined" FROM "auth_user" WHERE "auth_user"."id" = %s' - PARAMS = (3,)

Execution time: 0.000202s [Database: default]

QUERY = 'SELECT "auth_user"."id", "auth_user"."password", "auth_user"."last_login", "auth_user"."is_superuser", "auth_user"."username", "auth_user"."first_name", "auth_user"."last_name", "auth_user"."email", "auth_user"."is_staff", "auth_user"."is_active", "auth_user"."date_joined" FROM "auth_user" WHERE "auth_user"."id" = %s' - PARAMS = (4,)

Execution time: 0.000124s [Database: default]

QUERY = 'SELECT "auth_user"."id", "auth_user"."password", "auth_user"."last_login", "auth_user"."is_superuser", "auth_user"."username", "auth_user"."first_name", "auth_user"."last_name", "auth_user"."email", "auth_user"."is_staff", "auth_user"."is_active", "auth_user"."date_joined" FROM "auth_user" WHERE "auth_user"."id" = %s' - PARAMS = (5,)

Execution time: 0.000101s [Database: default]

QUERY = 'SELECT "auth_user"."id", "auth_user"."password", "auth_user"."last_login", "auth_user"."is_superuser", "auth_user"."username", "auth_user"."first_name", "auth_user"."last_name", "auth_user"."email", "auth_user"."is_staff", "auth_user"."is_active", "auth_user"."date_joined" FROM "auth_user" WHERE "auth_user"."id" = %s' - PARAMS = (6,)

Execution time: 0.000145s [Database: default]

QUERY = 'SELECT "auth_user"."id", "auth_user"."password", "auth_user"."last_login", "auth_user"."is_superuser", "auth_user"."username", "auth_user"."first_name", "auth_user"."last_name", "auth_user"."email", "auth_user"."is_staff", "auth_user"."is_active", "auth_user"."date_joined" FROM "auth_user" WHERE "auth_user"."id" = %s' - PARAMS = (7,)

Execution time: 0.000145s [Database: default]

QUERY = 'SELECT "auth_user"."id", "auth_user"."password", "auth_user"."last_login", "auth_user"."is_superuser", "auth_user"."username", "auth_user"."first_name", "auth_user"."last_name", "auth_user"."email", "auth_user"."is_staff", "auth_user"."is_active", "auth_user"."date_joined" FROM "auth_user" WHERE "auth_user"."id" = %s' - PARAMS = (8,)

Execution time: 0.000131s [Database: default]

QUERY = 'SELECT "auth_user"."id", "auth_user"."password", "auth_user"."last_login", "auth_user"."is_superuser", "auth_user"."username", "auth_user"."first_name", "auth_user"."last_name", "auth_user"."email", "auth_user"."is_staff", "auth_user"."is_active", "auth_user"."date_joined" FROM "auth_user" WHERE "auth_user"."id" = %s' - PARAMS = (9,)

Execution time: 0.000099s [Database: default]

QUERY = 'SELECT "auth_user"."id", "auth_user"."password", "auth_user"."last_login", "auth_user"."is_superuser", "auth_user"."username", "auth_user"."first_name", "auth_user"."last_name", "auth_user"."email", "auth_user"."is_staff", "auth_user"."is_active", "auth_user"."date_joined" FROM "auth_user" WHERE "auth_user"."id" = %s' - PARAMS = (10,)

Execution time: 0.000098s [Database: default]

QUERY = 'SELECT "auth_user"."id", "auth_user"."password", "auth_user"."last_login", "auth_user"."is_superuser", "auth_user"."username", "auth_user"."first_name", "auth_user"."last_name", "auth_user"."email", "auth_user"."is_staff", "auth_user"."is_active", "auth_user"."date_joined" FROM "auth_user" WHERE "auth_user"."id" = %s' - PARAMS = (11,)

Execution time: 0.000096s [Database: default]

[Profile: wsmith, Profile: julia, Profile: obrien, Profile: bigbrother, Profile: bigbrother2, Profile: aaronson, Profile: jones, Profile: rutherford, Profile: syme, Profile: tparsons, Profile: charrington]

````
Results:
12 database calls ( 1 + num of user = Database calls)

## Getting all Profiles (with join)
````python
>>> Profile.objects.all().select_related('user')
QUERY = 'SELECT "ozpcenter_profile"."id", "ozpcenter_profile"."display_name", "ozpcenter_profile"."bio", "ozpcenter_profile"."center_tour_flag", "ozpcenter_profile"."hud_tour_flag", "ozpcenter_profile"."webtop_tour_flag", "ozpcenter_profile"."dn", "ozpcenter_profile"."issuer_dn", "ozpcenter_profile"."auth_expires", "ozpcenter_profile"."access_control", "ozpcenter_profile"."user_id", "auth_user"."id", "auth_user"."password", "auth_user"."last_login", "auth_user"."is_superuser", "auth_user"."username", "auth_user"."first_name", "auth_user"."last_name", "auth_user"."email", "auth_user"."is_staff", "auth_user"."is_active", "auth_user"."date_joined" FROM "ozpcenter_profile" LEFT OUTER JOIN "auth_user" ON ( "ozpcenter_profile"."user_id" = "auth_user"."id" ) LIMIT 21' - PARAMS = ()

Execution time: 0.000472s [Database: default]

[Profile: wsmith, Profile: julia, Profile: obrien, Profile: bigbrother, Profile: bigbrother2, Profile: aaronson, Profile: jones, Profile: rutherford, Profile: syme, Profile: tparsons, Profile: charrington]
````
Results:
1 database call

## Debugging Storefront Serializer
````python
from rest_framework.response import Response
import ozpcenter.api.storefront.model_access as ma
import ozpcenter.api.storefront.serializers as se
import timeit
from django.test.client import RequestFactory

rf = RequestFactory()
get_request = rf.get('/hello/')

data = ma.get_storefront('bigbrother') # Database calls
sea = se.StorefrontSerializer(data,context={'request':get_request})
start = timeit.timeit(); r= Response(sea.data) ; end = timeit.timeit() # Database calls
print('Time: %s' % end)
````

## Improving `put_counts_in_listings_endpoint` database example
```
import time
from django.db import transaction


def show_db_calls():
    db_connection = transaction.get_connection()
    number_of_calls = len(db_connection.queries)
    db_connection.queries_log.clear()
    return number_of_calls


def group_by_sum(count_data_list, group_key, count_key='agency_count'):
    """
    { "agency__id": 1, "agency_count": 39, "approval_status": "APPROVED", "is_enabled": true},

    returns
        dict
    """
    count_dict = {}

    for record_dict in count_data_list:
        group_key_in_record = group_key in record_dict

        if group_key_in_record:
            group_key_value = record_dict[group_key]
            group_key_count_value = record_dict[count_key]
            group_key_value_in_count_dict = group_key_value in count_dict

            if group_key_value_in_count_dict:
                count_dict[group_key_value] = count_dict[group_key_value] + group_key_count_value
            else:
                count_dict[group_key_value] = group_key_count_value

    total_count = 0

    for key in count_dict:
        value = count_dict[key]
        total_count = total_count + value

    count_dict['_total_count'] = total_count

    return count_dict


def put_counts_in_listings_endpoint_new(queryset):
    """
    Add counts to the listing/ endpoint

    Args:
        querset: models.Listing queryset

    Returns:
        {
            total": <total listings>,
            organizations: {
                <org_id>: <int>,
                ...
            },
            enabled: <enabled listings>,
            IN_PROGRESS: <int>,
            PENDING: <int>,
            PENDING_DELETION: <int>"
            REJECTED: <int>,
            APPROVED_ORG: <int>,
            APPROVED: <int>,
            DELETED: <int>
        }
    """
    show_db_calls()
    start_time = int(round(time.time() * 1000))
    data = {}

    count_data = (models.Listing
                        .objects.filter(pk__in=queryset)
                        .values('agency__id','is_enabled', 'approval_status')
                        .annotate(agency_count=Count('agency__id')))

    enabled_count = group_by_sum(count_data, 'is_enabled')

    data['total'] = enabled_count.get('_total_count', 0)
    data['enabled'] = enabled_count.get(True, 0)

    agency_count = group_by_sum(count_data, 'agency__id')

    data['organizations'] = {}

    agency_ids = list(models.Agency.objects.values_list('id', flat=True))
    for agency_id in agency_ids:
        agency_id_str = str(agency_id)
        if agency_id in agency_count:
            data['organizations'][agency_id_str] = agency_count[agency_id]
        else:
            data['organizations'][agency_id_str] = '0'

    approval_status_count = group_by_sum(count_data, 'approval_status')
    approval_status_list = [
        models.Listing.IN_PROGRESS,
        models.Listing.PENDING,
        models.Listing.REJECTED,
        models.Listing.APPROVED_ORG,
        models.Listing.APPROVED,
        models.Listing.DELETED,
        models.Listing.PENDING_DELETION
    ]

    for current_approval_status in approval_status_list:
        data[current_approval_status] = approval_status_count.get(current_approval_status, 0)

    data['_time'] = int(round(time.time() * 1000)) - start_time
    data['_db_calls'] = show_db_calls()
    return data


def put_counts_in_listings_endpoint(queryset):
    """
    Add counts to the listing/ endpoint

    Args:
        querset: models.Listing queryset

    Returns:
        {
            total": <total listings>,
            organizations: {
                <org_id>: <int>,
                ...
            },
            enabled: <enabled listings>,
            IN_PROGRESS: <int>,
            PENDING: <int>,
            PENDING_DELETION: <int>"
            REJECTED: <int>,
            APPROVED_ORG: <int>,
            APPROVED: <int>,
            DELETED: <int>
        }
    """
    show_db_calls()
    start_time = int(round(time.time() * 1000))
    # TODO: Take in account 2pki user (rivera-20160908)

    data = {}

    # Number of total listings
    num_total = queryset.count()
    # Number of listing that is Enabled
    num_enabled = queryset.filter(is_enabled=True).count()

    # Number of listing that is IN_PROGRESS
    num_in_progress = queryset.filter(
        approval_status=models.Listing.IN_PROGRESS).count()

    # Number of listing that is PENDING
    num_pending = queryset.filter(
        approval_status=models.Listing.PENDING).count()

    # Number of listing that is REJECTED
    num_rejected = queryset.filter(
        approval_status=models.Listing.REJECTED).count()

    # Number of listing that is APPROVED_ORG
    num_approved_org = queryset.filter(
        approval_status=models.Listing.APPROVED_ORG).count()

    # Number of listing that is APPROVED
    num_approved = queryset.filter(
        approval_status=models.Listing.APPROVED).count()

    # Number of listing that is DELETED
    num_deleted = queryset.filter(
        approval_status=models.Listing.DELETED).count()

    # Number of listing that is PENDING_DELETION
    num_pending_deletion = queryset.filter(
        approval_status=models.Listing.PENDING_DELETION).count()

    data['total'] = num_total
    data['enabled'] = num_enabled
    data['organizations'] = {}
    data[models.Listing.IN_PROGRESS] = num_in_progress
    data[models.Listing.PENDING] = num_pending
    data[models.Listing.REJECTED] = num_rejected
    data[models.Listing.APPROVED_ORG] = num_approved_org
    data[models.Listing.APPROVED] = num_approved
    data[models.Listing.DELETED] = num_deleted
    data[models.Listing.PENDING_DELETION] = num_pending_deletion

    orgs = models.Agency.objects.all()
    for i in orgs:
        data['organizations'][str(i.id)] = queryset.filter(
            agency__id=i.id).count()

    data['_time'] = int(round(time.time() * 1000)) - start_time
    data['_db_calls'] = show_db_calls()
    return data
```

**`put_counts_in_listings_endpoint` function results**    
This function took 97 milliseconds and took 19 database calls
```
{
    "APPROVED_ORG": 0,
    "IN_PROGRESS": 0,
    "DELETED": 0,
    "PENDING": 0,
    "organizations": {
        "1": 2,
        "2": 1,
        "3": 0,
        "4": 0,
        "5": 0,
        "6": 0,
        "7": 0,
        "8": 0,
        "9": 0
    },
    "total": 3,
    "_time": 97,
    "enabled": 3,
    "PENDING_DELETION": 0,
    "REJECTED": 0,
    "_db_calls": 19,
    "APPROVED": 3
}
```

**`put_counts_in_listings_endpoint_new` function results**    
This function took 7 milliseconds and took 2 database calls
```
{
   "APPROVED_ORG": 0,
   "IN_PROGRESS": 0,
   "DELETED": 0,
   "PENDING": 0,
   "organizations": {
       "1": 2,
       "2": 1,
       "3": 0,
       "4": 0,
       "5": 0,
       "6": 0,
       "7": 0,
       "8": 0,
       "9": 0
   },
   "total": 3,
   "_time": 7,
   "enabled": 3,
   "PENDING_DELETION": 0,
   "REJECTED": 0,
   "_db_calls": 2,
   "APPROVED": 3
}
```

## Improving `put_counts_in_listings_endpoint` database example

**`_update_rating` original code**   
```
def _update_rating(username, listing):
    """
    Invoked each time a review is created, deleted, or updated
    """
    reviews = models.Review.objects.filter(listing=listing, review_parent__isnull=True)
    rate1 = reviews.filter(rate=1).count()
    rate2 = reviews.filter(rate=2).count()
    rate3 = reviews.filter(rate=3).count()
    rate4 = reviews.filter(rate=4).count()
    rate5 = reviews.filter(rate=5).count()
    total_votes = reviews.count()
    total_reviews = total_votes - reviews.filter(text=None).count()

    review_responses = models.Review.objects.filter(listing=listing, review_parent__isnull=False)
    total_review_responses = review_responses.count()

    # calculate weighted average
    if total_votes == 0:
        avg_rate = 0
    else:
        avg_rate = (5 * rate5 + 4 * rate4 + 3 * rate3 + 2 * rate2 + rate1) / total_votes
        avg_rate = float('{0:.1f}'.format(avg_rate))

    # update listing
    listing.total_rate1 = rate1
    listing.total_rate2 = rate2
    listing.total_rate3 = rate3
    listing.total_rate4 = rate4
    listing.total_rate5 = rate5
    listing.total_votes = total_votes
    listing.total_reviews = total_reviews
    listing.total_review_responses = total_review_responses
    listing.avg_rate = avg_rate
    listing.edited_date = utils.get_now_utc()
    listing.save()
    return listing
```

Code for benchmark (running user `make shell`)    
```
import time

def show_db_calls():
    db_connection = transaction.get_connection()
    number_of_calls = len(db_connection.queries)
    db_connection.queries_log.clear()
    return number_of_calls


show_db_calls()

start_time = int(round(time.time() * 1000))


from ozpcenter.api.listing.model_access import _update_rating
l = Listing.objects.all()
[_update_rating('bigbrother', la) for la in l]

print(int(round(time.time() * 1000)) - start_time)
print(show_db_calls())  # Not working
print('')

# 1434 Comment
# 3492 with counts()

```


**`_update_rating new code` function results**   

```
from django.db.models.expressions import RawSQL
l=Listing.objects.get(id=2);
Review.objects.filter(listing=l).values('rate').annotate(review_parent_isnull=RawSQL('"review_parent_id" is %s ', (None,)), rate_count=Count('rate'))


SQLITE3:
<QuerySet [{'rate_count': 1, 'rate': 1, 'review_parent_isnull': 0},
	{'rate_count': 1, 'rate': 1, 'review_parent_isnull': 1},
	{'rate_count': 1, 'rate': 3, 'review_parent_isnull': 1},
	{'rate_count': 1, 'rate': 4, 'review_parent_isnull': 1},
	{'rate_count': 1, 'rate': 5, 'review_parent_isnull': 1}]>

Postgresql
<QuerySet [{'rate': 3, 'rate_count': 1, 'review_parent_isnull': True},
           {'rate': 4, 'rate_count': 1, 'review_parent_isnull': True},
           {'rate': 1, 'rate_count': 1, 'review_parent_isnull': False},
           {'rate': 5, 'rate_count': 1, 'review_parent_isnull': True},
           {'rate': 1, 'rate_count': 1, 'review_parent_isnull': True}]>

```
SELECT "ozpcenter_review"."rate",
COUNT("ozpcenter_review"."rate") AS "rate_count",
("review_parent_id" is NULL ) AS "review_parent_isnull"
FROM "ozpcenter_review"
WHERE "ozpcenter_review"."listing_id" = 2
GROUP BY "ozpcenter_review"."rate", ("review_parent_id" is NULL )
```
