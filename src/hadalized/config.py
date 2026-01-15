"""Module containing all underlying color definitions and gamut info."""

from pathlib import Path
from typing import Literal, Self

from pydantic import Field, PrivateAttr

from hadalized.cache import Cache
from hadalized.color import parse
from hadalized.palette import (
    BaseNode,
    Bases,
    ColorField,
    ColorType,
    Hues,
    Palette,
)


def default_palettes() -> dict[str, Palette]:
    """Lazily compute default palette colors.

    Returns:
        A map of palette.name -> palette.

    """
    hues: dict[str, Hues] = {
        "neutral": Hues(
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
        ),
        "dark": Hues(
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
        ),
        "light": Hues(
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
        ),
        "hl": Hues(
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
        ),
        "bright": Hues(
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
        ),
    }

    class Ref:
        """Container for named color refs used in foregrounds and backgrounds."""

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

    # Palette definitions
    pdark: Palette = Palette(
        name="hadalized",
        desc="Main dark theme with blueish solarized inspired backgrounds.",
        mode="dark",
        gamut="srgb",
        hue=hues["dark"],
        bright=hues["bright"],
        hl=hues["hl"],
        base=Bases(
            bg=parse("oklch(0.13 0.025 220)"),
            bg1=parse("oklch(0.14 0.03 220)"),
            bg2=Ref.b16,
            bg3=Ref.b20,
            bg4=Ref.b25,
            bg5=Ref.b30,
            bg6=Ref.b35,
            hidden=Ref.g45,
            subfg=Ref.g70,
            fg=Ref.w80,
            emph=Ref.w85,
            op2=Ref.s80,
            op1=Ref.s85,
            op=Ref.s90,
        ),
    )

    pgray: Palette = Palette(
        name="hadalized-gray",
        desc="Dark theme variant with more grayish backgrounds.",
        mode="dark",
        gamut=pdark.gamut,
        hue=pdark.hue,
        bright=pdark.bright,
        hl=pdark.hl,
        base=Bases(
            bg=parse("oklch(0.13 0.005 220)"),
            bg1=parse("oklch(0.14 0.005 220)"),
            bg2=parse("oklch(0.16 0.005 220)"),
            bg3=parse("oklch(0.20 0.005 220)"),
            bg4=parse("oklch(0.25 0.005 220)"),
            bg5=parse("oklch(0.30 0.005 220)"),
            bg6=parse("oklch(0.35 0.005 220)"),
            hidden=pdark.base.hidden,
            subfg=pdark.base.subfg,
            fg=pdark.base.fg,
            emph=pdark.base.emph,
            op2=Ref.w80,
            op1=Ref.w85,
            op=Ref.w90,
        ),
    )

    pday: Palette = Palette(
        name="hadalized-day",
        desc="Light theme variant with sunny backgrounds.",
        mode="light",
        gamut="srgb",
        hue=hues["light"],
        bright=hues["bright"],
        hl=hues["hl"],
        base=Bases(
            bg=Ref.s100,
            bg1=Ref.s99,
            bg2=Ref.s95,
            bg3=Ref.s92,
            bg4=Ref.s99,
            bg5=Ref.s85,
            bg6=Ref.s80,
            hidden=Ref.g75,
            subfg=Ref.g60,
            fg=Ref.g30,
            emph=Ref.g20,
            op2=pdark.base.bg3,
            op1=pdark.base.bg2,
            op=pdark.base.bg,
        ),
    )

    pwhite: Palette = Palette(
        name="hadalized-white",
        desc="Light theme variant with whiter backgrounds.",
        mode="light",
        gamut=pday.gamut,
        hue=pday.hue,
        bright=pday.bright,
        hl=pday.hl,
        base=Bases(
            bg=Ref.w100,
            bg1=Ref.w99,
            bg2=Ref.w95,
            bg3=Ref.w92,
            bg4=Ref.w99,
            bg5=Ref.w85,
            bg6=Ref.w80,
            hidden=pday.base.hidden,
            subfg=pday.base.subfg,
            fg=pday.base.fg,
            emph=pday.base.emph,
            op2=pday.base.op2,
            op1=pday.base.op1,
            op=pday.base.op,
        ),
    )

    return {
        pdark.name: pdark,
        pgray.name: pgray,
        pday.name: pday,
        pwhite.name: pwhite,
    }


