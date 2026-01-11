from enum import StrEnum
from typing import ClassVar, Self

from coloraide import Color as ColorBase

from hadalized.base import BaseNode
from hadalized.render import Template as Template

"""Colorspace name constants."""

FIT_METHOD = "raytrace"
"""Configuration constants."""


class ColorSpace(StrEnum):
    srgb = "srgb"
    display_p3 = "display-p3"
    oklch = "oklch"


type ColorField = ColorInfo | GamutInfo | str
"""A field value containing either full ColorInfo for every gamut,
gamut specific color info, or a string representation of a color."""


def to_hex(val: ColorBase) -> str:
    """Convert RGB + alpha channels to their corresponding 24-bit or 34-bit
    hex color code. Used primarily to extract a hex code for use
    in programs--such as neovim--that only allow specifying colors
    via RGB channels.
    """
    if val.space() != ColorSpace.srgb:
        val = ColorBase(ColorSpace.srgb, val.coords(), alpha=val.alpha())
    return val.to_string(hex=True)


def parse(text: str) -> ColorBase:
    """Convert a CSS color string to a Color instance."""
    match = ColorBase.match(text, fullmatch=True)
    if match is None:
        raise ValueError(f"Could not parse color: {text}")
    return ColorBase(match.color)


def fit(val: ColorBase, gamut: str, fit_method=FIT_METHOD) -> ColorBase:
    """Fit a color to the specified input. Does not mutate input color."""
    return val.clone().fit(gamut, fit_method=fit_method)


def max_oklch_chroma(
    val: ColorBase,
    gamut: str,
    fit_method: str = FIT_METHOD,
) -> float:
    lightness, _, hue = val.convert("oklch").coords()
    cmax = ColorBase("oklch", (lightness, 0.4, hue))
    return fit(cmax, gamut, fit_method).get("chroma")


class GamutInfo(BaseNode):
    """Detailed information about a color fit to a specific gamut."""

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
    def new(cls, val: ColorBase, gamut: str, fit_method: str = FIT_METHOD) -> Self:
        """Obtain GamutInfo for the input color with respect to specified gamut."""
        if val.space() != ColorSpace.oklch:
            val = val.convert(ColorSpace.oklch)
        raw = val.convert(gamut)
        oklch_fitted = fit(val, gamut, fit_method)
        fitted = oklch_fitted.convert(gamut)
        return cls(
            oklch=oklch_fitted.to_string(),
            raw=raw.to_string(),
            css=fitted.to_string(),
            hex=to_hex(fitted),
            is_in_gamut=raw.in_gamut(),
            max_oklch_chroma=max_oklch_chroma(val, gamut),
        )


class ColorInfo(BaseNode):
    """Detailed information about a specific color."""

    gamut_keys: ClassVar[list[ColorSpace]] = [ColorSpace.display_p3, ColorSpace.srgb]

    # name: str
    # """Name of the color."""
    definition: str
    """Parseable color definition, e.g., a css value."""
    oklch: str
    """Raw oklch value."""
    gamuts: dict[str, GamutInfo]

    @property
    def srgb(self) -> GamutInfo:
        return self.gamuts[ColorSpace.srgb]

    @property
    def display_p3(self) -> GamutInfo:
        return self.gamuts[ColorSpace.display_p3]

    @classmethod
    def new(cls, val: str | ColorBase, fit_method: str = FIT_METHOD) -> Self:
        if isinstance(val, str):
            val = parse(val)

        definition = val.to_string()
        if val.space() != ColorSpace.oklch:
            val = val.convert(ColorSpace.oklch)

        return cls(
            definition=definition,
            oklch=val.to_string(),
            gamuts={k: GamutInfo.new(val, k, fit_method) for k in ColorInfo.gamut_keys},
        )


def info(val: ColorBase | str, fit_method: str = FIT_METHOD) -> ColorInfo:
    """Fit a color definition to pre-defined gamuts."""
    return ColorInfo.new(val, fit_method)
