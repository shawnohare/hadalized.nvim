"""Handle application cache."""

import json
from contextlib import suppress
from functools import cache
from hashlib import blake2b
from pathlib import Path
from shutil import rmtree
from typing import TYPE_CHECKING, Self

import xdg_base_dirs
from loguru import logger

if TYPE_CHECKING:
    from typing import ClassVar

    from jinja2 import Template

    from hadalized.models import BaseNode


# @cache
# def hash_template(template: Template) -> str:
#     """Hash the contents of a file."""
#     data: bytes = b"null"
#     if (fname := template.filename) is not None:
#         with suppress(FileNotFoundError):
#             data = Path(fname).read_bytes()
#     return blake2b(data, digest_size=32).hexdigest()
#

@cache
def get_template_bytes(template: Template) -> bytes:
    """Get template source bytes."""
    data: bytes = b"null"
    if (fname := template.filename) is not None:
        with suppress(FileNotFoundError):
            data = Path(fname).read_bytes()
    return data


@cache
def get_context_bytes(context: BaseNode) -> bytes:
    return context.model_dump_json().encode()

@cache
def _hash(context: BaseNode, template: Template) -> str:
    """Obtain digests for contents used to render a template. Used as
    an equivalent for the hash of a rendered template"""
    data = get_context_bytes(context) + get_template_bytes(template)
    return blake2b(data, digest_size=32).hexdigest()

class Cache:
    """Cache application level data."""

    default_dir: ClassVar[Path] = xdg_base_dirs.xdg_cache_home() / "hadalized"

    def __init__(self, cache_dir: Path = default_dir):
        # Use a single cache file until needs are warranted.
        self.cache_dir = cache_dir
        self._build_file = cache_dir / "builds.json"
        self._build_data = {}

    def load(self) -> Self:
        """Load the cache from cachefile."""
        try:
            with self._build_file.open(mode="r") as fp:
                logger.info(f"Loading build cache file {self._build_file}")
                data: dict = json.load(fp)
        except FileNotFoundError:
            data = {}
        self._build_data = data
        return self

    def save(self):
        logger.info(f"Saving build cache to {self._build_file}")
        self._build_file.parent.mkdir(parents=True, exist_ok=True)
        with self._build_file.open(mode="w") as fp:
            json.dump(self._build_data, fp)

    def clear(self):
        logger.info(f"Clearing cache directory {self.cache_dir}")
        with suppress(FileNotFoundError):
            rmtree(self.cache_dir)
        self._build_data = {}


    def add(self, path: Path, context: BaseNode, template: Template):
        self._build_data[str(path)] = _hash(context, template)

    def remove(self, path: Path, context: BaseNode, template: Template):
        self._build_data.pop(str(path), None)

    def check(self, path: Path, context: BaseNode, template: Template) -> bool:
        """Check if a file has been previously generated.

        Returns:
            True if generating the input file again would result in a duplicate.

        """
        return path.exists() and self._build_data.get(str(path)) == _hash(
            context, template
        )
