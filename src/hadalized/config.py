"""Module containing all underlying color definitions and gamut info."""

from pathlib import Path
from typing import Literal, Self

from pydantic import Field

from hadalized.cache import Cache
from hadalized.models import (
    BaseMap,
    BaseNode,
    ColorField,
    ColorInfo,
    ColorType,
    HueMap,
    Palette,
)

parse = ColorInfo.parse


class Mono:
    """Singleton class containing named monochromatic colors used for
    foregrounds and backgrounds.
    """

    black: ColorField = parse("oklch(0.10 0.01 220)")
    darkgray: ColorField = parse("oklch(0.30 0.01 220)")
    darkslategray: ColorField = "oklch(0.30 0.03 220)"
    gray: ColorField = parse("oklch(0.50 0.01 220)")
    slategray: ColorField = "oklch(0.600 0.03 220)"
    lightgray: ColorField = parse("oklch(0.70 0.01 220)")
    lightslategray: ColorField = "oklch(0.700 0.02 220)"
    white: ColorField = parse("oklch(0.995 0.01 220)")

    b12: ColorField = parse("oklch(0.125 0.025 220)")
    b13: ColorField = parse("oklch(0.135 0.025 220)")
    b16: ColorField = parse("oklch(0.1625 0.025 220)")
    b20: ColorField = parse("oklch(0.200 .030 220)")
    b25: ColorField = parse("oklch(0.250 .030 220)")
    b30: ColorField = parse("oklch(0.300 .035 220)")
    b35: ColorField = parse("oklch(0.350 .035 220)")
    g20: ColorField = parse("oklch(0.200 .010 220)")
    g30: ColorField = parse("oklch(0.300 .010 220)")
    g35: ColorField = parse("oklch(0.350 .010 220)")
    g45: ColorField = parse("oklch(0.450 .010 220)")
    g60: ColorField = parse("oklch(0.600 .010 220)")
    g65: ColorField = parse("oklch(0.650 .010 220)")
    g70: ColorField = parse("oklch(0.700 .010 220)")
    g75: ColorField = parse("oklch(0.750 .010 220)")
    g80: ColorField = parse("oklch(0.800 .010 220)")
    g90: ColorField = parse("oklch(0.900 .010 220)")
    s80: ColorField = parse("oklch(0.800 .020 100)")
    s85: ColorField = parse("oklch(0.850 .020 100)")
    s90: ColorField = parse("oklch(0.900 .020 100)")
    s91: ColorField = parse("oklch(0.910 .020 100)")
    s92: ColorField = parse("oklch(0.925 .020 100)")
    s95: ColorField = parse("oklch(0.950 .020 100)")
    s97: ColorField = parse("oklch(0.975 .015 100)")
    s99: ColorField = parse("oklch(0.990 .010 100)")
    s100: ColorField = parse("oklch(0.995 .010 100)")
    w80: ColorField = parse("oklch(0.800 .005 100)")
    w85: ColorField = parse("oklch(0.850 .005 100)")
    w90: ColorField = parse("oklch(0.900 .005 100)")
    w91: ColorField = parse("oklch(0.910 .005 100)")
    w92: ColorField = parse("oklch(0.925 .005 100)")
    w95: ColorField = parse("oklch(0.950 .005 100)")
    w97: ColorField = parse("oklch(0.975 .005 100)")
    w99: ColorField = parse("oklch(0.990 .005 100)")
    w100: ColorField = parse("oklch(0.995 .005 100)")


