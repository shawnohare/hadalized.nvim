from hadalized.config import Config
from hadalized.render import ThemeWriter

config = Config()


def test_neovim_writer(tmp_path):
    writer = ThemeWriter.neovim(config)
    writer.target_dir = tmp_path / writer.target_dir
    for palette in config.palettes.values():
        writer(palette)
        assert writer.palette_output_path(palette).exists()


def test_wezterm_writer(tmp_path):
    writer = ThemeWriter.wezterm(config)
    writer.target_dir = tmp_path / writer.target_dir
    for palette in config.palettes.values():
        writer(palette)
        assert writer.palette_output_path(palette).exists()
