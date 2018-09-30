from typing import TypeVar, Iterable, Generic

T = TypeVar('T')


class QuerySet(Iterable[T], Generic[T]): ...


class ManyRelatedManager(Generic[T]):

    def all(self) -> QuerySet[T]:
        """ Get the QuerySet for all related objects. """
        ...

    def add(self, *objs: T, bulk: bool = True) -> None:
        """ Add the specified model objects to the related object set. """
        ...

    def remove(self, *objs: T, bulk: bool = True) -> None:
        """ Remove the specified model objects to the related object set. """
        ...