class ANSIMap(BaseNode):
    """A mapping from color hue name to ANSI color index."""

    red: int = 1
    """Typically represents red."""
    rose: int = 9
    """Typically represents bright red."""
    green: int = 2
    """Typically represents green."""
    lime: int = 10
    """Typically represents bright green."""
    yellow: int = 3
    """Typically represents yellow."""
    orange: int = 11
    """Typically represents bright yellow."""
    blue: int = 4
    """Typically represents blue."""
    azure: int = 12
    """Typically represents bright blue."""
    magenta: int = 5
    """Typically represents magenta or purple."""
    violet: int = 13
    """Typically represents bright magenta or bright purple."""
    cyan: int = 6
    """Typically represents cyan."""
    mint: int = 14
    """Typically represents bright cyan."""
    _idx_to_name: dict[int, str] = PrivateAttr({})

    def model_post_init(self, context, /) -> None:
        """Model post init."""
        super().model_post_init(context)
        self._idx_to_name = {idx: name for name, idx in self}

    def get_name(self, idx: int) -> str:
        """Lookup the color name.

        Returns:
            The field name whose value is in the input.

        """
        return self._idx_to_name[idx]

    @property
    def pairing(self) -> list[tuple[str, str]]:
        """A map of a color and it's 'bright' variant."""
        return [(self.get_name(i), self.get_name(i + 8)) for i in range(1, 7)]


class TerminalConfig(BaseNode):
    """Configurations related to terminal emulators."""

    ansi: ANSIMap = ANSIMap()


class BuildConfig(BaseNode):
    """Information about which files should be generatted specific template."""

    template: str
    """Template filename."""
    output_path: Path
    """Output path template relative to a build directory."""
    copy_to: Path | None = None
    """Indicates if the built file should be copied to another directory.
    Typically relative the parent of the underlying build directory.
    """
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
    """How each Palette should be transformed when presented as context
    to the template."""
    skip: bool = False
    """If set to True, skip the directive."""

    @staticmethod
    def defaults() -> dict[str, BuildConfig]:
        """Builtin build configs.

        Returns:
            The default build instructions used to generate theme files.

        """
        return {
            "neovim": BuildConfig(
                template="neovim.lua",
                context_type="palette",
                output_path=Path("neovim/{name}.lua"),
                copy_to=Path("colors/{name}.lua"),
                color_type=ColorType.hex,
            ),
            "wezterm": BuildConfig(
                template="wezterm.toml",
                context_type="palette",
                output_path=Path("wezterm/{name}.toml"),
                color_type=ColorType.hex,
            ),
            "starship": BuildConfig(
                template="starship.toml",
                context_type="config",
                output_path=Path("starship/starship.toml"),
                color_type=ColorType.hex,
            ),
            "info": BuildConfig(
                template="palette_info.json",
                context_type="palette",
                output_path=Path("info/{name}.json"),
                color_type=ColorType.info,
            ),
            "html_samples": BuildConfig(
                template="palette.html",
                context_type="palette",
                output_path=Path("html_samples/{name}.html"),
                color_type=ColorType.css,
            ),
        }


class Config(BaseNode):
    """App configuration.

    Contains information about which app theme files to generate and where
    to write the build artifacts.
    """

    build_dir: Path = Path("./build")
    """Directory containing built theme files."""
    cache_dir: Path | None = Cache.default_dir
    """Application cache directory. Set to `None` to use an in-memory cache."""
    copy_dir: Path | None = Path("./")
    """A copy dir prefix. If set, any files built with a `copy_to` directive
    will be placed in this directory. When set to None, no files will be
    copied."""
    template_fs_dir: Path = Path("./templates")
    """Directory where templates will be searched for. If a template is not
    found in this directory, it will be loaded from those defined in the
    package."""
    builds: dict[str, BuildConfig] = Field(
        default_factory=BuildConfig.defaults,
        exclude=True,
    )
    """Build directives specifying how and which theme files are
    generated."""
    palettes: dict[str, Palette] = Field(default_factory=default_palettes)
    """Palette definitions."""
    terminal: TerminalConfig = TerminalConfig()
    misc: dict = Field(default={})

    def to(self, color_type: ColorType) -> Self:
        """Transform the ColorFields to the specified type.

        Use to render themes that require the entire context (e.g., all palettes),
        but where specific color representations (e.g., hex)
        are required.

        Returns:
            A new Config instance whose ColorFields match the input type.

        """
        return self.__class__(
            build_dir=self.build_dir,
            cache_dir=self.cache_dir,
            builds=self.builds,
            palettes={k: p.to(color_type) for k, p in self.palettes.items()},
            terminal=self.terminal,
            misc=self.misc,
        )

    def hex(self) -> Self:
        """Convert palette ColorField values to their hex representation.

        Returns:
            A new Config instance with color hex codes for ColorField values.

        """
        return self.to(ColorType.hex)

    def css(self) -> Self:
        """Convert palette ColorField values to their css representation.

        Returns:
            A new Config instance with color css strings for ColorField values.

        """
        return self.to(ColorType.css)
