from typing import TypeVar, Generic, Optional

T = TypeVar('T')


class Maybe(Generic[T]):

    __is_empty: bool
    __value: Optional[T]

    @staticmethod
    def empty() -> 'Maybe[None]':
        return Maybe(True, None)

    @staticmethod
    def value_of(value: Optional[T]) -> 'Maybe[T]':
        if value is None:
            return Maybe(True, None)
        return Maybe(False, value)

    def __init__(self, is_empty: bool, value: Optional[T]):
        self.__is_empty = is_empty
        self.__value = value

    @property
    def is_empty(self) -> bool:
        return self.__is_empty

    @property
    def value(self) -> Optional[T]:
        if self.__is_empty:
            raise ValueError("Maybe is empty")
        return self.__value
