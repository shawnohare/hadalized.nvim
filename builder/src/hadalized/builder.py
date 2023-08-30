import functools
import json
import tomllib
from collections import defaultdict
from collections.abc import Generator
from functools import reduce

# import hashlib
from copy import deepcopy
from itertools import product
from pathlib import Path
from typing import Literal, Self, TypedDict, Tuple

import coloraide
# import luadata
import pkg_resources

from pydantic import Field
from jinja2 import Environment, PackageLoader, select_autoescape

from .model import Model
from .config import Project, Config, HighlightDef, Mode

Spaces = ('oklch', 'p3', 'srgb', 'rec2020')
Gamuts = ("p3", "srgb")  # TODO: add rec2020 when it's used widely.

DarkAliases = {
    'bg0': 'dark0',
    'bg1': 'dark1',
    'bg2': 'dark2',
    'fg0': 'gray0',
    'fg1': 'gray1',
    'fg2': 'gray2',
    'op0': 'light0',
    'op1': 'light1',
    'op2': 'light2',
}

LightAliases = dict(zip(reversed(DarkAliases.keys()), DarkAliases.values()))


# TODO: Contexts.
# 1. Is a specific mode set? Many theme files are logicless and expect a
#    singular mode to be defined.
# 2. Is a specific gamut set? Almost always this is equivalent to whether
#    the application expects hex codes and whether it interprets them as
#    srgb or not. For example, wezterm currently seems to pass a hex code
#    to the system for rendering in whatever gamut is utilized by the monitor,
#    whereas other apps will explicitly
# 3. Think about whether only dealing with str -> dict[str, Color], that is,
#    concrete colorspace colors, simplifies things from a code and template
#    perspective. Most templates would likely be of the form
#    (mode, space) or (any mode, space) (e.g., neovim).
#    Probably it makes sense to make the main lookup key be (mode, space) itself
#    rather than weird nested structures.


class Color(Model):
    """Attributes for a concrete representation of a color
    (in a specified space)."""

    source: coloraide.Color = Field(default=coloraide.Color('#000000'), exclude=True)
    css: str = ''
    space: str = ''
    coords: list = Field(default_factory=list)
    unfitted_coords: list = Field(default_factory=list)
    alpha: float = 0.0
    in_gamut: bool = False
    hex: str = ''

    # def __repr__(self) -> str:
    #     return self.css

    @classmethod
    def new(cls, color: coloraide.Color, space: str = '') -> Self:
        """Create new instance in the specified space from an existing
        coloraide.Color instance.
        """
        source = color
        color = color.convert(space)
        unfitted_coords = color.coords()
        in_gamut = color.in_gamut()
        color.fit('oklch-chroma')
        if color.space() in ["srgb", "display-p3"]:
            coords = [round(255 * x) for x in color.coords()]
            hex = f"#{coords[0]:02x}{coords[1]:02x}{coords[2]:02x}"
        else:
            hex = ""

        return cls(
            source=source,
            css=color.to_string(),
            space=color.space(),
            coords=color.coords(),
            unfitted_coords=unfitted_coords,
            alpha=color.alpha(),
            hex=hex,
            in_gamut=in_gamut,
        )

    @functools.cache
    def fit(self, space: str) -> Self:
        """Return a new instance fit to the desired space."""
        return self.new(self.source, space)

    def __bool__(self) -> bool:
        return bool(self.css)

def map_coloraide(defs: dict[str, str | coloraide.Color]) -> dict[str, coloraide.Color]:
    return {k: coloraide.Color(v) for k, v in defs.items()}

class ColorMaker:
    """Utility for constructing colors derived from the theme's main color
    definitions."""

    def __init__(self, color_defs: dict[str, str | coloraide.Color]):
        self.coloraide = map_coloraide(color_defs)



    def mode_colors(self, overrides: dict[str, str], background: str, highlights: dict[str, HighlightDef]):
        aliases = LightAliases if background == 'light' else DarkAliases
        colors = self.coloraide.copy() | map_coloraide(overrides)
        for alias, color_name in aliases.items():
            colors[alias] = colors[color_name]

        # TODO: for each space, create colors and hl groups.
        spaces = {s: {'colors': {}, 'highlights': {}} for s in Spaces}
        for space in Spaces:
            colors_in_space = {k: Color.new(colors[k], space) for k, v in colors.items()}



