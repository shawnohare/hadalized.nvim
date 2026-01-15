import pytest

from hadalized.color import ColorInfo, ColorType, GamutInfo, parse, extract

from coloraide import Color


def test_parse_oklch():
    val = "oklch(0.5 0.1 25)"
    assert parse(val).oklch == val


def test_parse_rgb():
    assert parse("rgb(0.5 0.5 0.5)")


def test_parse_fail():
    with pytest.raises(ValueError):
        parse("bad color")


def test_gamut_info():
    val = Color("srgb", [0.5, 0.5, 0.5])
    assert GamutInfo.new(val, "display-p3")


def test_color_info_gamut_properties():
    val = parse("oklch(0.5 0.2 25)")
    assert val.srgb
    assert val.display_p3


def test_color_info_color_property():
    val = parse("oklch(0.5 0.2 25)")
    assert isinstance(val.color, Color)


def test_color_info_color_prop_from_unparsed():
    val = ColorInfo(
        definition="rgb(0.5 0.5 0.5)",
        oklch="",
        gamuts={},
    )
    assert isinstance(val.color, Color)


def test_color_info_bad_def():
    val = ColorInfo(
        definition="bad color",
        oklch="",
        gamuts={},
    )
    with pytest.raises(ValueError):
        val.color


def test_extract_on_str_input():
    assert extract("any", "", ColorType.hex) == "any"
