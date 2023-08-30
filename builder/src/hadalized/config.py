"""Models defining a Theme configuration file."""
import tomllib
from typing import Self

from functools import cache
from pydantic import Field

from .model import Model
from .utils import merge, load_toml



class HighlightDef(Model):
    """A color and style setting for UI elements and text tokens.

    Foreground and background color elements should reference a color alias.
    """
    fg: str = ''
    bg: str = ''
    style: str = ''
    link: str = ''

    # bold: bool = False
    # italic: bool = False
    # underline: bool = False
    # undercurl: bool = False
    # underdouble: bool = False
    # underdotted: bool = False
    # underdashed: bool = False
    # inverse: bool = False
    # italic: bool = False
    # standout: bool = False
    # strikethrough: bool = False
    # font_style: str = ''


HighlightDefault = HighlightDef(fg='fg2', bg='bg0')

class Colors(Model):
    # main accents
    red: str
    orange: str
    yellow: str
    green: str
    cyan: str
    blue: str
    violet: str
    magenta: str
    br_red: str
    br_orange: str
    br_yellow: str
    br_green: str
    br_cyan: str
    br_blue: str
    br_violet: str
    br_magenta: str
    dark0: str
    dark1: str
    dark2: str
    gray0: str
    gray1: str
    gray2: str
    light0: str
    light1: str
    light2: str


# class ModeColors(Colors):
#     """Mode-invariant color aliases."""
#     bg0 = ""
#     bg1 = ""
#     bg2 = ""
#     fg0 = ""
#     fg1 = ""
#     fg2 = ""
#     op0 = ""
#     op1 = ""
#     op2 = ""
#

class Mode(Model):
    """A theme variant, such as dark, light or high contrast (light / dark)."""
    name: str
    background: str
    colors: dict[str, str] = Field(default_factory=dict)


class Project(Model):
    """Project (theme) level metadata."""
    name: str
    version: str
    url: str


class Config(Model):
    """Model for a theme configuration.

    Each specific theme configuration will have its values merged
    into the default theme.
    """
    project: Project
    colors: dict[str, str] = Field(default_factory=dict)
    modes: dict[str, Mode] = Field(default_factory=dict)
    hl: dict[str, HighlightDef] = Field(default_factory=dict)

    @classmethod
    @cache
    def default(cls) -> dict:
        """Load and return the default configuration as a pure dict."""
        return load_toml("themes/defaults/default.toml")

    @classmethod
    def load(cls, path: str = '') -> Self:
        data = cls.default()
        if path:
            with open(path, "rb") as fp:
                data = merge(data, tomllib.load(fp))
        return cls.model_validate(data)
