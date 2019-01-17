from typing import NamedTuple, Optional, List, Dict, Any

DEFAULT_SECURITY_MARKING = "UNCLASSIFIED"

AGENCY_ICON = "agency_icon"
INTENT_ICON = "intent_icon"
SMALL_ICON = "small_icon"
LARGE_ICON = "large_icon"
BANNER_ICON = "banner_icon"
LARGE_BANNER_ICON = "large_banner_icon"
SMALL_SCREENSHOT = "small_screenshot"
LARGE_SCREENSHOT = "large_screenshot"


class ImageData(NamedTuple):
    filename: str
    security_marking: str
    image_type_name: str


class AgencyData(NamedTuple):
    title: str
    short_name: str
    icon: ImageData


class CategoryData(NamedTuple):
    title: str
    description: str


class ContactData(NamedTuple):
    contact_type_name: str
    name: str
    email: str
    organization: Optional[str]
    secure_phone: Optional[str]
    unsecure_phone: Optional[str]


class ContactTypeData(NamedTuple):
    name: str
    required: bool


class CustomFieldData(NamedTuple):
    type_name: str
    section: str
    display_name: str
    label: str
    description: str
    tooltip: str
    is_required: bool
    admin_only: bool
    properties: Optional[str]
    all_listing_types: bool


class CustomFieldTypeData(NamedTuple):
    name: str
    display_name: str
    media_type: str
    options: Optional[str]


class CustomFieldValueData(NamedTuple):
    custom_field_label: str
    value: str


class ImageTypeData(NamedTuple):
    name: str
    min_width: int
    max_width: int
    min_height: int
    max_height: int
    max_size_bytes: int


class IntentData(NamedTuple):
    action: str
    media_type: str
    label: str
    icon: ImageData


class ListingTypeData(NamedTuple):
    title: str
    description: str


class ScreenshotData(NamedTuple):
    order: int
    description: str
    large_image: ImageData
    small_image: ImageData


class DocUrlData(NamedTuple):
    name: str
    url: str


class ListingActivityData(NamedTuple):
    action: str
    author_username: str


class ListingData(NamedTuple):
    title: str
    description: str
    description_short: str
    launch_url: str
    version_name: str
    unique_name: str
    what_is_new: str
    usage_requirements: str
    system_requirements: str
    security_marking: str
    is_enabled: bool
    is_private: bool
    is_featured: bool
    is_exportable: bool
    iframe_compatible: bool

    agency_title: str
    listing_type_title: str
    small_icon: ImageData
    large_icon: ImageData
    banner_icon: ImageData
    large_banner_icon: ImageData

    category_titles: List[str]
    contact_emails: List[str]
    owner_usernames: List[str]
    intent_actions: List[str]
    tag_names: List[str]

    activities: List[ListingActivityData]
    custom_field_values: List[CustomFieldValueData]
    doc_urls: List[DocUrlData]
    screenshots: List[ScreenshotData]



class AccessControlData(NamedTuple):
    clearances: List[str]
    formal_accesses: List[str]
    visas: List[str]


class ProfileData(NamedTuple):
    username: str
    display_name: str
    bio: str
    email: str
    dn: str
    groups: List[str]
    organizations: List[str]
    stewarded_organizations: List[str]
    access_control: AccessControlData


class TagData(NamedTuple):
    name: str


class ModelData(NamedTuple):
    agencies: List[AgencyData]
    categories: List[CategoryData]
    contacts: List[ContactData]
    contact_types: List[ContactTypeData]
    custom_fields: List[CustomFieldData]
    custom_field_types: List[CustomFieldTypeData]
    image_types: List[ImageTypeData]
    intents: List[IntentData]
    listings: List[ListingData]
    listing_types: List[ListingTypeData]
    profiles: List[ProfileData]
    tags: List[TagData]


def parse_model(data: Dict[str, Any]) -> ModelData:
    agencies = [parse_agency(agency) for agency in data["agencies"]]
    categories = [parse_category(category) for category in data["categories"]]
    contacts = [parse_contact(contact) for contact in data["contacts"]]
    contact_types = [parse_contact_type(contact_type) for contact_type in data["contact_types"]]
    custom_fields = [parse_custom_field(custom_field) for custom_field in data["custom_fields"]]
    custom_field_types = [parse_custom_field_type(field_type) for field_type in data["custom_field_types"]]
    image_types = [parse_image_type(image_type) for image_type in data["image_types"]]
    intents = [parse_intent(intent) for intent in data["intents"]]
    listings = [parse_listing(listing) for listing in data["listings"]]
    listing_types = [parse_listing_type(listing_type) for listing_type in data["listing_types"]]
    profiles = [parse_profile(profile) for profile in data["profiles"]]
    tags = [parse_tag(tag) for tag in data["tags"]]

    return ModelData(agencies=agencies,
                     categories=categories,
                     contacts=contacts,
                     contact_types=contact_types,
                     custom_fields=custom_fields,
                     custom_field_types=custom_field_types,
                     image_types=image_types,
                     intents=intents,
                     listings=listings,
                     listing_types=listing_types,
                     profiles=profiles,
                     tags=tags)


def parse_access_control(data: Dict[str, Any]) -> AccessControlData:
    return AccessControlData(clearances=data["clearances"],
                             formal_accesses=data["formal_accesses"],
                             visas=data["visas"])


def parse_agency(data: Dict[str, Any]) -> AgencyData:
    return AgencyData(title=data["title"],
                      short_name=data["short_name"],
                      icon=parse_image(data["icon"], AGENCY_ICON))


