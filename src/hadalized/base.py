"""Base container for all model classes."""

from typing import ClassVar

import luadata
from pydantic import BaseModel, ConfigDict, PrivateAttr


class BaseNode(BaseModel):
    """An extension of the base model to give some dict like semantics."""

    model_config: ClassVar[ConfigDict] = ConfigDict(
        frozen=True,
    )
    _bytes: bytes | None = PrivateAttr(None)

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
        key = key.replace("-", "_")
        return getattr(self, key)

    def model_dump_lua(self) -> str:
        """Dump the model as a lua table.

        Returns:
            A human readable lua table string.

        """
        # TODO: Unclear if we want to import luadata just for this
        return luadata.serialize(self.model_dump(mode="json"), indent="  ")

    def __hash__(self) -> int:
        """Make an instance hashable for use in cache and dict lookups.

        Returns:
            The BaseModel hash.

        """
        # Defined for type checking purposes. Frozen models are hashable.
        return hash(super())

    def encode(self) -> bytes:
        """Bytes of the model's JSON dump.

        Returns:
            Hashable bytes containing the content of the model.

        """
        if self._bytes is None:
            self._bytes = self.model_dump_json().encode()
        return self._bytes