class ColorSet(Model):
    """A collection of colors over some color spaces of interest."""
    oklch: Color
    srgb: Color
    p3: Color
    rec2020: Color

    def hex(self, gamut: str = "srgb") -> str:
        """Obtain the hex code for the provided RGB space."""
        return self[gamut].hex

    @classmethod
    def parse(cls, css: str) -> Self:
        """Obtain a set of colors in various spaces from a CSS string."""
        color = coloraide.Color(css)
        data = {k: Color.new(color, k) for k in Spaces}
        return cls.model_validate(data)

    @classmethod
    def map(cls, colors: dict[str, str]) -> dict[str, Self]:
        return {k: cls.parse(v) for k, v in colors.items()}

    @classmethod
    def map_spaces(cls, colors: dict[str, str]) -> dict[str, dict[str, Color]]:
        """For each colorspace, map a  """
        spaces = {k: {} for k in Spaces}
        for key, css in colors.items():
            color = coloraide.Color(css)
            for space in Spaces:
                spaces[space][key] = Color.new(color, space)
        return spaces

    def __bool__(self) -> bool:
        return bool(self.oklch)

# TODO: Could always pass the same theme context
# class TemplateContext(Model):
#     theme: str
#     version: str
#     url: str
#     modes: dict
#     hl: dict

# TODO: Just use config highlight (groups).
# class FontStyle(Model):
#     bold: bool = False
#     inverse: bool = False
#     italic: bool = False
#     # standout: bool = False
#     strikethrough: bool = False
#     undercurl: bool = False
#     underdashed: bool = False
#     underdotted: bool = False
#     underdouble: bool = False
#     underline: bool = False
#
#     @classmethod
#     def new(cls, val: str) -> Self:
#         """Convert a space delimited list of style descriptors into an instance.
#         """
#         attrs_set = {k: True for k in val.split(' ')}
#         return cls.model_validate(attrs_set)
#


# @dataclass
# class View:
#     """
#     A color access layer.
#
#     1. Is a specific gamut / color space specified? If so pass colors.
#     2. Is a specific mode set? Then colors are for that mode only.
#
#     Usage
#     view = View(mode=mode, gamut=gamut)
#     """
#     colors: dict[str, ColorSet]
#     mode_colors: dict[str, ColorSet]
#     highlights: dict[str, Highlight]
#     mode: str = ''
#     gamut: str = ''
#
#     def color(self, name: str) -> ColorSet | Color:
#         # If a highlight group is passed get the fg or bg color.
#         if name.startswith('hl.'):
#             key, _, attr = name.rpartition('.')
#             hl = self.highlights[key]
#             name = getattr(hl, attr)
#         # if (color := self.mode_colors.get(name)) i
#
#
#         colors = self.mode_colors.get(self.mode, self.colors)
#         color_set = colors[name]
#         if self.gamut:
#             color = color_set[gamut]
#         else:
#             color = color_set
#
#
#
#
#
#         color = self.modes[]
#
#
#


def resolve_colors(colors: dict[str, str | ColorSet]) -> dict[str, ColorSet]:
    # TODO: Do we need this function? It's usefulwhen clor aliases are
    # configurable, but not useful otherwise.
    resolved = {}
    for key, color in colors.items():
        while not isinstance(color, ColorSet):
            try:
                color = colors[color]
            except KeyError:
                color = ColorSet.parse(color)
        resolved[key] = color
    return resolved


