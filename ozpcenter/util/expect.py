from datetime import datetime, timezone
from typing import Mapping, Any, Optional

from dateutil.parser import parse as parse_date

from . import Mappable
from .maybe import Maybe


def prop_of(obj: Mappable, property_name: str):
    if type(obj) is dict or isinstance(obj, Mapping):
        if property_name not in obj:
            raise AssertionError("property '{}' : no key in '{}'".format(property_name, type(obj)))
        return obj.get(property_name)

    try:
        return getattr(obj, property_name)
    except AttributeError:
        raise AssertionError("property '{}' : no attr in '{}'".format(property_name, type(obj)))


def maybe_prop_of(obj: Mappable, property_name: str) -> Maybe[Any]:
    if type(obj) is dict or isinstance(obj, Mapping):
        if property_name not in obj:
            return Maybe.empty()
        return Maybe.value_of(obj.get(property_name))

    try:
        return Maybe.value_of(getattr(obj, property_name))
    except AttributeError:
        return Maybe.empty()


def nullable_prop_of(obj: Mappable, property_name: str):
    if type(obj) is dict or isinstance(obj, Mapping):
        if property_name not in obj:
            return None
        return obj.get(property_name)

    try:
        return getattr(obj, property_name)
    except AttributeError:
        return None


def datetime_prop_of(obj: Mappable, property_name: str):
    value = prop_of(obj, property_name)

    return datetime_value(value, "property '%s'" % property_name)


def datetime_value(value, message: Optional[str] = None):
    if type(value) is str:
        value = parse_date(value)

    if type(value) is not datetime:
        default_message = "expected str or datetime, got %s" % type(value)
        raise AssertionError(format_message(default_message, message))

    if value.tzinfo is None:
        value = value.astimezone(timezone.utc)

    return value


def format_message(default_message: str, message: Optional[str] = None):
    if message:
        return "%s : %s" % (message, default_message)
    return default_message
