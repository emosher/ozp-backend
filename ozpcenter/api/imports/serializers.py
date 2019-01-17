from datetime import datetime
from typing import Type, List, Optional, TypeVar
from PIL import Image as PilImage
import requests
from io import BytesIO
from rest_framework import serializers
import logging
from ozpcenter.models import AffiliatedStore
from ozpcenter.models import Agency
from ozpcenter.models import Category
from ozpcenter.models import ChangeDetail
from ozpcenter.models import Contact
from ozpcenter.models import ContactType
from ozpcenter.models import CustomField
from ozpcenter.models import CustomFieldType
from ozpcenter.models import CustomFieldValue
from ozpcenter.models import DocUrl
from ozpcenter.models import ExternalModel
from ozpcenter.models import Image
from ozpcenter.models import ImageType
from ozpcenter.models import ImportMetadata
from ozpcenter.models import Intent
from ozpcenter.models import Listing
from ozpcenter.models import ListingActivity
from ozpcenter.models import ListingType
from ozpcenter.models import Profile
from ozpcenter.models import Review
from ozpcenter.models import Screenshot
from ozpcenter.models import Tag
from .model_dict import ModelDict

S_co = TypeVar('S_co', bound=serializers.Serializer, covariant=True)
M_co = TypeVar('M_co', bound=ExternalModel, covariant=True)

logger = logging.getLogger('ozp-center.' + str(__name__))

class ImportSerializer(serializers.Serializer):

    def save(self):
        instance = self._get_or_create_model()

        for field in self.to_one_field_names:
            field_value = self.validated_data[field]
            setattr(instance, field, field_value)

        instance.save()

        for field in self.to_many_field_names:
            field_values = self.validated_data[field]
            model_field = getattr(instance, field)
            model_field.add(*field_values)

        return instance

    def update(self, instance, validated_data):
        pass

    def create(self, validated_data):
        pass

    def _get_or_create_model(self) -> M_co:
        model_class = self.model_class
        external_id = self.validated_data["id"]

        instance = self._find_external_object(model_class, external_id)
        if not instance:
            metadata = self._create_metadata(external_id)
            instance = model_class(import_metadata=metadata)
        else:
            self._update_metadata(instance)

        return instance

    def _find_external_object(self, cls: Type[M_co], external_id: int) -> Optional[M_co]:
        return cls.objects.filter(import_metadata__affiliated_store=self.affiliated_store,
                                  import_metadata__external_id=external_id).first()

    def _create_metadata(self, external_id: int) -> ImportMetadata:
        metadata = ImportMetadata(affiliated_store=self.affiliated_store,
                                  external_id=external_id,
                                  last_updated=self.import_timestamp)
        metadata.save()
        return metadata

    def _update_metadata(self, obj: ExternalModel) -> None:
        obj.import_metadata.last_updated = self.import_timestamp
        obj.import_metadata.save()

    @property
    def model_class(self) -> Type[M_co]:
        assert hasattr(self, 'Meta'), \
            "Class %s missing 'Meta' attribute" % self.__class__.__name__

        assert hasattr(self.Meta, 'model'), \
            "Class %s missing 'Meta.model' attribute" % self.__class__.__name__

        return self.Meta.model

    @property
    def to_one_field_names(self) -> List[str]:
        return [f for f in self.get_fields() if f != "id" and not isinstance(self.fields[f], ManyReferenceField)]

    @property
    def to_many_field_names(self) -> List[str]:
        return [f for f in self.get_fields() if isinstance(self.fields[f], ManyReferenceField)]

    @property
    def affiliated_store(self) -> AffiliatedStore:
        assert "affiliated_store" in self.context, \
            "%s instance missing 'context.affiliated_store' value" % self.__class__.__name__

        return self.context["affiliated_store"]

    @property
    def import_timestamp(self) -> datetime:
        assert "import_timestamp" in self.context, \
            "%s instance missing 'context.import_timestamp' value" % self.__class__.__name__

        return self.context["import_timestamp"]

    @property
    def models(self) -> ModelDict:
        assert "models" in self.context, \
            "%s instance missing 'context.models' value" % self.__class__.__name__

        return self.context["models"]

    @property
    def auth_credentials(self):
        assert "auth_credentials" in self.context, \
            "%s instance missing 'context.auth_credentials' value" % self.__class__.__name__

        return self.context["auth_credentials"]