class Highlight(Model):
    """A highlight group or semantic token to which a foreground, background
    and style elements can be applied. Essentially identical to (neo)vim
    highlight groups.

    It is assumed a foreground and background color are always specified.

    WARNING: Experimental feature not widely implemented.
    """

    fg: Color | ColorSet | None = Color()
    bg: Color | ColorSet | None = Color()
    style: str = ''
    link: str = ''




class ModeLookup(Model):
    """A mode and space color mapping."""
    color: dict[str, Color]
    hl: dict[str, Highlight]

    @classmethod
    def new(cls, colors: dict[str, ColorSet], highlights: dict[str, HighlightDef], space: str) -> Self:
        """Create a (Mode, Space) Color and Highlight lookup"""
        default = highlights.get('default', HighlightDef(fg='fg2', bg='bg0'))

        def new_highlight(val: HighlightDef) -> Highlight:
            orig = val
            while val.link:
                val = highlights[val.link]
            group = Highlight(
                fg=colors[orig.fg or val.fg or default.fg][space],
                bg=colors[orig.bg or val.bg or default.fg][space],
                style=orig.style or val.style or default.fg,
                link=orig.link or 'default',
            )
            return group

        return cls(
            color= {k: v[space] for k, v in colors.items()},
            hl={k: new_highlight(v) for k, v in highlights.items()},
        )


class ModeContext(Model):
    # project: Project
    name: str
    background: str
    space: str
    color: dict[str, Color]
    hl: dict[str, Highlight]

    @classmethod
    def new(cls, config: Config, mode_key: str, colors: dict[str, ColorSet], space: str) -> Self:
        highlights = config.hl
        default_hl: HighlightDef = highlights.get('default', HighlightDef(fg='fg2', bg='bg0'))
        mode_def = config.modes[mode_key]

        def new_highlight(val: HighlightDef) -> Highlight:
            orig = val
            while val.link:
                val = highlights[val.link]
            group = Highlight(
                fg=colors[orig.fg or val.fg or default_hl.fg][space],
                bg=colors[orig.bg or val.bg or default_hl.fg][space],
                style=orig.style or val.style or default_hl.fg,
                link=orig.link or 'default',
            )
            return group

        return cls(
            name=mode_def.name,
            background=mode_def.background,
            space=space,
            color= {k: v[space] for k, v in colors.items()},
            hl={k: new_highlight(v) for k, v in highlights.items()},
        )

    def __getitem__(self, key):
        if key.startswith('hl.'):
            val = self.hl[key]
        elif key in self.color:
            val = self.color[key]
        else:
            val = getattr(self, key)
        return val



class NewTheme:
    # TODO: What do we want here?
    # metadata (project node) and a bunch of (mode, space)
    # lookups. Beyond this, just a simple function to essentially
    # filter these lookups based on template context.
    # - Theme can always pass in project node.
    # - Should be a 'color' context.

    def __init__(self, config: Config):
        self.config = config
        self._data = self.config.model_dump()
        self.project = self.config.project
        self.modes = self._data['modes']

        theme_colors = ColorSet.map(self.config.colors)

        for (mode_key, conf), space in product(self._data['modes'].items(), Spaces):
            mode_colors = theme_colors | ColorSet.map(conf.colors)
            self._data['modes'][mode_key]['colors'] = mode_colors
            for space in Spaces:
                ctx = ModeContext.new(config, mode_key, mode_colors, space)
                self.modes[(mode_key, space)] = ctx

    def select_modes(self, mode: str | None = None, spaces: list[str] | None = None):
        """Select a subset of (mode, space) colors."""
        spaces = spaces or list(Spaces)
        mode_sel = [mode] if mode else self.modes.keys()
        modes = {k: self.modes[k] for k in product(mode_sel, spaces)}

        mode_selected = bool(mode)
        single_space = len(spaces) == 1

        # TODO: Is this too complicated? Maybe always return dict[str, ModeContext]
        out: ModeContext | dict[str, ModeContext] | dict[str, dict[str, ModeContext]]
        if mode_selected and single_space:
            # access like red, hl.comment
            out = list(modes.values())[0]
        elif mode_selected and not single_space:
            # acess like oklch.red
            out = {k[1]: v for k, v in modes.items()}
        elif not mode_selected and single_space:
            # access like dark.red
            out = {k[0]: v for k, v in modes.items()}
        else:
            # access like mode['dark.oklch'].red
            # out = modes
            out = defaultdict(dict)
            for (mode_key, space_key), inst in modes.items():
                out[mode_key][space_key] = inst

        if mode_selected and not single_space:
            ctx = {space: self.modes((mode, space)) for space in spaces}
        elif mode_selected and single_space:
            return


