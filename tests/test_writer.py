import pytest

from hadalized.config import Config
from hadalized.writer import ThemeWriter, run


def test_theme_writer_run(config: Config):
    """Tests the main ThemeWriter.run"""
    with ThemeWriter(config) as writer:
        written = writer.run()
        assert written
        assert (config.build_dir / "neovim" / "hadalized.lua").exists()
        assert (config.build_dir / "wezterm" / "hadalized.toml").exists()
        assert (config.build_dir / "starship" / "starship.toml").exists()
        # Check now that the in memory cache is checks result in no new builds.
        written = writer.run()
        assert written == []


def test_run(config: Config):
    """Tests the main ThemeWriter.run"""
    run(config)


def test_writer_exist_with_exception(config: Config):
    with pytest.raises(ValueError):
        with ThemeWriter(config):
            raise ValueError("bomb")
