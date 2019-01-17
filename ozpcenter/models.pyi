from datetime import datetime
from typing import ClassVar
from typing import List
from typing import Optional

from django.contrib.auth.models import User
from django.db import models

from .django_types import ManyRelatedManager


class AffiliatedStore(models.Model):
    objects: ClassVar['AffiliatedStoreManager']

    title: str
    server_url: str
    icon: Image
    is_enabled: bool


class AffiliatedStoreManager(models.Manager):

    def get_queryset(self) -> models.QuerySet: ...

    def find_all(self) -> List[AffiliatedStore]: ...

    def find_by_id(self, id: int) -> AffiliatedStore: ...


class ImportMetadata(models.Model):
    affiliated_store: AffiliatedStore
    external_id: int
    last_updated: datetime


class ExternalModel(models.Model):
    import_metadata: ImportMetadata
    is_external: bool


class Agency(ExternalModel):
    title: str
    icon: Image
    short_name: str


class ApplicationLibraryEntry(models.Model):
    objects: ClassVar['AccessControlApplicationLibraryEntryManager']

    folder: Optional[str]
    owner: Profile
    listing: Listing
    position: int


class AccessControlApplicationLibraryEntryManager(models.Manager): ...


class Category(ExternalModel):
    title: str
    description: Optional[str]


class ChangeDetail(ExternalModel):
    field_name: str
    old_value: Optional[str]
    new_value: Optional[str]


class Contact(ExternalModel):
    objects: ClassVar[ContactManager]

    secure_phone: Optional[str]
    unsecure_phone: Optional[str]
    email: str
    name: str
    organization: Optional[str]
    contact_type: ContactType


class ContactManager(models.Manager): ...


class ContactType(ExternalModel):
    name: str
    required: bool


class CustomFieldType(ExternalModel):
    name: str
    display_name: str
    media_type: str
    options: str


class CustomField(ExternalModel):
    objects: ClassVar['CustomFieldManager']

    type: CustomFieldType
    section: str
    display_name: str
    label: str
    description: str
    tooltip: str
    is_required: bool
    admin_only: bool
    properties: str
    all_listing_types: bool


class CustomFieldManager(models.Manager): ...


class CustomFieldValue(ExternalModel):
    objects: ClassVar['CustomFieldValueManager']

    custom_field: CustomField
    value: str


class CustomFieldValueManager(models.Manager): ...


class DocUrl(ExternalModel):
    objects: ClassVar['DocUrlManager']

    name: str
    url: str
    listing: Listing


class DocUrlManager(models.Manager): ...


class ImageType(ExternalModel):
    objects: ClassVar['ImageTypeManager']

    SMALL_ICON: ClassVar[str]
    LARGE_ICON: ClassVar[str]
    BANNER_ICON: ClassVar[str]
    LARGE_BANNER_ICON: ClassVar[str]
    SMALL_SCREENSHOT: ClassVar[str]
    LARGE_SCREENSHOT: ClassVar[str]

    name: str
    max_size_bytes: int
    max_width: int
    max_height: int
    min_width: int
    min_height: int


class ImageTypeManager(models.Manager):

    def internal_only(self) -> models.QuerySet: ...


class Image(ExternalModel):
    objects: ClassVar['AccessControlImageManager']

    uuid: str
    security_marking: str
    file_extension: str
    image_type: ImageType


class Intent(ExternalModel):
    action: str
    media_type: str
    label: str
    icon: Image


class AccessControlImageManager(models.Manager): ...


class Profile(ExternalModel):
    objects: ClassVar['ProfileManager']

    USER_ROLE: ClassVar[str]
    BETA_USER_ROLE: ClassVar[str]
    ORG_STEWARD_ROLE: ClassVar[str]
    AML_STEWARD_ROLE: ClassVar[str]
    API_EXPORT_ROLE: ClassVar[str]

    display_name: str
    bio: str
    dn: str
    issuer_dn: Optional[str]
    auth_expires: datetime
    access_control: str
    center_tour_flag: bool
    hud_tour_flag: bool
    webtop_tour_flag: bool
    email_notification_flag: bool
    listing_notification_flag: bool
    subscription_notification_flag: bool
    leaving_ozp_warning_flag: bool
    is_external: bool

    user: Optional[User]

    organizations: ManyRelatedManager[Agency]
    stewarded_organizations: ManyRelatedManager[Agency]

    def highest_role(self) -> str: ...

    def is_apps_mall_steward(self) -> bool: ...

    def is_steward(self) -> bool: ...

    def is_user(self) -> bool: ...

    def is_beta_user(self) -> bool: ...

    def _get_group_names(self) -> List[str]: ...


