from typing import List
from typing import Tuple

from rest_framework.test import APIClient

from ozpcenter.models import Profile


class BaseAPI(object):

    def __init__(self, base_url: str, client: APIClient):
        self.base_url = base_url
        self.client = client

    def authenticate_as(self, profile: Profile):
        self.client.force_authenticate(user=profile.user)

    def list(self) -> Tuple[int, List[dict]]:
        return self.client.get("%s/" % self.base_url, format="json")

    def get(self, resource_id: int, data=None, auth: Profile = None) -> Tuple[int, dict]:
        if auth is not None:
            self.authenticate_as(auth)

        response = self.client.get("%s/%s/" % (self.base_url, resource_id), data, format="json")

        return response.status_code, response.data

    def create(self, data=None, auth: Profile = None) -> Tuple[int, dict]:
        if auth is not None:
            self.authenticate_as(auth)

        response = self.client.post("%s/" % self.base_url, data, format="json")

        return response.status_code, response.data

    def update(self, resource_id: int, data=None, auth: Profile = None) -> Tuple[int, dict]:
        if auth is not None:
            self.authenticate_as(auth)

        response = self.client.put("%s/%s/" % (self.base_url, resource_id), data, format="json")

        return response.status_code, response.data

    def patch(self, resource_id: int, data=None, auth: Profile = None) -> Tuple[int, dict]:
        if auth is not None:
            self.authenticate_as(auth)

        response = self.client.patch("%s/%s/" % (self.base_url, resource_id), data, format="json")

        return response.status_code, response.data

    def delete(self, resource_id: int, data=None):
        response = self.client.delete("%s/%s/" % (self.base_url, resource_id), data, format="json")

        return response.status_code, response.data


class ListingAPI(BaseAPI):

    def __init__(self, client: APIClient):
        super().__init__("/api/listing", client)

    def get_activity(self, listing_id: int, data=None):
        return self.client.get("%s/%s/activity/" % (self.base_url, listing_id), data, format="json")
