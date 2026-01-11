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
        try:
            template = self._fs_env.get_template(name)
        except TemplateNotFound:
            template = self._package_env.get_template(name)
        self._template: JinjaTemplate = template
        self.name: str = name

    def __hash__(self) -> int:
        return hash(self._template)

    def render(self, context: BaseNode) -> str:
        return self._template.render(context=context)

    def write(self, path: Path, context: BaseNode):
        path.write_text(self.render(context))

    @cache
    def encode(self) -> bytes:
        """Get template source bytes."""
        data: bytes = b"null"
        if (fname := self._template.filename) is not None:
            with suppress(FileNotFoundError):
                data = Path(fname).read_bytes()
        return data

    def hash(self, context: BaseNode) -> str:
        """Obtain a proxy for a hash of the rendered template."""
        data = self.encode() + b":::" + context.encode()
        return blake2b(data, digest_size=32).hexdigest()
