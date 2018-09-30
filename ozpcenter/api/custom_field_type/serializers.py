from rest_framework import serializers

from ozpcenter.models import CustomFieldType


class CustomFieldTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomFieldType
        fields = '__all__'
