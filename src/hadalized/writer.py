"""Render templates and write outputs."""

import shutil
from contextlib import suppress
from functools import cache
from hashlib import blake2b
from pathlib import Path
from typing import TYPE_CHECKING, ClassVar

from jinja2 import (
    Environment,
    FileSystemLoader,
    PackageLoader,
    StrictUndefined,
    TemplateNotFound,
    select_autoescape,
)
from jinja2 import (
    Template as JinjaTemplate,
)
from loguru import logger

from hadalized.cache import Cache
from hadalized.config import BuildConfig, Config

if TYPE_CHECKING:
    from hadalized.base import BaseNode


@cache
def get_fs_env(path: Path = Path("./templates")) -> Environment:
    """Template environment that reads from a relative directory.

    Returns:
        A jinja2.Environment with a filesystem loader.

    """
    return Environment(
        loader=FileSystemLoader(searchpath=path),
        undefined=StrictUndefined,
        autoescape=select_autoescape("html", "xml"),
    )


class Template:
    """Renders and writes templates."""

    _package_env: ClassVar[Environment] = Environment(
        loader=PackageLoader("hadalized"),
        undefined=StrictUndefined,
        # autoescape=True,
        autoescape=select_autoescape("html", "xml"),
    )
    _default_fs_env: ClassVar[Environment] = get_fs_env()

    def __init__(self, name: str, fs_dir: Path | None = None):
        """Load template with the specified name."""
        fs_env = get_fs_env(fs_dir) if fs_dir else self._default_fs_env
        try:
            template = fs_env.get_template(name)
        except TemplateNotFound:
            template = self._package_env.get_template(name)
        self._template: JinjaTemplate = template
        self.name: str = name
        self._bytes: bytes | None = None

    def __hash__(self) -> int:
        """Hash the underlying template engine template instance.

        Returns:
            An object hash.

        """
        return hash(self._template)

    def render(self, context: BaseNode) -> str:
        """Render the template with the specified context.

        Returns:
            The rendered template that can be written to a theme file.

        """
        return self._template.render(context=context)

    def encode(self) -> bytes:
        """Encode the template source.

        Returns:
            Byte encoding of the raw, unrendered template source file.

        """
        if self._bytes is None:
            data: bytes = b"null"
            if (fname := self._template.filename) is not None:
                with suppress(FileNotFoundError):
                    data = Path(fname).read_bytes()
            self._bytes = data
        return self._bytes


class ThemeWriter:
    """Generate application theme files."""

    def __init__(self, config: Config | None = None):
        """Prepare an instance for writing files.

        Initializtion does not connect to the cache database or write
        any files.

        Args:
            config: A configuration instance if customization is required.

        """
        config = config or Config()
        self.config: Config = config
        self.cache = Cache(cache_dir=config.cache_dir)
        self.build_dir: Path = self.config.build_dir
        self.palettes = list(self.config.palettes.values())

    @staticmethod
    def _fmt_path(path: str | Path, context: BaseNode) -> Path:
        return Path(str(path).format(**context.data))

    @staticmethod
    def _hash(template: Template, context: BaseNode) -> str:
        data = template.encode() + b":::" + context.encode()
        return blake2b(data, digest_size=32).hexdigest()

    def _should_generate(self, path: Path, digest: str) -> bool:
        """Check whether a file should be generated.

        Returns:
            True if the file should be generated again due to template changes,
            context changes, or non-existence of target file.

        """
        return not path.exists() or self.cache.get_hash(path) != digest

    def build(self, build_config: BuildConfig) -> list[Path]:
        """Generate color theme files for a specific app.

        Returns:
            A list of file paths that were generated.

        """
        config = self.config
        template = Template(build_config.template, config.template_fs_dir)
        written: list[Path] = []
        if build_config.context_type == "palette":
            context_nodes = self.palettes
        else:
            context_nodes = [config]

        for node in context_nodes:
            path: Path = config.build_dir / self._fmt_path(
                build_config.output_path, node
            )
            path.parent.mkdir(parents=True, exist_ok=True)
            context = node.to(build_config.color_type)
            digest = self._hash(template, context)

            # Check whether we can skip generating the file.
            if self._should_generate(path, digest):
                logger.info(f"Writing {path}")
                path.write_text(template.render(context), encoding="utf-8")
                self.cache.add(path, digest)
                written.append(path)
            else:
                logger.info(f"Already generated {path}")

            # Copy files if necessary.
            if build_config.copy_to is not None and config.copy_files:
                copy_path: Path = self._fmt_path(build_config.copy_to, node)
                if config.copy_dir is not None:
                    if copy_path.is_absolute():
                        copy_path = copy_path.relative_to("/")
                    copy_path = config.copy_dir / copy_path
                if self._should_generate(copy_path, digest):
                    copy_path.parent.mkdir(parents=True, exist_ok=True)
                    logger.info(f"Copying {path} to {copy_path}")
                    shutil.copy(path, copy_path)
                    self.cache.add(copy_path, digest)
                else:
                    logger.info(f"Already copied {copy_path}")

        return written

    def run(self) -> list[Path]:
        """Generate all relevant app theme files.

        Returns:
            A list of file paths that were generated.

        """
        written = []
        for directive in self.config.builds.values():
            written += self.build(directive)
        return written

    def __enter__(self):
        """Connect to the cache db.

        Returns:
            The instance with a connection to the cache db.

        """
        self.cache.connect()
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        """Close cache db connection."""
        if exc_type is not None:
            logger.error((exc_type, exc_value, traceback))
        self.cache.close()


def run(config: Config | None = None):
    """Generate all application theme files with the default configuration."""
    with ThemeWriter(config) as writer:
        writer.run()
