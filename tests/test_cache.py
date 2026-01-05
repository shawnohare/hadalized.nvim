from hadalized.cache import Cache
from hadalized.gen import get_template
from hadalized.config import Config


def test_save_and_clear(tmp_path):
    config = Config(build_dir=tmp_path)
    cache = Cache(cache_dir=tmp_path / "cache")
    template = get_template("palette_info.json")
    palette = config.palettes["hadalized"]
    cache.add(tmp_path / "info.json", palette, template)
    assert cache._build_data
    cache.save()
    assert cache._build_file.exists()
    cache.clear()
    assert not cache._build_file.exists()
