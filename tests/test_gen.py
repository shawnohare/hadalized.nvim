from hadalized.config import Config
from hadalized.gen import FileWriter


def test_write_all(tmp_path):
    config = Config(build_dir=tmp_path, cache_dir=tmp_path / "cache")
    writer = FileWriter(config)
    written = writer.write_all()
    assert written
    assert (config.build_dir / "neovim" / "hadalized.lua").exists()
    assert (config.build_dir / "wezterm" / "hadalized.toml").exists()
    assert (config.build_dir / "starship" / "starship.toml").exists()
    written = writer.write_all()
    assert written == []
