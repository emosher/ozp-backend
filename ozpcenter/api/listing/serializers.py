"""
Listing Serializers
"""
import datetime
import logging

import pytz
from django.contrib import auth
from django.core.exceptions import ValidationError
from rest_framework import serializers

import ozpcenter.api.agency.model_access as agency_model_access
import ozpcenter.api.agency.serializers as agency_serializers
import ozpcenter.api.category.model_access as category_model_access
import ozpcenter.api.category.serializers as category_serializers
import ozpcenter.api.contact_type.model_access as contact_type_model_access
import ozpcenter.api.contact_type.serializers as contact_type_serializers
import ozpcenter.api.image.model_access as image_model_access
import ozpcenter.api.image.serializers as image_serializers
import ozpcenter.api.intent.model_access as intent_model_access
import ozpcenter.api.intent.serializers as intent_serializers
import ozpcenter.api.listing.model_access as model_access
import ozpcenter.api.profile.serializers as profile_serializers
import ozpcenter.model_access as generic_model_access
from ozpcenter import constants
from ozpcenter import errors
from ozpcenter import models
from ozpcenter.api.serializers import CustomFieldSerializer
from ozpcenter.api.serializers import CustomFieldValueSerializer
from ozpcenter.pubsub import dispatcher
from plugins import plugin_manager
from plugins.plugin_manager import system_anonymize_identifiable_data
from plugins.plugin_manager import system_has_access_control

logger = logging.getLogger('ozp-center.' + str(__name__))


class ListingTypeSerializer(serializers.ModelSerializer):
    custom_fields = CustomFieldSerializer(read_only=True, many=True)

    class Meta:
        model = models.ListingType
        fields = ('id', 'title', 'description', 'custom_fields')

        extra_kwargs = {
            'title': {'validators': []}
        }


class ListingTypePOSTSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.ListingType
        fields = ('id', 'title', 'description', 'custom_fields')

        extra_kwargs = {
            'title': {'validators': []}
        }


class DocUrlSerializer(serializers.ModelSerializer):

    class Meta:
        model = models.DocUrl
        fields = ('name', 'url')


class ScreenshotSerializer(serializers.ModelSerializer):
    small_image = image_serializers.ImageSerializer()
    large_image = image_serializers.ImageSerializer()

    class Meta:
        model = models.Screenshot
        fields = ('order', 'small_image', 'large_image', 'description')

        extra_kwargs = {
            'description': {'validators': []}
        }


class TagSerializer(serializers.ModelSerializer):

    class Meta:
        model = models.Tag
        fields = ('id', 'name',)

        extra_kwargs = {
            'name': {'validators': []}
        }


class ChangeDetailSerializer(serializers.ModelSerializer):

    class Meta:
        model = models.ChangeDetail
        fields = '__all__'


class ShortListingSerializer(serializers.HyperlinkedModelSerializer):
    agency = agency_serializers.CreateAgencySerializer(required=False)

    class Meta:
        model = models.Listing
        fields = ('unique_name', 'title', 'id', 'agency', 'small_icon', 'is_deleted')


class ListingActivitySerializer(serializers.ModelSerializer):
    author = profile_serializers.ShortProfileSerializer()
    listing = ShortListingSerializer()
    change_details = ChangeDetailSerializer(many=True)

    class Meta:
        model = models.ListingActivity
        fields = ('action', 'activity_date', 'description', 'author', 'listing',
            'change_details')


class RejectionListingActivitySerializer(serializers.ModelSerializer):
    author = profile_serializers.ShortProfileSerializer()

    class Meta:
        model = models.ListingActivity
        fields = ('action', 'activity_date', 'description', 'author')


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


