"""Data structures used to define color palettes."""

from collections.abc import Callable
from enum import StrEnum, auto
from functools import partial
from typing import Literal, Self

from pydantic import PrivateAttr

from hadalized.base import BaseNode
from hadalized.color import ColorField, ColorInfo

type ColorFieldHandler = Callable[[ColorField], ColorField]


class ColorType(StrEnum):
    """Constants representing nodes in a ColorInfo object."""

    info = "ColorInfo"
    gamut = "GamutInfo"
    hex = auto()
    oklch = auto()
    css = auto()


def _extract(
    val: ColorField,
    gamut: str,
    color_type: ColorType,
) -> ColorField:
    """Extract fields from a ColorInfo or GamutInfo instance.

    The function is idempotent, but composing terminates at the first leaf.
    For example, with f as this function
        f(f(color, "srgb", ColorType.hex), gamut="display-p3", color_type=ColorType.css)
    is the same as
        f(color, "srgb", ColorType.hex)
    as the latter call already extracts a leaf value. Similarly
        f(f(color, "srgb", "gamut"), gamut="", color_type=ColorType.css)
    is equivalent to
        f(color, "srgb", ColorType.css)

    Returns:
        A new Colorfield, typically a value extracted from a ColorInfo
        instance.

    """
    if color_type == ColorType.info or isinstance(val, str):
        return val

    node = val.gamuts[gamut] if isinstance(val, ColorInfo) else val
    return node if color_type == ColorType.gamut else node[color_type]


class ColorMap(BaseNode):
    """Base dataclass for mappings of the form color name -> ColorInfo.

    The fields can either be a complete object containing data for all
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
        """Apply a generic color field handler to each field.

        Returns:
            A new ColorMap instance with the handler applied to each field.

        """
        data: dict[str, ColorField] = {k: handler(v) for k, v in self}
        return self.model_validate(data)


class HueMap(ColorMap):
    """Configuration node for named hues."""

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
    """Configuration node for foregrounds and backgrounds."""

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
    """A collection of hues and bases.

    The primary data structure used to render an application theme template.
    """

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
    _cache: dict = PrivateAttr({})
    """Used to cach transformations of the palette."""

    def map(self, handler: ColorFieldHandler) -> Self:
        """Map a handler accross color fields.

        Returns:
            A new Palette instance with the handler applied to each
            field that contains a ColorMap instance.

        """
        kwargs = {k: v.map(handler) if isinstance(v, ColorMap) else v for k, v in self}
        return self.model_validate(kwargs)

    def to(self, color_type: ColorType) -> Self:
        """Entry point for the `map` method that accepts a directive.

        Returns:
            A new Palette instance with the handler applied to each
            field that contains a ColorMap instance.

        """
        if color_type == "info":
            return self

        if (val := self._cache.get(color_type)) is None:
            func = partial(_extract, gamut=self.gamut, color_type=color_type)
            val = self.map(func)
            self._cache[color_type] = val
        return val

    def gamut_info(self) -> Self:
        """Extract GamutInfo from each ColorInfo leaf.

        Returns:
            A new Palette where each ColorField leaf is a GamutInfo instance.

        """
        return self.to(ColorType.gamut)

    def hex(self) -> Self:
        """Extract RGB hex codes from each ColorInfo leaf.

        Returns:
            A new Palette where each ColorField leaf is a hex code string
            in the palette's `gamut` value.

        """
        return self.to(ColorType.hex)

    def css(self) -> Self:
        """Extract css strings from each ColorInfo leaf.

        Returns:
            A new Palette where each ColorField leaf is a css string referencing
            the palette's `gamut` value.

        """
        return self.to(ColorType.css)

    def oklch(self) -> Self:
        """Extract oklch strings from each ColorInfo leaf.

        Returns:
            A new Palette where each ColorField leaf is an oklch string fit
            the palette's `gamut` value.

        """
        return self.to(ColorType.oklch)

    def identity(self) -> Self:
        """No op identity function on a palette.

        Returns:
            The instance itself.

        """
        return self
