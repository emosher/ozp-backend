import json

from PIL import Image
from django.db import transaction

import ozpcenter.api.listing.model_access as listing_model_access
from ozpcenter import models
from ozpcenter.scripts.model_schema import *


class ModelGenerator(object):
    default_image_path: str

    agencies_by_title: Dict[str, models.Agency]
    categories_by_title: Dict[str, models.Category]
    contact_types_by_name: Dict[str, models.ContactType]
    contacts_by_email: Dict[str, models.Contact]
    custom_field_types_by_name: Dict[str, models.CustomFieldType]
    custom_fields_by_label: Dict[str, models.CustomField]
    image_types_by_name: Dict[str, models.ImageType]
    intents_by_action: Dict[str, models.Intent]
    listing_types_by_title: Dict[str, models.ListingType]
    profiles_by_username: Dict[str, models.Profile]
    tags_by_name: Dict[str, models.Tag]

    def __init__(self, default_image_path):
        self.default_image_path = default_image_path

        self.agencies_by_title = {}
        self.categories_by_title = {}
        self.contact_types_by_name = {}
        self.contacts_by_email = {}
        self.custom_field_types_by_name = {}
        self.custom_fields_by_label = {}
        self.image_types_by_name = {}
        self.intents_by_action = {}
        self.listing_types_by_title = {}
        self.profiles_by_username = {}
        self.tags_by_name = {}

    def create_model(self, model: ModelData):
        # depends on: none
        with transaction.atomic():
            for image_type in model.image_types:
                self.create_image_type(image_type)

        # depends on: none
        with transaction.atomic():
            for category in model.categories:
                self.create_category(category)

        # depends on: none
        with transaction.atomic():
            for contact_type in model.contact_types:
                self.create_contact_type(contact_type)

        # depends on: none
        with transaction.atomic():
            for listing_type in model.listing_types:
                self.create_listing_type(listing_type)

        # depends on: none
        with transaction.atomic():
            for tag in model.tags:
                self.create_tag(tag)

        # depends on: none
        with transaction.atomic():
            for field_type in model.custom_field_types:
                self.create_custom_field_type(field_type)

        # depends on: custom_field_types
        with transaction.atomic():
            for field in model.custom_fields:
                self.create_custom_field(field)

        # depends on: contact_types
        with transaction.atomic():
            for contact in model.contacts:
                self.create_contact(contact)

        # depends on: image_types
        with transaction.atomic():
            for agency in model.agencies:
                self.create_agency(agency)

        # depends on: image_types
        with transaction.atomic():
            for intent in model.intents:
                self.create_intent(intent)

        # depends on: agencies, groups
        with transaction.atomic():
            for profile in model.profiles:
                self.create_profile(profile)

        # depends on: everything else
        for listing in model.listings:
            with transaction.atomic():
                self.create_listing(listing)

    def create_agency(self, agency: AgencyData) -> models.Agency:
        icon = self.create_image(agency.icon)

        instance = models.Agency(title=agency.title,
                                 short_name=agency.short_name,
                                 icon=icon)
        instance.save()
        self.agencies_by_title[agency.title] = instance
        return instance

    def create_category(self, category: CategoryData) -> models.Category:
        instance = models.Category(title=category.title,
                                   description=category.description)
        instance.save()
        self.categories_by_title[category.title] = instance
        return instance

    def create_contact_type(self, contact_type: ContactTypeData) -> models.ContactType:
        instance = models.ContactType(name=contact_type.name,
                                      required=contact_type.required)
        instance.save()
        self.contact_types_by_name[contact_type.name] = instance
        return instance

    def create_contact(self, contact: ContactData) -> models.Contact:
        contact_type = self.contact_types_by_name.get(contact.contact_type_name, None)
        assert contact_type is not None, "ContactType with name '{}' not found".format(contact.contact_type_name)

        instance = models.Contact(contact_type=contact_type,
                                  name=contact.name,
                                  email=contact.email,
                                  organization=contact.organization,
                                  secure_phone=contact.secure_phone,
                                  unsecure_phone=contact.unsecure_phone)
        instance.save()
        self.contacts_by_email[contact.email] = instance
        return instance

    def create_custom_field(self, field: CustomFieldData) -> models.CustomField:
        field_type = self.custom_field_types_by_name.get(field.type_name, None)
        assert field_type is not None, "CustomFieldType with name '{}' not found".format(field.type_name)

        instance = models.CustomField(type=field_type,
                                      section=field.section,
                                      display_name=field.display_name,
                                      label=field.label,
                                      description=field.description,
                                      tooltip=field.tooltip,
                                      is_required=field.is_required,
                                      admin_only=field.admin_only,
                                      properties=field.properties,
                                      all_listing_types=field.all_listing_types)
        instance.save()
        self.custom_fields_by_label[field.label] = instance
        return instance

    def create_custom_field_type(self, field_type: CustomFieldTypeData) -> models.CustomFieldType:
        instance = models.CustomFieldType(name=field_type.name,
                                          display_name=field_type.display_name,
                                          media_type=field_type.media_type,
                                          options=field_type.options)
        instance.save()
        self.custom_field_types_by_name[field_type.name] = instance
        return instance

    def create_custom_field_value(self,
                                  listing: models.Listing,
                                  field_value: CustomFieldValueData) -> models.CustomFieldValue:
        custom_field = self.custom_fields_by_label.get(field_value.custom_field_label, None)
        assert custom_field is not None, "CustomField with label '{}' not found".format(field_value.custom_field_label)

        instance = models.CustomFieldValue(custom_field=custom_field,
                                           value=field_value.value,
                                           listing=listing)
        instance.save()
        return instance

    def create_doc_url(self, listing: models.Listing, doc_url: DocUrlData) -> models.DocUrl:
        instance = models.DocUrl(name=doc_url.name,
                                 url=doc_url.url,
                                 listing=listing)
        instance.save()
        return instance

    def create_image_type(self, image_type: ImageTypeData) -> models.ImageType:
        instance = models.ImageType(name=image_type.name,
                                    min_width=image_type.min_width,
                                    max_width=image_type.max_width,
                                    min_height=image_type.min_width,
                                    max_height=image_type.max_width,
                                    max_size_bytes=image_type.max_size_bytes)
        instance.save()
        self.image_types_by_name[image_type.name] = instance
        return instance

    def create_image(self, image: ImageData) -> models.Image:
        image_type = self.image_types_by_name.get(image.image_type_name, None)
        assert image_type is not None, "ImageType with name '{}' not found".format(image.image_type_name)

        pil_image = Image.open(self.default_image_path + image.filename)

        instance = models.Image.create_image(pil_image,
                                             file_extension=image.filename.split('.')[-1],
                                             security_marking=image.security_marking,
                                             image_type_obj=image_type)
        return instance

    def create_intent(self, intent: IntentData) -> models.Intent:
        icon = self.create_image(intent.icon)

        instance = models.Intent(action=intent.action,
                                 media_type=intent.media_type,
                                 label=intent.label,
                                 icon=icon)
        instance.save()
        self.intents_by_action[intent.action] = instance
        return instance

    def create_listing_type(self, listing_type: ListingTypeData) -> models.ListingType:
        instance = models.ListingType(title=listing_type.title,
                                      description=listing_type.description)
        instance.save()
        self.listing_types_by_title[listing_type.title] = instance
        return instance

    def create_listing(self, listing: ListingData) -> models.Listing:
        agency = self.agencies_by_title.get(listing.agency_title, None)
        assert agency is not None, "Agency with title '{}' not found".format(listing.agency_title)

        listing_type = self.listing_types_by_title.get(listing.listing_type_title, None)
        assert listing_type is not None, "ListingType with title '{}' not found".format(listing.listing_type_title)

        small_icon = self.create_image(listing.small_icon)
        large_icon = self.create_image(listing.large_icon)
        banner_icon = self.create_image(listing.banner_icon)
        large_banner_icon = self.create_image(listing.large_banner_icon)

        instance = models.Listing(title=listing.title,
                                  description=listing.description,
                                  description_short=listing.description_short,
                                  launch_url=listing.launch_url,
                                  version_name=listing.version_name,
                                  unique_name=listing.unique_name,
                                  what_is_new=listing.what_is_new,
                                  usage_requirements=listing.usage_requirements,
                                  system_requirements=listing.system_requirements,
                                  security_marking=listing.security_marking,

                                  is_enabled=listing.is_enabled,
                                  is_private=listing.is_private,
                                  is_featured=listing.is_featured,
                                  is_exportable=listing.is_exportable,

                                  small_icon=small_icon,
                                  large_icon=large_icon,
                                  banner_icon=banner_icon,
                                  large_banner_icon=large_banner_icon,

                                  agency=agency,
                                  listing_type=listing_type)
        instance.save()

        for category_title in listing.category_titles:
            category = self.categories_by_title.get(category_title, None)
            assert category is not None, "Category with title '{}' not found".format(category_title)
            instance.categories.add(category)

        for contact_email in listing.contact_emails:
            contact = self.contacts_by_email.get(contact_email, None)
            assert contact is not None, "Contact with email '{}' not found".format(contact_email)
            instance.contacts.add(contact)

        for custom_field_value in listing.custom_field_values:
            self.create_custom_field_value(instance, custom_field_value)

        for intent_action in listing.intent_actions:
            intent = self.intents_by_action.get(intent_action, None)
            assert intent is not None, "Intent with action '{}' not found".format(intent_action)
            instance.intents.add(intent)

        for owner_username in listing.owner_usernames:
            owner = self.profiles_by_username.get(owner_username, None)
            assert owner is not None, "Profile with username '{}' not found".format(owner_username)
            instance.owners.add(owner)

        for tag_name in listing.tag_names:
            tag = self.tags_by_name.get(tag_name, None)
            assert tag is not None, "Tag with name '{}' not found".format(tag_name)
            instance.tags.add(tag)

        for screenshot in listing.screenshots:
            self.create_screenshot(instance, screenshot)

        for doc_url in listing.doc_urls:
            self.create_doc_url(instance, doc_url)

        for activity in listing.activities:
            author = self.profiles_by_username.get(activity.author_username, None)
            assert author is not None, "Profile with username '{}' not found".format(activity.author_username)

            if activity.action == 'CREATED':
                listing_model_access.create_listing(author, instance)
            elif activity.action == 'SUBMITTED':
                listing_model_access.submit_listing(author, instance)
            elif activity.action == 'APPROVED_ORG':
                listing_model_access.approve_listing_by_org_steward(author, instance)
            elif activity.action == 'APPROVED':
                listing_model_access.approve_listing(author, instance)

        return instance

    def create_profile(self, profile: ProfileData) -> models.Profile:
        access_control = json.dumps(profile.access_control)

        instance = models.Profile.create_user(profile.username,
                                              email=profile.email,
                                              display_name=profile.display_name,
                                              bio=profile.bio,
                                              access_control=access_control,
                                              organizations=profile.organizations,
                                              stewarded_organizations=profile.stewarded_organizations,
                                              groups=profile.groups,
                                              dn=profile.dn)
        instance.save()
        self.profiles_by_username[profile.username] = instance
        return instance

    def create_screenshot(self, listing: models.Listing, screenshot: ScreenshotData) -> models.Screenshot:
        small_image = self.create_image(screenshot.small_image)
        large_image = self.create_image(screenshot.large_image)

        instance = models.Screenshot(order=screenshot.order,
                                     description=screenshot.description,
                                     small_image=small_image,
                                     large_image=large_image,
                                     listing=listing)
        instance.save()
        return instance

    def create_tag(self, tag: TagData) -> models.Tag:
        instance = models.Tag(name=tag.name)
        instance.save()
        self.tags_by_name[tag.name] = instance
        return instance
