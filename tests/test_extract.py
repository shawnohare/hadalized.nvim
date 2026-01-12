from hadalized.color import ColorInfo


def test_parse():
    color_def = "oklch(0.5 0.1 25)"
    cinfo = ColorInfo.parse(color_def)
    assert cinfo.oklch == color_def
