"""Handle application cache."""

import json
from contextlib import suppress
from functools import cache
from hashlib import blake2b
from pathlib import Path
from shutil import rmtree
from typing import TYPE_CHECKING, Protocol, Self

import xdg_base_dirs
from loguru import logger

if TYPE_CHECKING:
    from typing import ClassVar

    from jinja2 import Template


@cache
def hash_template(template: Template) -> str:
    """Hash the contents of a file."""
    data: bytes = b"null"
    if (fname := template.filename) is not None:
        with suppress(FileNotFoundError):
            data = Path(fname).read_bytes()
    return blake2b(data, digest_size=32).hexdigest()


class Hashable(Protocol):
    """An object whose content is hashable."""

    def hash(self) -> str: ...


class Cache:
    """Cache application level data."""

    default_dir: ClassVar[Path] = xdg_base_dirs.xdg_cache_home() / "hadalized"

    def __init__(self, cache_dir: Path = default_dir):
        # Use a single cache file until needs are warranted.
        self.cache_dir = cache_dir
        self.build_file = cache_dir / "builds.json"
        self.data = {}

    def load(self) -> Self:
        """Load the cache from cachefile."""
        try:
            with self.build_file.open(mode="r") as fp:
                logger.info(f"Loading cache file {self.build_file}")
                data: dict = json.load(fp)
        except FileNotFoundError:
            data = {}
        self.data = data
        return self

    def save(self):
        logger.info(f"Saving cache to {self.build_file}")
        self.build_file.parent.mkdir(parents=True, exist_ok=True)
        with self.build_file.open(mode="w") as fp:
            json.dump(self.data, fp)

    def clear(self):
        logger.info(f"Clearing cache directory {self.cache_dir}")
        with suppress(FileNotFoundError):
            rmtree(self.cache_dir)
        self.data = {}

    @staticmethod
    def _val(context: Hashable, template: Template) -> str:
        """Obtain digests for contents of the"""
        return f"{context.hash()},{hash_template(template)}"

    def add(self, path: Path, context: Hashable, template: Template):
        self.data[str(path)] = self._val(context, template)

    def check(self, path: Path, context: Hashable, template: Template) -> bool:
        """Check if a file needs to be re-generated.

        Returns:
            True if the palette file has been generated.

        """
        val = self._val(context, template)
        return path.exists() and self.data.get(str(path)) == val


# app_cache = Cache()