def parse_category(data: Dict[str, Any]) -> CategoryData:
    return CategoryData(title=data["title"],
                        description=data["description"])


def parse_contact(data: Dict[str, Any]) -> ContactData:
    return ContactData(contact_type_name=data["contact_type_name"],
                       name=data["name"],
                       email=data["email"],
                       organization=data.get("organization", None),
                       secure_phone=data.get("secure_phone", None),
                       unsecure_phone=data.get("unsecure_phone", None))


def parse_contact_type(data: Dict[str, Any]) -> ContactTypeData:
    return ContactTypeData(name=data["name"],
                           required=data["required"])


def parse_custom_field(data: Dict[str, Any]) -> CustomFieldData:
    return CustomFieldData(type_name=data["type_name"],
                           section=data["section"],
                           display_name=data["display_name"],
                           label=data["label"],
                           description=data["description"],
                           tooltip=data["tooltip"],
                           is_required=data["is_required"],
                           admin_only=data["admin_only"],
                           properties=data.get("properties", None),
                           all_listing_types=data["all_listing_types"])


def parse_custom_field_type(data: Dict[str, Any]) -> CustomFieldTypeData:
    return CustomFieldTypeData(name=data["name"],
                               display_name=data["display_name"],
                               media_type=data["media_type"],
                               options=data.get("options", None))


def parse_custom_field_value(data: Dict[str, any]) -> CustomFieldValueData:
    return CustomFieldValueData(custom_field_label=data["custom_field_label"],
                                value=data["value"])


def parse_doc_url(data: Dict[str, Any]) -> DocUrlData:
    return DocUrlData(name=data["name"],
                      url=data["url"])


def parse_image(data: Dict[str, Any], default_image_type: str) -> ImageData:
    return ImageData(filename=data["filename"],
                     security_marking=data.get("security_marking", DEFAULT_SECURITY_MARKING),
                     image_type_name=data.get("image_type_name", default_image_type))


def parse_image_type(data: Dict[str, Any]) -> ImageTypeData:
    return ImageTypeData(name=data["name"],
                         min_width=data.get("min_width", 16),
                         max_width=data.get("max_width", 2048),
                         min_height=data.get("min_height", 16),
                         max_height=data.get("max_height", 2048),
                         max_size_bytes=data.get("max_size_bytes", 2097152))


def parse_intent(data: Dict[str, Any]) -> IntentData:
    return IntentData(action=data["action"],
                      media_type=data["media_type"],
                      label=data["label"],
                      icon=parse_image(data["icon"], INTENT_ICON))


def parse_listing(data: Dict[str, Any]) -> ListingData:
    activities = [parse_listing_activity(activity) for activity in data["activities"]]
    custom_field_values = [parse_custom_field_value(field_value) for field_value in data["custom_field_values"]]
    doc_urls = [parse_doc_url(doc_url) for doc_url in data["doc_urls"]]
    screenshots = [parse_screenshot(screenshot) for screenshot in data["screenshots"]]

    return ListingData(title=data["title"],
                       description=data["description"],
                       description_short=data["description_short"],
                       launch_url=data["launch_url"],
                       version_name=data["version_name"],
                       unique_name=data["unique_name"],
                       what_is_new=data["what_is_new"],
                       usage_requirements=data["usage_requirements"],
                       system_requirements=data["system_requirements"],
                       security_marking=data["security_marking"],
                       is_enabled=data["is_enabled"],
                       is_private=data["is_private"],
                       is_featured=data["is_featured"],
                       is_exportable=data["is_exportable"],
                       iframe_compatible=data["iframe_compatible"],

                       agency_title=data["agency_title"],
                       listing_type_title=data["listing_type_title"],
                       small_icon=parse_image(data["small_icon"], SMALL_ICON),
                       large_icon=parse_image(data["large_icon"], LARGE_ICON),
                       banner_icon=parse_image(data["banner_icon"], BANNER_ICON),
                       large_banner_icon=parse_image(data["large_banner_icon"], LARGE_BANNER_ICON),

                       category_titles=data["category_titles"],
                       contact_emails=data["contact_emails"],
                       intent_actions=data.get("intent_actions", None),
                       owner_usernames=data["owner_usernames"],
                       tag_names=data["tag_names"],

                       activities=activities,
                       custom_field_values=custom_field_values,
                       doc_urls=doc_urls,
                       screenshots=screenshots)


def parse_listing_activity(data: Dict[str, Any]) -> ListingActivityData:
    return ListingActivityData(action=data["action"],
                               author_username=data["author_username"])


def parse_listing_type(data: Dict[str, Any]) -> ListingTypeData:
    return ListingTypeData(title=data["title"],
                           description=data["description"])


def parse_profile(data: Dict[str, Any]) -> ProfileData:
    orgs = data["organizations"] if data["organizations"] else []
    stewarded_orgs = data["stewarded_organizations"] if data["stewarded_organizations"] else []

    return ProfileData(username=data["username"],
                       display_name=data["display_name"],
                       bio=data["bio"],
                       email=data["email"],
                       dn=data["dn"],
                       groups=data["groups"],
                       organizations=orgs,
                       stewarded_organizations=stewarded_orgs,
                       access_control=parse_access_control(data["access_control"]))


def parse_screenshot(data: Dict[str, Any]) -> ScreenshotData:
    return ScreenshotData(order=data["order"],
                          description=data["description"],
                          large_image=parse_image(data["large_image"], LARGE_SCREENSHOT),
                          small_image=parse_image(data["small_image"], SMALL_SCREENSHOT))


def parse_tag(data: Dict[str, Any]) -> TagData:
    return TagData(name=data["name"])
