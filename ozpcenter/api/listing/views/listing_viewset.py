import logging
import operator

from django.db.models import Min
from django.db.models.functions import Lower
from django.shortcuts import get_object_or_404
from rest_framework import filters
from rest_framework import status
from rest_framework import viewsets
from rest_framework.response import Response

import ozpcenter.api.listing.model_access as model_access
import ozpcenter.api.listing.serializers as serializers
from ozpcenter import errors
from ozpcenter import permissions

logger = logging.getLogger('ozp-center.' + str(__name__))


class ListingViewSet(viewsets.ModelViewSet):
    """
    Get all listings this user can see

    Listing Types

    ModelViewSet for getting all Listings

    Access Control
    ===============
    - All users can view

    URIs
    ======
    GET /api/listing
    Summary:
        Get a list of all system-wide Listings
    Response:
        200 - Successful operation - [ListingSerializer]

    POST /api/listing/
    Summary:
        Add a Listing
    Request:
        data: ListingSerializer Schema
    Response:
        200 - Successful operation - ListingSerializer

    GET /api/listing/{pk}
    Summary:
        Find a Listing Entry by ID
    Response:
        200 - Successful operation - ListingSerializer

    PUT /api/listing/{pk}
    Summary:
        Update a Listing Entry by ID

    PATCH /api/listing/{pk}
    Summary:
        Update (Partial) a Listing Entry by ID

    DELETE /api/listing/{pk}
    Summary:
        Delete a Listing Entry by ID
    """

    permission_classes = (permissions.IsUser,)
    serializer_class = serializers.ListingSerializer
    filter_backends = (filters.SearchFilter, filters.OrderingFilter)
    search_fields = ('title', 'id', 'owners__display_name', 'agency__title', 'agency__short_name',)
    ordering_fields = ('id', 'agency__title', 'agency__short_name', 'is_enabled', 'is_featured',
                       'edited_date', 'security_marking', 'is_private', 'is_exportable', 'approval_status',
                       'approved_date',
                       'avg_rate', 'total_votes')
    case_insensitive_ordering_fields = ('title',)
    ordering = ('is_deleted', '-edited_date')

    def get_queryset(self):
        approval_status = self.request.query_params.get('approval_status', None)
        # org = self.request.query_params.get('org', None)
        orgs = self.request.query_params.getlist('org', False)
        enabled = self.request.query_params.get('enabled', None)
        ordering = self.request.query_params.get('ordering', None)
        owners_id = self.request.query_params.get('owners_id', None)
        if enabled:
            enabled = enabled.lower()
            if enabled in ['true', '1']:
                enabled = True
            else:
                enabled = False
        if ordering:
            ordering = [s.strip() for s in ordering.split(',')]
        else:
            # always default to last modified for consistency
            ordering = ['-edited_date']

        listings = model_access.get_listings(self.request.user.username)
        if owners_id:
            listings = listings.filter(owners__id=owners_id)
        if approval_status:
            listings = listings.filter(approval_status=approval_status)
        if orgs:
            listings = listings.filter(agency__short_name__in=orgs)
        if enabled is not None:
            listings = listings.filter(is_enabled=enabled)
        # have to handle this case manually because the ordering includes an app multiple times
        # if there are multiple owners. We instead do sorting by case insensitive compare of the
        # app owner that comes first alphabetically
        param = [s for s in ordering if 'owners__display_name' == s or '-owners__display_name' == s]
        if ordering is not None and param:
            orderby = 'min'
            if param[0].startswith('-'):
                orderby = '-min'
            listings = listings.annotate(min=Min(Lower('owners__display_name'))).order_by(orderby)
            self.ordering = None

        # Django REST filters are canse sensitive by default, so we handle case_insensitive fields
        # manually.  May want to abstract this functionality in an OrderingFilter sub-class
        case_insensitive_ordering = [s for s in ordering if s in self.case_insensitive_ordering_fields or
                                     s.startswith('-') and s[1:] in self.case_insensitive_ordering_fields]
        if ordering is not None and case_insensitive_ordering:
            for field in case_insensitive_ordering:
                if field.startswith('-'):
                    listings = listings.order_by(Lower(field[1:])).reverse()
                else:
                    listings = listings.order_by(Lower(field))
            self.ordering = None

        return listings

    def list(self, request):
        queryset = serializers.ListingSerializer.setup_eager_loading(self.get_queryset())
        queryset = self.filter_queryset(queryset)
        counts_data = model_access.put_counts_in_listings_endpoint(queryset)
        # it appears that because we override the queryset here, we must
        # manually invoke the pagination methods
        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = serializers.ListingSerializer(page,
                                                       context={'request': request}, many=True)
            r = self.get_paginated_response(serializer.data)
            # add counts to response
            r.data['counts'] = counts_data
            return r

        serializer = serializers.ListingSerializer(queryset,
                                                   context={'request': request}, many=True)
        r = Response(serializer.data)
        # add counts to response
        counts = {'counts': counts_data}
        r.data.append(counts)
        return r

    def create(self, request):
        """
        Save a new Listing - only title is required

        Sample Payload:
        {
           "title":"My Test App",
           "description":"This is the full description of my app",
           "descriptionShort":"short app description",
           "contacts":[
              {
                 "type":"Technical Support",
                 "name":"Tech Support Contact",
                 "organization":"ABC Inc",
                 "email":"tsc@gmail.com",
                 "securePhone":"555-555-5555",
                 "unsecurePhone":"111-222-3454"
              }
           ],
           "tags":[
              "tag1",
              "tag2"
           ],
           "type":"Web Application",
           "usage_requirements":"None",
           "system_requirements":"None",
           "versionName":"1.0.0",
           "launchUrl":"http://www.google.com/myApp",
           "whatIsNew":"Nothing is new",
           "owners":[
              {
                 "username":"alan"
              }
           ],
           "agency":"Test Organization",
           "categories":[
              "Entertainment",
              "Media and Video"
           ],
           "intents":[
              "application/json/edit",
              "application/json/view"
           ],
           "docUrls":[
              {
                 "name":"wiki",
                 "url":"http://www.wikipedia.com/myApp"
              }
           ],
           "smallIconId":"b0b54993-0668-4419-98e8-787e4c3a2dc2",
           "largeIconId":"e94128ab-d32d-4241-8820-bd2c69a64a87",
           "bannerIconId":"ecf79771-79a0-4884-a36d-5820c79c6d72",
           "featuredBannerIconId":"c3e6a369-4773-485e-b369-5cebaa331b69",
           "changeLogs":[

           ],
           "screenshots":[
              {
                 "smallImageId":"0b8db892-b669-4e86-af23-d899cb4d4d91",
                 "largeImageId":"80957d25-f34b-48bc-b860-b353cfd9e101"
              }
           ]
        }

        ---
        parameters:
            - name: body
              required: true
              paramType: body
        parameters_strategy:
            form: replace
            query: replace
        omit_serializer: true
        """
        # logger.debug('inside ListingViewSet.create', extra={'request': request})
        serializer = serializers.ListingSerializer(data=request.data,
                                                   context={'request': request}, partial=True)

        if not serializer.is_valid():
            logger.error('{0!s}'.format(serializer.errors), extra={'request': request})
            raise errors.ValidationException('{0}'.format(serializer.errors))

        serializer.save()

        return Response(serializer.data, status=status.HTTP_201_CREATED)

    def retrieve(self, request, pk=None):
        """
        Get a Listing by id
        """
        queryset = self.get_queryset().get(pk=pk)
        serializer = serializers.ListingSerializer(queryset,
                                                   context={'request': request})
        # TODO: Refactor in future to use django ordering (mlee)
        temp = serializer.data.get('screenshots')
        temp.sort(key=operator.itemgetter('order'))
        return Response(serializer.data)

    def destroy(self, request, pk=None):
        """
        Delete a listing
        """
        queryset = self.get_queryset()
        listing = get_object_or_404(queryset, pk=pk)
        description = request.data['description'] if 'description' in request.data else None
        if not description:
            raise errors.InvalidInput('Description is required when deleting a listing')

        model_access.delete_listing(request.user.username, listing, description)
        return Response(status=status.HTTP_204_NO_CONTENT)

    def update(self, request, pk=None):
        """
        Update a Listing

        Sample payload:

        {
           "id":45,
           "title":"My Test App",
           "description":"This is the full description of my app",
           "descriptionShort":"short app description",
           "contacts":[
              {
                 "securePhone":"555-555-5555",
                 "unsecurePhone":"111-222-3454",
                 "email":"tsc@gmail.com",
                 "organization":"ABC Inc",
                 "name":"Tech Support Contact",
                 "type":"Technical Support"
              }
           ],
           "totalReviews":0,
           "avgRate":0,
           "totalRate1":0,
           "totalRate2":0,
           "totalRate3":0,
           "totalRate4":0,
           "height":null,
           "width":null,
           "totalRate5":0,
           "totalVotes":0,
           "tags":[
              "tag2",
              "tag1"
           ],
           "type":"Web Application",
           "uuid":"e378c427-bba6-470c-b2f3-e550b9129504",
           "usage_requirements":"None",
           "system_requirements":"None",
           "iframe_compatible":false,
           "versionName":"1.0.0",
           "launchUrl":"http://www.google.com/myApp",
           "whatIsNew":"Nothing is new",
           "owners":[
              {
                 "displayName":"kevink",
                 "username":"kevink",
                 "id":5
              }
           ],
           "agency":"Test Organization",
           "agencyShort":"TO",
           "currentRejection":null,
           "isEnabled":true,
           "categories":[
              "Media and Video",
              "Entertainment"
           ],
           "editedDate":"2015-08-12T10:53:47.036+0000",
           "intents":[
              "application/json/edit",
              "application/json/view"
           ],
           "docUrls":[
              {
                 "url":"http://www.wikipedia.com/myApp",
                 "name":"wiki"
              }
           ],
           "approvalStatus":"IN_PROGRESS",
           "isFeatured":false,
           "smallIconId":"b0b54993-0668-4419-98e8-787e4c3a2dc2",
           "largeIconId":"e94128ab-d32d-4241-8820-bd2c69a64a87",
           "bannerIconId":"ecf79771-79a0-4884-a36d-5820c79c6d72",
           "featuredBannerIconId":"c3e6a369-4773-485e-b369-5cebaa331b69",
           "changeLogs":[

           ],
           "screenshots":[
              {
                 "largeImageId":"80957d25-f34b-48bc-b860-b353cfd9e101",
                 "smallImageId":"0b8db892-b669-4e86-af23-d899cb4d4d91"
              }
           ]
        }
        """
        # logger.debug('inside ListingViewSet.update', extra={'request': request})
        instance = self.get_queryset().get(pk=pk)
        serializer = serializers.ListingSerializer(instance, data=request.data, context={'request': request},
                                                   partial=True)

        # logger.debug('created ListingSerializer', extra={'request': request})

        if not serializer.is_valid():
            logger.error('{0!s}'.format(serializer.errors), extra={'request': request})
            raise errors.ValidationException('{0}'.format(serializer.errors))

        serializer.save()
        return Response(serializer.data, status=status.HTTP_200_OK)

    def partial_update(self, request, pk=None):
        """
        TODO: Probably don't use this (PATCH)
        """
        pass