# def colorspace_map(colors: dict[str, ColorSet], space: str) -> dict[str, Color]:
#     """Extract the Color instance for a specific colorspace from a defined
#     """
#     return {k: v[space] for k, v in colors.items()}
#
# def highlight_groups_map(colors: dict[str, ColorSet], highlights: dict[str, HighlightDef], space: str = '') -> dict[str, Highlight]:
#     """Create HighlightGroups with Color or ColorSet values for fg and bg
#     from Highlight
#
#     """
#     default = highlights.get('default', HighlightDef(fg='fg2', bg='bg0'))
#
#     def mapper(val: HighlightDef) -> Highlight:
#         orig = val
#         val = default
#         while val.link:
#             val = highlights[val.link]
#         # TODO: What are good default values for fg and bg if they're omitted?
#         fg=colors[orig.fg or val.fg]
#         bg=colors[orig.bg or val.bg]
#         if space:
#             fg = fg[space]
#             bg = bg[space]
#         group = Highlight(
#             fg=colors.get(orig.fg or val.fg),
#             bg=colors.get(orig.bg or val.bg),
#             style=orig.style or val.style,
#             link=orig.link or 'default',
#         )
#         return group
#
#     return {k: mapper(v) for k, v in highlights.items()}
#

# def mode_colors(colors: dict[str, ColorSet], highlights: dict[str, HighlightDef]) -> dict:

class ModeColors(dict):

    def __init__(self, colors: dict[str, ColorSet], highlights: dict[str, HighlightDef]):
        # super().__init__(self)
        self.colors = ColorLookup(colors, highlights)
        color_spaces: dict[str, dict]= {
            space: {name: color[space]} for space, (name, color) in product(Spaces, colors.items())
        }
        self.spaces = {k: ColorLookup(v, highlights) for k, v in color_spaces.items()}
        self.oklch = self.spaces['oklch']
        self.p3 = self.spaces['p3']
        self.srgb = self.spaces['srgb']
        self.rec2020 = self.spaces['rec2020']

        # for name, color in colors.items():
        #     self[name] = color
        # for space in Spaces:
        #     self[space] = self.spaces[space]





class Mode(Model):
    """A Mode represents a concrete collection of
    colors and highlight groups drawn from a theme's main
    color palette.

    Examples of modes would be a "light" or "dark" or
    "high contrast dark".

    Example usage in templates
    {{ m.red }} -> "#ff0000" when gamut is "srgb" and format is "hex"
    {{ m.red.hex }} -> "#ff0000"
    """
    name: str = 'dark'
    background: str = 'dark'
    colors: dict[str, ColorSet] = Field(default_factory=dict)
    # spaces: dict[str, dict[str, Color]]
    # hl: dict[str, Highlight]
    # gamut: str = ''
    # format: str = ''
    #



class Theme(Config):
    """A fully parsed configuration."""
    colors: dict[str, ColorSet]
    modes: dict[str, Mode]


    # def context(self, mode: str = '', space: str = '') -> dict:
    #     colors = self.colors
    #     if mode:
    #         colors = self.modes[mode].colors