class ProfileManager(models.Manager): ...


class ListingActivity(ExternalModel):
    objects: ClassVar[AccessControlListingActivityManager]

    CREATED: ClassVar[str]
    MODIFIED: ClassVar[str]
    SUBMITTED: ClassVar[str]
    APPROVED_ORG: ClassVar[str]
    APPROVED: ClassVar[str]
    REJECTED: ClassVar[str]
    ENABLED: ClassVar[str]
    DISABLED: ClassVar[str]
    ENABLED_OUTSIDE_VISIBILITY: ClassVar[str]
    DISABLED_OUTSIDE_VISIBILITY: ClassVar[str]
    DELETED: ClassVar[str]
    REVIEW_EDITED: ClassVar[str]
    REVIEW_DELETED: ClassVar[str]
    PENDING_DELETION: ClassVar[str]
    REVIEWED: ClassVar[str]

    action: str
    activity_date: datetime
    description: Optional[str]

    author: Profile
    listing: Listing

    change_details: ManyRelatedManager[ChangeDetail]


class AccessControlListingActivityManager(models.Manager):

    def for_user(self, username: str) -> models.QuerySet: ...


class ListingType(ExternalModel):
    title: str
    description: str
    custom_fields: ManyRelatedManager[CustomField]


class Listing(ExternalModel):
    IN_PROGRESS: ClassVar[str]
    PENDING: ClassVar[str]
    APPROVED_ORG: ClassVar[str]
    APPROVED: ClassVar[str]
    REJECTED: ClassVar[str]
    DELETED: ClassVar[str]
    PENDING_DELETION: ClassVar[str]

    is_deleted: bool

    agency: Agency
    banner_icon: Image
    large_banner_icon: Image
    large_icon: Image
    listing_type: ListingType
    small_icon: Image

    categories: ManyRelatedManager[Category]
    contacts: ManyRelatedManager[Contact]
    custom_fields: ManyRelatedManager[CustomFieldValue]
    intents: ManyRelatedManager[Intent]
    owners: ManyRelatedManager[Profile]
    tags: ManyRelatedManager[Tag]


class ImportTask(models.Model):
    objects: ClassVar['ImportTaskManager']

    name: str
    update_type: str
    cron_exp: str
    exec_interval: int
    url: str
    extra_url_params: str
    enabled: bool
    last_run_result: ImportTaskResult
    keystore_path: str
    keystore_pass: str
    truststore_path: str

    def set_exec_interval(self, value: int, unit: str): ...


class ImportTaskManager(models.Manager):

    def get_queryset(self) -> models.QuerySet: ...

    def find_all(self) -> List[ImportTask]: ...

    def find_by_id(self, id: int) -> ImportTask: ...


class ImportTaskResult(models.Model):
    objects: ClassVar['ImportTaskResultManager']

    import_task: ImportTask
    message: str
    result: str
    run_date: datetime


class ImportTaskResultManager(models.Manager):

    def get_queryset(self) -> models.QuerySet: ...

    def find_all(self) -> List[ImportTaskResult]: ...

    def find_by_id(self, id: int) -> ImportTaskResult: ...

    def find_all_by_import_task(self, import_task_pk: int) -> List[ImportTaskResult]: ...


class Notification(models.Model):
    objects: ClassVar['NotificationManager']

    created_date: datetime
    message: str
    expires_date: datetime
    author: Profile
    dismissed_by: ManyRelatedManager[Profile]
    listing: Optional[Listing]
    agency: Optional[Agency]
    _peer: Optional[str]
    group_target: str
    entity_id: Optional[int]


class NotificationManager(models.Manager): ...


class NotificationMailbox(models.Model):
    objects: ClassVar['NotificationMailboxManager']

    target_profile: Profile
    notification: Notification
    emailed_status: bool
    read_status: bool
    acknowledged_status: bool


class NotificationMailboxManager(models.Manager): ...


class RecommendationFeedback(models.Model): ...


class RecommendationsEntry(models.Model): ...


class Review(ExternalModel):
    objects: ClassVar[AccessControlReviewManager]

    text: Optional[str]
    rate: int
    edited_date: datetime
    created_date: datetime

    listing: Listing
    author: Profile


class AccessControlReviewManager(models.Manager): ...


class Screenshot(ExternalModel):
    objects: ClassVar[ScreenshotManager]

    order: Optional[int]
    small_image: Image
    large_image: Image
    listing: Listing
    description: str


class ScreenshotManager(models.Manager): ...


class Subscription(models.Model): ...


class Tag(ExternalModel):
    name: str
