import unittest
from typing import List, Callable

from ozpcenter.util import Mappable
from ozpcenter.util import expect


class AssertionsMixin(unittest.TestCase):

    def assertPropertyEqual(self, actual: Mappable, expected: Mappable, property_name: str, assertion: Callable = None):
        actual_value = expect.prop_of(actual, property_name)
        expected_value = expect.prop_of(expected, property_name)

        if assertion is not None:
            assertion(actual_value, expected_value)
        else:
            self.assertEqual(actual_value, expected_value, "property '%s' value" % property_name)

    def assertPropertyEqualValue(self, actual: Mappable, property_name: str, expected_value: any):
        actual_value = expect.prop_of(actual, property_name)

        self.assertEqual(actual_value, expected_value, "property '%s' value" % property_name)

    def assertPropertyIsNone(self, actual: Mappable, property_name: str):
        actual_value = expect.nullable_prop_of(actual, property_name)

        self.assertIsNone(actual_value, "property '%s' is None" % property_name)

    def assertPropertyNotNone(self, actual: Mappable, property_name: str):
        actual_value = expect.prop_of(actual, property_name)

        self.assertIsNotNone(actual_value, "property '%s' not None" % property_name)

    def assertPropertyEqualOrNotNone(self, actual: Mappable, expected: Mappable, property_name: str):
        actual_value = expect.prop_of(actual, property_name)
        expected_value = expect.maybe_prop_of(expected, property_name)

        if expected_value.is_empty:
            self.assertIsNotNone(actual_value, "property '%s' not None" % property_name)
        else:
            self.assertEqual(actual_value, expected_value.value, "property '%s'" % property_name)

    def assertDateTimePropertyEqual(self, actual: Mappable, expected: Mappable, property_name: str):
        expected_value = expect.maybe_prop_of(actual, property_name)

        if not expected_value.is_empty:
            self.assertEqual(expect.datetime_prop_of(actual, property_name),
                             expect.datetime_prop_of(expected, property_name))

    def assertEachEqual(self, actual: List[Mappable], expected: List[Mappable], comparator: Callable):
        self.assertIsNotNone(actual)
        self.assertIsNotNone(expected)

        expected_count = len(expected)
        self.assertEqual(len(actual), expected_count)
        for i in range(0, expected_count):
            comparator(actual[i], expected[i])