class TemplateContext:


    # def view(self, gamut: str = '', format: str = '') -> Self:
    #     return self.__class__(
    #         name=self.name,
    #         background=self.background,
    #         colors=self.colors,
    #         hl=self.hl,
    #         gamut=gamut or self.gamut,
    #         format=format or self.format,
    #     )
    #
    # @functools.cache
    # def color(self, name: str) -> Color | ColorAttrs | str:
    #     color = self.colors[name]
    #     if self.gamut:
    #         color = color[self.gamut]
    #         if format == 'hex':
    #             color = color.hex



    # @functools.cache
    # def hex(self, gamut: str) -> dict:
    #     colors = {k: v.hex(gamut) for k, v in self.colors.items()},
    #     hl = {}
    #     for key, group in self.hl.items():
    #         group_dict = group.dump()
    #         if group.fg:
    #             group_dict['fg'] = group.fg.hex(gamut)
    #         if group.bg:
    #             group_dict['bg'] = group.bg.hex(gamut)
    #         hl[key] = group_dict
    #
    #
    #     return {
    #         "name": self.name,
    #         "background": self.background,
    #         "colors": colors,
    #         "hl": hl,
    #     }
    #

# FIXME: Delete this overly complicated thing.
# 1. There are themes and modes (variants) only.
# 2. Modes define color aliases / overrides
# 3. Theme defines highlight groups.
# class Scheme(ColorContext):
#     """A processed Scheme node from a configuration file. A Scheme is the
#     primary context passed to most templates that can handle light and
#     dark mode logic in the same file.
#     """
#
#     name: str
#     colors: dict[str, Color]
#     aliases: dict[str, dict[str, str]]
#
#
#     @functools.cache
#     def mode(self, mode: str) -> Mode:
#         """Create a Mode instance whose color map contains
#         the Scheme named colors and aliases resolved to Color instances.
#         """
#         aliases = merge({k:k for k in self.colors}, self.aliases["ansi"], self.aliases[mode])
#         resolved = {}
#         for alias, key in aliases.items():
#             # Look if the "alias" is a css definition first.
#             try:
#                 color = Color.new(key)
#             except ValueError:
#                 color = None
#             cnt = 1
#             while (color := self.colors.get(key, color)) is None:
#                 key = aliases[key]
#                 cnt += 1
#                 if cnt >= 20:
#                     raise ValueError(f'Unable to resolve {alias=}')
#             resolved[alias] = color
#
#         return Mode(
#             name=self.name,
#             mode=mode,
#             colors=resolved,
#             # **resolved,
#         )
#
#     @property
#     def dark(self) -> Mode:
#         """Return dark background mode variant containing Color instances."""
#         return self.mode('dark')
#
#     @property
#     def light(self) -> Mode:
#         """Return light background mode variant containing Color instances."""
#         return self.mode('light')
#
#     @functools.cache
#     def hex(self, gamut: str) -> SchemeHex:
#         return SchemeHex(
#             name=self.name,
#             gamut=gamut,
#             dark=self.dark.hex(gamut),
#             light=self.light.hex(gamut),
#         )
#
#     @functools.cache
#     def css(self) -> SchemeCSS:
#         return SchemeCSS(
#             name=self.name,
#             dark=self.dark.css(),
#             light=self.light.css(),
#         )



