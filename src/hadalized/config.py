"""Module containing all underlying color definitions and gamut info."""
from functools import cache
from typing import Self

from hadalized.models import (
    ColorField,
    BaseNode,
    HueMap,
    BaseMap,
    Info,
    Palette,
)


class Mono:
    """Singleton class containing named monochromatic colors used for
    foregrounds and backgrounds.
    """
    black: ColorField = Info("oklch(0.10 0.01 220)")
    darkgray: ColorField = Info("oklch(0.30 0.01 220)")
    darkslategray: ColorField     = "oklch(0.30 0.03 220)"
    gray: ColorField = Info("oklch(0.50 0.01 220)")
    slategray: ColorField         = "oklch(0.600 0.03 220)"
    lightgray: ColorField = Info("oklch(0.70 0.01 220)")
    lightslategray: ColorField  = "oklch(0.700 0.02 220)"
    white: ColorField = Info("oklch(0.995 0.01 220)")

    b12: ColorField = Info("oklch(0.125 0.025 220)")
    b13: ColorField = Info("oklch(0.135 0.025 220)")
    b16: ColorField = Info("oklch(0.1625 0.025 220)")
    b20: ColorField = Info("oklch(0.200 .030 220)")
    b25: ColorField = Info("oklch(0.250 .030 220)")
    b30: ColorField = Info("oklch(0.300 .035 220)")
    b35: ColorField = Info("oklch(0.350 .035 220)")
    g20: ColorField = Info("oklch(0.200 .010 220)")
    g30: ColorField = Info("oklch(0.300 .010 220)")
    g35: ColorField = Info("oklch(0.350 .010 220)")
    g45: ColorField = Info("oklch(0.450 .010 220)")
    g60: ColorField = Info("oklch(0.600 .010 220)")
    g65: ColorField = Info("oklch(0.650 .010 220)")
    g70: ColorField = Info("oklch(0.700 .010 220)")
    g75: ColorField = Info("oklch(0.750 .010 220)")
    g80: ColorField = Info("oklch(0.800 .010 220)")
    g90: ColorField = Info("oklch(0.900 .010 220)")
    s80: ColorField = Info("oklch(0.800 .020 100)")
    s85: ColorField = Info("oklch(0.850 .020 100)")
    s90: ColorField = Info("oklch(0.900 .020 100)")
    s91: ColorField = Info("oklch(0.910 .020 100)")
    s92: ColorField = Info("oklch(0.925 .020 100)")
    s95: ColorField = Info("oklch(0.950 .020 100)")
    s97: ColorField = Info("oklch(0.975 .015 100)")
    s99: ColorField = Info("oklch(0.990 .010 100)")
    s100: ColorField = Info("oklch(0.995 .010 100)")
    w80: ColorField = Info("oklch(0.800 .005 100)")
    w85: ColorField = Info("oklch(0.850 .005 100)")
    w90: ColorField = Info("oklch(0.900 .005 100)")
    w91: ColorField = Info("oklch(0.910 .005 100)")
    w92: ColorField = Info("oklch(0.925 .005 100)")
    w95: ColorField = Info("oklch(0.950 .005 100)")
    w97: ColorField = Info("oklch(0.975 .005 100)")
    w99: ColorField = Info("oklch(0.990 .005 100)")
    w100: ColorField = Info("oklch(0.995 .005 100)")



