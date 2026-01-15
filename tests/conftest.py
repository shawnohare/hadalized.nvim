from pathlib import Path
from typing import TYPE_CHECKING
import pytest

from hadalized.config import Config

if TYPE_CHECKING:
    from hadalized.palette import Palette

_config = Config()


@pytest.fixture
def config(tmp_path) -> Config:
    return Config(
        build_dir=tmp_path,
        cache_dir=None,
        copy_dir=tmp_path / "copies",
        template_fs_dir=Path(__file__).parent,
    )


@pytest.fixture
def palette() -> Palette:
    return _config.palettes["hadalized"]
