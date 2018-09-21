"""
Category Serializers
"""
import logging

from django.contrib import auth
from rest_framework import serializers

import ozpcenter.api.agency.serializers as agency_serializers

from ozpcenter import models
from plugins.plugin_manager import system_anonymize_identifiable_data
from plugins.plugin_manager import system_has_access_control
from plugins import plugin_manager


logger = logging.getLogger('ozp-center.' + str(__name__))


class CategorySerializer(serializers.ModelSerializer):

    class Meta:
        model = models.Category
        fields = '__all__'


class ListingCategorySerializer(serializers.ModelSerializer):

    class Meta:
        model = models.Category
        fields = ('title', 'description')

        extra_kwargs = {
            'title': {'validators': []}
        }


# TODO: Import from listing_serializers
class CreateListingUserSerializer(serializers.ModelSerializer):

    class Meta:
        model = auth.models.User
        fields = ('id', 'username',)

        extra_kwargs = {
            'username': {'validators': []}
        }

    def to_representation(self, data):
        access_control_instance = plugin_manager.get_system_access_control_plugin()
        ret = super(CreateListingUserSerializer, self).to_representation(data)

        # Used to anonymize usernames
        anonymize_identifiable_data = system_anonymize_identifiable_data(self.context['request'].user.username)

        check_request_self = False
        if self.context['request'].user.id == ret['id']:
            check_request_self = True

        del ret['id']

        if anonymize_identifiable_data and not check_request_self:
            ret['username'] = access_control_instance.anonymize_value('username')

        return ret


# TODO: Import from listing_serializers
class CreateListingProfileSerializer(serializers.ModelSerializer):
    user = CreateListingUserSerializer()

    class Meta:
        model = models.Profile
        fields = ('id', 'user', 'display_name')
        read_only = ('id', 'display_name')

    def to_representation(self, data):
        access_control_instance = plugin_manager.get_system_access_control_plugin()
        ret = super(CreateListingProfileSerializer, self).to_representation(data)

        # Used to anonymize usernames
        anonymize_identifiable_data = system_anonymize_identifiable_data(self.context['request'].user.username)

        check_request_self = False
        if self.context['request'].user.id == ret['id']:
            check_request_self = True

        if anonymize_identifiable_data and not check_request_self:
            ret['display_name'] = access_control_instance.anonymize_value('display_name')

        return ret


class CategoryListingSerializer(serializers.HyperlinkedModelSerializer):
    agency = agency_serializers.CreateAgencySerializer(required=False)
    categories = ListingCategorySerializer(many=True, required=False)
    owners = CreateListingProfileSerializer(required=False, many=True)

    class Meta:
        model = models.Listing
        fields = ('unique_name', 'title', 'id', 'agency', 'categories', 'owners')

        extra_kwargs = {
            'unique_name': {'validators': []},
            'title': {'validators': []},
            'agency': {'validators': []},
            'owners': {'validators': []}
        }

    def validate(self, data):
        print('Inside of validate')
        print(data)
        return data

    def create(self, validated_data):
        # print('Inside of create')
        # Listing
        return validated_data


class CreateCategoryListingSerializer(serializers.HyperlinkedModelSerializer):
    categories = ListingCategorySerializer(many=True, required=False)
    id = serializers.IntegerField()

    class Meta:
        model = models.Listing
        fields = ('id', 'categories')
        extra_kwargs = {
            'id': {'validators': []},
        }

    def validate(self, data):
        if 'id' in data:
            data['listing'] = models.Listing.objects.filter(id=data['id']).first()
            # get that listing
        else:
            data['listing'] = []

        if not data['listing']:
            raise serializers.ValidationError('Could not find listing')

        if 'categories' in data:
            category_list = []
            for category_data in data['categories']:
                if 'title' in category_data:
                    category_list.append(category_data['title'])
            data['categories'] = models.Category.objects.filter(title__in=category_list)

            if len(data['categories']) > 3:
                raise serializers.ValidationError('Can not add more than 3 categories for one listing')
            if not data['categories']:
                raise serializers.ValidationError('Could not find categories')
        else:
            data['categories'] = []

        return data

    def create(self, validated_data):
        listing_object = validated_data['listing']
        listing_object.categories.clear()

        for category_object in validated_data['categories']:
            print(category_object)
            listing_object.categories.add(category_object)

        return validated_data['listing']