class TemplateConfig(Model):
    """Configuration for a template. Typically specified in the default
    node, but each template can specify additional nodes to apply per
    template.

    This makes the templates as logicless as possible.

    Below are some general context scenarios we encounter.

    - What color value is expected?
      - css? Then use oklch or some other standard.
      - hex? Need to pick a RGB colorspace such as sRGB, display-p3, rec2020.
        Most applications will tend to expect either sRGB or use the system
        colorspace. The upshot is that apps which explicitly take a hex code
        as an SRGB value might render duller colors if a p3 RGB code is
        passed.
    - Does the theme file color values depend on an external application, e.g.,
      terminal neovim where the hex colors get interpreted by the underlying
    - What's the context?
      - Is the theme file logicless, such as a simple toml config that
        requires a specific (Scheme, mode, space, value) to be passed?
      - If there's some logic allowed in the theme file, we could pass in
        - The full context containing all Schemes and modes.
          (space, value) since those are almost always fixed per application.
        - A single Scheme (containing dark and light variants).
      - Only a single (Scheme, mode, space, value)?

    Another simplified view is the following

    - color_type is "srgb" (hex), "p3" (hex), "oklch" (css), "color"

    Attrs:
        color_value: If "hex", each color context variable will contain a
            hexcode for a specific gamut. "css" produces an object
            containing css codes for multiple spaces, to allow fallbacks.
            Typically an application's theme configuration will
            expect colors defined as either hex codes or CSS. Some applications
            have color values processed by an external application, e.g.,
            a TUI instance of neovim has its colorscheme hexcodes
            interpreted by the underlying terminal emulator. These external
            applications sometimes treat the RGB values of the hexcode as
            "native" or process them as sRGB values. The upshot is that
            some themes might look duller if the external application assumes
            sRGB codes but display-p3 or rec2020 codes are provided.

        gamuts: If an application's color space is known in advance,
            this can be set when hex values are expected. Otherwise generate a
            theme file for each
            appropriate gamut. We assume that the gamut of an application is
            known in advance and set appropriately by the user.

        context: The underlying context view of the template.
            If "full", pass in all Schemes, where the color values are
            determined by the color_value and gamut fields.
            Access to colors in this
            case is "{Scheme}.{mode}.{color}".
            If "Scheme", provide dark and light modes for a single Scheme.
            Access to colors is {mode}.{color}.
            The "mode" case exposes color parameters directly, according
            to the color_value and gamut fields. Access is {color}. Most
            themes expect a mode to be passed, but some can allow defining
            a number of different colors for different Schemes and gamuts,
            such as a neovim colorscheme or Xresources file.

    """
    color_value: Literal["css", "hex", "object"] = "hex"
    context: Literal["full", "Scheme", "mode"] = "mode"
    gamuts: list[str] = Field(default_factory=lambda: Gamuts)
    filename: str = "{Scheme}_{mode}_{gamut}{extension}"
    extension: str = ''
    output: str = "build"





def new_theme(config: Config) -> Theme:
    """Generate the core data that is used to create template context views."""
    data = config.model_dump()
    colors = ColorSet.map(config.colors)
    data['colors'] = data
    base_keys = ['dark0']
    for key, mode in config.modes.items():
        mode_data = mode.model_dump()
        mode_data['colors'] = colors | ColorSet.map(mode.colors)
        data['modes'][key] = Mode.model_validate(mode_data)

    return Theme.model_validate(data)





class ContextGenerator:

    def __init__(self, config_path: str = ""):
        schemes: dict[str, Scheme] = {}

        defaults_path = config_path or pkg_resources.resource_filename(
            "hadalized", "defaults.toml"
        )
        with open(defaults_path, "rb") as fp:
            defaults = tomllib.load(fp)

        if not config_path:
            path = Path(defaults_path).parent / 'themes' / 'default.toml'
        else:
            path = Path(config_path)

        with path.open('rb') as fp:
            config_data = merge(defaults, tomllib.load(fp))
            scheme_defaults = {k: config_data[k] for k in ['aliases', 'colors', 'hl']}

        schemes = {}
        for key, node in config_data['schemes'].items():
            scheme_data = merge(scheme_defaults, node)
            scheme_data.setdefault("name", key)
            config_data['schemes'][key] = scheme_data
            schemes[key] = Scheme.model_validate(scheme_data)

        self.config = Config.model_validate(config_data)

        self.schemes = schemes

    def __call__(self, node: TemplateConfig) -> Generator[ColorContext, None, None]:
        """Infer contexts from a template configuration file.

        A single set of files is rendered for each ColorContext element
        returned.

        Args:
            node: A configuration node for the template file.
        """
        schemes = self.schemes.values()

        def context(scheme: Scheme | Mode) -> Generator[ColorContext, None, None]:
            """Obtain the appropriate context(s) for the configuration
            color_type.
            """
            match node.color_value:
                case "hex":
                    for gamut in node.gamuts:
                        yield Scheme.hex(gamut)
                case "css":
                    yield Scheme.css()
                case "object":
                    yield scheme
                case _:
                    raise ValueError('Invalide {color_value=}.')

        match node.context:
            case ("full" ):
                # # Render a single template file.
                # WARNING: It's not clear if we should actualy support this
                # case or always insist on generating files for
                yield Schemes(
                    # Schemes={k: c for k, p in self.Schemes.items() for c in context(p)},
                    Schemes=self.schemes,
                    template_config=node,
                )
            case "scheme":
                for scheme in schemes:
                    for ctx in context(scheme):
                        yield ctx
            case "mode":
                for scheme, mode in product(schemes, Modes):
                    for ctx in context(Scheme.mode(mode)):
                        yield ctx
            case _:
                raise ValueError(f"Invalid arg {context=}")


