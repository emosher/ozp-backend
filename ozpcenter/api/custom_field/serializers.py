from rest_framework import serializers

import ozpcenter.api.custom_field_type.serializers as custom_field_type_serializers
from ozpcenter.models import CustomField


class CustomFieldSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomField
        fields = '__all__'

    type = custom_field_type_serializers.CustomFieldTypeSerializer()


class CustomFieldPOSTSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomField
        fields = '__all__'
