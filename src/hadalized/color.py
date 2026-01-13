"""Color string parsing and information extraction."""

from enum import StrEnum
from typing import ClassVar, Self

from coloraide import Color as ColorBase
from pydantic import PrivateAttr

from hadalized.base import BaseNode

"""Colorspace name constants."""


class ColorSpace(StrEnum):
    """Colorspace constants."""

    srgb = "srgb"
    display_p3 = "display-p3"
    oklch = "oklch"


type ColorField = ColorInfo | GamutInfo | str
"""A field value containing either full ColorInfo for every gamut,
gamut specific color info, or a string representation of a color."""


def to_hex(val: ColorBase) -> str:
    """Convert RGB to their corresponding 24-bit or 34-bit hex color code.

    Used primarily to extract a hex code for use
    in programs--such as neovim--that only allow specifying colors
    via RGB channels.

    Returns:
        A hex color code.

    """
    if val.space() != ColorSpace.srgb:
        val = ColorBase(ColorSpace.srgb, val.coords(), alpha=val.alpha())
    return val.to_string(hex=True)


class GamutInfo(BaseNode):
    """Detailed information about a color fit to a specific gamut."""

    fit_method: ClassVar[str] = "raytrace"

    name: str
    """Name of the gamut."""
    oklch: str
    """The oklch value fitted to the gamut."""
    raw: str
    """The raw oklch value before fitting."""
    css: str
    """The css string within the gamut."""
    hex: str
    """Hex code."""
    is_in_gamut: bool
    """Indicates whether the raw value is within the color gamut."""
    max_oklch_chroma: float
    """The maximum oklch chroma value determined from the fit method."""

    @classmethod
    def fit(cls, val: ColorBase, gamut: str) -> ColorBase:
        """Fit a color to the specified gamut.

        Returns:
            A new fitted instance.

        """
        return val.clone().fit(gamut, fit_method=cls.fit_method)

    @classmethod
    def _max_chroma(cls, val: ColorBase, gamut: str) -> float:
        lightness, _, hue = val.convert("oklch").coords()
        cmax = ColorBase("oklch", (lightness, 0.4, hue))
        return cls.fit(cmax, gamut).get("chroma")

    @classmethod
    def new(cls, val: ColorBase, gamut: str) -> Self:
        """Gamut details for the input fit to the specified gamut.

        Returns:
            A GamutInfo instance.

        """
        if val.space() != ColorSpace.oklch:
            val = val.convert(ColorSpace.oklch)
        raw = val.convert(gamut)
        oklch_fitted = cls.fit(val, gamut)
        fitted = oklch_fitted.convert(gamut)
        return cls(
            name=gamut,
            oklch=oklch_fitted.to_string(),
            raw=raw.to_string(),
            css=fitted.to_string(),
            hex=to_hex(fitted),
            is_in_gamut=raw.in_gamut(),
            max_oklch_chroma=cls._max_chroma(val, gamut),
        )


class ColorInfo(BaseNode):
    """Detailed information about a specific color."""

    gamut_keys: ClassVar[list[ColorSpace]] = [ColorSpace.display_p3, ColorSpace.srgb]

    definition: str
    """Parseable color definition, e.g., a css value."""
    oklch: str
    """Raw oklch value."""
    gamuts: dict[str, GamutInfo]
    _color: ColorBase | None = PrivateAttr(None)

    @property
    def srgb(self) -> GamutInfo:
        """The srgb GamutInfo."""
        return self.gamuts[ColorSpace.srgb]

    @property
    def display_p3(self) -> GamutInfo:
        """The display-p3 GamutInfo."""
        return self.gamuts[ColorSpace.display_p3]

    @staticmethod
    def _parse(val: str) -> ColorBase:
        match = ColorBase.match(val, fullmatch=True)
        if match is None:
            raise ValueError(f"Could not parse color: {val}")
        return ColorBase(match.color)

    @classmethod
    def parse(cls, val: str | ColorBase) -> Self:
        """Parse a string representation of a color.

        Returns:
            A ColorInfo instance parsed from the input string. Raises a
            ValueError if the input is not parseable.

        Raises:
            ValueError when the string is unparseable.

        """
        if isinstance(val, str):
            val = cls._parse(val)

        definition = val.to_string()
        if val.space() != ColorSpace.oklch:
            val = val.convert(ColorSpace.oklch)

        inst = cls(
            definition=definition,
            oklch=val.to_string(),
            gamuts={k: GamutInfo.new(val, k) for k in ColorInfo.gamut_keys},
        )
        inst._color = val
        return inst

    @property
    def color(self) -> ColorBase:
        """The underlying coloraide.Color instance if the instance was parsed."""
        if self._color is None:
            self._color = self._parse(self.definition)
        return self._color


def parse(val: str | ColorBase) -> ColorInfo:
    """Parse a string representation of a color.

    Returns:
        A ColorInfo instance parsed from the input string. Raises a
        ValueError if the input is not parseable.

    Raises:
        ValueError if the input is not parseable.

    """
    return ColorInfo.parse(val)