class ThemeWriter:
    """Render theme templates and write resulting theme files."""

    def __init__(self, context_generator: ContextGenerator | None = None):
        self.context = context_generator or ContextGenerator()
        self.env = Environment(
            loader=PackageLoader("hadalized"), autoescape=select_autoescape()
        )

    def __call__(self, app: str):
        """Render a template and place in the build subdir.
        Assumes a colorspace is passed as context.

        A template in templates/wezterm/colorscheme.toml will be writte to
        build/wezterm/{Scheme}_{mode}_{space}.toml

        Args:
            app: Subdirectory of "templates" containing
                application theme templates. For example "wezterm".
        """
        subdir_path = Path(app)
        config_path = Path(
            pkg_resources.resource_filename(
                "hadalized", str("templates"/subdir_path/"config.toml")
            )
        )

        # Load configuration for each template in the subdir and marshal into
        # a Model.
        with config_path.open("rb") as fp:
            data = tomllib.load(fp)
            config = {k: TemplateConfig(**merge(data['default'], v)) for k, v in data.items()}

        # Render and write a template for each template file and context item.
        for path in config_path.parent.glob('*'):
            if path.name == "config.toml":
                continue
            template_config = config.get(path.stem, config['default'])
            template_path = subdir_path / path.name
            for context in self.context(template_config):
                self.write(template_path, template_config, context)

    def write(self, path: Path, config: TemplateConfig, context: ColorContext):
        """Write a single file given the template config and context.

        Args:
            path: Relative path to template, e.g., {app}/default.toml
        """

        out_dir = config.output / path.parent
        out_dir.parent.mkdir(exist_ok=True, parents=True)

        filename = config.filename.format(
            scheme=context.get('name', ''),
            mode=context.get('mode', ''),
            gamut=context.get('gamut', ''),
            extension=config.extension,
        ).strip('_')

        with (out_dir / filename).open("w") as fp:
            template = self.env.get_template(str(path))
            text = template.render(c=context, **context.dump(), **context.colors)
            fp.write(text)


# def main():
#     views = Views()
#     # modes = {k: v.modes() for k, v in Schemes.items()}
#     Scheme_dicts = {k: v.to_dict() for k, v in views.Schemes.items()}
#
#     with open("lua/hadalized/Schemes.lua", "w") as fp:
#         print("Writing hadalized neovim theme Scheme module.")
#         tables = luadata.serialize(views.to_hex(), indent="\t")
#         # print(tables)
#         # print(views.to_hex(flatten=False))
#         fp.write(f"""-- WARNING: Autogenerated\n\nreturn {tables}""")
#
#     # Dump Scheme color objects.
#     with open("Schemes.json", "w") as fp:
#         json.dump(Scheme_dicts, fp, indent=4)
#
#     # WIP: Render and write templates.
#     writer = Writer()
#     context = views.get_space('hadalized', 'dark', 'p3')
#     writer('wezterm/default.toml', context)
#     context = views.get_space('hadalized', 'light', 'p3')
#     writer('wezterm/default.toml', context)
#
#
# if __name__ == "__main__":
#     main()