def validate_listing(serializer_instance, data):
    # TODO Put in listing model_access.py
    access_control_instance = plugin_manager.get_system_access_control_plugin()
    profile = generic_model_access.get_profile(serializer_instance.context['request'].user.username)

    # This checks to see if value exist as a key and value is not None
    if not data.get('title'):
        raise serializers.ValidationError('Title is required')

    if 'security_marking' not in data:
        raise serializers.ValidationError('Security Marking is Required')

    # Assign a default security_marking level if none is provided
    if not data.get('security_marking'):
        data['security_marking'] = constants.DEFAULT_SECURITY_MARKING

    if not access_control_instance.validate_marking(data['security_marking']):
        raise serializers.ValidationError('Security Marking Format is Invalid')

    # Don't allow user to select a security marking that is above
    # their own access level
    if not system_has_access_control(profile.user.username, data.get('security_marking')):
        raise serializers.ValidationError('Security marking too high for current user')

    # Don't allow 2nd-party user to be an submit/edit a listing
    if system_anonymize_identifiable_data(profile.user.username):
        raise serializers.ValidationError('Permissions are invalid for current profile')

    # TODO: errors.PermissionDenied instead of serializers.ValidationError

    data['description'] = data.get('description')
    data['launch_url'] = data.get('launch_url')
    data['version_name'] = data.get('version_name')
    data['unique_name'] = data.get('unique_name')
    data['what_is_new'] = data.get('what_is_new')
    data['description_short'] = data.get('description_short')
    data['usage_requirements'] = data.get('usage_requirements')
    data['system_requirements'] = data.get('system_requirements')
    data['is_private'] = data.get('is_private', False)
    data['is_exportable'] = data.get('is_exportable', False)
    data['security_marking'] = data.get('security_marking')

    # only checked on update, not create
    data['is_enabled'] = data.get('is_enabled', False)
    data['is_508_compliant'] = data.get('is_508_compliant', False)
    data['is_featured'] = data.get('is_featured', False)
    data['approval_status'] = data.get('approval_status')

    # Agency
    agency_title = None if data.get('agency') is None else data.get('agency', {}).get('title')
    if agency_title:
        data['agency'] = agency_model_access.get_agency_by_title(agency_title)
        if data['agency'] is None:
            raise serializers.ValidationError('Invalid Agency')
    else:
        data['agency'] = profile.organizations.all()[0]

    # Listing Type
    type_title = None if data.get('listing_type') is None else data.get('listing_type', {}).get('title')
    if type_title:
        data['listing_type'] = model_access.get_listing_type_by_title(type_title)
    else:
        data['listing_type'] = None

    # Images
    image_keys = ['small_icon', 'large_icon', 'banner_icon', 'large_banner_icon']

    for image_key in image_keys:
        current_image_value = data.get(image_key)
        if current_image_value:
            if 'id' not in current_image_value:
                raise serializers.ValidationError('Image({!s}) requires a {!s}'.format(image_key, 'id'))
            if current_image_value.get('security_marking') is None:
                current_image_value['security_marking'] = constants.DEFAULT_SECURITY_MARKING
            if not access_control_instance.validate_marking(current_image_value['security_marking']):
                raise errors.InvalidInput('{!s} Security Marking is invalid'.format(image_key))
        else:
            data[image_key] = None

    # Screenshot
    screenshots = data.get('screenshots')
    if screenshots is not None:
        screenshots_out = []
        image_require_fields = ['id']
        for screenshot_set in screenshots:

            if ('small_image' not in screenshot_set or
                    'large_image' not in screenshot_set):
                raise serializers.ValidationError(
                    'Screenshot Set requires {0!s} fields'.format('small_image, large_icon'))
            screenshot_small_image = screenshot_set.get('small_image')
            screenshot_large_image = screenshot_set.get('large_image')

            for field in image_require_fields:
                if field not in screenshot_small_image:
                    raise serializers.ValidationError('Screenshot Small Image requires a {0!s}'.format(field))

            for field in image_require_fields:
                if field not in screenshot_large_image:
                    raise serializers.ValidationError('Screenshot Large Image requires a {0!s}'.format(field))

            if not screenshot_small_image.get('security_marking'):
                screenshot_small_image['security_marking'] = constants.DEFAULT_SECURITY_MARKING
            if not access_control_instance.validate_marking(screenshot_small_image['security_marking']):
                raise errors.InvalidInput('Security Marking is invalid')

            if not screenshot_large_image.get('security_marking'):
                screenshot_large_image['security_marking'] = constants.DEFAULT_SECURITY_MARKING
            if not access_control_instance.validate_marking(screenshot_large_image['security_marking']):
                raise errors.InvalidInput('Security Marking is invalid')

            screenshots_out.append(screenshot_set)
            data['screenshots'] = screenshots_out
    else:
        data['screenshots'] = None

    # Contacts
    if 'contacts' in data:
        for contact in data['contacts']:
            if 'name' not in contact:
                raise serializers.ValidationError('Contact requires [name] field')
            if 'email' not in contact:
                raise serializers.ValidationError('Contact requires [email] field')
            if 'secure_phone' not in contact:
                contact['secure_phone'] = None
            if 'unsecure_phone' not in contact:
                contact['unsecure_phone'] = None
            if 'contact_type' not in contact:
                raise serializers.ValidationError('Contact requires [contact_type] field')

            contact_type = contact.get('contact_type')
            contact_type_name = None if contact_type is None else contact_type.get('name')

            if not contact_type_name:
                raise serializers.ValidationError('Contact field requires correct format')

            contact_type_instance = contact_type_model_access.get_contact_type_by_name(contact_type_name)
            if not contact_type_instance:
                raise serializers.ValidationError('Contact Type [{}] not found'.format(contact_type_name))

    # owners
    owners = []
    if 'owners' in data:
        for owner in data['owners']:
            user_dict = owner.get('user')
            user_username = None if user_dict is None else user_dict.get('username')

            if not user_username:
                raise serializers.ValidationError('Owner field requires correct format')

            owner_profile = generic_model_access.get_profile(user_username)
            if not owner_profile:
                raise serializers.ValidationError('Owner Profile not found')

            # Don't allow user to select a security marking that is above
            # their own access level
            if not system_has_access_control(owner_profile.user.username, data.get('security_marking')):
                raise serializers.ValidationError('Security marking too high for current owner profile')

            # Don't allow 2nd-party user to be an owner of a listing
            if system_anonymize_identifiable_data(owner_profile.user.username):
                raise serializers.ValidationError('Permissions are invalid for current owner profile')

            owners.append(owner_profile)
    data['owners'] = owners

    # Categories
    categories = []
    if 'categories' in data:
        for category in data['categories']:
            category_title = category.get('title')
            if not category_title:
                raise serializers.ValidationError('Categories field requires correct format')

            category_instance = category_model_access.get_category_by_title(category_title)
            if not category_instance:
                raise serializers.ValidationError('Category [{}] not found'.format(category_title))

            categories.append(category_instance)
    data['categories'] = categories

    # Intents
    intents = []
    if 'intents' in data:
        for intent in data['intents']:
            intent_action = intent.get('action')
            if not intent_action:
                raise serializers.ValidationError('Intent field requires correct format')

            intent_instance = intent_model_access.get_intent_by_action(intent_action)
            if not intent_instance:
                raise serializers.ValidationError('Intent Action [{}] not found'.format(intent_action))

            intents.append(intent_instance)
    data['intents'] = intents

    # doc urls will be created in create()
    if 'doc_urls' in data:
        pass

    # tags will be created (if necessary) in create()
    if 'tags' in data:
        pass

    return data


