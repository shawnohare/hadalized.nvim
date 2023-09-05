from itertools import chain

from typing import Self, TypedDict
from functools import cache

import coloraide

from jinja2 import Environment, PackageLoader, select_autoescape
from pydantic import Field, BaseModel

from . import config
from .model import Model

Spaces = ("oklch", "p3", "srgb", "rec2020")
Gamuts = ("p3", "srgb")  # TODO: add rec2020 when it's used widely.

DarkAliases = {
    "bg0": "dark0",
    "bg1": "dark1",
    "bg2": "dark2",
    "fg0": "gray0",
    "fg1": "gray1",
    "fg2": "gray2",
    "op0": "light0",
    "op1": "light1",
    "op2": "light2",
}

LightAliases = dict(zip(reversed(DarkAliases.keys()), DarkAliases.values()))

Aliases = {
    "dark": DarkAliases,
    "light": LightAliases,
}


# TODO: Contexts.
# 1. Is a specific mode set? Many theme files are logicless and expect a
#    singular mode to be defined.
# 2. Is a specific gamut set? Almost always this is equivalent to whether
#    the application expects hex codes and whether it interprets them as
#    srgb or not. For example, wezterm currently seems to pass a hex code
#    to the system for rendering in whatever gamut is utilized by the monitor,
#    whereas other apps will explicitly
# 3. Think about whether only dealing with str -> dict[str, Color], that is,
#    concrete colorspace colors, simplifies things from a code and template
#    perspective. Most templates would likely be of the form
#    (mode, space) or (any mode, space) (e.g., neovim).
#    Probably it makes sense to make the main lookup key be (mode, space) itself
#    rather than weird nested structures.


@cache
def parse(css: str) -> coloraide.Color:
    """Parse a CSS color definition into a coloraide.Color object."""
    return coloraide.Color(css)


class Color(BaseModel):
    """Attributes for a concrete representation of a color
    (in a specified space)."""

    css: str
    space: str
    coords: list
    alpha: float
    hex: str
    unfitted_coords: list
    unfitted_in_gamut: bool

    @classmethod
    @cache
    def new(cls, css: str, space: str) -> Self:
        """Create new instance in the specified space from an existing
        coloraide.Color instance.
        """
        color = parse(css)
        space = "display-p3" if space == "p3" else space
        color = color.convert(space)
        unfitted_coords = color.coords()
        in_gamut = color.in_gamut()
        color.fit("oklch-chroma")
        if color.space() in ["srgb", "display-p3"]:
            coords = [round(255 * x) for x in color.coords()]
            hex = f"#{coords[0]:02x}{coords[1]:02x}{coords[2]:02x}"
        else:
            hex = ""

        return cls(
            css=color.to_string(),
            space=color.space(),
            coords=color.coords(),
            alpha=color.alpha(),
            hex=hex,
            unfitted_coords=unfitted_coords,
            unfitted_in_gamut=in_gamut,
        )

    @classmethod
    def map(cls, colors: dict[str, str], space: str) -> dict[str, Self]:
        """Map coloraide.Color instances to the specific space."""
        return {k: cls.new(v, space) for k, v in colors.items()}


class HLGroup(BaseModel):
    """A highlight group or semantic token to which a foreground, background
    and style elements can be applied. Essentially identical to (neo)vim
    highlight groups.

    It is assumed a foreground and background color are always specified.

    WARNING: Experimental feature not widely implemented.

    # Semantics.
    To keep things simple we currently support only minimal semantics.
    If a color is null then it is assumed undefined and will resolve to the
    first non-null color in the highlight group link path. Otherwise,
    the explicitly defined color is used. Currently this implies that
    there is no direct way to tell the highlight group to explicitly use
    no color (and therefor resolve to the default group).
    """

    fg: Color | None = None
    bg: Color | None = None
    style: str | None = ""
    link: str | None = None


