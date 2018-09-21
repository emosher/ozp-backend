"""
Category Model Access
"""
import logging

from django.db.models.functions import Lower
from django.core.exceptions import ObjectDoesNotExist
from ozpcenter import errors

from ozpcenter import models

import ozpcenter.model_access as generic_model_access


logger = logging.getLogger('ozp-center.' + str(__name__))


def get_all_categories():
    """
    Get all categories
    """
    return models.Category.objects.order_by(Lower('title')).all()


def get_category_by_title(title, reraise=False):
    """
    Get a category by title
    """
    try:
        return models.Category.objects.get(title=title)
    except models.Category.DoesNotExist as err:
        if reraise:
            raise err
        return None


def get_category_by_id(input_id, reraise=False):
    """
    Get a category by id
    """
    try:
        return models.Category.objects.get(id=input_id)
    except models.Category.DoesNotExist as err:
        if reraise:
            raise err
        return None


def get_listing_by_category_id(profile, category_id, reraise=False):
    """
    Get listings by category_id

    Args:
        profile
        category_id
        reraise(bool)
    """
    try:
        profile_highest_role = profile.highest_role()
        if profile_highest_role == 'APPS_MALL_STEWARD':
            # Get all listings that contain this category
            queryset = models.Listing.objects.filter(categories=category_id)
            return queryset
        elif profile_highest_role == 'ORG_STEWARD':
            # Get listings associated with Org Steward's agency(organization) that contain this category
            user_orgs = profile.stewarded_organizations.all()

            queryset = (models.Listing
                        .objects
                        .filter(categories__in=category_id, agency__in=user_orgs))
            return queryset

        else:
            # Get listings where the user is an owner that contain this category
            queryset = (models.Listing
                        .objects
                        .filter(categories=category_id,
                                owners=profile))
            return queryset

    except ObjectDoesNotExist as err:
        if reraise:
            raise err
        else:
            return None
