"""
Contact Types Serializers
"""
import logging

from rest_framework import serializers

from ozpcenter import models
from plugins import plugin_manager
from plugins.plugin_manager import system_has_access_control
from plugins.plugin_manager import system_anonymize_identifiable_data


logger = logging.getLogger('ozp-center.' + str(__name__))


class ContactTypeSerializer(serializers.ModelSerializer):
    # TODO: anonymize_identifiable_data name
    class Meta:
        model = models.ContactType
        fields = '__all__'


class ListingContactTypeSerializer(serializers.ModelSerializer):

    class Meta:
        model = models.ContactType
        fields = ('name',)

        extra_kwargs = {
            'name': {'validators': []}
        }

    def to_representation(self, data):
        access_control_instance = plugin_manager.get_system_access_control_plugin()
        ret = super(ListingContactTypeSerializer, self).to_representation(data)

        # Used to anonymize usernames
        anonymize_identifiable_data = system_anonymize_identifiable_data(self.context['request'].user.username)

        if anonymize_identifiable_data:
            ret['name'] = access_control_instance.anonymize_value('contact_type_name')

        return ret


class ContactSerializer(serializers.ModelSerializer):
    contact_type = ListingContactTypeSerializer()

    class Meta:
        model = models.Contact
        fields = '__all__'

    def to_representation(self, data):
        access_control_instance = plugin_manager.get_system_access_control_plugin()
        ret = super(ContactSerializer, self).to_representation(data)

        # Used to anonymize usernames
        anonymize_identifiable_data = system_anonymize_identifiable_data(self.context['request'].user.username)

        if anonymize_identifiable_data:
            ret['secure_phone'] = access_control_instance.anonymize_value('secure_phone')
            ret['unsecure_phone'] = access_control_instance.anonymize_value('unsecure_phone')
            ret['secure_phone'] = access_control_instance.anonymize_value('secure_phone')
            ret['name'] = access_control_instance.anonymize_value('name')
            ret['organization'] = access_control_instance.anonymize_value('organization')
            ret['email'] = access_control_instance.anonymize_value('email')
        return ret
