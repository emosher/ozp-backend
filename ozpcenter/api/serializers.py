from rest_framework import serializers

from ozpcenter import models


class CustomFieldTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.CustomFieldType
        fields = (
            'id',
            'name',
            'display_name',
            'media_type',
            'options'
        )


class CustomFieldSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.CustomField
        fields = (
            'id',
            'type',
            'section',
            'display_name',
            'label',
            'description',
            'tooltip',
            'is_required',
            'admin_only',
            'properties',
            'all_listing_types'
        )

    type = CustomFieldTypeSerializer(required=True)


class CustomFieldValueSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.CustomFieldValue
        fields = (
            'id',
            'custom_field',
            'value'
        )


class ListingTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.ListingType
        fields = (
            'id',
            'title',
            'description',
            'custom_fields'
        )

    custom_fields = CustomFieldSerializer(many=True,
                                          required=False,
                                          allow_empty=True)
