from rest_framework import serializers

from ozpcenter import models


class CustomFieldTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.CustomFieldType
        exclude = ("import_metadata",)


class CustomFieldSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.CustomField
        exclude = ("import_metadata",)

    type = serializers.PrimaryKeyRelatedField(read_only=True)


class CustomFieldValueSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.CustomFieldValue
        exclude = ("import_metadata",)

    custom_field = serializers.PrimaryKeyRelatedField(read_only=True)


class DocUrlSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.DocUrl
        exclude = ("listing", "import_metadata")


class ReviewSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Review
        exclude = ("listing", "import_metadata")


class ScreenshotSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Screenshot
        exclude = ("listing", "import_metadata")


class ListingSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Listing
        exclude = ("import_metadata",)

    # Internal Entities
    doc_urls = DocUrlSerializer(many=True, read_only=True)
    reviews = ReviewSerializer(many=True, read_only=True)
    screenshots = ScreenshotSerializer(many=True, read_only=True)
    custom_fields = CustomFieldValueSerializer(many=True, read_only=True)

    # External Entities
    agency = serializers.PrimaryKeyRelatedField(read_only=True)
    banner_icon = serializers.PrimaryKeyRelatedField(read_only=True)
    categories = serializers.PrimaryKeyRelatedField(many=True, read_only=True)
    contacts = serializers.PrimaryKeyRelatedField(many=True, read_only=True)
    large_banner_icon = serializers.PrimaryKeyRelatedField(read_only=True)
    large_icon = serializers.PrimaryKeyRelatedField(read_only=True)
    listing_type = serializers.PrimaryKeyRelatedField(read_only=True)
    owners = serializers.PrimaryKeyRelatedField(many=True, read_only=True)
    small_icon = serializers.PrimaryKeyRelatedField(read_only=True)
    tags = serializers.PrimaryKeyRelatedField(many=True, read_only=True)
    required_listings = serializers.PrimaryKeyRelatedField(read_only=True)
    last_activity = serializers.PrimaryKeyRelatedField(read_only=True)
    current_rejection = serializers.PrimaryKeyRelatedField(read_only=True)
    intents = serializers.PrimaryKeyRelatedField(many=True, read_only=True)


class AgencySerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Agency
        exclude = ("import_metadata",)


class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Category
        exclude = ("import_metadata",)


class ChangeDetailSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.ChangeDetail
        exclude = ("import_metadata",)


class ContactSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Contact
        exclude = ("import_metadata",)


class ContactTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.ContactType
        exclude = ("import_metadata",)


class ImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Image
        exclude = ("import_metadata",)


class ImageTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.ImageType
        exclude = ("import_metadata",)


class IntentSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Intent
        exclude = ("import_metadata",)


class ListingActivitySerializer(serializers.ModelSerializer):
    class Meta:
        model = models.ListingActivity
        exclude = ("import_metadata",)


class ListingTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.ListingType
        exclude = ("import_metadata",)


class ProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Profile
        exclude = ("user", "import_metadata")


class TagSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Tag
        exclude = ("import_metadata",)
