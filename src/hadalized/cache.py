"""Handle application cache."""

import sqlite3
from contextlib import suppress
from shutil import rmtree
from typing import TYPE_CHECKING, Self

import xdg_base_dirs
from loguru import logger

if TYPE_CHECKING:
    from pathlib import Path
    from typing import ClassVar

    from hadalized.models import BaseNode, Template


# @cache
# def hash_template(template: Template) -> str:
#     """Hash the contents of a file."""
#     data: bytes = b"null"
#     if (fname := template.filename) is not None:
#         with suppress(FileNotFoundError):
#             data = Path(fname).read_bytes()
#     return blake2b(data, digest_size=32).hexdigest()
#


# @cache
# def _get_template_bytes(template: Template) -> bytes:
#     """Get template source bytes."""
#     data: bytes = b"null"
#     if (fname := template.filename) is not None:
#         with suppress(FileNotFoundError):
#             data = Path(fname).read_bytes()
#     return data
#
#
#
#
# @cache
# def _hash(context: BaseNode, template: Template) -> str:
#     """Obtain digests for contents used to render a template. Used as
#     an equivalent for the hash of a rendered template"""
#     data = _get_context_bytes(context) + _get_template_bytes(template)
#     return blake2b(data, digest_size=32).hexdigest()
#

# class Cache:
#     """Cache application level data."""
#
#     default_dir: ClassVar[Path] = xdg_base_dirs.xdg_cache_home() / "hadalized"
#
#     def __init__(self, cache_dir: Path = default_dir):
#         # Use a single cache file until needs are warranted.
#         self.cache_dir = cache_dir
#         self._build_file = cache_dir / "builds.json"
#         self._build_data = {}
#
#     def load(self) -> Self:
#         """Load the cache from cachefile."""
#         try:
#             with self._build_file.open(mode="r") as fp:
#                 logger.info(f"Loading build cache file {self._build_file}")
#                 data: dict = json.load(fp)
#         except FileNotFoundError:
#             data = {}
#         self._build_data = data
#         return self
#
#     def save(self):
#         logger.info(f"Saving build cache to {self._build_file}")
#         self._build_file.parent.mkdir(parents=True, exist_ok=True)
#         with self._build_file.open(mode="w") as fp:
#             json.dump(self._build_data, fp)
#
#     def clear(self):
#         logger.info(f"Clearing cache directory {self.cache_dir}")
#         with suppress(FileNotFoundError):
#             rmtree(self.cache_dir)
#         self._build_data = {}
#
#     def add(self, path: Path, context: BaseNode, template: Template):
#         self._build_data[str(path)] = _hash(context, template)
#
#     def remove(self, path: Path):
#         self._build_data.pop(str(path), None)


class CacheDB:
    """Base class for cache layers that utilize a sqlite db."""

    default_dir: ClassVar[Path] = xdg_base_dirs.xdg_cache_home() / "hadalized"

    def __init__(self, cache_dir: Path = default_dir):
        # Use a single cache file until needs are warranted.
        self.cache_dir: Path = cache_dir
        self._db_file: Path = cache_dir / "cache.db"
        self.cache_dir.mkdir(parents=True, exist_ok=True)
        self._conn: sqlite3.Connection

    def setup(self):
        pass

    def connect(self) -> Self:
        self._conn = sqlite3.connect(self._db_file)
        self.setup()
        return self

    def close(self):
        return self._conn.close()

    def clear(self):
        logger.info(f"Clearing cache directory {self.cache_dir}")
        with suppress(FileNotFoundError):
            rmtree(self.cache_dir)


class Cache(CacheDB):
    """Caching layer for built themes."""

    def setup(self):
        """Creates a table containing built theme files and an equivalent of
        their content hash."""
        with self._conn:
            self._conn.execute("""
                CREATE TABLE IF NOT EXISTS
                builds(path TEXT PRIMARY KEY, hash TEXT)""")

    def add(self, path: Path, file_hash: str):
        """Record a generated file path and a proxy for the hash of its contents
        to the cache database."""
        with self._conn:
            self._conn.execute(
                """
                INSERT INTO builds VALUES(:path, :hash)
                ON CONFLICT(path) DO UPDATE SET hash=:hash""",
                {
                    "path": str(path),
                    "hash": file_hash,
                },
            )

    def delete(self, path: Path):
        """Remove a cache entry."""
        with self._conn:
            self._conn.execute(
                """
                DELETE FROM builds WHERE path == :path
                """,
                {"path": str(path)},
            )

    def get_hash(self, path: Path) -> str | None:
        """Select a build digest for the input path."""
        with self._conn:
            cur = self._conn.execute(
                """
               SELECT hash FROM builds WHERE path == :path limit 1""",
                {"path": str(path)},
            )
            data = cur.fetchone()
        return data[0] if isinstance(data, tuple) else None

    def check(
        self, path: Path, template: Template, context: BaseNode
    ) -> tuple[bool, str]:
        # if path doesn't exist, have to hash
        # if path exists, need to compare hashes and check.
        # if path exists and hashes agree, skp
        # if path exists and hashes disagree, add.
        digest = template.hash(context)
        ok = self.get_hash(path) == digest if path.exists() else False
        return (ok, digest)

        # return path.exists() and self.get_hash(path) == template.hash(context)
