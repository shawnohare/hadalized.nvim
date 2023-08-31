import functools

from typing import Self, TypedDict

import coloraide

from jinja2 import Environment, PackageLoader, select_autoescape
from pydantic import Field

from . import config
from .model import Model

Spaces = ('oklch', 'p3', 'srgb', 'rec2020')
Gamuts = ("p3", "srgb")  # TODO: add rec2020 when it's used widely.

DarkAliases = {
    'bg0': 'dark0',
    'bg1': 'dark1',
    'bg2': 'dark2',
    'fg0': 'gray0',
    'fg1': 'gray1',
    'fg2': 'gray2',
    'op0': 'light0',
    'op1': 'light1',
    'op2': 'light2',
}

LightAliases = dict(zip(reversed(DarkAliases.keys()), DarkAliases.values()))

Aliases = {
    'dark': DarkAliases,
    'light': LightAliases,
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


def map_coloraide(defs: dict[str, str]) -> dict[str, coloraide.Color]:
    """Convert a color definition dict into one containing the underlying coloraide.Color
    objects.
    """
    return {k: coloraide.Color(v) for k, v in defs.items()}



class Color(Model):
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
    def new(cls, color: coloraide.Color, space: str) -> Self:
        """Create new instance in the specified space from an existing
        coloraide.Color instance.
        """
        color = color.convert(space)
        unfitted_coords = color.coords()
        in_gamut = color.in_gamut()
        color.fit('oklch-chroma')
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


class HLGroup(Model):
    """A highlight group or semantic token to which a foreground, background
    and style elements can be applied. Essentially identical to (neo)vim
    highlight groups.

    It is assumed a foreground and background color are always specified.

    WARNING: Experimental feature not widely implemented.
    """

    fg: Color | None = None
    bg: Color |  None = None
    style: str = ''
    link: str = ''


class ResolvedColors(Model):
    """Colors resolved for a specific space and theme variant."""
    colors: dict[str, Color]
    highlights: dict[str, HLGroup]


# TODO: Put the color lookup thing here?


class VariantColors(Model):
    """A lookup for colors and highlight groups."""
    space: str
    colors: dict[str, Color]
    hl: dict[str, HLGroup] = Field(exclude=True)


# class Context(dict):
#
#     def __getitem__(self, key):
#         if (val := self.colors.get(key)) is None:
#             if key.startswith('hl.'):
#                 val = self.hl[key]
#             else:
#                 val = getattr(self, key)
#         return val


class Variant(Model):
    """A theme variant with colors and highlights fully resolved
    for each colorspace.
    """
    name: str
    mode: str
    oklch: VariantColors
    p3: VariantColors
    srgb: VariantColors
    rec2020: VariantColors



class ColorResolver:
    """Utility for constructing colors derived from the theme's main color
    definitions."""

    def __init__(self, colors: dict[str, str], highlights: dict[str, config.HLGroup]):
        self.colors = map_coloraide(colors)
        self.highlights: dict[str, config.HLGroup] = highlights

    def variant(self,  node: config.Variant) -> dict[str, ResolvedColors]:
        """Produce colors for a theme variant."""
        colors = self.colors | map_coloraide(node.colors)
        highlight_defs = self.highlights | node.hl

        for alias, color in Aliases[node.mode].items():
            colors[alias] = colors[color]

        # TODO: for each space, create colors and hl groups.
        result: dict[str, ResolvedColors] = {s: {'colors': {}, 'highlights': {}} for s in Spaces}
        for space in Spaces:
            _colors = {k: Color.new(v, space) for k, v in colors.items()}
            data = result[space]

            data['colors'] = _colors

            # Populate the spaces highlight group, resolving any links.
            default_hl: config.HLGroup = highlight_defs.get('default', config.HLGroup(fg='fg2', bg='bg0'))
            for key, val in highlight_defs.items():
                orig = val
                while val.link:
                    val = highlight_defs[val.link]
                # TODO: Need to determine proper semantics for explicit nulls.
                group = HLGroup(
                    fg=_colors[orig.fg or val.fg or default_hl.fg],
                    bg=_colors[orig.bg or val.bg or default_hl.fg],
                    style=orig.style or val.style or default_hl.fg,
                    link=orig.link or 'default',
                )
                data['highlights'][key] = group

        return result




