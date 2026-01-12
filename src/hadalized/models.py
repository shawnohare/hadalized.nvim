from collections.abc import Callable
from functools import cache, partial
from typing import Literal, Self

from hadalized.base import BaseNode
from hadalized.color import ColorField, ColorInfo
from hadalized.render import Template as Template

type PaletteHandler = Callable[[Palette], Palette]
"""A function that can produce context to provide to a template."""

type ColorFieldHandler = Callable[[ColorField], ColorField]

type ColorType = Literal["info", "gamut", "hex", "oklch", "css"]
"""Denotes the type of value contained in a ColorField.
- info indicates the field is a full ColorInfo instance.
- gamut indicates the field is a GamutInfo instance.
- hex indicates the field is a GamutInfo.hex string.
- oklch indicates the field is a GamutInfo.oklch string.
- css indicates the field is a GamutInfo.css string.
"""


def _extract(
    val: ColorField,
    gamut: str,
    color_type: ColorType,
) -> ColorField:
    """ColorFieldHandler that extracts a particular leaf field value from a
    GamutInfo field.

    The function is idempotent, but composing terminates at the first leaf.
    For example, with f as this function
        f(f(color, "srgb", "hex"), gamut="display-p3", color_type="css")
    is the same as
        f(color, "srgb", "hex")
    as the latter call already extracts a leaf value. Similarly
        f(f(color, "srgb", "gamut"), gamut="", color_type="css")
    is equivalent to
        f(color, "srgb", "css")
    """
    if color_type == "identity" or isinstance(val, str):
        return val

    node = val.gamuts[gamut] if isinstance(val, ColorInfo) else val
    return node if color_type == "gamut" else node[color_type]


class ColorMap(BaseNode):
    """A data structure containing color name -> color info of some form. The
    form can either be a complete color info object containing data for all
    gamuts, gamut specific color info, or a string. While the model itself
    does not enforce uniformity of type among the strings, the data structure
    should typically be equivalent to one of
        Mapping[str, ColorInfo]
        Mapping[str, GamutColor]
        Mapping[str, str]
    Instances containing values other than ColorInfo are obtained via transform
    methods.
    """

    def map(self, handler: ColorFieldHandler) -> Self:
        """Apply a generic color field handler to each field."""
        data: dict[str, ColorField] = {k: handler(v) for k, v in self}
        return self.model_validate(data)


# def fmap(data: Mapping[str, ColorField]) -> Mapping[str, ColorField]:


class HueMap(ColorMap):
    """Configuration node for name hues."""

    red: ColorField
    orange: ColorField
    yellow: ColorField
    lime: ColorField
    green: ColorField
    mint: ColorField
    cyan: ColorField
    azure: ColorField
    blue: ColorField
    violet: ColorField
    magenta: ColorField
    rose: ColorField


class BaseMap(ColorMap):
    """Configuration node for monochromatic foregrounds and backgrounds."""

    black: ColorField = ColorInfo.parse("oklch(0.10 0.01 220)")
    darkgray: ColorField = ColorInfo.parse("oklch(0.30 0.01 220)")
    gray: ColorField = ColorInfo.parse("oklch(0.50 0.01 220)")
    lightgray: ColorField = ColorInfo.parse("oklch(0.70 0.01 220)")
    white: ColorField = ColorInfo.parse("oklch(0.995 0.01 220)")
    bg: ColorField
    bg1: ColorField
    bg2: ColorField
    bg3: ColorField
    bg4: ColorField
    bg5: ColorField
    bg6: ColorField
    hidden: ColorField
    subfg: ColorField
    fg: ColorField
    emph: ColorField
    op2: ColorField
    op1: ColorField
    op: ColorField


class Palette(BaseNode):
    """Defines the colors to injkkkect to a particular theme template."""

    name: str
    desc: str
    mode: Literal["dark", "light"]
    """Whether the theme is dark or light mode."""
    gamut: Literal["srgb", "display-p3"] = "srgb"
    """Default gamut to use for themes that require hex codes."""
    hue: HueMap
    """Named color hues relative to the palette."""
    base: BaseMap
    """Named bases relative to the palette."""
    hl: HueMap
    bright: HueMap

    def map(self, handler: ColorFieldHandler) -> Self:
        kwargs = {k: v.map(handler) if isinstance(v, ColorMap) else v for k, v in self}
        return self.model_validate(kwargs)

    @cache
    def to(self, color_type: ColorType) -> Self:
        """Return a transformed palette containing ColorField values
        specified color type."""
        if color_type == "info":
            return self

        func = partial(_extract, gamut=self.gamut, color_type=color_type)
        return self.map(func)

    def gamut_info(self) -> Self:
        return self.to("gamut")

    def hex(self) -> Self:
        """Produce a palette with only css strings in the specified gamut
        instead of full color info.
        """
        return self.to("hex")

    def css(self) -> Self:
        """Produce a palette with only css strings in the specified gamut
        instead of full color info.
        """
        return self.to("css")

    def oklch(self) -> Self:
        """Produce a palette with only oklch css strings in the specified gamut
        instead of full color info.
        """
        return self.to("oklch")

    def identity(self) -> Self:
        """No op identity function on a palette."""
        return self
