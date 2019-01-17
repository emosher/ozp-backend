from typing import Dict, List

from rest_framework.response import Response
from rest_framework.viewsets import ReadOnlyModelViewSet

from ozpcenter.models import Agency
from ozpcenter.models import Category
from ozpcenter.models import ChangeDetail
from ozpcenter.models import Contact
from ozpcenter.models import ContactType
from ozpcenter.models import CustomField
from ozpcenter.models import CustomFieldType
from ozpcenter.models import Image
from ozpcenter.models import ImageType
from ozpcenter.models import Intent
from ozpcenter.models import Listing
from ozpcenter.models import ListingActivity
from ozpcenter.models import ListingType
from ozpcenter.models import Profile
from ozpcenter.models import Tag
from ozpcenter.permissions import IsAmlStewardOrHasExportRole
from .serializers import AgencySerializer
from .serializers import CategorySerializer
from .serializers import ChangeDetailSerializer
from .serializers import ContactSerializer
from .serializers import ContactTypeSerializer
from .serializers import CustomFieldSerializer
from .serializers import CustomFieldTypeSerializer
from .serializers import ImageSerializer
from .serializers import ImageTypeSerializer
from .serializers import IntentSerializer
from .serializers import ListingActivitySerializer
from .serializers import ListingSerializer
from .serializers import ListingTypeSerializer
from .serializers import ProfileSerializer
from .serializers import TagSerializer


class ExportViewSet(ReadOnlyModelViewSet):
    permission_classes = (IsAmlStewardOrHasExportRole,)

    def list(self, request, *args, **kwargs):
        export_task = ExportTask()
        export_task.run()
        return Response(export_task.serialize())


