"""Color string parsing and information extraction."""

from collections.abc import Callable
from enum import StrEnum, auto
from typing import ClassVar, Self

from coloraide import Color as ColorBase
from pydantic import PrivateAttr

from hadalized.base import BaseNode

type ColorField = ColorInfo | GamutInfo | str
"""A field value containing either full ColorInfo for every gamut,
gamut specific color info, or a string representation of a color."""

type ColorFieldHandler = Callable[[ColorField], ColorField]


class ColorSpace(StrEnum):
    """Colorspace constants."""

    srgb = auto()
    display_p3 = "display-p3"
    oklch = auto()


class ColorType(StrEnum):
    """Constants representing nodes in a ColorInfo object.

    Use in build directives to declaratively apply transformations to
    Palette ColorField instances.
    """

    info = "ColorInfo"
    """Indicates a ColorField should be a full ColorInfo instance."""
    gamut = "GamutInfo"
    """Indicates a ColorField should be a GamutInfo instance, typically
    in the gamut defined by a Palette."""
    hex = auto()
    """Indicates a ColorField should be a RGB hex code in a specified gamut."""
    oklch = auto()
    """Indicates a ColorField should be a oklch css code in a specified gamut."""
    css = auto()
    """Indicates a ColorField should be a css code in a specified gamut."""


def _parse(val: str) -> ColorBase | None:
    """Parse an input string into a coloraide.Color instance.

    Returns:
        The color instance if parseable else None.

    """
    match = ColorBase.match(val, fullmatch=True)
    return ColorBase(match.color) if match else None


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

    @staticmethod
    def _to_hex(val: ColorBase) -> str:
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
            hex=cls._to_hex(fitted),
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

    @property
    def color(self) -> ColorBase:
        """The underlying coloraide.Color object derived from the string definition.

        Raises:
            ValueError: If the definition is not parseable.

        """
        if self._color is None:
            parsed = _parse(self.definition)
            if parsed is None:
                raise ValueError(f"Unable to parse {self.definition=}")
            self._color = parsed
        return self._color


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


def parse(val: str) -> ColorInfo:
    """Parse a string representation of a color.

    Returns:
        A ColorInfo instance parsed from the input string. Raises a
        ValueError if the input is not parseable.

    Raises:
        ValueError: if the input is not parseable.

    """
    parsed = _parse(val)
    if parsed is None:
        raise ValueError(f"Unable to parse color from {val=}")

    definition = parsed.to_string()
    if parsed.space() != ColorSpace.oklch:
        parsed = parsed.convert(ColorSpace.oklch)

    inst = ColorInfo(
        definition=definition,
        oklch=parsed.to_string(),
        gamuts={k: GamutInfo.new(parsed, k) for k in ColorInfo.gamut_keys},
    )
    inst._color = parsed
    return inst


def extract(
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