class Colors(BaseModel):
    """The colors (in a concrete colorspace) available."""

    red: Color
    orange: Color
    yellow: Color
    green: Color
    cyan: Color
    blue: Color
    violet: Color
    magenta: Color
    br_red: Color
    br_orange: Color
    br_yellow: Color
    br_green: Color
    br_cyan: Color
    br_blue: Color
    br_violet: Color
    br_magenta: Color
    dark0: Color
    dark1: Color
    dark2: Color
    gray0: Color
    gray1: Color
    gray2: Color
    light0: Color
    light1: Color
    light2: Color
    bg0: Color
    bg0: Color
    bg0: Color
    fg0: Color
    fg1: Color
    fg2: Color
    op0: Color
    op0: Color
    op0: Color


# class Context(dict):
#
#     def __getitem__(self, key):
#         if (val := self.colors.get(key)) is None:
#             if key.startswith('hl.'):
#                 val = self.hl[key]
#             else:
#                 val = getattr(self, key)
#         return val


class VariantColors(BaseModel):
    """Contains colors in a concrete colorspace for a specific variant.

    When passed as a template context that selects (variant, space)
    access like

        project.name
        name
        red
        comment.fg
        hl["comment.doc"].fg
        comment__doc.fg

    """

    project: config.Project = Field(exclude=True)
    name: str = Field(exclude=True)
    mode: str = Field(exclude=True)
    space: str
    colors: dict[str, Color]
    hl: dict[str, HLGroup]

    def model_post_init(self):
        for key, val in chain(self.colors.items(), self.hl.items()):
            key = key.replace(".", "__")
            self.__dict__[key] = val

    # def __getitem__(self, key: str):
    #     if (val := self.colors.get(key)) is None:
    #         try:
    #             val = self.hl[key.strip("@")]
    #         except KeyError:
    #             val = getattr(self, key)
    #     return val
    #


class Variant(BaseModel):
    """A theme variant with colors and highlights fully resolved
    for each colorspace.

    When passed as a theme context
    """

    project: config.Project = Field(exclude=True)
    name: str
    mode: str
    spaces: dict[str, VariantColors]

    def model_post_init(self):
        for key, val in self.spaces.items():
            self.__dict__[key] = val

    @classmethod
    def new(cls, project: config.Project, node: config.Variant) -> Self:
        spaces: dict[str, VariantColors] = {}
        for space in Spaces:
            colors = Color.map(node.colors, space)
            for alias, key in Aliases[node.mode].items():
                colors[alias] = colors[key]

            # Populate the spaces highlight groups with Colors.
            hl = {}
            for key, val in node.hl.items():
                group = HLGroup(
                    fg=colors[val.fg],
                    bg=colors[val.bg],
                    style=val.style,
                    link=val.link,
                )
                hl[key] = group

            spaces[space] = VariantColors(
                project=project,
                name=node.name,
                mode=node.mode,
                space=space,
                colors=colors,
                hl=hl,
            )

        variant = Variant(
            project=project,
            name=node.name,
            mode=node.mode,
            spaces=spaces,
        )

        return variant


class Theme(BaseModel):
    """A fully resolved theme. Includes all variants with colors defined
    for all colorspaces.

    When passed as a theme context access via
        project.name
        dark.oklch.red
        dark.oklch.comment.fg
    """

    project: config.Project
    colors: dict[str, str]
    hl: dict[str, config.HLGroup]
    # hl: dict[str, config.HLGroup]
    variants: dict[str, Variant]

    def model_post_init(self):
        for key, variant in self.variants.items():
            self.__dict__[key] = variant

    # def __getitem__(self, key: str):
    #     if (val := self.variants.get(key)) is None:
    #         val = getattr(self, key)
    #     return val

    @classmethod
    def new(cls, conf: config.Config) -> Self:
        variants = {k: Variant.new(conf.project, v) for k, v in conf.variants.items()}

        return cls(
            project=conf.project,
            colors=conf.colors,
            hl=conf.hl,
            variants=variants,
        )

    def select(
        self, variant: str = "", space: str = ""
    ) -> Self | Variant | VariantColors | dict:
        """Select an appropriate context to pass to a template. The output
        is fully parameterized by the optional choices of variant and space.
        """
        if space and variant:
            obj = self.variants[variant].spaces[space]
        elif space and not variant:
            variants = {k: v.spaces[space] for k, v in self.variants.items()}
            obj = {
                "project": self.project,
                "variants": variants,
                **variants,
            }
        elif not space and variant:
            obj = self.variants[variant]
        else:
            obj = self
        return obj
