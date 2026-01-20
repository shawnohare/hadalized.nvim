"""Application cache layer."""

import sqlite3
from contextlib import suppress
from shutil import rmtree
from typing import TYPE_CHECKING, Self

import xdg_base_dirs as xdg
from loguru import logger

if TYPE_CHECKING:
    from pathlib import Path
    from typing import ClassVar


class CacheDB:
    """Base class for cache layers that utilize a sqlite db."""

    default_dir: ClassVar[Path] = xdg.xdg_cache_home() / "hadalized"

    def __init__(self, cache_dir: Path | None = default_dir):
        """Create a new instance.

        Args:
            cache_dir: Where to store the database file.
               If `None` is provided, an in-memory database
               will be used.

        """
        self.cache_dir: Path = cache_dir or self.default_dir
        self.in_memory: bool = cache_dir is None
        self._db_file: Path = self.cache_dir / "cache.db"
        if not self.in_memory:
            self.cache_dir.mkdir(parents=True, exist_ok=True)
        self._conn: sqlite3.Connection

    def _setup(self):
        """Subclass defined function to create necessary tables."""

    def connect(self) -> Self:
        """Connect to the underlying sqlite database.

        Returns:
            The connected instance.

        """
        file = ":memory:" if self.in_memory else self._db_file
        self._conn = sqlite3.connect(file)
        self._setup()
        return self

    def close(self):
        """Close the database connection."""
        self._conn.close()

    def clear(self):
        """Clear the cache contents."""
        if not self.in_memory:
            logger.info(f"Clearing cache directory {self.cache_dir}")
            self.close()
            with suppress(FileNotFoundError):
                rmtree(self.cache_dir)

    def __enter__(self) -> Self:
        """Connect to the database.

        Returns:
            The connected instance.

        """
        self.connect()
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        """Close the database connection."""
        if exc_type is not None:
            logger.error((exc_type, exc_value, traceback))
        self.close()


class Cache(CacheDB):
    """Caching layer for built themes."""

    def _setup(self):
        with self._conn:
            self._conn.execute("""
                CREATE TABLE IF NOT EXISTS
                builds(path TEXT PRIMARY KEY, hash TEXT)""")

    def add(self, path: str | Path, digest: str):
        """Add a (path, hash hexdigest) to the database.

        Used after a file is successfully generated to store a proxy for
        the contents of the generated file.
        """
        with self._conn:
            self._conn.execute(
                """INSERT INTO builds VALUES(:path, :digest)
                ON CONFLICT(path) DO UPDATE SET hash=:digest""",
                {
                    "path": str(path),
                    "digest": digest,
                },
            )

    def delete(self, path: str | Path):
        """Remove a cache entry."""
        with self._conn:
            self._conn.execute(
                """DELETE FROM builds WHERE path == ?""",
                [str(path)],
            )

    def get_hash(self, path: str | Path) -> str | None:
        """Get a build digest for the input path.

        Returns:
            A hash (proxy) of the previously generated file or None if no
            record is found.

        """
        with self._conn:
            cur = self._conn.execute(
                """SELECT hash FROM builds WHERE path == ? LIMIT 1""",
                [str(path)],
            )
            data = cur.fetchone()
        return data[0] if isinstance(data, tuple) else None
