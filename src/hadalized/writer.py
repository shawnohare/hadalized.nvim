"""Render templates and write outputs."""

from contextlib import suppress
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


class Template:
    """Renders and writes templates."""

    _package_env: ClassVar[Environment] = Environment(
        loader=PackageLoader("hadalized"),
        undefined=StrictUndefined,
        # autoescape=True,
        autoescape=select_autoescape("html", "xml"),
    )
    _fs_env: ClassVar[Environment] = Environment(
        loader=FileSystemLoader(searchpath="./templates"),
        undefined=StrictUndefined,
        autoescape=select_autoescape("html", "xml"),
    )

    def __init__(self, name: str):
        """Load template with the specified name."""
        try:
            template = self._fs_env.get_template(name)
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

    def hash(self, context: BaseNode) -> str:
        """Compute a proxy for the hash of a rendered template.

        Returns:
            A hash hexdigest of the raw template and the context that would be
            used to render it. This hash is different from a hash of the rendered
            template, but is invariant with respect to it. In other words,
            if the output file bytes change then so too will this hash.

        """
        data = self.encode() + b":::" + context.encode()
        return blake2b(data, digest_size=32).hexdigest()


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
        self.cache = Cache(cache_dir=config.cache_dir, in_memory=config.cache_in_memory)
        self.build_dir: Path = self.config.build_dir
        self.palettes = list(self.config.palettes.values())

    def build(self, config: BuildConfig) -> list[Path]:
        """Generate color theme files for a specific app.

        Returns:
            A list of file paths that were generated.

        """
        template = Template(config.template)
        target_dir = self.config.build_dir / config.output_path.parent
        target_dir.mkdir(parents=True, exist_ok=True)
        if config.context_type == "palette":
            context_nodes = self.palettes
        else:
            context_nodes = [self.config]
        written: list[Path] = []
        for node in context_nodes:
            path = target_dir / config.output_path.name.format(**node.model_dump())
            context = node.to(config.color_type)

            # Check whether we can skip generating the file.
            digest = template.hash(context)
            if path.exists() and self.cache.get_hash(path) == digest:
                logger.info(f"Already generated {path}")
                continue

            logger.info(f"Writing {path}")
            path.write_text(template.render(context))
            self.cache.add(path, digest)
            written.append(path)
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