def create_listing(serializer_instance, validated_data):
    # TODO Put in listing model_access.py
    user = serializer_instance.context['request'].user
    profile = generic_model_access.get_profile(user.username)

    title = validated_data['title']

    logger.info('creating listing {0!s} for user {1!s}'.format(title,
        user.username), extra={'request': serializer_instance.context.get('request')})

    # TODO required_listings
    listing = models.Listing(title=title,
        agency=validated_data['agency'],
        description=validated_data['description'],
        launch_url=validated_data['launch_url'],
        version_name=validated_data['version_name'],
        unique_name=validated_data['unique_name'],
        what_is_new=validated_data['what_is_new'],
        description_short=validated_data['description_short'],
        usage_requirements=validated_data['usage_requirements'],
        system_requirements=validated_data['system_requirements'],
        security_marking=validated_data['security_marking'],
        listing_type=validated_data['listing_type'],
        is_private=validated_data['is_private'],
        is_508_compliant=validated_data['is_508_compliant'])

    image_keys = ['small_icon', 'large_icon', 'banner_icon', 'large_banner_icon']
    for image_key in image_keys:
        if validated_data[image_key]:
            new_value_image = image_model_access.get_image_by_id(validated_data[image_key].get('id'))

            if new_value_image is None:
                raise errors.InvalidInput('Error while saving, can not find image by id')
            if image_key == 'small_icon':
                listing.small_icon = new_value_image
            elif image_key == 'large_icon':
                listing.large_icon = new_value_image
            elif image_key == 'banner_icon':
                listing.banner_icon = new_value_image
            elif image_key == 'large_banner_icon':
                listing.large_banner_icon = new_value_image

    listing.save()

    if validated_data.get('contacts') is not None:
        for contact in validated_data['contacts']:
            contact_type_instance = contact_type_model_access.get_contact_type_by_name(contact['contact_type']['name'])
            new_contact, created = models.Contact.objects.get_or_create(name=contact['name'],
                email=contact['email'],
                secure_phone=contact['secure_phone'],
                unsecure_phone=contact['unsecure_phone'],
                organization=contact.get('organization', None),
                contact_type=contact_type_instance)
            new_contact.save()
            listing.contacts.add(new_contact)

    if validated_data.get('owners') is not None:
        if validated_data['owners']:
            for owner in validated_data['owners']:
                listing.owners.add(owner)
        else:
            # if no owners are specified, just add the current user
            listing.owners.add(profile)

    if validated_data.get('categories') is not None:
        for category in validated_data['categories']:
            listing.categories.add(category)

    # tags will be automatically created if necessary
    if validated_data.get('tags') is not None:
        for tag in validated_data['tags']:
            obj, created = models.Tag.objects.get_or_create(
                name=tag['name'])
            listing.tags.add(obj)

    if validated_data.get('intents') is not None:
        for intent in validated_data['intents']:
            listing.intents.add(intent)

    # doc_urls will be automatically created
    if validated_data.get('doc_urls') is not None:
        for d in validated_data['doc_urls']:
            doc_url = models.DocUrl(name=d['name'], url=d['url'], listing=listing)
            doc_url.save()

    # screenshots will be automatically created
    if validated_data.get('screenshots') is not None:
        for screenshot_dict in validated_data['screenshots']:
            screenshot = models.Screenshot(
                order=screenshot_dict.get('order'),
                small_image=image_model_access.get_image_by_id(screenshot_dict['small_image']['id']),
                large_image=image_model_access.get_image_by_id(screenshot_dict['large_image']['id']),
                description=screenshot_dict.get('description'),
                listing=listing)
            screenshot.save()

    if 'custom_fields' in validated_data:
        for field_value_dict in validated_data['custom_fields']:
            field_id = field_value_dict['custom_field'].id
            field = models.CustomField.objects.find_by_id(id=field_id)
            value = field_value_dict['value']

            field_value = models.CustomFieldValue(listing=listing,
                                                  custom_field=field,
                                                  value=value)
            field_value.save()

            listing.custom_fields.add(field_value)

    # create a new activity
    model_access.create_listing(profile, listing)

    dispatcher.publish('listing_created', listing=listing, profile=profile)
    return listing


