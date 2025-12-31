import pytest

from hadalized.models import Info


def test_extract_info():
    color_def = "oklch(0.5 0.1 25)"
    info = Info(color_def)
    assert info.oklch == color_def
