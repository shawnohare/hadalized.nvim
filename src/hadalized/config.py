from functools import cache
from typing import Self

from hadalized.models import (
    ColorField,
    BaseNode,
    ColorMap,
    HueMap,
    BaseMap,
    Info,
    Palette,
    Hues,
    PaletteMap,
)


class MonochromeMap(ColorMap):
    """Singleton class containing named monochromatic colors used for
    foregrounds and backgrounds.
    """

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


mono = MonochromeMap()

hues: Hues = Hues(
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
    ),
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
    ),
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
    ),
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
    ),
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
    ),
)


# Palette definitions
palette_dark: Palette = Palette(
    name="hadalized",
    desc="Main dark theme with blueish solarized inspired backgrounds.",
    mode="dark",
    gamut="srgb",
    hue=hues.dark,
    base=BaseMap(
        bg=Info("oklch(0.13 0.03 220)"),
        bgvar=Info("oklch(0.14 0.03 220)"),
        bg1=mono.b16,
        bg2=mono.b20,
        bg3=mono.b25,
        bg4=mono.b30,
        bg5=mono.b35,
        hidden=mono.g45,
        comment=mono.g70,
        fg=mono.w80,
        emph=mono.w85,
        op2=mono.s80,
        op1=mono.s85,
        op=mono.s90,
    ),
    hl=hues.hl,
    bright=hues.bright,
)


palette_day: Palette = Palette(
    name="hadalized-day",
    desc="Light theme variant with sunny backgrounds.",
    mode="light",
    gamut="srgb",
    hue=hues.light,
    base=BaseMap(
        bg=mono.s100,
        bgvar=mono.s99,
        bg1=mono.s95,
        bg2=mono.s92,
        bg3=mono.s99,
        bg4=mono.s85,
        bg5=mono.s80,
        hidden=mono.g75,
        comment=mono.g60,
        fg=mono.g30,
        emph=mono.g20,
        op2=palette_dark.base.bg2,
        op1=palette_dark.base.bg1,
        op=palette_dark.base.bg,
    ),
    hl=hues.hl,
    bright=hues.bright,
)

palette_white: Palette = Palette(
    name="hadalized-white",
    desc="Light theme variant with whiter backgrounds.",
    mode=palette_day.mode,
    gamut=palette_day.gamut,
    hue=palette_day.hue,
    base=BaseMap(
        bg=mono.w100,
        bgvar=mono.w99,
        bg1=mono.w95,
        bg2=mono.w92,
        bg3=mono.w99,
        bg4=mono.w85,
        bg5=mono.w80,
        hidden=palette_day.base.hidden,
        comment=palette_day.base.comment,
        fg=palette_day.base.fg,
        emph=palette_day.base.emph,
        op2=palette_day.base.op2,
        op1=palette_day.base.op1,
        op=palette_day.base.op,
    ),
    hl=hues.hl,
    bright=hues.bright,
)


misc: dict = {
    "degrees": {
        "rose": 0,
        "red": 25,
        "orange": 60,
        "yellow": 100,
        "lime": 120,
        "green": 135,
        "mint": 160,
        "cyan": 180,
        "azure": 220,
        "blue": 250,
        "violet": 290,
        "magenta": 330,
    },
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

    mono: MonochromeMap = mono
    """Monochromatic colors used in palette bases."""
    hues: Hues = hues
    """Reusable hue definitions for dark and light modes."""
    palettes: PaletteMap = PaletteMap(
        dark=palette_dark,
        day=palette_day,
        white=palette_white,
    )
    """Palette definitions."""
    misc: dict = misc

    @staticmethod
    @cache
    def load() -> Config:
        return Config()

    def to(self, key: str, gamut: str | None = None) -> Self:
        default_gamut = gamut or "srgb"
        return self.__class__(
            mono=mono.to(key, default_gamut),
            hues=self.hues.to(key, default_gamut),
            palettes=self.palettes.to(key, gamut),
            misc=self.misc,
        )
