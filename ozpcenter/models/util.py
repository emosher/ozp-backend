from .agency import Agency


def get_user_excluded_orgs(profile_instance):
    """
    Get exclude organizations for private apps

    from ozpcenter.models import get_user_excluded_orgs; get_user_excluded_orgs(Profile.objects.get(user__username='wsmith'))
    """
    highest_role = profile_instance.highest_role()
    # having highest_role variable reduce 1949 to 1574 (wsmith)
    if highest_role == 'APPS_MALL_STEWARD':
        exclude_orgs = []
    elif highest_role == 'ORG_STEWARD':
        user_orgs = profile_instance.stewarded_organizations.all()
        # Commenting this out reduce DB 3811 to 3623 for /api/listing
        # user_orgs = [i.title for i in user_orgs]
        exclude_orgs = Agency.objects.exclude(pk__in=user_orgs)
    else:
        user_orgs = profile_instance.organizations.all()
        exclude_orgs = Agency.objects.exclude(pk__in=user_orgs)

    return exclude_orgs
