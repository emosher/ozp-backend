from typing import Optional

from ozpcenter.django_types import QuerySet

from ozpcenter.models import CustomFieldValue
from ozpcenter.models import Listing
from ozpcenter.models import Profile


def get_listing_by_id(username: str, id: int, reraise: bool = False) -> Optional[Listing]: ...


def create_listing(author: Profile, listing: Listing) -> Listing:
    """ Add the CREATED ListingActivity to the Listing and set approval status to IN_PROGRESS """
    ...


def submit_listing(author: Profile, listing: Listing) -> Listing:
    """ Add the SUBMITTED ListingActivity to the Listing and set approval status to PENDING """
    ...


def approve_listing_by_org_steward(org_steward: Profile, listing: Listing) -> Listing:
    """ Add the APPROVED_ORG ListingActivity to the Listing and set approval status to APPROVED_ORG """
    ...


def approve_listing(steward: Profile, listing: Listing) -> Listing:
    """ Add the APPROVED ListingActivity to the Listing and set approval status to APPROVED """
    ...


def get_all_custom_field_values() -> QuerySet[CustomFieldValue]: ...


def get_custom_field_value_by_id(id: int, reraise: bool = False) -> Optional[CustomFieldValue]: ...


def is_listing_owner_or_admin(username: str, instance: Listing) -> bool:
    """
    :raises [errors.PermissionDenied]
    """
    ...
