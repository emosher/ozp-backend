"""
Storefront Serializers
"""
import logging

from rest_framework import serializers

from ozpcenter import models
import ozpcenter.model_access as generic_model_access
import ozpcenter.api.agency.serializers as agency_serializers
import ozpcenter.api.listing.serializers as listing_serializers
import ozpcenter.api.image.serializers as image_serializers


logger = logging.getLogger('ozp-center.' + str(__name__))


class StorefrontListingSerializer(serializers.HyperlinkedModelSerializer):
    agency = agency_serializers.CreateAgencySerializer(required=False)
    large_banner_icon = image_serializers.ImageSerializer(required=False, allow_null=True)
    banner_icon = image_serializers.ImageSerializer(required=False, allow_null=True)

    class Meta:
        model = models.Listing
        fields = ('id',
                  'title',
                  'agency',
                  'avg_rate',
                  'total_reviews',
                  'feedback_score',
                  'is_private',
                  'is_bookmarked',
                  'feedback',
                  'description_short',
                  'security_marking',
                  'usage_requirements',
                  'system_requirements',
                  'launch_url',
                  'large_banner_icon',
                  'banner_icon',
                  'unique_name',
                  'is_enabled')

    def _is_bookmarked(self, request_user, request_listing):
        # TODO: put in listing model_access.py call from there > creative name for method
        bookmarks = models.ApplicationLibraryEntry.objects.filter(listing=request_listing, owner=request_user)
        return len(bookmarks) >= 1

    def _feedback(self, request_user, request_listing):
        # TODO: put in listing model_access.py call from there > creative name for method
        recommendation = models.RecommendationFeedback.objects.for_user(request_user).filter(target_profile=request_user, target_listing=request_listing).first()

        if recommendation is None:
            return 0

        return recommendation.feedback

    def to_representation(self, data):
        ret = super(StorefrontListingSerializer, self).to_representation(data)
        request_user = generic_model_access.get_profile(self.context['request'].user)  # TODO: Get the profile from view request instead of getting it from db again

        ret['feedback'] = self._feedback(request_user, data)
        ret['is_bookmarked'] = self._is_bookmarked(request_user, data)
        return ret


class StorefrontSerializer(serializers.Serializer):
    recommended = StorefrontListingSerializer(many=True)
    featured = StorefrontListingSerializer(many=True)
    recent = StorefrontListingSerializer(many=True)
    most_popular = StorefrontListingSerializer(many=True)
