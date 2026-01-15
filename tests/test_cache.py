import pytest

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


def test_add_in_memory():
    with Cache(cache_dir=None) as cache:
        path = "test.txt"
        cache.add(path, "123")
        assert cache.get_hash(path) == "123"


def test_exit_with_error():
    with pytest.raises(ValueError):
        with Cache(None):
            raise ValueError("bomb")
