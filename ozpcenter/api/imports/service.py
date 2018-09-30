import logging
from typing import Dict, Any

from django.utils import timezone
from rest_framework.serializers import Serializer

from ozpcenter.api.imports.serializers import *

logger = logging.getLogger("ozp-center." + str(__name__))

S_co = TypeVar('S_co', bound=Serializer, covariant=True)
M_co = TypeVar('M_co', bound=ExternalModel, covariant=True)


class ImportTask(object):
    def __init__(self, import_data, affiliated_store: AffiliatedStore, auth=None, import_timestamp=None):
        self.import_data = import_data
        self.affiliated_store = affiliated_store
        self.import_timestamp = import_timestamp if import_timestamp else timezone.now()
        self.auth_credentials = auth if auth else None

        self.models: ModelDict = ModelDict()
        self.errors = []

    def run(self):
        # depends on: n/a
        self._import_model_type("image_types", ImageTypeSerializer, ImageType)
        self._import_model_type("categories", CategorySerializer, Category)
        self._import_model_type("change_details", ChangeDetailSerializer, ChangeDetail)
        self._import_model_type("contact_types", ContactTypeSerializer, ContactType)
        self._import_model_type("custom_field_types", CustomFieldTypeSerializer, CustomFieldType)
        self._import_model_type("listing_types", ListingTypeSerializer, ListingType)
        self._import_model_type("tags", TagSerializer, Tag)

        # depends on: custom_field_type
        self._import_model_type("custom_fields", CustomFieldSerializer, CustomField)

        # depends on: contact_types
        self._import_model_type("contacts", ContactSerializer, Contact)

        # depends on: image_types
        self._import_model_type("images", ImageSerializer, Image)

        # depends on: images
        self._import_model_type("agencies", AgencySerializer, Agency)
        self._import_model_type("intents", IntentSerializer, Intent)

        # depends on: agencies
        self._import_model_type("profiles", ProfileSerializer, Profile)

        # depends on: everything above
        self._import_model_type("listings", ListingSerializer, Listing)

        # depends on: change_details, listings
        self._import_model_type("listing_activities", ListingActivitySerializer, ListingActivity)

        for listing in self._get_import_data("listings"):
            self._serialize_embedded(DocUrlSerializer, DocUrl, listing["doc_urls"], "listing", listing["id"])
            self._serialize_embedded(ReviewSerializer, Review, listing["reviews"], "listing", listing["id"])
            self._serialize_embedded(ScreenshotSerializer, Screenshot, listing["screenshots"], "listing", listing["id"])
            self._serialize_embedded(CustomFieldValueSerializer, CustomFieldValue, listing["custom_fields"], "listing",
                                     listing["id"])

            self._add_required_listings(listing)
            self._add_last_activity(listing)
            self._add_current_rejection(listing)


        self.clean_old_import_data()
        return {
            "agencies": self.models.list(Agency),
            "categories": self.models.list(Category),
            "contact_types": self.models.list(ContactType),
            "contacts": self.models.list(Contact),
            "custom_field_types": self.models.list(CustomFieldType),
            "custom_fields": self.models.list(CustomField),
            "image_types": self.models.list(ImageType),
            "images": self.models.list(Image),
            "intents": self.models.list(Intent),
            "listing_types": self.models.list(ListingType),
            "listings": self.models.list(Listing),
            "profiles": self.models.list(Profile),
            "tags": self.models.list(Tag),
            "errors": self.errors
        }

    def _add_required_listings(self, listing):
        required_listing_id = listing["required_listings"]
        if required_listing_id is None:
            return

        required_listing = self.models.get(Listing, required_listing_id)
        if not required_listing:
            self._add_error(Listing, "required_listings with id=%d not found" % required_listing_id)
            return

        imported_listing = self.models.get(Listing, listing["id"])
        imported_listing.required_listings = required_listing
        imported_listing.save()

    def _add_last_activity(self, listing):
        activity_id = listing["last_activity"]
        if activity_id is None:
            return

        activity = self.models.get(ListingActivity, activity_id)
        if not activity:
            self._add_error(Listing, "last_activity with id=%d not found" % activity_id)
            return

        imported_listing = self.models.get(Listing, listing["id"])
        imported_listing.last_activity = activity
        imported_listing.save()

    def _add_current_rejection(self, listing):
        rejection_id = listing["current_rejection"]
        if rejection_id is None:
            return

        rejection = self.models.get(ListingActivity, rejection_id)
        if not rejection:
            self._add_error(Listing, "current_rejection with id=%d not found" % rejection_id)
            return

        imported_listing = self.models.get(Listing, listing["id"])
        imported_listing.current_rejection = rejection
        imported_listing.save()

    def _get_import_data(self, key: str) -> List[dict]:
        if key not in self.import_data:
            return []
        return self.import_data.get(key)

    def _import_model_type(self, model_name: str, serializer_cls: Type[S_co], model_cls: Type[M_co]) -> None:
        for data in self._get_import_data(model_name):
            serializer = self.create_serializer(serializer_cls, data)
            if not serializer.is_valid():
                self._add_validation_error(model_cls, serializer)
                continue

            instance = serializer.save()
            self.models.add(instance)

    def _serialize_embedded(self, serializer_cls: Type[S_co], model_cls: Type[M_co], data: List,
                            parent_ref: str, parent_pk: int) -> List[M_co]:
        instances = []
        for d in data:
            d[parent_ref] = parent_pk
            serializer = self.create_serializer(serializer_cls, d)
            if not serializer.is_valid():
                self._add_validation_error(model_cls, serializer)
                continue

            instance = serializer.save()
            instances.append(instance)
        return instances

    def _add_validation_error(self, cls: Type[M_co], serializer: S_co) -> None:
        self.errors.append({
            "type": cls.__name__,
            "error": "validation",
            "details": serializer.errors
        })

    def _add_error(self, cls: Type[M_co], error_details: Any) -> None:
        self.errors.append({
            "type": cls.__name__,
            "error": "validation",
            "details": error_details
        })

    def find_external_object(self, cls, external_id):
        return cls.objects.filter(import_metadata__affiliated_store=self.affiliated_store,
                                  import_metadata__external_id=external_id).first()

    def create_metadata(self, external_id):
        metadata = ImportMetadata(affiliated_store=self.affiliated_store,
                                  external_id=external_id,
                                  last_updated=self.import_timestamp)
        metadata.save()
        return metadata

    def update_metadata(self, obj: ExternalModel):
        obj.import_metadata.last_updated = self.import_timestamp
        obj.import_metadata.save()

    def create_serializer(self, cls: Type[S_co], data: Dict) -> S_co:
        return cls(data=data, context={
            "affiliated_store": self.affiliated_store,
            "import_timestamp": self.import_timestamp,
            "models": self.models,
            "auth_credentials": self.auth_credentials
        })

    def clean_model_type(self, cls: Type[M_co]):
        #Query db with timestamp BEFORE current timestamp and Affiliated Store. Remove anything found
        cls.objects.filter(import_metadata__affiliated_store=self.affiliated_store,
                           import_metadata__last_updated__lt=self.import_timestamp).delete()

    def clean_old_import_data(self):
        self.clean_model_type(ImageType)
        self.clean_model_type(Category)
        self.clean_model_type(ChangeDetail)
        self.clean_model_type(ContactType)
        self.clean_model_type(CustomFieldType)
        self.clean_model_type(ListingType)
        self.clean_model_type(Tag)

        # depends on: custom_field_type
        self.clean_model_type(CustomField)

        # depends on: contact_types
        self.clean_model_type(Contact)

        # depends on: image_types
        self.clean_model_type(Image)

        # depends on: images
        self.clean_model_type(Agency)
        self.clean_model_type(Intent)

        # depends on: agencies
        self.clean_model_type(Profile)

        # depends on: everything above
        self.clean_model_type(Listing)

        # depends on: change_details, listings
        self.clean_model_type(ListingActivity)
