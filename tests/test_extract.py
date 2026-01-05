from hadalized.models import info


def test_extract_info():
    color_def = "oklch(0.5 0.1 25)"
    cinfo = info(color_def)
    assert cinfo.oklch == color_def
