from typing import TYPE_CHECKING
import pytest

from hadalized.config import Config

if TYPE_CHECKING:
    from hadalized.palette import Palette

_config = Config()


@pytest.fixture
def config(tmp_path) -> Config:
    return Config(build_dir=tmp_path, cache_in_memory=True)


@pytest.fixture
def palette() -> Palette:
    return _config.palettes["hadalized"]