def update_listing(serializer_instance, instance, validated_data):
    # TODO Put in listing model_access.py
    user = serializer_instance.context['request'].user
    profile = generic_model_access.get_profile(user.username)

    if profile.highest_role() not in ['APPS_MALL_STEWARD', 'ORG_STEWARD']:
        if profile not in instance.owners.all():
            raise errors.PermissionDenied(
                'User ({0!s}) is not an owner of this listing'.format(user.username))

    if instance.is_deleted:
        raise errors.PermissionDenied('Cannot update a previously deleted listing')

    change_details = []

    simple_fields = ['title', 'description', 'description_short',
        'launch_url', 'version_name', 'usage_requirements', 'system_requirements', 'unique_name',
        'what_is_new', 'security_marking']

    for i in simple_fields:
        if getattr(instance, i) != validated_data[i]:
            change_details.append({'old_value': getattr(instance, i),
                'new_value': validated_data[i], 'field_name': i})
            setattr(instance, i, validated_data[i])

    if validated_data['is_enabled'] != instance.is_enabled:
        if validated_data['is_enabled']:
            model_access.enable_listing(profile, instance)
        else:
            model_access.disable_listing(profile, instance)

        instance.is_enabled = validated_data['is_enabled']

        if validated_data['approval_status'] == models.Listing.APPROVED:
            dispatcher.publish('listing_enabled_status_changed',
                               listing=instance,
                               profile=profile,
                               is_enabled=validated_data['is_enabled'])

    if validated_data['is_508_compliant'] != instance.is_508_compliant:
        changeset = {'old_value': model_access.bool_to_string(instance.is_508_compliant),
                'new_value': model_access.bool_to_string(validated_data['is_508_compliant']), 'field_name': 'is_508_compliant'}
        change_details.append(changeset)
        instance.is_508_compliant = validated_data['is_508_compliant']

    if validated_data['is_private'] != instance.is_private:
        changeset = {'old_value': model_access.bool_to_string(instance.is_private),
                'new_value': model_access.bool_to_string(validated_data['is_private']), 'field_name': 'is_private'}
        change_details.append(changeset)
        instance.is_private = validated_data['is_private']

        if validated_data['approval_status'] == models.Listing.APPROVED:
            dispatcher.publish('listing_private_status_changed',
                               listing=instance,
                               profile=profile,
                               is_private=validated_data['is_private'])

    if validated_data['is_featured'] != instance.is_featured:
        if profile.highest_role() not in ['APPS_MALL_STEWARD', 'ORG_STEWARD']:
            raise errors.PermissionDenied('Only stewards can change is_featured setting of a listing')

        change_details.append({'old_value': model_access.bool_to_string(instance.is_featured),
                'new_value': model_access.bool_to_string(validated_data['is_featured']), 'field_name': 'is_featured'})
        instance.is_featured = validated_data['is_featured']
        instance.featured_date = datetime.datetime.now(pytz.utc) if validated_data['is_featured'] else None

    if validated_data['is_exportable'] != instance.is_exportable:
        if profile.highest_role() not in ['APPS_MALL_STEWARD', 'ORG_STEWARD']:
            raise errors.PermissionDenied('Only stewards can change is_exportable setting of a listing')
            
        change_details.append({'old_value': model_access.bool_to_string(instance.is_exportable),
                'new_value': model_access.bool_to_string(validated_data['is_exportable']), 'field_name': 'is_exportable'})
        instance.is_exportable = validated_data['is_exportable']

    s = validated_data['approval_status']
    if s and s != instance.approval_status:  # Check to see if approval_status has changed
        old_approval_status = instance.approval_status
        if s == models.Listing.APPROVED and profile.highest_role() != 'APPS_MALL_STEWARD':
            raise errors.PermissionDenied('Only an APPS_MALL_STEWARD can mark a listing as APPROVED')
        if s == models.Listing.APPROVED_ORG and profile.highest_role() not in ['APPS_MALL_STEWARD', 'ORG_STEWARD']:
            raise errors.PermissionDenied('Only stewards can mark a listing as APPROVED_ORG')
        if s == models.Listing.PENDING:
            model_access.submit_listing(profile, instance)
        if s == models.Listing.PENDING_DELETION:
            # pending deletion should be handled through ListingPendingDeletionViewSet
            # keeping this here for now for backwards compatibility
            model_access.pending_delete_listing(profile, instance, 'Unknown reason')
        if s == models.Listing.APPROVED_ORG:
            model_access.approve_listing_by_org_steward(profile, instance)
        if s == models.Listing.APPROVED:
            model_access.approve_listing(profile, instance)
        if s == models.Listing.REJECTED:
            # TODO: need to get the rejection text from somewhere
            model_access.reject_listing(profile, instance, 'TODO: rejection reason')

        dispatcher.publish('listing_approval_status_changed',
                           listing=instance,
                           profile=profile,
                           old_approval_status=old_approval_status,
                           new_approval_status=instance.approval_status)

    if instance.listing_type != validated_data['listing_type']:
        if instance.listing_type:
            old_value = instance.listing_type.title
        else:
            old_value = None
        if validated_data['listing_type']:
            new_value = validated_data['listing_type'].title
        else:
            new_value = None
        change_details.append({'old_value': old_value,
                'new_value': new_value, 'field_name': 'listing_type'})
        instance.listing_type = validated_data['listing_type']

    image_keys = ['small_icon', 'large_icon', 'banner_icon', 'large_banner_icon']
    for image_key in image_keys:
        if validated_data[image_key]:
            old_value = model_access.image_to_string(getattr(instance, image_key), True, 'old_value({0!s})'.format(image_key))
            new_value = model_access.image_to_string(validated_data[image_key], False, 'new_value({0!s})'.format(image_key))

            if old_value != new_value:
                new_value_image = None

                old_image_id = None
                if old_value is not None:
                    old_image_id = getattr(instance, image_key).id
                if validated_data[image_key].get('id') == old_image_id:
                    new_value_image = getattr(instance, image_key)
                    new_value_image.security_marking = validated_data[image_key].get('security_marking')
                    new_value_image.save()
                else:
                    new_value_image = image_model_access.get_image_by_id(validated_data[image_key].get('id'))

                    if new_value_image is None:
                        raise errors.InvalidInput('Error while saving, can not find image by id')

                change_details.append({'old_value': old_value,
                        'new_value': new_value, 'field_name': image_key})

                if image_key == 'small_icon':
                    instance.small_icon = new_value_image
                elif image_key == 'large_icon':
                    instance.large_icon = new_value_image
                elif image_key == 'banner_icon':
                    instance.banner_icon = new_value_image
                elif image_key == 'large_banner_icon':
                    instance.large_banner_icon = new_value_image

    if 'contacts' in validated_data:
        old_contact_instances = instance.contacts.all()
        old_contacts = model_access.contacts_to_string(old_contact_instances, True)
        new_contacts = model_access.contacts_to_string(validated_data['contacts'])

        if old_contacts != new_contacts:
            change_details.append({'old_value': old_contacts,
                'new_value': new_contacts, 'field_name': 'contacts'})
            instance.contacts.clear()
            for contact in validated_data['contacts']:
                # TODO: Smarter Handling of Duplicates Contact Records
                # A contact with the same name and email should be the same contact
                # in the backend.
                # Person1(name='N1',email='n2@n2.com') and
                #    Person1' (name='N1',email='n2@n2.com',secure_phone = '414-444-444')
                # The two people above should be one contact
                # if approval_status: "IN_PROGRESS" then it should be using
                # contact model ids' since it is temporary contacts
                obj, created = models.Contact.objects.get_or_create(
                    name=contact['name'],
                    email=contact['email'],
                    secure_phone=contact['secure_phone'],
                    unsecure_phone=contact['unsecure_phone'],
                    organization=contact.get('organization', None),
                    contact_type=contact_type_model_access.get_contact_type_by_name(
                        contact['contact_type']['name'])
                )
                instance.contacts.add(obj)

    if 'categories' in validated_data:
        old_category_instances = instance.categories.all()
        old_categories = model_access.categories_to_string(old_category_instances, True)
        new_categories = model_access.categories_to_string(validated_data['categories'], True)

        if old_categories != new_categories:
            changeset = {'old_value': old_categories,
                'new_value': new_categories, 'field_name': 'categories'}
            change_details.append(changeset)
            instance.categories.clear()
            for category in validated_data['categories']:
                instance.categories.add(category)

            dispatcher.publish('listing_categories_changed',
                               listing=instance,
                               profile=profile,
                               old_categories=old_category_instances,
                               new_categories=validated_data['categories'])

    if 'owners' in validated_data:
        old_owner_instances = instance.owners.all()
        old_owners = model_access.owners_to_string(old_owner_instances, True)
        new_owners = model_access.owners_to_string(validated_data['owners'], True)
        if old_owners != new_owners:
            change_details.append({'old_value': old_owners,
                'new_value': new_owners, 'field_name': 'owners'})
            instance.owners.clear()
            for owner in validated_data['owners']:
                instance.owners.add(owner)

    # tags will be automatically created if necessary
    if 'tags' in validated_data:
        old_tag_instances = instance.tags.all()
        old_tags = model_access.tags_to_string(old_tag_instances, True)
        new_tags = model_access.tags_to_string(validated_data['tags'])

        if old_tags != new_tags:
            changeset = {'old_value': old_tags,
                         'new_value': new_tags, 'field_name': 'tags'}
            change_details.append(changeset)
            instance.tags.clear()
            new_tags_instances = []
            for tag in validated_data['tags']:
                obj, created = models.Tag.objects.get_or_create(
                    name=tag['name'])
                instance.tags.add(obj)
                new_tags_instances.append(obj)

            dispatcher.publish('listing_tags_changed',
                               listing=instance,
                               profile=profile,
                               old_tags=old_tag_instances,
                               new_tags=new_tags_instances)

    # tags will be automatically created if necessary
    if 'custom_fields' in validated_data:
        old_custom_field_instances = instance.custom_fields.all()
        custom_fields = model_access.custom_field_values_to_string(old_custom_field_instances, True)
        new_custom_fields = model_access.custom_field_values_to_string(validated_data['custom_fields'])
        if custom_fields != new_custom_fields:
            changeset = {'old_value': custom_fields,
                         'new_value': new_custom_fields,
                         'field_name': 'custom_fields'}
            change_details.append(changeset)
            new_custom_fields_instances = []
            for cfv in validated_data['custom_fields']:
                id = cfv['custom_field'].id
                cf = models.CustomField.objects.find_by_id(id=id)
                obj, created = models.CustomFieldValue.objects.get_or_create(
                    listing=instance,
                    custom_field=cf,
                    value=cfv['value']
                )
                if created:
                    instance.custom_fields.add(obj)
                new_custom_fields_instances.append(obj)

            dispatcher.publish('listing_custom_field_values_changed',
                               listing=instance,
                               profile=profile,
                               old_tags=old_custom_field_instances,
                               new_tags=new_custom_fields_instances)

    if 'intents' in validated_data:
        old_intent_instances = instance.intents.all()
        old_intents = model_access.intents_to_string(old_intent_instances, True)
        new_intents = model_access.intents_to_string(validated_data['intents'], True)
        if old_intents != new_intents:
            change_details.append({'old_value': old_intents,
                'new_value': new_intents, 'field_name': 'intents'})
            instance.intents.clear()
            for intent in validated_data['intents']:
                instance.intents.add(intent)

    # doc_urls will be automatically created
    if 'doc_urls' in validated_data:
        old_doc_url_instances = model_access.get_doc_urls_for_listing(instance)
        old_doc_urls = model_access.doc_urls_to_string(old_doc_url_instances, True)
        new_doc_urls = model_access.doc_urls_to_string(validated_data['doc_urls'])
        if old_doc_urls != new_doc_urls:
            change_details.append({
                'old_value': old_doc_urls,
                'new_value': new_doc_urls,
                'field_name': 'doc_urls'})

            new_doc_url_instances = []
            for d in validated_data['doc_urls']:
                obj, created = models.DocUrl.objects.get_or_create(
                    name=d['name'], url=d['url'], listing=instance)
                new_doc_url_instances.append(obj)
            for i in old_doc_url_instances:
                if i not in new_doc_url_instances:
                    logger.info('Deleting doc_url: {0!s}'.format(i.id), extra={'request': serializer_instance.context.get('request')})
                    i.delete()

    # screenshots will be automatically created
    if 'screenshots' in validated_data:
        old_screenshot_instances = model_access.get_screenshots_for_listing(instance)
        old_screenshots = model_access.screenshots_to_string(old_screenshot_instances, True)
        new_screenshots = model_access.screenshots_to_string(validated_data['screenshots'])
        if old_screenshots != new_screenshots:
            change_details.append({'old_value': old_screenshots,
                'new_value': new_screenshots, 'field_name': 'screenshots'})

        new_screenshot_instances = []

        for s in validated_data['screenshots']:
            new_small_image = image_model_access.get_image_by_id(s['small_image']['id'])
            new_small_image.security_marking = s['small_image']['security_marking']
            new_small_image.save()

            new_large_image = image_model_access.get_image_by_id(s['large_image']['id'])
            new_large_image.security_marking = s['large_image']['security_marking']
            new_large_image.save()

            obj, created = models.Screenshot.objects.get_or_create(
                order=s.get('order'),
                small_image=new_small_image,
                large_image=new_large_image,
                description=s.get('description'),
                listing=instance)

            new_screenshot_instances.append(obj)

        for i in old_screenshot_instances:
            if i not in new_screenshot_instances:
                logger.info('Deleting screenshot: {0!s}'.format(i.id), extra={'request': serializer_instance.context.get('request')})
                i.delete()

    if 'agency' in validated_data:
        if instance.agency != validated_data['agency']:
            change_details.append({'old_value': instance.agency.title,
                'new_value': validated_data['agency'].title, 'field_name': 'agency'})
            instance.agency = validated_data['agency']

    instance.save()

    # If the listing was modified add an entry showing changes
    if change_details:
        model_access.log_listing_modification(profile, instance, change_details)

        new_change_details = []
        field_to_exclude = ['is_private', 'categories', 'tags']
        for change_detail in change_details:
            if change_detail['field_name'] not in field_to_exclude:
                new_change_details.append(change_detail)

        if new_change_details:
            dispatcher.publish('listing_changed',
                               listing=instance,
                               profile=profile,
                               change_details=new_change_details)

    instance.edited_date = datetime.datetime.now(pytz.utc)
    return instance


