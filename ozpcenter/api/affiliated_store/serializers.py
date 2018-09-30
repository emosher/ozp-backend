from rest_framework import serializers

import ozpcenter.api.image.serializers as image_serializers
from ozpcenter.models import AffiliatedStore


class AffiliatedStoreSerializer(serializers.ModelSerializer):
    class Meta:
        model = AffiliatedStore
        fields = ('id', 'title', 'server_url', 'icon', 'is_enabled')

    icon = image_serializers.ImageSerializer()


class AffiliatedStorePOSTSerializer(serializers.ModelSerializer):
    class Meta:
        model = AffiliatedStore
        fields = ('id', 'title', 'server_url', 'icon', 'is_enabled')


class AffiliatedStoreReferenceSerializer(serializers.ModelSerializer):
    class Meta:
        model = AffiliatedStore
        fields = ('id', 'title')