class ReferenceField(serializers.Field):

    def __init__(self, cls: Type[M_co], **kwargs):
        self.reference_cls = cls
        super().__init__(**kwargs)

    def to_internal_value(self, data):
        return self.get_reference(data)

    def get_reference(self, data):
        reference = self.root.models.get(self.reference_cls, data)
        if not reference:
            raise serializers.ValidationError("%s not found with id=%d" % (self.reference_cls.__name__, data))
        return reference

    def to_representation(self, value):
        pass

    @property
    def root(self) -> ImportSerializer:
        return super().root


class ManyReferenceField(ReferenceField):

    def to_internal_value(self, data):
        return [self.get_reference(d) for d in data]


class AgencySerializer(ImportSerializer):
    class Meta:
        model = Agency

    id = serializers.IntegerField(required=True)
    title = serializers.CharField(required=True, max_length=255)
    short_name = serializers.CharField(required=True, max_length=32)

    icon = ReferenceField(Image, required=False)


class CategorySerializer(ImportSerializer):
    class Meta:
        model = Category

    id = serializers.IntegerField(required=True)
    title = serializers.CharField(required=True, max_length=50)
    description = serializers.CharField(required=False, allow_null=True, allow_blank=True, max_length=500)


class ChangeDetailSerializer(ImportSerializer):
    class Meta:
        model = ChangeDetail

    id = serializers.IntegerField(required=True)
    old_value = serializers.CharField(required=False, allow_null=True, allow_blank=True, max_length=4000)
    new_value = serializers.CharField(required=False, allow_null=True, allow_blank=True, max_length=4000)


class ContactTypeSerializer(ImportSerializer):
    class Meta:
        model = ContactType

    id = serializers.IntegerField(required=True)
    name = serializers.CharField(required=True, max_length=50)
    required = serializers.BooleanField(required=True)


class ContactSerializer(ImportSerializer):
    class Meta:
        model = Contact

    id = serializers.IntegerField(required=True)
    secure_phone = serializers.CharField(required=False, allow_null=True, allow_blank=True, max_length=50)
    unsecure_phone = serializers.CharField(required=False, allow_null=True, allow_blank=True, max_length=50)
    email = serializers.CharField(required=True, max_length=100)
    name = serializers.CharField(required=True, max_length=100)
    organization = serializers.CharField(required=False, allow_null=True, max_length=100)

    contact_type = ReferenceField(ContactType, required=True)


class CustomFieldTypeSerializer(ImportSerializer):
    class Meta:
        model = CustomFieldType

    id = serializers.IntegerField(required=True)
    name = serializers.CharField(required=True, max_length=50)
    display_name = serializers.CharField(required=True, max_length=50)
    media_type = serializers.CharField(required=True, max_length=255)
    options = serializers.CharField(required=False, allow_null=True, allow_blank=True, max_length=4000)


class CustomFieldSerializer(ImportSerializer):
    class Meta:
        model = CustomField

    id = serializers.IntegerField(required=True)
    section = serializers.CharField(required=True, max_length=50)
    display_name = serializers.CharField(required=True, max_length=100)
    label = serializers.CharField(required=True, max_length=50)
    description = serializers.CharField(required=True, max_length=250)
    tooltip = serializers.CharField(required=True, max_length=50)
    is_required = serializers.BooleanField(required=True)
    admin_only = serializers.BooleanField(required=True)
    properties = serializers.CharField(required=False, allow_null=True, allow_blank=True, max_length=4000)
    all_listing_types = serializers.BooleanField(required=True)

    type = ReferenceField(CustomFieldType, required=True)


class CustomFieldValueSerializer(ImportSerializer):
    class Meta:
        model = CustomFieldValue

    id = serializers.IntegerField(required=True)
    value = serializers.CharField(required=True, max_length=2000)

    listing = ReferenceField(Listing, required=True)
    custom_field = ReferenceField(CustomField, required=True)


