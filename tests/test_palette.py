
from hadalized.palette import Palette


def test_palette_to(palette: Palette):
    assert isinstance(palette.hex(), Palette)
    assert isinstance(palette.oklch(), Palette)
    assert isinstance(palette.css(), Palette)


def test_node_properties(palette: Palette):
    assert palette.meta
    assert palette.colors
