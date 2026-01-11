from hadalized.cache import Cache


def test_save_and_clear(tmp_path):
    cache = Cache(cache_dir=tmp_path / "cache").connect()
    path = tmp_path / "test.txt"
    cache.add(path, "123")
    assert cache.get_hash(path) == "123"
    cache.close()
