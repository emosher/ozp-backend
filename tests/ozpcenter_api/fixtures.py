import json
import uuid
from typing import Optional

from django.contrib.auth.models import Group, User

from ozpcenter.api.agency.model_access import get_agency_by_title
from ozpcenter.models import AffiliatedStore
from ozpcenter.models import Agency
from ozpcenter.models import ContactType
from ozpcenter.models import CustomField
from ozpcenter.models import CustomFieldType
from ozpcenter.models import CustomFieldValue
from ozpcenter.models import Image
from ozpcenter.models import ImageType
from ozpcenter.models import ImportTask
from ozpcenter.models import ImportTaskResult
from ozpcenter.models import Listing
from ozpcenter.models import ListingType
from ozpcenter.models import Profile


def find_group_by_name(name: str) -> Optional[Group]:
    try:
        return Group.objects.get(name=name)
    except Group.DoesNotExist:
        return None


def create_contact_type(name: str, required: bool = False) -> ContactType:
    contact_type = ContactType(name=name,
                               required=required)
    contact_type.save()
    return contact_type


def create_group(name: str) -> Group:
    existing = find_group_by_name(name)
    if existing is not None:
        return existing

    group = Group(name=name)
    group.save()
    return group


def create_image_type(name: str, **kwargs):
    image_type = ImageType(name=name,
                           min_width=kwargs.get('min_width', 16),
                           min_height=kwargs.get('min_height', 16),
                           max_width=kwargs.get('max_width', 2048),
                           max_height=kwargs.get('max_height', 2048),
                           max_size_bytes=kwargs.get('max_size_bytes', 2097152))
    image_type.save()
    return image_type


def create_image(image_type: ImageType, **kwargs):
    image = Image(image_type=image_type,
                  uuid=kwargs.get('uuid', str(uuid.uuid4())),
                  security_marking=kwargs.get('security_marking', 'UNCLASSIFIED'),
                  file_extension=kwargs.get('file_extension', '.png'))
    image.save()
    return image


def create_agency(title: str, short_name: str) -> Agency:
    existing = get_agency_by_title(title)
    if existing is not None:
        return existing

    agency = Agency(title=title,
                    short_name=short_name)
    agency.save()
    return agency


def create_superuser(username: str, email: str, password: str) -> User:
    return User.objects.create_superuser(username, email, password)


def create_user(username: str, email: str, password: str) -> User:
    return User.objects.create_user(username, email, password)


def create_profile(user: Optional[User], display_name: str, dn: str, bio: str,
                   access_control: Optional[dict]) -> Profile:
    profile = Profile(user=user,
                      display_name=display_name,
                      dn=dn,
                      issuer_dn=None,
                      access_control=json.dumps(access_control),
                      bio=bio)
    profile.save()
    return profile


def create_custom_field_value(listing: Listing, custom_field: CustomField, value: str) -> CustomFieldValue:
    custom_field_value = CustomFieldValue(listing=listing,
                                          custom_field=custom_field,
                                          value=value)
    custom_field_value.save()
    return custom_field_value


def create_minimal_listing(title: str, security_marking: str, agency: Agency) -> Listing:
    listing = Listing(title=title, security_marking=security_marking, agency=agency)
    listing.save()
    return listing


def create_custom_field(type: CustomFieldType, display_name: str, label: str, ) -> CustomField:
    custom_field = CustomField(type=type, display_name=display_name, label=label)
    custom_field.save()
    return custom_field


def create_custom_field_type(name: str, display_name: str, media_type: str, ) -> CustomFieldType:
    custom_field_type = CustomFieldType(name=name, media_type=media_type, display_name=display_name)
    custom_field_type.save()
    return custom_field_type


def create_import_task(name: str, update_type: str, affiliated_store: AffiliatedStore) -> ImportTask:
    import_task = ImportTask(name=name, update_type=update_type, affiliated_store=affiliated_store)
    import_task.save()
    return import_task


def create_import_task_result(import_task: ImportTask, message: str, result: str) -> ImportTaskResult:
    import_task_result = ImportTaskResult(import_task=import_task,
                                          message=message,
                                          result=result)
    import_task_result.save()
    return import_task_result