class DocUrlSerializer(ImportSerializer):
    class Meta:
        model = DocUrl

    id = serializers.IntegerField(required=True)
    name = serializers.CharField(required=True, max_length=255)
    url = serializers.CharField(required=True, max_length=2083)

    listing = ReferenceField(Listing, required=True)


class ImageTypeSerializer(ImportSerializer):
    class Meta:
        model = ImageType

    id = serializers.IntegerField(required=True)
    name = serializers.CharField(required=True)
    max_size_bytes = serializers.IntegerField(required=True)
    max_width = serializers.IntegerField(required=True)
    max_height = serializers.IntegerField(required=True)
    min_width = serializers.IntegerField(required=True)
    min_height = serializers.IntegerField(required=True)


class ImageSerializer(ImportSerializer):
    class Meta:
        model = Image

    id = serializers.IntegerField(required=True)
    uuid = serializers.CharField(required=True, max_length=36)
    security_marking = serializers.CharField(required=True, max_length=1024)
    file_extension = serializers.CharField(required=True, max_length=16)

    image_type = ReferenceField(ImageType, required=True)

    def save(self):
        instance = self._get_or_create_model()

        for field in self.to_one_field_names:
            field_value = self.validated_data[field]
            setattr(instance, field, field_value)

        url = instance.import_metadata.affiliated_store.server_url
        url += '/api/image/' + str(instance.import_metadata.external_id)

        try:
            response = requests.get(url, auth=self.auth_credentials)
        except requests.exceptions.ConnectionError as err:
            instance.save()

            for field in self.to_many_field_names:
                field_values = self.validated_data[field]
                model_field = getattr(instance, field)
                model_field.add(*field_values)

            return instance

        img = PilImage.open(BytesIO(response.content))

        created_img = Image.create_image(img,
                                       image_type=self.validated_data['image_type'],
                                       security_marking=self.validated_data['security_marking'],
                                       file_extension=self.validated_data['file_extension'])

        created_img.import_metadata = instance.import_metadata

        if instance.id:
            instance.delete()

        for field in self.to_many_field_names:
            field_values = self.validated_data[field]
            model_field = getattr(created_img, field)
            model_field.add(*field_values)

        created_img.save()

        return created_img


class IntentSerializer(ImportSerializer):
    class Meta:
        model = Intent

    id = serializers.IntegerField(required=True)
    action = serializers.CharField(required=True, max_length=64)
    media_type = serializers.CharField(required=True, max_length=129)
    label = serializers.CharField(required=True, max_length=255)

    icon = ReferenceField(Image, required=True)


class ListingSerializer(ImportSerializer):
    class Meta:
        model = Listing

    id = serializers.IntegerField(required=True)
    title = serializers.CharField(required=True, max_length=255)
    approved_date = serializers.DateTimeField(required=False, allow_null=True)
    edited_date = serializers.DateTimeField(required=True)
    featured_date = serializers.DateTimeField(required=False, allow_null=True)
    description = serializers.CharField(required=False, allow_null=True, allow_blank=True, max_length=8192)
    description_short = serializers.CharField(required=False, allow_null=True, allow_blank=True, max_length=150)
    launch_url = serializers.CharField(required=False, allow_null=True, allow_blank=True, max_length=2083)
    version_name = serializers.CharField(required=False, allow_null=True, allow_blank=True, max_length=255)
    unique_name = serializers.CharField(required=False, allow_null=True, allow_blank=True, max_length=255)
    what_is_new = serializers.CharField(required=False, allow_null=True, allow_blank=True, max_length=255)
    usage_requirements = serializers.CharField(required=False, allow_null=True, allow_blank=True, max_length=1000)
    system_requirements = serializers.CharField(required=False, allow_null=True, allow_blank=True, max_length=1000)
    approval_status = serializers.CharField(required=True, max_length=255)
    security_marking = serializers.CharField(required=False, allow_null=True, allow_blank=True, max_length=1024)
    is_enabled = serializers.BooleanField(required=True)
    is_featured = serializers.BooleanField(required=True)
    is_deleted = serializers.BooleanField(required=True)
    is_508_compliant = serializers.BooleanField(required=True)
    iframe_compatible = serializers.BooleanField(required=True)
    is_private = serializers.BooleanField(required=True)
    is_exportable = serializers.BooleanField(required=True)

    avg_rate = serializers.FloatField(required=True)
    total_votes = serializers.IntegerField(required=True)
    total_rate5 = serializers.IntegerField(required=True)
    total_rate4 = serializers.IntegerField(required=True)
    total_rate3 = serializers.IntegerField(required=True)
    total_rate2 = serializers.IntegerField(required=True)
    total_rate1 = serializers.IntegerField(required=True)

    total_reviews = serializers.IntegerField(required=True)
    total_review_responses = serializers.IntegerField(required=True)

    feedback_score = serializers.IntegerField(required=True)

    listing_type = ReferenceField(ListingType, required=True)
    agency = ReferenceField(Agency, required=True)
    large_icon = ReferenceField(Image, required=False, allow_null=True)
    small_icon = ReferenceField(Image, required=False, allow_null=True)
    banner_icon = ReferenceField(Image, required=False, allow_null=True)
    large_banner_icon = ReferenceField(Image, required=False, allow_null=True)

    contacts = ManyReferenceField(Contact, required=True)
    owners = ManyReferenceField(Profile, required=True)
    categories = ManyReferenceField(Category, required=True)
    tags = ManyReferenceField(Tag, required=True)
    intents = ManyReferenceField(Intent, required=True)


