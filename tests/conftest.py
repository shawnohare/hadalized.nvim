import pytest

from hadalized.config import Config


@pytest.fixture
def config(tmp_path) -> Config:
    return Config(build_dir=tmp_path, cache_in_memory=True)