class CertIssuesField(serializers.ReadOnlyField):
    """
    Read Only Field
    """

    def from_native(self, obj):
        return obj


class ListingSerializer(serializers.ModelSerializer):
    is_bookmarked = serializers.ReadOnlyField()
    feedback = serializers.ReadOnlyField()
    screenshots = ScreenshotSerializer(many=True, required=False)
    doc_urls = DocUrlSerializer(many=True, required=False)
    owners = CreateListingProfileSerializer(required=False, many=True)
    categories = category_serializers.ListingCategorySerializer(many=True, required=False)
    tags = TagSerializer(many=True, required=False)
    custom_fields = CustomFieldValueSerializer(many=True, required=False)
    contacts = contact_type_serializers.ContactSerializer(many=True, required=False)
    intents = intent_serializers.IntentSerializer(many=True, required=False)
    small_icon = image_serializers.ImageSerializer(required=False, allow_null=True)
    large_icon = image_serializers.ImageSerializer(required=False, allow_null=True)
    banner_icon = image_serializers.ImageSerializer(required=False, allow_null=True)
    large_banner_icon = image_serializers.ImageSerializer(required=False, allow_null=True)
    agency = agency_serializers.CreateAgencySerializer(required=False)
    last_activity = ListingActivitySerializer(required=False, read_only=True)
    current_rejection = RejectionListingActivitySerializer(required=False, read_only=True)
    listing_type = ListingTypeSerializer(required=False, allow_null=True)
    cert_issues = CertIssuesField(required=False)

    class Meta:
        model = models.Listing
        depth = 2
        fields = '__all__'

    @staticmethod
    def setup_eager_loading(queryset):
        # prefetch_related many-to-many relationships
        queryset = queryset.prefetch_related('agency__icon')
        queryset = queryset.prefetch_related('screenshots')
        queryset = queryset.prefetch_related('screenshots__small_image')
        queryset = queryset.prefetch_related('screenshots__large_image')
        queryset = queryset.prefetch_related('doc_urls')
        queryset = queryset.prefetch_related('owners')
        queryset = queryset.prefetch_related('owners__user')
        queryset = queryset.prefetch_related('owners__organizations')
        queryset = queryset.prefetch_related('owners__stewarded_organizations')
        queryset = queryset.prefetch_related('categories')
        queryset = queryset.prefetch_related('tags')
        queryset = queryset.prefetch_related('contacts')
        queryset = queryset.prefetch_related('contacts__contact_type')
        queryset = queryset.prefetch_related('listing_type')
        queryset = queryset.prefetch_related('last_activity')
        queryset = queryset.prefetch_related('last_activity__change_details')
        queryset = queryset.prefetch_related('last_activity__author')
        queryset = queryset.prefetch_related('last_activity__author__organizations')
        queryset = queryset.prefetch_related('last_activity__author__stewarded_organizations')
        queryset = queryset.prefetch_related('last_activity__listing')
        queryset = queryset.prefetch_related('last_activity__listing__contacts')
        queryset = queryset.prefetch_related('last_activity__listing__owners')
        queryset = queryset.prefetch_related('last_activity__listing__owners__user')
        queryset = queryset.prefetch_related('last_activity__listing__categories')
        queryset = queryset.prefetch_related('last_activity__listing__tags')
        queryset = queryset.prefetch_related('last_activity__listing__intents')
        queryset = queryset.prefetch_related('current_rejection')
        queryset = queryset.prefetch_related('intents')
        queryset = queryset.prefetch_related('intents__icon')
        return queryset

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
        ret = super(ListingSerializer, self).to_representation(data)

        anonymize_identifiable_data = system_anonymize_identifiable_data(self.context['request'].user.username)
        request_user = generic_model_access.get_profile(self.context['request'].user)  # TODO: Get the profile from view request instead of getting it from db again

        if anonymize_identifiable_data:
            ret['contacts'] = []
        check_failed = []
        # owners
        if 'owners' in ret and not anonymize_identifiable_data:
            for owner in ret['owners']:
                user_dict = owner.get('user')
                user_username = None if user_dict is None else user_dict.get('username')

                # if not user_username:
                # raise serializers.ValidationError('Owner field requires correct format')

                owner_profile = generic_model_access.get_profile(user_username)
                # if not owner_profile:
                #    raise serializers.ValidationError('Owner Profile not found')

                # Don't allow user to select a security marking that is above
                # their own access level\
                try:
                    if system_has_access_control(owner_profile.user.username, ret.get('security_marking')) is False:
                        check_failed.append(owner_profile.user.username)
                        # raise serializers.ValidationError(owner_profile.user.username + 'User certificate is invalid')
                except Exception:
                    check_failed.append(owner_profile.user.username)

        ret['cert_issues'] = check_failed
        ret['feedback'] = self._feedback(request_user, data)
        ret['is_bookmarked'] = self._is_bookmarked(request_user, data)
        return ret

    def validate(self, data):
        return validate_listing(self, data)

    def create(self, validated_data):
        return create_listing(self, validated_data)

    def update(self, instance, validated_data):
        return update_listing(self, instance, validated_data)


