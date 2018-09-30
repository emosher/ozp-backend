import random
import uuid

import factory

from ozpcenter import models


def _generate_uuid():
    return str(uuid.uuid4())


class ImageTypeFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = models.ImageType
        django_get_or_create = ("name",)

    name = factory.Sequence(lambda n: "image_type_%s" % n)

    max_size_bytes = 1048576

    max_width = 2048
    min_width = 16
    max_height = 2048
    min_height = 16


class ImageFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = models.Image
        django_get_or_create = ("uuid",)

    uuid = factory.LazyFunction(_generate_uuid)

    security_marking = "UNCLASSIFIED"

    file_extension = "png"

    image_type = factory.SubFactory(ImageTypeFactory)


class AgencyFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = models.Agency
        django_get_or_create = ("title",)

    title = factory.Sequence(lambda n: "Three Letter Agency %s" % n)

    short_name = factory.Sequence(lambda n: "TLA %s" % n)

    icon = factory.SubFactory(ImageFactory, image_type__name="agency_icon")

    @staticmethod
    def create_default_agencies():
        return [
            AgencyFactory(title="Ministry of Truth", short_name="Minitrue"),
            AgencyFactory(title="Ministry of Peace", short_name="Minipax"),
            AgencyFactory(title="Ministry of Love", short_name="Miniluv"),
            AgencyFactory(title="Ministry of Plenty", short_name="Miniplen"),
        ]


class ProfileFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = models.Profile
        django_get_or_create = ("dn",)

    display_name = factory.Faker('name')

    bio = factory.Faker('text', max_nb_chars=100)

    dn = factory.Faker('user_name')

    @factory.post_generation
    def organizations(self, create, extracted, **kwargs):
        if not create:
            return

        if extracted:
            for agency in extracted:
                self.organizations.add(agency)
            return

        self.organizations.add(
            AgencyFactory(**random.choice([
                {"title": "Ministry of Truth", "short_name": "Minitrue"},
                {"title": "Ministry of Peace", "short_name": "Minipax"},
                {"title": "Ministry of Love", "short_name": "Miniluv"},
                {"title": "Ministry of Plenty", "short_name": "Miniplen"}
            ]))
        )


class AffiliatedStoreFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = models.AffiliatedStore

    title = factory.Sequence(lambda n: "Affiliated Store %s" % n)

    server_url = factory.Sequence(lambda n: "http://www.store-%s.com" % n)

    icon = None

    is_enabled = True


class CategoryFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = models.Category
        django_get_or_create = ("title",)

    title = factory.Sequence(lambda n: "Category %s" % (n + 1))

    description = factory.Faker('text', max_nb_chars=500, ext_word_list=None)


class ContactTypeFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = models.ContactType
        django_get_or_create = ("name",)

    name = factory.Sequence(lambda n: "Contact Type %s" % (n + 1))

    required = False


class ContactFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = models.Contact

    name = factory.Sequence(lambda n: "Contact %s" % (n + 1))

    email = "test@email.com"

    contact_type = factory.SubFactory(ContactTypeFactory)


class IntentFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = models.Intent

    action = factory.Sequence(lambda n: "/application/json/intent_%s" % (n + 1))

    media_type = "vnd.ozp-intent-v1+json.json"

    label = factory.Sequence(lambda n: "Intent %s" % (n + 1))

    icon = factory.SubFactory(ImageFactory, image_type__name="intent_icon")


class ListingTypeFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = models.ListingType
        django_get_or_create = ("title",)

    title = factory.Sequence(lambda n: "Listing Type %s" % (n + 1))

    description = factory.Sequence(lambda n: "Listing Type %s" % (n + 1))


class ListingFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = models.Listing

    title = factory.Sequence(lambda n: "Listing %s" % (n + 1))

    agency = factory.SubFactory(AgencyFactory)

    listing_type = factory.SubFactory(ListingTypeFactory)

    banner_icon = factory.SubFactory(ImageFactory, image_type__name="banner_icon")
    large_banner_icon = factory.SubFactory(ImageFactory, image_type__name="large_banner_icon")
    small_icon = factory.SubFactory(ImageFactory, image_type__name="small_icon")
    large_icon = factory.SubFactory(ImageFactory, image_type__name="large_icon")

    is_exportable = False

    @factory.post_generation
    def reviews(self, create, extracted, **kwargs):
        if not create or not extracted:
            return

        if type(extracted) is int:
            for i in range(1, extracted + 1):
                self.reviews.add(ReviewFactory(listing=self))
            return

        for review in extracted:
            self.reviews.add(review)


class DocUrlFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = models.DocUrl

    name = factory.Faker('uri_page')

    url = factory.Faker('uri')


class ListingActivityFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = models.ListingActivity

    action = factory.Iterator(models.ListingActivity.ACTION_CHOICES, getter=lambda c: c[0])

    description = factory.Faker('text', max_nb_chars=255)

    @factory.post_generation
    def change_details(self, create, extracted, **kwargs):
        if not create or not extracted:
            return

        if type(extracted) is int:
            for i in range(1, extracted + 1):
                self.change_details.add(ChangeDetailFactory(field_name="Field %i" % i))
            return

        for group in extracted:
            self.change_details.add(group)


class ReviewFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = models.Review

    text = factory.Faker('text', max_nb_chars=200)

    rate = factory.Iterator([1, 2, 3, 4, 5])

    author = factory.SubFactory(ProfileFactory)


class ChangeDetailFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = models.ChangeDetail

    field_name = factory.Faker('text', max_nb_chars=100)

    old_value = factory.Faker('text', max_nb_chars=50)

    new_value = factory.Faker('text', max_nb_chars=50)


class TagFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = models.Tag
        django_get_or_create = ("name",)

    name = factory.Sequence(lambda n: "Tag %s" % (n + 1))


class ScreenshotFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = models.Screenshot

    small_image = factory.SubFactory(ImageFactory, image_type__name="small_screenshot")

    large_image = factory.SubFactory(ImageFactory, image_type__name="large_screenshot")

    description = factory.Faker('text', max_nb_chars=160)


class CustomFieldTypeFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = models.CustomFieldType

    name = factory.Sequence(lambda n: "CustomFieldType %s" % (n + 1))
    display_name = factory.Sequence(lambda n: "CustomFieldType %s" % (n + 1))

    media_type = factory.Faker('text', max_nb_chars=50)
    options = factory.Faker('text', max_nb_chars=50)


class CustomFieldFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = models.CustomField

    display_name = factory.Sequence(lambda n: "CustomField %s" % (n + 1))
    label = factory.Sequence(lambda n: "CustomField %s" % (n + 1))

    section = factory.Faker('text', max_nb_chars=50)
    description = factory.Faker('text', max_nb_chars=50)
    tooltip = factory.Faker('text', max_nb_chars=50)
    is_required = factory.Faker('pybool')
    admin_only = factory.Faker('pybool')
    properties = factory.Faker('text', max_nb_chars=50)
    all_listing_types = factory.Faker('pybool')

    type = factory.SubFactory(CustomFieldTypeFactory)


class CustomFieldValueFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = models.CustomFieldValue

    value = factory.Sequence(lambda n: "CustomFieldValue %s" % (n + 1))

    custom_field = factory.SubFactory(CustomFieldFactory)

