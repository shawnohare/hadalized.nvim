from typing import Iterable, Self, Literal


from coloraide import Color
from pydantic import BaseModel


SRGB = "srgb"
P3 = "display-p3"
OKLCH = "oklch"

"""Colorspace name constants."""

FIT_METHOD = "raytrace"
"""Configuration constants."""

type ColorField = ColorInfo | str


class BaseNode(BaseModel):
    """An extension of the base model to give some dict like semantics."""

    def items(self) -> Iterable[tuple]:
        return ((k, getattr(self, k)) for k in self.__class__.model_fields)

    def __getitem__(self, key: str):
        key = key.replace("-", "_")
        return getattr(self, key)


class GamutColor(BaseNode):
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


class ColorInfo(BaseNode):
    """Detailed information about a specific color."""

    # name: str
    # """Name of the color."""
    definition: str
    """Parseable color definition, e.g., a css value."""
    oklch: str
    """Raw oklch value."""
    gamuts: dict[str, GamutColor]

    # srgb: GamutColor
    # """srgb info"""
    # display_p3: GamutColor = Field(
    #     validation_alias=AliasChoices("display_p3", "display-p3"),
    #     serialization_alias="display-p3",
    # )
    @property
    def srgb(self) -> GamutColor:
        return self.gamuts["srgb"]

    @property
    def display_p3(self) -> GamutColor:
        return self.gamuts["display-p3"]

    def to(self, key: str, gamut: str) -> str:
        """Convert the color to a css or hex code."""
        gi = self.gamuts[gamut]
        return getattr(gi, key)


def to_hex(color: Color) -> str:
    """Convert RGB + alpha channels to their corresponding 24-bit or 34-bit
    hex color code. Used primarily to extract a hex code for use
    in programs--such as neovim--that only allow specifying colors
    via RGB channels.
    """
    if color.space() != SRGB:
        color = Color(SRGB, color.coords(), alpha=color.alpha())
    return color.to_string(hex=True)


def parse(text: str) -> Color:
    """Convert a CSS color string to a Color instance."""
    match = Color.match(text, fullmatch=True)
    if match is None:
        raise ValueError(f"Could not parse color: {text}")
    return Color(match.color)


def fit(color: Color, gamut: str, fit_method=FIT_METHOD) -> Color:
    """Fit a color to the specified input. Does not mutate input color."""
    return color.clone().fit(gamut, fit_method=fit_method)


def max_oklch_chroma(
    color: Color | str, fit_method: str = FIT_METHOD
) -> dict[str, float]:
    if isinstance(color, str):
        color = parse(color)
    lightness, _, hue = color.convert("oklch").coords()
    cmax = Color("oklch", (lightness, 0.4, hue))
    return {
        "lightness": lightness,
        "hue": hue,
        P3: fit(cmax, P3, fit_method).get("chroma"),
        SRGB: fit(cmax, SRGB, fit_method).get("chroma"),
    }


def Info(color: Color | str, fit_method: str = FIT_METHOD) -> ColorInfo:
    """Fit a color definition to pre-defined gamuts."""
    if isinstance(color, str):
        color = parse(color)
    definition = color.to_string()
    if color.space() != OKLCH:
        color = color.convert(OKLCH)

    max_chromas = max_oklch_chroma(color)

    gamuts: dict[str, GamutColor] = {}
    for gamut in (SRGB, P3):
        raw = color.convert(gamut)
        oklch_fitted = fit(color, gamut, fit_method)
        fitted = oklch_fitted.convert(gamut)
        gamuts[gamut] = GamutColor(
            oklch=oklch_fitted.to_string(),
            raw=raw.to_string(),
            css=fitted.to_string(),
            hex=to_hex(fitted),
            is_in_gamut=raw.in_gamut(),
            max_oklch_chroma=max_chromas[gamut],
        )

    return ColorInfo(
        definition=definition,
        oklch=color.to_string(),
        gamuts=gamuts,
    )


class ColorMap(BaseNode):
    """A data structure containing color name -> color info or string."""

    def to(self, key: str, gamut: str) -> Self:
        """Extract a property such as hex code or css string of the gamut color."""
        data: dict[str, str] = {
            k: v.to(key=key, gamut=gamut) if isinstance(v, ColorInfo) else v
            for k, v in self.items()
        }
        return self.model_validate(data)

    def hex(self, gamut: str) -> Self:
        """Convert"""
        return self.to("hex", gamut)

    def css(self, gamut: str) -> Self:
        """Convert"""
        return self.to("css", gamut)


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

    black: ColorField = Info("oklch(0.10 0.01 220)")
    darkgray: ColorField = Info("oklch(0.30 0.01 220)")
    gray: ColorField = Info("oklch(0.50 0.01 220)")
    lightgray: ColorField = Info("oklch(0.70 0.01 220)")
    white: ColorField = Info("oklch(0.995 0.01 220)")
    black: ColorField
    darkgray: ColorField
    gray: ColorField
    lightgray: ColorField
    white: ColorField
    bg: ColorField
    bgvar: ColorField
    bg1: ColorField
    bg2: ColorField
    bg3: ColorField
    bg4: ColorField
    bg5: ColorField
    hidden: ColorField
    comment: ColorField
    fg: ColorField
    emph: ColorField
    op2: ColorField
    op1: ColorField
    op: ColorField


class Palette(BaseNode):
    name: str
    desc: str
    mode: Literal["dark", "light"]
    """Whether the theme is dark or light mode."""
    gamut: Literal["srgb", "display-p3"]
    """Default gamut to use for themes that require hex codes."""
    hue: HueMap
    """Named color hues relative to the palette."""
    base: BaseMap
    """Named bases relative to the palette."""
    hl: HueMap
    bright: HueMap
    # mono: MonochromeMap = mono

    def to(self, key: str, gamut: str | None = None) -> Self:
        """Produce a palette with only hex codes in the specified gamut
        instead of full color info.
        """
        # colors = {k: v.to(self.gamut, key) for k, v in self.colors().items()}
        gamut = gamut or self.gamut
        return self.__class__(
            name=self.name,
            desc=self.desc,
            mode=self.mode,
            gamut=self.gamut,
            hue=self.hue.to(key, gamut),
            base=self.base.to(key, gamut),
            hl=self.hl.to(key, gamut),
            bright=self.hl.to(key, gamut),
            # mono=self.mono.to(key, gamut),
        )

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
