"""Base container for all model classes."""

from functools import cache
from typing import ClassVar

import luadata
from pydantic import BaseModel, ConfigDict


class BaseNode(BaseModel):
    """An extension of the base model to give some dict like semantics."""

    model_config: ClassVar[ConfigDict] = ConfigDict(
        frozen=True,
    )

    def __len__(self) -> int:
        return len(self.__class__.model_fields)

    def __getitem__(self, key: str):
        key = key.replace("-", "_")
        return getattr(self, key)

    def model_dump_lua(self) -> str:
        # TODO: Unclear if we want to import luadata just for this
        return luadata.serialize(self.model_dump(mode="json"), indent="  ")

    def __hash__(self) -> int:
        # Defined for type checking purposes. Frozen models are hashable.
        return hash(super())

    @cache
    def encode(self) -> bytes:
        return self.model_dump_json().encode()
