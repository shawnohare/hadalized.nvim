"""Models defining a Theme configuration file."""
import tomllib
from typing import Literal, Self

from functools import cache
from pydantic import Field, BaseModel

from . import utils


DefaultFG = "fg2"
DefaultBG = "bg0"


class HLGroup(BaseModel):
    """A color and style setting for UI elements and text tokens.

    Foreground and background color elements should reference a color alias.
    """

    fg: str = ""
    bg: str = ""
    style: str = ""
    link: str | None = None
    resolved: bool = False

    # bold: bool = False
    # italic: bool = False
    # underline: bool = False
    # undercurl: bool = False
    # underdouble: bool = False
    # underdotted: bool = False
    # underdashed: bool = False
    # inverse: bool = False
    # italic: bool = False
    # standout: bool = False
    # strikethrough: bool = False
    # font_style: str = ''


def resolve_links(hlgroups: dict[str, HLGroup]) -> dict[str, HLGroup]:
    """Populate each highlight group's color attributes with a concrete
    aliases by walking through the links until the first concrete aliases
    are found. For example, supposing
        default = { "fg": "red", "bg": "dark0"}
        group0 = {"fg": "blue"}
        group1 = {"fg": "green", "link": "group0"}
        group2 = {"bg": "yellow", "link": "group1"}
    after resolving
        group1 = {"fg": "green", "bg": "dark0"}
        group2 = {"fg": "green", bg": "yellow"}
    """
    default = DefaultHLGroup
    new = {}

    for key, val in hlgroups.items():
        if val.resolved:
            new[key] = val
            continue
        # Keep track of the fg / bg values while we walk through
        # linked groups. We want the color for the first non-null
        orig = val
        # orig.link = orig.link or 'default'
        fgs: list[str] = [val.fg] if val.fg else []
        bgs: list[str] = [val.bg] if val.bg else []
        styles: list[str] = [val.style] if val.style else []

        # Walk down link path and get all concrete color aliases.
        while val.link and not val.resolved:
            val = hlgroups[val.link]
            if val.fg:
                fgs.append(val.fg)
            if val.bg:
                bgs.append(val.bg)
            if val.style:
                styles.append(val.style)

        fgs.append(default.fg)
        bgs.append(default.bg)
        styles.append(default.style)

        new[key] = HLGroup(
            fg=fgs[0],
            bg=bgs[0],
            style=styles[0],
            link=orig.link or "default",
            resolved=True,
        )

    return new


DefaultHLGroup = HLGroup(fg="fg2", bg="bg0")


class Colors(BaseModel):
    # main accents
    red: str
    orange: str
    yellow: str
    green: str
    cyan: str
    blue: str
    violet: str
    magenta: str
    br_red: str
    br_orange: str
    br_yellow: str
    br_green: str
    br_cyan: str
    br_blue: str
    br_violet: str
    br_magenta: str
    dark0: str
    dark1: str
    dark2: str
    gray0: str
    gray1: str
    gray2: str
    light0: str
    light1: str
    light2: str


# class ModeColors(Colors):
#     """Mode-invariant color aliases."""
#     bg0 = ""
#     bg1 = ""
#     bg2 = ""
#     fg0 = ""
#     fg1 = ""
#     fg2 = ""
#     op0 = ""
#     op1 = ""
#     op2 = ""
#


class Variant(BaseModel):
    """A theme variant, such as dark, light or high contrast (light / dark)."""

    name: str
    mode: str
    colors: dict[str, str] = Field(default_factory=dict)
    hl: dict[str, HLGroup] = Field(default_factory=dict)


class Project(BaseModel):
    """Project (theme) level metadata."""

    name: str
    version: str
    url: str


class ThemeConfig(BaseModel):
    """Model for a theme configuration specifying colors."""

    project: Project
    colors: dict[str, str] = Field(default_factory=dict)
    variants: dict[str, Variant] = Field(default_factory=dict)
    hl: dict[str, HLGroup] = Field(default_factory=dict)

    @classmethod
    @cache
    def default(cls) -> dict:
        """Load and return the default configuration as a pure dict."""
        return utils.load_toml("themes/default.toml")

    @classmethod
    def load(cls, path: str = "") -> Self:
        data = cls.default()
        if path:
            with open(path, "rb") as fp:
                data = utils.merge(data, tomllib.load(fp))
        conf = cls.model_validate(data)

        # Resolve all highlight links.
        conf.hl = resolve_links(conf.hl)
        for variant in conf.variants.values():
            variant.hl = resolve_links(conf.hl | variant.hl)
            variant.colors = conf.colors | variant.colors
        return conf


class TemplateConfigNode(BaseModel):
    """Configuration node for an application theme template. Typically
    specified in the default node, but each application template config
    can specify additional
    nodes to apply per template file.

    Attrs:

        context: The underlying context view of the template.
            "full" implies all variants and colorspaces are accessible.
            "variant" implies a single variant with colors in any colorspace
                are accessible.
            "space" implies all variant colors from a single colorspace
                are accessible.
            "variant.space" is the most common context, where a single
                variant and colorspace are available. Most application
                themes that do not allow logic would use this context.

        extension: File extension for the rendered application theme.

        colorspaces: When "space" appears in the context, generate an
            application theme file for each space listed in the
            `colorspaces` parameter. Ignored otherwise.

    """

    context: Literal["full", "variant", "space", "variant.space"]
    extension: str
    colorspaces: list[str] = Field(default_factory=lambda: [])
    filename: str = ""
    output: str = "build"

    def model_post_init(self):
        if not self.filename:
            fname = "{project.name}"
            if "variant" in self.context:
                fname += "_{variant}"
            if "space" in self.context:
                fname += "_{space}"
            fname += self.extension
            self.filename = fname


class TemplateConfig(BaseModel):
    """Model for an application theme template configuration file."""

    default: TemplateConfigNode
    templates: dict[str, TemplateConfigNode] = Field(default_factory=dict)

    @classmethod
    def load(cls, app: str) -> Self:
        data = utils.load_template_config(app)
        for key, node in data["templates"].items():
            data["templates"][key] = data["default"] | node
        return cls.model_validate(data)