class Hues:
    neutral = HueMap(
        red=parse("oklch(0.575 0.185 25)"),
        orange=parse("oklch(0.650 0.150 60)"),
        yellow=parse("oklch(0.675 0.120 100)"),
        lime=parse("oklch(0.650 0.130 115)"),
        green=parse("oklch(0.575 0.165 130)"),
        mint=parse("oklch(0.675 0.130 155)"),
        cyan=parse("oklch(0.625 0.100 180)"),
        azure=parse("oklch(0.675 0.110 225)"),
        blue=parse("oklch(0.575 0.140 250)"),
        violet=parse("oklch(0.575 0.185 290)"),
        magenta=parse("oklch(0.575 0.185 330)"),
        rose=parse("oklch(0.675 0.100 360)"),
    )
    dark = HueMap(
        red=parse("oklch(0.60 0.185 25)"),
        orange=parse("oklch(0.650 0.150 60)"),
        yellow=parse("oklch(0.700 0.120 100)"),
        lime=parse("oklch(0.675 0.120 115)"),
        green=parse("oklch(0.650 0.165 130)"),
        mint=parse("oklch(0.715 0.130 155)"),
        cyan=parse("oklch(0.650 0.100 180)"),
        azure=parse("oklch(0.725 0.110 225)"),
        blue=parse("oklch(0.625 0.150 250)"),
        violet=parse("oklch(0.625 0.185 290)"),
        magenta=parse("oklch(0.625 0.185 330)"),
        rose=parse("oklch(0.700 0.100 360)"),
    )
    light = HueMap(
        red=parse("oklch(0.550 0.185 25)"),
        orange=parse("oklch(0.650 0.150 60)"),
        yellow=parse("oklch(0.650 0.120 100)"),
        lime=parse("oklch(0.650 0.130 115)"),
        green=parse("oklch(0.575 0.165 130)"),
        mint=parse("oklch(0.650 0.130 155)"),
        cyan=parse("oklch(0.550 0.100 180)"),
        azure=parse("oklch(0.650 0.110 225)"),
        blue=parse("oklch(0.575 0.140 250)"),
        violet=parse("oklch(0.550 0.185 290)"),
        magenta=parse("oklch(0.550 0.185 330)"),
        rose=parse("oklch(0.625 0.100 360)"),
    )
    hl = HueMap(
        red=parse("oklch(0.800 0.100 25)"),
        orange=parse("oklch(0.850 0.100 60)"),
        yellow=parse("oklch(0.950 0.200 100)"),
        lime=parse("oklch(0.855 0.100 115)"),
        green=parse("oklch(0.85 0.100 130)"),
        mint=parse("oklch(0.875 0.100 155)"),
        cyan=parse("oklch(0.900 0.100 180)"),
        azure=parse("oklch(0.875 0.100 225)"),
        blue=parse("oklch(0.825 0.100 250)"),
        violet=parse("oklch(0.825 0.200 290)"),
        magenta=parse("oklch(0.825 0.200 330)"),
        rose=parse("oklch(0.825 0.200 360)"),
    )
    bright = HueMap(
        red=parse("oklch(0.675 0.200 25)"),
        orange=parse("oklch(0.75 0.200 60)"),
        yellow=parse("oklch(0.80 0.200 100)"),
        lime=parse("oklch(0.800 0.200 120)"),
        green=parse("oklch(0.800 0.200 135)"),
        mint=parse("oklch(0.800 0.200 155)"),
        cyan=parse("oklch(0.800 0.200 180)"),
        azure=parse("oklch(0.800 0.200 225)"),
        blue=parse("oklch(0.800 0.200 250)"),
        violet=parse("oklch(0.800 0.200 290)"),
        magenta=parse("oklch(0.800 0.200 330)"),
        rose=parse("oklch(0.800 0.200 360)"),
    )


class Palettes:
    # Palette definitions
    dark: Palette = Palette(
        name="hadalized",
        desc="Main dark theme with blueish solarized inspired backgrounds.",
        mode="dark",
        gamut="srgb",
        hue=Hues.dark,
        base=BaseMap(
            bg=parse("oklch(0.13 0.025 220)"),
            bg1=parse("oklch(0.14 0.03 220)"),
            bg2=Mono.b16,
            bg3=Mono.b20,
            bg4=Mono.b25,
            bg5=Mono.b30,
            bg6=Mono.b35,
            hidden=Mono.g45,
            subfg=Mono.g70,
            fg=Mono.w80,
            emph=Mono.w85,
            op2=Mono.s80,
            op1=Mono.s85,
            op=Mono.s90,
        ),
        hl=Hues.hl,
        bright=Hues.bright,
    )

    gray: Palette = Palette(
        name="hadalized-gray",
        desc="Dark theme variant with more grayish backgrounds.",
        mode="dark",
        gamut="srgb",
        hue=Hues.dark,
        base=BaseMap(
            bg=parse("oklch(0.13 0.005 220)"),
            bg1=parse("oklch(0.14 0.005 220)"),
            bg2=parse("oklch(0.16 0.005 220)"),
            bg3=parse("oklch(0.20 0.005 220)"),
            bg4=parse("oklch(0.25 0.005 220)"),
            bg5=parse("oklch(0.30 0.005 220)"),
            bg6=parse("oklch(0.35 0.005 220)"),
            hidden=dark.base.hidden,
            subfg=dark.base.subfg,
            fg=dark.base.fg,
            emph=dark.base.emph,
            op2=Mono.w80,
            op1=Mono.w85,
            op=Mono.w90,
        ),
        hl=Hues.hl,
        bright=Hues.bright,
    )

    day: Palette = Palette(
        name="hadalized-day",
        desc="Light theme variant with sunny backgrounds.",
        mode="light",
        gamut="srgb",
        hue=Hues.light,
        base=BaseMap(
            bg=Mono.s100,
            bg1=Mono.s99,
            bg2=Mono.s95,
            bg3=Mono.s92,
            bg4=Mono.s99,
            bg5=Mono.s85,
            bg6=Mono.s80,
            hidden=Mono.g75,
            subfg=Mono.g60,
            fg=Mono.g30,
            emph=Mono.g20,
            op2=dark.base.bg3,
            op1=dark.base.bg2,
            op=dark.base.bg,
        ),
        hl=Hues.hl,
        bright=Hues.bright,
    )

    white: Palette = Palette(
        name="hadalized-white",
        desc="Light theme variant with whiter backgrounds.",
        mode=day.mode,
        gamut=day.gamut,
        hue=day.hue,
        base=BaseMap(
            bg=Mono.w100,
            bg1=Mono.w99,
            bg2=Mono.w95,
            bg3=Mono.w92,
            bg4=Mono.w99,
            bg5=Mono.w85,
            bg6=Mono.w80,
            hidden=day.base.hidden,
            subfg=day.base.subfg,
            fg=day.base.fg,
            emph=day.base.emph,
            op2=day.base.op2,
            op1=day.base.op1,
            op=day.base.op,
        ),
        hl=day.hl,
        bright=day.bright,
    )

    @classmethod
    def to_dict(cls) -> dict[str, Palette]:
        return {
            cls.dark.name: cls.dark,
            cls.gray.name: cls.gray,
            cls.day.name: cls.day,
            cls.white.name: cls.white,
        }


