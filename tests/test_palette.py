from hadalized.color import GamutInfo
from hadalized.palette import Palette


def test_palette_to(palette: Palette):
    val = palette.hex()
    leaf = val.hue.red
    assert isinstance(val, Palette)
    assert isinstance(leaf, str)
    assert leaf.startswith("#")

    val = palette.css()
    leaf = val.hue.red
    assert isinstance(val, Palette)
    assert isinstance(leaf, str)

    val = palette.oklch()
    leaf = val.hue.red
    assert isinstance(val, Palette)
    assert isinstance(leaf, str)
    assert leaf.startswith("oklch")

    val = palette.gamut_info()
    leaf = val.hue.red
    assert isinstance(val, Palette)
    assert isinstance(leaf, GamutInfo)
    assert leaf.hex.startswith("#")


def test_node_properties(palette: Palette):
    assert palette.meta
    assert palette.colors
