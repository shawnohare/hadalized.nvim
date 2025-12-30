
from hadalized.config import Config


def test_config_load():
    assert Config.load()
