import unittest
from typing import Union, List

from ozpcenter.models import AffiliatedStore
from ozpcenter.models import CustomField
from ozpcenter.models import CustomFieldType
from ozpcenter.models import CustomFieldValue
from ozpcenter.models import Image
from ozpcenter.models import ImageType
from ozpcenter.models import ImportTask
from ozpcenter.models import ImportTaskResult
from ozpcenter.models import Listing
from ozpcenter.models import ListingType
from ozpcenter.util import Mappable
from ozpcenter.util import expect
from . import AssertionsMixin

_AffiliatedStore = Union[AffiliatedStore, Mappable]
_CustomFieldType = Union[CustomFieldType, Mappable]
_Image = Union[Image, Mappable]
_ImageType = Union[ImageType, Mappable]
_ImportTask = Union[ImportTask, Mappable]
_ImportTaskResult = Union[ImportTaskResult, Mappable]
_Listing = Union[Listing, Mappable]
_ListingType = Union[ListingType, Mappable]
_CustomField = Union[CustomField, Mappable]
_CustomFieldValue = Union[CustomFieldValue, Mappable]


class ModelAssertionsMixin(AssertionsMixin,
                           unittest.TestCase):

    def assertHasId(self, actual: Mappable, expected: Mappable):
        self.assertPropertyEqualOrNotNone(actual, expected, 'id')

    def assertStoreEqual(self, actual: _AffiliatedStore, expected: _AffiliatedStore):
        self.assertHasId(actual, expected)
        self.assertPropertyEqual(actual, expected, 'title')
        self.assertPropertyEqual(actual, expected, 'server_url')
        self.assertPropertyEqual(actual, expected, 'is_enabled')
        self.assertPropertyEqual(actual, expected, 'icon', self.assertImageEqual)

    def assertStoresEqual(self, actual: List[_AffiliatedStore], expected: List[_AffiliatedStore]):
        self.assertEachEqual(actual, expected, self.assertStoreEqual)

    def assertImportTaskEqual(self, actual: _ImportTask, expected: _ImportTask):
        self.assertHasId(actual, expected)
        self.assertPropertyEqual(actual, expected, 'name')
        self.assertPropertyEqual(actual, expected, 'update_type')

    def assertImportTasksEqual(self, actual: List[_ImportTask], expected: List[_ImportTask]):
        self.assertEachEqual(actual, expected, self.assertImportTaskEqual)

    def assertImportTaskResultEqual(self, actual: _ImportTaskResult, expected: _ImportTaskResult):
        self.assertHasId(actual, expected)
        self.assertDateTimePropertyEqual(actual, expected, 'run_date')
        self.assertPropertyEqual(actual, expected, 'result')
        self.assertPropertyEqual(actual, expected, 'message')

    def assertImportTaskResultsEqual(self, actual: List[_ImportTaskResult], expected: List[_ImportTaskResult]):
        self.assertEachEqual(actual, expected, self.assertImportTaskResultEqual)

    def assertImageEqual(self, actual: Union[int, dict], expected: Union[int, dict, Image]):
        if type(expected) is int:
            if type(actual) is int:
                self.assertEqual(actual, expected)
            else:
                self.assertEqual(actual['id'], expected)
        else:
            self.assertHasId(actual, expected)
            self.assertPropertyEqual(actual, expected, 'security_marking')
            self.assertEqual(actual['url'], 'http://testserver/api/image/{}/'.format(expect.prop_of(expected, 'id')))

    def assertStoreRefEqual(self, actual: _AffiliatedStore, expected: _AffiliatedStore):
        self.assertIsNotNone(actual)
        self.assertIsNotNone(expected)

        self.assertHasId(actual, expected)
        self.assertPropertyEqual(actual, expected, 'title')

    def assertListingEqual(self, actual: _Listing, expected: _Listing):
        self.assertIsNotNone(actual)
        self.assertIsNotNone(expected)

        self.assertHasId(actual, expected)
        self.assertPropertyEqual(actual, expected, 'is_external')

    def assertListingTypeEqual(self, actual: _ListingType, expected: _ListingType):
        self.assertIsNotNone(actual)
        self.assertIsNotNone(expected)

        self.assertHasId(actual, expected)
        self.assertPropertyEqual(actual, expected, 'title')
        self.assertPropertyEqual(actual, expected, 'description')
        # self.assertPropertyEqual(actual, expected, 'custom_fields', self.assertCustomFieldsEqual)

    def assertListingTypesEqual(self, actual: List[_ListingType], expected: List[_ListingType]):
        self.assertEachEqual(actual, expected, self.assertListingTypeEqual)

    def assertCustomFieldTypeEqual(self, actual: Union[int, dict], expected: Union[int, dict, CustomFieldType]):
        if type(expected) is int:
            if type(actual) is int:
                self.assertEqual(actual, expected)
            else:
                self.assertEqual(actual['id'], expected)

        elif type(actual) is int:
            if type(expected) is int:
                self.assertEqual(actual, expected)
            else:
                self.assertEqual(expected.id, actual)
        else:
            self.assertIsNotNone(actual)
            self.assertIsNotNone(expected)

            self.assertHasId(actual, expected)
            self.assertPropertyEqual(actual, expected, 'name')

    def assertCustomFieldTypesEqual(self, actual: List[_CustomFieldType], expected: List[_CustomFieldType]):
        self.assertEachEqual(actual, expected, self.assertCustomFieldTypeEqual)

    def assertCustomFieldEqual(self, actual: Union[int, dict, _CustomField], expected: Union[int, dict, _CustomField]):
        if type(expected) is int:
            if type(actual) is int:
                self.assertEqual(actual, expected)
            else:
                self.assertEqual(actual['id'], expected)
        elif type(actual) is int:
            if type(expected) is int:
                self.assertEqual(actual, expected)
            else:
                self.assertEqual(expected.id, actual)
        else:
            self.assertIsNotNone(actual)
            self.assertIsNotNone(expected)

            self.assertHasId(actual, expected)
            self.assertPropertyEqual(actual, expected, 'type', self.assertCustomFieldTypeEqual)
            self.assertPropertyEqual(actual, expected, 'section')
            self.assertPropertyEqual(actual, expected, 'display_name')
            self.assertPropertyEqual(actual, expected, 'label')
            self.assertPropertyEqual(actual, expected, 'description')
            self.assertPropertyEqual(actual, expected, 'tooltip')
            self.assertPropertyEqual(actual, expected, 'is_required')
            self.assertPropertyEqual(actual, expected, 'admin_only')
            self.assertPropertyEqual(actual, expected, 'properties')
            self.assertPropertyEqual(actual, expected, 'all_listing_types')

    def assertCustomFieldsEqual(self, actual: List[_CustomField], expected: List[_CustomField]):
        self.assertEachEqual(actual, expected, self.assertCustomFieldEqual)

    def assertCustomFieldValueEqual(self, actual: Union[list, _CustomFieldValue],
                                    expected: Union[list, _CustomFieldValue]):
        if type(actual) is list:
            actual = actual.pop(0)
        self.assertIsNotNone(actual)
        self.assertIsNotNone(expected)

        self.assertHasId(actual, expected)
        self.assertPropertyEqual(actual, expected, 'custom_field', self.assertCustomFieldEqual)
        self.assertPropertyEqual(actual, expected, 'value')

    def assertCustomFieldValuesEqual(self, actual: List[_CustomFieldValue], expected: List[_CustomFieldValue]):
        self.assertEachEqual(actual, expected, self.assertCustomFieldValueEqual)

