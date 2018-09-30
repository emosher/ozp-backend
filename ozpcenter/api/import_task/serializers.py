from rest_framework import serializers

from ozpcenter.models import ImportTask
from ozpcenter.models import ImportTaskResult


class ImportTaskSerializer(serializers.ModelSerializer):
    class Meta:
        model = ImportTask
        fields = '__all__'


class ImportTaskResultSerializer(serializers.ModelSerializer):
    class Meta:
        model = ImportTaskResult
        fields = '__all__'