class ExportTask(object):

    def __init__(self):
        self.listings: List[Listing] = []

        self.agencies: Dict[int, Agency] = {}
        self.categories: Dict[int, Category] = {}
        self.change_details: Dict[int, ChangeDetail] = {}
        self.contacts: Dict[int, Contact] = {}
        self.contact_types: Dict[int, ContactType] = {}
        self.custom_fields: Dict[int, CustomField] = {}
        self.custom_field_types: Dict[int, CustomFieldType] = {}
        self.images: Dict[int, Image] = {}
        self.image_types: Dict[int, ImageType] = {}
        self.intents: Dict[int, Intent] = {}
        self.listing_types: Dict[int, ListingType] = {}
        self.listing_activities: Dict[int, ListingActivity] = {}
        self.profiles: Dict[int, Profile] = {}
        self.tags: Dict[int, Tag] = {}

    def run(self):
        self.listings = list(Listing.objects.find_published_for_export())

        for listing in self.listings:
            self._add_listing_related(listing)

    def _add_listing_related(self, listing: Listing):
        for listing_activity in list(listing.listing_activities.all()):
            self._add_listing_activity(listing_activity)

        for category in list(listing.categories.all()):
            self._add_category(category)

        for custom_field_value in list(listing.custom_fields.all()):
            self._add_custom_field(custom_field_value.custom_field)

        for contact in list(listing.contacts.all()):
            self._add_contact(contact)

        for intent in list(listing.intents.all()):
            self._add_intent(intent)

        for owner in list(listing.owners.all()):
            self._add_profile(owner)

        for tag in list(listing.tags.all()):
            self._add_tag(tag)

        for screenshot in list(listing.screenshots.all()):
            self._add_image(screenshot.small_image)
            self._add_image(screenshot.large_image)

        for review in list(listing.reviews.all()):
            self._add_profile(review.author)

        self._add_agency(listing.agency)
        self._add_icons(listing)
        self._add_listing_type(listing.listing_type)

    def _add_custom_field(self, custom_field: CustomField):
        if custom_field is not None and custom_field.id not in self.custom_fields:
            self.custom_fields[custom_field.id] = custom_field

            self._add_custom_field_type(custom_field.type)

    def _add_custom_field_type(self, custom_field_type: CustomFieldType):
        if custom_field_type is not None and custom_field_type.id not in self.custom_field_types:
            self.custom_field_types[custom_field_type.id] = custom_field_type

    def _add_listing_activity(self, listing_activity: ListingActivity):
        if listing_activity is not None and listing_activity.id not in self.listing_activities:
            self.listing_activities[listing_activity.id] = listing_activity

            for change_detail in list(listing_activity.change_details.all()):
                self._add_change_detail(change_detail)

    def _add_change_detail(self, change_detail: ChangeDetail):
        if change_detail is not None and change_detail.id not in self.change_details:
            self.change_details[change_detail.id] = change_detail

    def _add_agency(self, agency: Agency):
        if agency is not None and agency.id not in self.agencies:
            self.agencies[agency.id] = agency
            self._add_image(agency.icon)

    def _add_intent(self, intent: Intent):
        if intent is not None and intent.id not in self.intents:
            self.intents[intent.id] = intent
            self._add_image(intent.icon)

    def _add_profile(self, profile: Profile):
        if profile is not None and profile.id not in self.profiles:
            self.profiles[profile.id] = profile

            for org in list(profile.organizations.all()):
                self._add_agency(org)

            for org in list(profile.stewarded_organizations.all()):
                self._add_agency(org)

    def _add_category(self, category: Category):
        if category is not None and category.id not in self.categories:
            self.categories[category.id] = category

    def _add_listing_type(self, listing_type: ListingType):
        if listing_type.id not in self.listing_types:
            self.listing_types[listing_type.id] = listing_type

    def _add_tag(self, tag: Tag):
        if tag.id not in self.tags:
            self.tags[tag.id] = tag

    def _add_icons(self, listing: Listing):
        self._add_image(listing.small_icon)
        self._add_image(listing.large_icon)
        self._add_image(listing.banner_icon)
        self._add_image(listing.large_banner_icon)

    def _add_image(self, image: Image):
        if image is not None and image.id not in self.images:
            self.images[image.id] = image

            self._add_image_type(image.image_type)

    def _add_image_type(self, image_type: ImageType):
        if image_type is not None and image_type.id not in self.image_types:
            self.image_types[image_type.id] = image_type

    def _add_contact(self, contact: Contact):
        if contact.id not in self.contacts:
            self.contacts[contact.id] = contact

            self._add_contact_type(contact.contact_type)

    def _add_contact_type(self, contact_type: ContactType):
        if contact_type.id not in self.contact_types:
            self.contact_types[contact_type.id] = contact_type

    def serialize(self):
        listings = ListingSerializer(self.listings, many=True).data

        agencies = AgencySerializer(self.agencies.values(), many=True).data
        categories = CategorySerializer(self.categories.values(), many=True).data
        change_details = ChangeDetailSerializer(self.change_details.values(), many=True).data
        contacts = ContactSerializer(self.contacts.values(), many=True).data
        contact_types = ContactTypeSerializer(self.contact_types.values(), many=True).data
        custom_fields = CustomFieldSerializer(self.custom_fields.values(), many=True).data
        custom_field_types = CustomFieldTypeSerializer(self.custom_field_types.values(), many=True).data
        images = ImageSerializer(self.images.values(), many=True).data
        image_types = ImageTypeSerializer(self.image_types.values(), many=True).data
        intents = IntentSerializer(self.intents.values(), many=True).data
        listing_activities = ListingActivitySerializer(self.listing_activities.values(), many=True).data
        listing_types = ListingTypeSerializer(self.listing_types.values(), many=True).data
        profiles = ProfileSerializer(self.profiles.values(), many=True).data
        tags = TagSerializer(self.tags.values(), many=True).data

        return {
            "listings": listings,
            "agencies": agencies,
            "categories": categories,
            "change_details": change_details,
            "contacts": contacts,
            "contact_types": contact_types,
            "custom_fields": custom_fields,
            "custom_field_types": custom_field_types,
            "images": images,
            "image_types": image_types,
            "intents": intents,
            "listing_activities": listing_activities,
            "listing_types": listing_types,
            "profiles": profiles,
            "tags": tags
        }
