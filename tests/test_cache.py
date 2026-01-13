from hadalized.cache import Cache


def test_add(tmp_path):
    with Cache(cache_dir=tmp_path) as cache:
        path = tmp_path / "test.txt"
        cache.add(path, "123")
        assert cache.get_hash(path) == "123"


def test_delete(tmp_path):
    with Cache(cache_dir=tmp_path) as cache:
        path = tmp_path / "test.txt"
        cache.add(path, "123")
        cache.delete(path)
        assert cache.get_hash(path) is None


def test_clear(tmp_path):
    with Cache(cache_dir=tmp_path) as cache:
        path = tmp_path / "test.txt"
        cache.add(path, "123")
    cache.clear()
    assert not cache._db_file.exists()


def test_add_in_memory(tmp_path):
    with Cache(in_memory=True) as cache:
        path = tmp_path / "test.txt"
        cache.add(path, "123")
        assert cache.get_hash(path) == "123"