class ListingActivitySerializer(ImportSerializer):
    class Meta:
        model = ListingActivity

    id = serializers.IntegerField(required=True)
    action = serializers.CharField(required=True, max_length=128)
    activity_date = serializers.DateTimeField(required=True)
    description = serializers.CharField(required=False, allow_null=True, allow_blank=True, max_length=2000)

    author = ReferenceField(Profile, required=True)
    listing = ReferenceField(Listing, required=True)
    change_details = ManyReferenceField(ChangeDetail, required=True)


class ListingTypeSerializer(ImportSerializer):
    class Meta:
        model = ListingType

    id = serializers.IntegerField(required=True)
    title = serializers.CharField(required=True, max_length=50)
    description = serializers.CharField(required=True, max_length=255)


class ProfileSerializer(ImportSerializer):
    class Meta:
        model = Profile

    id = serializers.IntegerField(required=True)
    display_name = serializers.CharField(required=True, max_length=255)
    bio = serializers.CharField(required=True, allow_blank=True, max_length=1000)
    dn = serializers.CharField(required=True, max_length=1000)
    issuer_dn = serializers.CharField(required=False, allow_null=True, allow_blank=True, max_length=1000)
    auth_expires = serializers.DateTimeField(required=True)
    access_control = serializers.CharField(required=True, max_length=16384)

    center_tour_flag = serializers.BooleanField(required=True)
    hud_tour_flag = serializers.BooleanField(required=True)
    webtop_tour_flag = serializers.BooleanField(required=True)
    email_notification_flag = serializers.BooleanField(required=True)
    listing_notification_flag = serializers.BooleanField(required=True)
    subscription_notification_flag = serializers.BooleanField(required=True)
    leaving_ozp_warning_flag = serializers.BooleanField(required=True)

    organizations = ManyReferenceField(Agency, required=True)
    stewarded_organizations = ManyReferenceField(Agency, required=True)


class ReviewSerializer(ImportSerializer):
    class Meta:
        model = Review

    id = serializers.IntegerField(required=True)
    text = serializers.CharField(required=False, allow_null=True, allow_blank=True, trim_whitespace=False,
                                 max_length=4000)
    rate = serializers.IntegerField(required=True)
    edited_date = serializers.DateTimeField(required=True)
    created_date = serializers.DateTimeField(required=True)

    listing = ReferenceField(Listing, required=True)
    author = ReferenceField(Profile, required=True)


class ScreenshotSerializer(ImportSerializer):
    class Meta:
        model = Screenshot

    id = serializers.IntegerField(required=True)
    description = serializers.CharField(required=False, allow_null=True, allow_blank=True, max_length=160)

    small_image = ReferenceField(Image, required=True)
    large_image = ReferenceField(Image, required=True)
    listing = ReferenceField(Listing, required=True)


class TagSerializer(ImportSerializer):
    class Meta:
        model = Tag

    id = serializers.IntegerField(required=True)
    name = serializers.CharField(required=True)
