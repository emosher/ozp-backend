from typing import TypeVar, Dict, Type, Optional, List

from rest_framework import serializers

from ozpcenter.models import ExternalModel

S_co = TypeVar('S_co', bound=serializers.Serializer, covariant=True)
M_co = TypeVar('M_co', bound=ExternalModel, covariant=True)


class ModelDict(object):
    def __init__(self):
        self.models: Dict[Type[M_co], Dict[int, M_co]] = {}

    def get(self, cls: Type[M_co], external_id: int) -> Optional[M_co]:
        cls_models = self.models.get(cls, None)
        if cls_models is None:
            return None

        return cls_models.get(external_id, None)

    def list(self, cls: Type[M_co]) -> List[M_co]:
        cls_models = self.models.get(cls, None)
        if cls_models is None:
            return list()

        return list(cls_models.values())

    def add(self, instance: M_co) -> None:
        cls = type(instance)
        if cls not in self.models:
            self.models[cls] = {}

        external_id = instance.import_metadata.external_id

        self.models[cls][external_id] = instance
