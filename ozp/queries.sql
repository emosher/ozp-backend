/*===========
query_name: example1
from ozpcenter.models import get_user_excluded_orgs;
get_user_excluded_orgs(Profile.objects.get(user__username='wsmith'))
===========*/
SELECT "ozpcenter_agency"."id", "ozpcenter_agency"."title", "ozpcenter_agency"."icon_id", "ozpcenter_agency"."short_name"
FROM "ozpcenter_agency"
WHERE NOT ("ozpcenter_agency"."id" IN (
	SELECT U0."id" AS Col1
	FROM "ozpcenter_agency" U0
	INNER JOIN "stewarded_agency_profile" U1 ON (U0."id" = U1."agency_id")
	WHERE U1."profile_id" = 5));

/*===========
query_name: get_listings
Query to get all listings
===========*/
SELECT
  ozpcenter_listing.id,
  ozpcenter_listing.title,
  ozpcenter_listing.approved_date,
  ozpcenter_listing.edited_date,
  ozpcenter_listing.description,
  ozpcenter_listing.launch_url,
  ozpcenter_listing.version_name,
  ozpcenter_listing.unique_name,
  ozpcenter_listing.what_is_new,
  ozpcenter_listing.usage_requirements,
  ozpcenter_listing.system_requirements,
  ozpcenter_listing.description_short,
  ozpcenter_listing.approval_status,
  ozpcenter_listing.is_enabled,
  ozpcenter_listing.is_featured,
  ozpcenter_listing.avg_rate,
  ozpcenter_listing.total_rate1,
  ozpcenter_listing.total_rate2,
  ozpcenter_listing.total_rate3,
  ozpcenter_listing.total_rate4,
  ozpcenter_listing.total_rate5,
  ozpcenter_listing.total_votes,
  ozpcenter_listing.total_reviews,
  ozpcenter_listing.feedback_score,
  ozpcenter_listing.iframe_compatible,
  ozpcenter_listing.security_marking,
  ozpcenter_listing.is_private,
  ozpcenter_listing.current_rejection_id,
  ozpcenter_listing.last_activity_id,
  ozpcenter_listing.listing_type_id,
  ozpcenter_listing.required_listings_id,
  ozpcenter_listing.is_deleted,

  /* One to Many */
  ozpcenter_listing.listing_type_id,
  ozpcenter_listingtype.title listing_type_title,

  /* One to Many Images*/
  ozpcenter_listing.agency_id agency_id,
  ozpcenter_agency.title agency_title,
  ozpcenter_agency.short_name agency_short_name,

  ozpcenter_listing.small_icon_id,
  small_icon.security_marking small_icon_security_marking,

  ozpcenter_listing.large_icon_id,
  large_icon.security_marking large_icon_security_marking,

  ozpcenter_listing.banner_icon_id,
  banner_icon.security_marking banner_icon_security_marking,

  ozpcenter_listing.large_banner_icon_id,
  large_banner_icon.security_marking large_banner_icon_security_marking,

  /* Many to Many */
  /* Category */
  category_listing.category_id,
  ozpcenter_category.title category_title,
  ozpcenter_category.description categorequiredry_description,

  /* Contact */
  contact_listing.contact_id contact_id,
  ozpcenter_contact.contact_type_id contact_type_id, /* Check to see if contact_id and contact_type_id is correct*/
  ozpcenter_contacttype.name contact_type_name,
  ozpcenter_contact.secure_phone contact_secure_phone,
  ozpcenter_contact.unsecure_phone contact_unsecure_phone,
  ozpcenter_contact.email contact_email,
  ozpcenter_contact.name contact_name,
  ozpcenter_contact.organization contact_organization,

  /* Tags */
  tag_listing.tag_id,
  ozpcenter_tag.name tag_name,

  /* Owners */
  owners.profile_id,
  owner_profile.display_name owner_display_name,
  owner_profile.user_id owner_user_id,
  owner_user.username owner_username,

  /* Intents */
  intent_listing.intent_id,
  ozpcenter_intent.action intent_action,

  /* Bookmarks */
  lib_entries.bookmark_count
FROM
  ozpcenter_listing
