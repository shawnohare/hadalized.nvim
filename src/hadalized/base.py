"""Base container for all model classes."""

from importlib.metadata import version
from typing import ClassVar, Self

from pydantic import BaseModel, ConfigDict, PrivateAttr

_version = version("hadalized")


class BaseNode(BaseModel):
    """An extension of pydantic.BaseModel that all model classes inherit."""

    model_config: ClassVar[ConfigDict] = ConfigDict(
        frozen=True,
    )

    _dumped: dict | None = PrivateAttr(None)
    _bytes: bytes | None = PrivateAttr(None)

    @property
    def package_version(self) -> str:
        """The hadalized package version."""
        return _version

    def __len__(self) -> int:
        """Length.

        Returns:
            The number of fields defined by the model.

        """
        return len(self.__class__.model_fields)

    def __getitem__(self, key: str):
        """Provide dict-like lookup for all models.

        Returns:
            The field specified by the input key.

        """
        return getattr(self, key.replace("-", "_"))

    @property
    def data(self) -> dict:
        """Cached model dump."""
        if self._dumped is None:
            self._dumped = self.model_dump()
        return self._dumped

    def model_dump_lua(self) -> str:
        """Dump the model as a lua table.

        Returns:
            A human readable lua table string.

        """
        import luadata

        # TODO: Unclear if we want to import luadata just for this
        return luadata.serialize(self.model_dump(mode="json"), indent="  ")

    def __hash__(self) -> int:
        """Make an instance hashable for use in cache and dict lookups.

        Defined for type checking purposes. Frozen models are hashable.

        Returns:
            The BaseModel hash.

        """
        return hash(super())

    def encode(self) -> bytes:
        """Bytes of the model's JSON dump.

        Returns:
            Hashable bytes containing the content of the model.

        """
        if self._bytes is None:
            self._bytes = self.model_dump_json().encode()
        return self._bytes

    def replace(self, **kwargs) -> Self:
        """Create a new instance with input arguments merged in.

        Returns:
            A new instance.

        """
        new_kwargs = self.model_dump() | kwargs
        return self.__class__.model_validate(new_kwargs)
