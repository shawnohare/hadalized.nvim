"""Schema for a color palette.

A palette is the primary context used to render a color theme.
"""

from functools import partial
from typing import Literal, Self

from pydantic import Field, PrivateAttr

from hadalized.base import BaseNode
from hadalized.color import (
    ColorField,
    ColorFieldHandler,
    ColorMap,
    ColorType,
    extract,
)
from hadalized.web import WebColors


class Hues(ColorMap):
    """Configuration node for named accents."""

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


class Bases(ColorMap):
    """Configuration node for foregrounds and backgrounds."""

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


class PaletteMeta(BaseNode):
    """Palette metadata."""

    name: str
    desc: str
    version: str = "2.0.2"
    """Version of the palette color definitions."""
    mode: Literal["dark", "light"]
    """Whether the theme is dark or light mode."""
    gamut: Literal["srgb", "display-p3"] = "srgb"


class PaletteColors(BaseNode):
    """Palette color maps."""

    hue: Hues
    """Named main color hues."""
    bright: Hues
    """Named bright color variants."""
    hl: Hues
    """Name highlight color variants."""
    base: Bases
    """Named bases relative to the palette."""
    web: WebColors = Field(default_factory=WebColors.get)
    """Static named colors."""


class Palette(PaletteColors, PaletteMeta):
    """A collection of hues and bases.

    The primary data structure used to render an application theme template.
    """

    _cache: dict = PrivateAttr({})
    _meta: PaletteMeta | None = PrivateAttr(None)
    _colors: PaletteColors | None = PrivateAttr(None)
    """Used to cach transformations of the palette."""

    @property
    def meta(self) -> PaletteMeta:
        """Palette metadata."""
        if self._meta is None:
            self._meta = PaletteMeta(
                name=self.name,
                desc=self.desc,
                version=self.version,
                mode=self.mode,
                gamut=self.gamut,
            )
        return self._meta

    @property
    def colors(self) -> PaletteColors:
        """Palette color maps."""
        if self._colors is None:
            self._colors = PaletteColors(
                hue=self.hue,
                bright=self.bright,
                hl=self.hl,
                base=self.base,
            )
        return self._colors

    def map(self, handler: ColorFieldHandler) -> Self:
        """Map a handler accross color fields.

        Returns:
            A new Palette instance with the handler applied to each
            field that contains a ColorMap instance.

        """
        # kwargs = self.meta.model_dump() | {k: v.map(handler) for k, v in self.colors}
        return self.model_validate({
            k: v.map(handler) if isinstance(v, ColorMap) else v for k, v in self
        })

    def to(self, color_type: ColorType) -> Self:
        """Entry point for the `map` method that accepts a directive.

        Returns:
            A new Palette instance with the handler applied to each
            field that contains a ColorMap instance.

        """
        if color_type == ColorType.info:
            return self

        if (val := self._cache.get(color_type)) is None:
            func = partial(extract, gamut=self.gamut, color_type=color_type)
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