/* One to Many Joins */
JOIN ozpcenter_agency ON (ozpcenter_listing.agency_id = ozpcenter_agency.id)
JOIN ozpcenter_listingtype ON (ozpcenter_listingtype.id = ozpcenter_listing.listing_type_id)
JOIN ozpcenter_image small_icon ON (small_icon.id = ozpcenter_listing.small_icon_id)
JOIN ozpcenter_image large_icon ON (large_icon.id = ozpcenter_listing.small_icon_id)
JOIN ozpcenter_image banner_icon ON (banner_icon.id = ozpcenter_listing.small_icon_id)
JOIN ozpcenter_image large_banner_icon ON (large_banner_icon.id = ozpcenter_listing.small_icon_id)
/* Many to Many Joins */

/* Categories */
LEFT JOIN category_listing ON (category_listing.listing_id = ozpcenter_listing.id)
LEFT JOIN ozpcenter_category on (category_listing.category_id = ozpcenter_category.id)

/* Contacts */
LEFT JOIN contact_listing ON (contact_listing.listing_id = ozpcenter_listing.id)
LEFT JOIN ozpcenter_contact on (contact_listing.contact_id = ozpcenter_contact.id)
LEFT JOIN ozpcenter_contacttype on (ozpcenter_contact.contact_type_id = ozpcenter_contacttype.id)

/* Tags */
LEFT JOIN tag_listing ON (tag_listing.listing_id = ozpcenter_listing.id)
LEFT JOIN ozpcenter_tag ON (tag_listing.tag_id = ozpcenter_tag.id)

/* Owners */
LEFT JOIN profile_listing owners ON (owners.listing_id = ozpcenter_listing.id)
LEFT JOIN ozpcenter_profile owner_profile ON (owners.profile_id = owner_profile.id)
LEFT JOIN auth_user owner_user ON (owner_profile.user_id = owner_user.id)

/* Intent */
LEFT JOIN intent_listing ON (intent_listing.listing_id = ozpcenter_listing.id)
LEFT JOIN ozpcenter_intent ON (intent_listing.intent_id = ozpcenter_intent.id)

/* Bookmarks */
LEFT JOIN (SELECT ozpcenter_applicationlibraryentry.listing_id, count(ozpcenter_applicationlibraryentry.listing_id) bookmark_count
           FROM ozpcenter_applicationlibraryentry
           GROUP BY ozpcenter_applicationlibraryentry.listing_id) lib_entries ON (lib_entries.listing_id = ozpcenter_listing.id)
/*
Get Listings that are enabled, not deleted, and approved
*/
WHERE ozpcenter_listing.is_enabled = {} AND
      ozpcenter_listing.is_deleted = {} AND
      ozpcenter_listing.approval_status = 'APPROVED'
ORDER BY ozpcenter_listing.approved_date DESC;

/*===========
query_name: get_roles_orgs
Query to get user roles and orgs
===========*/
SELECT
  ozpcenter_profile.id profile_id,
  ozpcenter_profile.display_name profile_display_name,
  auth_user.username profile_username,
  auth_group.name profile_group_name,
  CASE auth_group.name
    WHEN 'APPS_MALL_STEWARD' THEN 1
    WHEN 'ORG_STEWARD' THEN 2
    WHEN 'USER' THEN 3
  END role_priority,
  agency.title agency_title,
  steward_agency.title steward_agency

FROM ozpcenter_profile
  JOIN auth_user ON (ozpcenter_profile.user_id = auth_user.id)
  JOIN auth_user_groups ON (auth_user_groups.user_id = auth_user.id)
  JOIN auth_group ON (auth_user_groups.group_id = auth_group.id)

  LEFT JOIN agency_profile ON (ozpcenter_profile.id = agency_profile.profile_id)
  LEFT JOIN ozpcenter_agency agency ON (agency_profile.agency_id = agency.id)

  LEFT JOIN stewarded_agency_profile ON (ozpcenter_profile.id = stewarded_agency_profile.profile_id)
  LEFT JOIN ozpcenter_agency steward_agency ON (stewarded_agency_profile.agency_id = steward_agency.id)

ORDER BY profile_username, role_priority
