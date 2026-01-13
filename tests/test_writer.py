from hadalized.config import Config
from hadalized.writer import ThemeWriter


def test_run(config: Config):
    """Tests the main ThemeWriter.run"""
    with ThemeWriter(config) as writer:
        written = writer.run()
        assert written
        assert (config.build_dir / "neovim" / "hadalized.lua").exists()
        assert (config.build_dir / "wezterm" / "hadalized.toml").exists()
        assert (config.build_dir / "starship" / "starship.toml").exists()
        written = writer.run()
        assert written == []
