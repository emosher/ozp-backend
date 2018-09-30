import abc
from typing import List

from django.contrib.auth.models import User
from rest_framework import permissions

from ozpcenter.models import Profile
from plugins import plugin_manager

SAFE_METHODS = ["GET", "HEAD", "OPTIONS"]


class BaseAuthentication(permissions.BasePermission, metaclass=abc.ABCMeta):
    def has_permission(self, request, view):
        if not request.user.is_authenticated():
            return False

        ozp_authorization = plugin_manager.get_system_authorization_plugin()
        ozp_authorization.authorization_update(request.user.username, request=request)

        return self.has_authorization(request, view)

    @abc.abstractmethod
    def has_authorization(self, request, view):
        pass


class IsAppsMallSteward(permissions.BasePermission):

    def has_permission(self, request, view):
        return has_any_role(request.user, [Profile.AML_STEWARD_ROLE])


class IsAppsMallStewardOrReadOnly(BaseAuthentication):
    def has_authorization(self, request, view):
        return (request.method in SAFE_METHODS or
                has_any_role(request.user, [Profile.AML_STEWARD_ROLE]))


class IsAmlStewardOrHasExportRole(BaseAuthentication):
    def has_authorization(self, request, view):
        return has_any_role(request.user, [Profile.API_EXPORT_ROLE, Profile.AML_STEWARD_ROLE])


class IsOrgSteward(BaseAuthentication):
    def has_authorization(self, request, view):
        return has_any_role(request.user, [Profile.AML_STEWARD_ROLE, Profile.ORG_STEWARD_ROLE])


class IsOrgStewardOrReadOnly(BaseAuthentication):
    def has_authorization(self, request, view):
        return (request.method in SAFE_METHODS or
                has_any_role(request.user, [Profile.AML_STEWARD_ROLE, Profile.ORG_STEWARD_ROLE]))


class IsUser(BaseAuthentication):
    def has_authorization(self, request, view):
        return has_any_role(request.user, [Profile.AML_STEWARD_ROLE, Profile.ORG_STEWARD_ROLE, Profile.USER_ROLE, Profile.API_EXPORT_ROLE])


def has_any_role(user: User, role_names: List[str]) -> bool:
    user_role_names = [role.name for role in user.groups.all()]

    for role in user_role_names:
        if role in role_names:
            return True
    return False
