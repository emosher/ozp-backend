from typing import Optional

from django.core.exceptions import ObjectDoesNotExist

from ozpcenter.models import Profile


def get_profile(username: str) -> Optional[Profile]:
    try:
        return Profile.objects.get(user__username=username)
    except ObjectDoesNotExist:
        return None
