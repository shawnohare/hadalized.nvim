import pytest

from hadalized.config import Config
from hadalized.writer import Template

from jinja2 import TemplateNotFound


def test_template_is_hashable():
    assert {Template("neovim.lua"): True}


def test_template_load_from_specified_dir(config: Config):
    template = Template("template.txt", fs_dir=config.template_fs_dir)
    assert template._template


def test_template_load_from_specified_dir_fail(config: Config):
    with pytest.raises(TemplateNotFound):
        Template("does-not-exist.txt", fs_dir=config.template_fs_dir)