class ReviewResponsesSerializer(serializers.ModelSerializer):
    author = profile_serializers.ShortProfileSerializer()

    class Meta:
        model = models.Review
        fields = ('id', 'author', 'listing', 'rate', 'text', 'edited_date', 'created_date')
        validators = []  # Remove a default "unique together" constraint.


class ReviewResponsesField(serializers.ReadOnlyField):
    """
    Read Only Field
    """

    def from_native(self, obj):
        return obj


class ReviewSerializer(serializers.ModelSerializer):
    author = profile_serializers.ShortProfileSerializer()
    review_responses = ReviewResponsesField()

    class Meta:
        model = models.Review
        fields = ('id', 'author', 'listing', 'rate', 'text', 'edited_date', 'created_date', 'review_parent', 'review_responses')
        validators = []  # Remove a default "unique together" constraint.

    def to_representation(self, data):
        data = super(ReviewSerializer, self).to_representation(data)

        responses_queryset = models.Review.objects.for_user(self.context['request'].user.username).filter(review_parent=data['id']).order_by('created_date')
        review_responses_serializer = ReviewResponsesSerializer(responses_queryset, context={'request': self.context['request']}, many=True)
        data['review_responses'] = review_responses_serializer.data

        return data

    def validate(self, data):
        """
        validate review
        """
        data['listing'] = self.context['listing']

        if 'rate' not in data:
            raise serializers.ValidationError('Missing required rate field')

        if 'text' not in data:
            data['text'] = None
            # raise serializers.ValidationError('Missing required text field')

        if 'review_parent' not in data:
            data['review_parent'] = None
        else:
            review_parent = data['review_parent']

            if review_parent.review_parent is not None:
                raise serializers.ValidationError('More than one level review responses not allowed')

        return data

    def create(self, validated_data):
        profile = generic_model_access.get_profile(self.context['request'].user.username)
        try:
            resp = model_access.create_listing_review(profile,
                        validated_data['listing'],
                validated_data['rate'],
                validated_data['text'],
                validated_data['review_parent'])
        except ValidationError as err:
            raise serializers.ValidationError('{}'.format(err))
        return resp

    def update(self, review_instance, validated_data):
        try:
            review = model_access.edit_listing_review(self.context['request'].user.username,
                                                      review_instance,
                                                      validated_data['rate'],
                                                      validated_data['text'])
        except ValidationError as err:
            raise serializers.ValidationError('{}'.format(err))
        return review


class RecommendationFeedbackSerializer(serializers.ModelSerializer):

    class Meta:
        model = models.RecommendationFeedback
        fields = ('id', 'feedback')
        validators = []  # Remove a default "unique together" constraint.

    def validate(self, data):
        """
        validate feedback
        """
        data['listing'] = self.context['listing']

        if 'feedback' not in data:
            raise serializers.ValidationError('Missing required feedback field')
        else:
            feedback = data['feedback']
            if feedback not in [-1, 1]:
                raise serializers.ValidationError('feedback can only be -1 or 1')
        return data

    def create(self, validated_data):
        profile = generic_model_access.get_profile(self.context['request'].user.username)
        try:
            resp = model_access.create_recommendation_feedback(profile,
                        validated_data['listing'],
                validated_data['feedback'])
        except ValidationError as err:
            raise serializers.ValidationError('{}'.format(err))
        return resp

    def update(self, feedback_instance, validated_data):
        raise serializers.ValidationError('{}'.format('Update not Supported'))
