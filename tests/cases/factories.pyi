from typing import TypeVar, Generic, List

import factory

from ozpcenter import models

T = TypeVar('T')


class GenericFactory(Generic[T]):

    @staticmethod
    def create_batch(num: int, **kwargs) -> List[T]: ...


class ImageTypeFactory(GenericFactory[models.ImageType],
                       factory.django.DjangoModelFactory):

    def __new__(cls, **kwargs) -> models.ImageType: ...


class CategoryFactory(GenericFactory[models.Category],
                      factory.django.DjangoModelFactory):

    def __new__(cls, **kwargs) -> models.Category: ...


class ContactFactory(GenericFactory[models.Contact],
                     factory.django.DjangoModelFactory):

    def __new__(cls, **kwargs) -> models.Contact: ...


class CustomFieldTypeFactory(GenericFactory[models.CustomFieldType],
                             factory.django.DjangoModelFactory):

    def __new__(cls, **kwargs) -> models.CustomFieldType: ...


class CustomFieldFactory(GenericFactory[models.CustomField],
                         factory.django.DjangoModelFactory):

    def __new__(cls, **kwargs) -> models.CustomField: ...


class CustomFieldValueFactory(GenericFactory[models.CustomFieldValue],
                              factory.django.DjangoModelFactory):

    def __new__(cls, **kwargs) -> models.CustomFieldValue: ...


class DocUrlFactory(GenericFactory[models.DocUrl],
                    factory.django.DjangoModelFactory):

    def __new__(cls, **kwargs) -> models.DocUrl: ...


class IntentFactory(GenericFactory[models.Intent],
                    factory.django.DjangoModelFactory):

    def __new__(cls, **kwargs) -> models.Listing: ...


class ListingActivityFactory(GenericFactory[models.ListingActivity],
                             factory.django.DjangoModelFactory):

    def __new__(cls, **kwargs) -> models.ListingActivity: ...


class ListingFactory(GenericFactory[models.Listing],
                     factory.django.DjangoModelFactory):

    def __new__(cls, **kwargs) -> models.Listing: ...


class TagFactory(GenericFactory[models.Tag],
                 factory.django.DjangoModelFactory):

    def __new__(cls, **kwargs) -> models.Tag: ...


class ScreenshotFactory(GenericFactory[models.Screenshot],
                        factory.django.DjangoModelFactory):

    def __new__(cls, **kwargs) -> models.Screenshot: ...


class AffiliatedStoreFactory(GenericFactory[models.AffiliatedStore],
                             factory.django.DjangoModelFactory):

    def __new__(cls, **kwargs) -> models.AffiliatedStore: ...