class Hues:
    neutral=HueMap(
        red=Info("oklch(0.575 0.185 25)"),
        orange=Info("oklch(0.650 0.150 60)"),
        yellow=Info("oklch(0.675 0.120 100)"),
        lime=Info("oklch(0.650 0.130 115)"),
        green=Info("oklch(0.575 0.165 130)"),
        mint=Info("oklch(0.675 0.130 155)"),
        cyan=Info("oklch(0.625 0.100 180)"),
        azure=Info("oklch(0.675 0.110 225)"),
        blue=Info("oklch(0.575 0.140 250)"),
        violet=Info("oklch(0.575 0.185 290)"),
        magenta=Info("oklch(0.575 0.185 330)"),
        rose=Info("oklch(0.675 0.100 360)"),
    )
    dark=HueMap(
        red=Info("oklch(0.60 0.185 25)"),
        orange=Info("oklch(0.650 0.150 60)"),
        yellow=Info("oklch(0.700 0.120 100)"),
        lime=Info("oklch(0.675 0.120 115)"),
        green=Info("oklch(0.650 0.165 130)"),
        mint=Info("oklch(0.715 0.130 155)"),
        cyan=Info("oklch(0.650 0.100 180)"),
        azure=Info("oklch(0.725 0.110 225)"),
        blue=Info("oklch(0.625 0.150 250)"),
        violet=Info("oklch(0.625 0.185 290)"),
        magenta=Info("oklch(0.625 0.185 330)"),
        rose=Info("oklch(0.700 0.100 360)"),
    )
    light=HueMap(
        red=Info("oklch(0.550 0.185 25)"),
        orange=Info("oklch(0.650 0.150 60)"),
        yellow=Info("oklch(0.650 0.120 100)"),
        lime=Info("oklch(0.650 0.130 115)"),
        green=Info("oklch(0.575 0.165 130)"),
        mint=Info("oklch(0.650 0.130 155)"),
        cyan=Info("oklch(0.550 0.100 180)"),
        azure=Info("oklch(0.650 0.110 225)"),
        blue=Info("oklch(0.575 0.140 250)"),
        violet=Info("oklch(0.550 0.185 290)"),
        magenta=Info("oklch(0.550 0.185 330)"),
        rose=Info("oklch(0.625 0.100 360)"),
    )
    hl=HueMap(
        red=Info("oklch(0.800 0.100 25)"),
        orange=Info("oklch(0.850 0.100 60)"),
        yellow=Info("oklch(0.950 0.200 100)"),
        lime=Info("oklch(0.855 0.100 115)"),
        green=Info("oklch(0.85 0.100 130)"),
        mint=Info("oklch(0.875 0.100 155)"),
        cyan=Info("oklch(0.900 0.100 180)"),
        azure=Info("oklch(0.875 0.100 225)"),
        blue=Info("oklch(0.825 0.100 250)"),
        violet=Info("oklch(0.825 0.200 290)"),
        magenta=Info("oklch(0.825 0.200 330)"),
        rose=Info("oklch(0.825 0.200 360)"),
    )
    bright=HueMap(
        red=Info("oklch(0.675 0.200 25)"),
        orange=Info("oklch(0.75 0.200 60)"),
        yellow=Info("oklch(0.80 0.200 100)"),
        lime=Info("oklch(0.800 0.200 120)"),
        green=Info("oklch(0.800 0.200 135)"),
        mint=Info("oklch(0.800 0.200 155)"),
        cyan=Info("oklch(0.800 0.200 180)"),
        azure=Info("oklch(0.800 0.200 225)"),
        blue=Info("oklch(0.800 0.200 250)"),
        violet=Info("oklch(0.800 0.200 290)"),
        magenta=Info("oklch(0.800 0.200 330)"),
        rose=Info("oklch(0.800 0.200 360)"),
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
            bg=Info("oklch(0.13 0.025 220)"),
            bgvar=Info("oklch(0.14 0.03 220)"),
            bg1=Mono.b16,
            bg2=Mono.b20,
            bg3=Mono.b25,
            bg4=Mono.b30,
            bg5=Mono.b35,
            hidden=Mono.g45,
            comment=Mono.g70,
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
            bg=Info("oklch(0.13 0.005 220)"),
            bgvar=Info("oklch(0.14 0.005 220)"),
            bg1=Info("oklch(0.16 0.005 220)"),
            bg2=Info("oklch(0.20 0.005 220)"),
            bg3=Info("oklch(0.25 0.005 220)"),
            bg4=Info("oklch(0.30 0.005 220)"),
            bg5=Info("oklch(0.35 0.005 220)"),
            hidden=dark.base.hidden,
            comment=dark.base.hidden,
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
        bgvar=Mono.s99,
        bg1=Mono.s95,
        bg2=Mono.s92,
        bg3=Mono.s99,
        bg4=Mono.s85,
        bg5=Mono.s80,
        hidden=Mono.g75,
        comment=Mono.g60,
        fg=Mono.g30,
        emph=Mono.g20,
        op2=dark.base.bg2,
        op1=dark.base.bg1,
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
            bgvar=Mono.w99,
            bg1=Mono.w95,
            bg2=Mono.w92,
            bg3=Mono.w99,
            bg4=Mono.w85,
            bg5=Mono.w80,
            hidden=day.base.hidden,
            comment=day.base.comment,
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
    def items(cls) -> dict[str, Palette]:
        return {
            "dark": cls.dark,
            "gray": cls.gray,
            "day": cls.day,
            "white": cls.white,
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


class Config(BaseNode):
    """An instance containing the color definitions and expanded info
    from within this module.
    """

    palettes: dict[str, Palette] = Palettes.items()
    """Palette definitions."""
    misc: dict = misc

    @staticmethod
    @cache
    def load() -> Config:
        return Config()

    def to(self, key: str, gamut: str | None = None) -> Self:
        return self.__class__(
                palettes={k: p.to(key, gamut) for k, p in self.palettes.items()},
            misc=self.misc,
        )
