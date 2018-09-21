"""
Agency Serializers
"""
import logging

from rest_framework import serializers

from ozpcenter import models


logger = logging.getLogger('ozp-center.' + str(__name__))


class AgencySerializer(serializers.ModelSerializer):

    class Meta:
        model = models.Agency
        depth = 2
        fields = ('title', 'short_name', 'id')


class CreateAgencySerializer(serializers.ModelSerializer):

    class Meta:
        model = models.Agency
        depth = 2
        fields = ('title', 'short_name')

        extra_kwargs = {
            'title': {'validators': []},
            'short_name': {'validators': []}
        }


class MinimalAgencySerializer(serializers.ModelSerializer):

    class Meta:
        model = models.Agency
        fields = ('short_name',)