def create_steward(agency: Agency = None) -> Profile:
    return _create_profile(AML_STEWARD_PROFILE, agency)


def create_org_steward(agency: Agency = None) -> Profile:
    return _create_profile(ORG_STEWARD_PROFILE, agency)


def create_user_profile(agency: Agency = None) -> Profile:
    return _create_profile(USER_PROFILE, agency)


def create_listing_type(title: str, description: str) -> ListingType:
    listing_type = ListingType(title=title, description=description)
    listing_type.save()
    return listing_type


def create_export_profile(agency: Agency = None) -> Profile:
    return _create_profile(EXPORT_USER_PROFILE, agency)


def create_affiliated_store(title: str, server_url: str, icon: Image, is_enabled: bool) -> AffiliatedStore:
    store = AffiliatedStore(title=title,
                            server_url=server_url,
                            icon=icon,
                            is_enabled=is_enabled)
    store.save()
    return store


def _create_profile(details: dict, agency: Agency = None) -> Profile:
    if agency is None:
        agency = create_agency('Ministry of Truth', 'Minitrue')

    group = create_group(details['group'])

    if details['group'] in [Profile.AML_STEWARD_ROLE, Profile.ORG_STEWARD_ROLE]:
        user = create_superuser(details['username'], details['email'], details['password'])
    else:
        user = create_user(details['username'], details['email'], details['password'])

    user.groups.add(group)

    profile = create_profile(user,
                             details['display_name'],
                             details['dn'],
                             details['bio'],
                             details['access_control'])

    profile.organizations.add(agency)

    if details['group'] == ORG_STEWARD_GROUP:
        profile.stewarded_organizations.add(agency)

    return profile

AML_STEWARD_GROUP = 'APPS_MALL_STEWARD'
ORG_STEWARD_GROUP = 'ORG_STEWARD'
USER_GROUP = 'USER'

EXPORT_USER_PROFILE = {
    'group': Profile.API_EXPORT_ROLE,
    'username': 'exporter',
    'email': 'exporter@oceania.gov',
    'password': 'password',
    'display_name': 'Export User',
    'dn': 'Export User exporter',
    'bio': '',
    'access_control': {
        'clearances': ['UNCLASSIFIED', 'CONFIDENTIAL', 'SECRET', 'TOP SECRET'],
        'formal_accesses': ['SIERRA', 'TANGO', 'GOLF', 'HOTEL'],
        'visas': ['NOVEMBER']
    }
}

AML_STEWARD_PROFILE = {
    'group': Profile.AML_STEWARD_ROLE,
    'username': 'bigbrother',
    'email': 'bigbrother@oceania.gov',
    'password': 'password',
    'display_name': 'Big Brother',
    'dn': 'Big Brother bigbrother',
    'bio': 'I make everyones life better',
    'access_control': {
        'clearances': ['UNCLASSIFIED', 'CONFIDENTIAL', 'SECRET', 'TOP SECRET'],
        'formal_accesses': ['SIERRA', 'TANGO', 'GOLF', 'HOTEL'],
        'visas': ['NOVEMBER']
    }
}

ORG_STEWARD_PROFILE = {
    'group': Profile.ORG_STEWARD_ROLE,
    'username': 'wsmith',
    'email': 'wsmith@oceania.gov',
    'password': 'password',
    'display_name': 'Winston Smith',
    'dn': 'Winston Smith wsmith',
    'bio': 'I work at the Ministry of Truth',
    'access_control': {
        'clearances': ['UNCLASSIFIED', 'CONFIDENTIAL', 'SECRET', 'TOP SECRET'],
        'formal_accesses': ['SIERRA', 'TANGO'],
        'visas': ['NOVEMBER']
    }
}

USER_PROFILE = {
    'group': Profile.USER_ROLE,
    'username': 'jones',
    'email': 'jones@airstripone.com',
    'password': 'password',
    'display_name': 'Jones',
    'dn': 'Jones jones',
    'bio': 'I am a normal person',
    'access_control': {
        'clearances': ['UNCLASSIFIED', 'CONFIDENTIAL', 'SECRET'],
        'formal_accesses': [],
        'visas': ['NOVEMBER']
    }
}