misc: dict = {
    "terminal": {
        "pairings": {
            "red": ["red", "rose"],
            "yellow": ["yellow", "orange"],
            "green": ["green", "lime"],
            "cyan": ["cyan", "mint"],
            "blue": ["blue", "azure"],
            "magenta": ["magenta", "violet"],
        },
        "colors": {
            "red": 1,
            "rose": 9,
            "green": 2,
            "lime": 10,
            "yellow": 3,
            "orange": 11,
            "blue": 4,
            "azure": 12,
            "magenta": 5,
            "violet": 13,
            "cyan": 6,
            "min": 14,
        },
    },
}


class BuildDirective(BaseNode):
    """Information about which files should be generatted for a specific
    template.
    """

    template: str
    """Template filename."""
    output_path: Path
    """Output path template relative to a build directory."""
    context_type: Literal["palette", "config"]
    """The underlying context type to pass to the template. Currently two
    modes are supported.
    - "palette", which assumes that each template is rendered with an individual
      palette.
    - "config", where there entire configuration, in particular all palettes,
      are passed into a single palette.
    """
    # handler_type: Literal["hex", "css", "oklch", "lua", "identity"]
    color_type: ColorType
    """Indicates the type of value a ColorField should have within the context."""
    """Determines a transformation (extraction) to apply to each ColorField leaf
    in a palette.
    - None is equivalent to the identity function, and used when the most
      complete context is required. Each Palette ColorMap field will contain
      the full ColorInfo value. For example `palette.hue.red` will be a
      ColorInfo instance.
    - "gamut" extracts the GamutInfo node for each Palette's color maps as
      specified by the Palette's `gamut` field. For example, `palette.hue.red`
      will contain a GamutInfo object with css values, in-gamut oklch, and hex
      codes.
    - "hex" extracts the GamutInfo.hex value for each color field in the gamut
      specified by the Palette's `gamut` field. For example, `palette.hue.red`
      will be a RGB hex code that assumes a profile matching the palette's gamut.
    - "css" extracts the GamutInfo.css value for each color field in the gamut
      specified by the Palette's `gamut` field. For example, `palette.hue.red`
      will be a css value for the palette's gamut.
    - "oklch" extracts the GamutInfo.oklch css representationfor each color
      field in the gamut specified by the Palette's `gamut` field. For
      example, `palette.hue.red` could be `oklch(0.55 0.15 25)`, where the
      defined color value is fitted to the palette's gamut.
    """


def default_build_directives() -> dict[str, BuildDirective]:
    return {
        "neovim": BuildDirective(
            template="neovim.lua",
            context_type="palette",
            output_path=Path("neovim/{name}.lua"),
            color_type="hex",
        ),
        "wezterm": BuildDirective(
            template="wezterm.toml",
            context_type="palette",
            output_path=Path("wezterm/{name}.toml"),
            color_type="hex",
        ),
        "starship": BuildDirective(
            template="starship.toml",
            context_type="config",
            output_path=Path("starship/starship.toml"),
            color_type="hex",
        ),
        "info": BuildDirective(
            template="palette_info.json",
            context_type="palette",
            output_path=Path("info/{name}.json"),
            color_type="info",
        ),
        "html_samples": BuildDirective(
            template="palette.html",
            context_type="palette",
            output_path=Path("html_samples/{name}.html"),
            color_type="css",
        ),
    }


class Config(BaseNode):
    """An instance containing the color definitions and expanded info
    from within this module.
    """

    build_dir: Path = Path("./build")
    """Directory containing built theme files."""
    cache_dir: Path = Cache.default_dir
    """Application cache directory."""
    directives: dict[str, BuildDirective] = Field(
        default_factory=default_build_directives,
        exclude=True,
    )
    """Build directives specifying how and which theme files are
    generated."""
    palettes: dict[str, Palette] = Palettes.to_dict()
    """Palette definitions."""
    misc: dict = misc

    def to(self, color_type: ColorType):
        return self.__class__(
            build_dir=self.build_dir,
            cache_dir=self.cache_dir,
            directives=self.directives,
            palettes={k: p.to(color_type) for k, p in self.palettes.items()},
            misc=self.misc,
        )

    def hex(self) -> Self:
        return self.to("hex")

    def css(self) -> Self:
        return self.to("css")
