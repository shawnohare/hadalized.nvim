"""BaseModel subclass providing hashability."""
from functools import reduce, cache
from operator import xor

from pydantic import BaseModel, ConfigDict


def hash_dict(inst: dict) -> int:
    """Simple hash of a dict whose values are either dicts or hashable."""

    def _hash(item: tuple) -> int:
        _, val = item
        if isinstance(val, dict):
            return hash_dict(val)
        elif isinstance(val, list):
            return reduce(xor, map(hash, val))
        else:
            return hash(item)

    return reduce(xor, map(_hash, inst.items()), 0)
    # return hash((type(inst), items))


class ModelDump(dict):
    """Subclass to ensure that cached model dumps return the same
    object instead of copies.
    """


class Model(BaseModel):
    """A hashable version of BaseModel with some basic dict-like
    semantics.
    """

    model_config = ConfigDict(extra="allow", frozen=True)

    def __setitem__(self, key: str, value) -> None:
        if hasattr(self, key):
            setattr(self, key, value)
        elif self.model_extra is not None:
            self.model_extra[key] = value

    def __getitem__(self, key: str):
        if hasattr(self, key):
            val = getattr(self, key)
        elif self.model_extra is not None:
            val = self.model_extra[key]
        else:
            raise KeyError("{key=} not found.")
        return val

    def get(self, key: str, default=None):
        """Equivalent to dict.get"""
        try:
            val = self[key]
        except (AttributeError, KeyError):
            val = default
        return val

    def items(self):
        for key, val in self:
            yield key, val

    def values(self):
        for _, val in self:
            yield val

    def keys(self):
        for key, _ in self:
            yield key

    def __hash__(self) -> int:
        if (val := self.get("_hash")) is not None or not isinstance(val, int):
            data = (
                type(self),
                hash_dict(self.__dict__),
                hash_dict(self.model_extra or {}),
            )
            val = hash(data)
            self["_hash"] = val
        return val

    @cache
    def dump(self) -> dict:
        """Cache a model dump. Will return the same dict instance
        with every call.
        """
        return ModelDump(self.model_dump())
