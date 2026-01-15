import pytest

from hadalized.config import Config
from hadalized.writer import ThemeWriter, Template, run

from jinja2 import TemplateNotFound


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


def test_template_is_hashable():
    assert {Template("neovim.lua"): True}


def test_template_load_from_specified_dir(config: Config):
    template = Template("template.txt", fs_dir=config.template_fs_dir)
    assert template._template


def test_template_load_from_specified_dir_fail(config: Config):
    with pytest.raises(TemplateNotFound):
        Template("does-not-exist.txt", fs_dir=config.template_fs_dir)
