import pytest

from hadalized.gen import FileWriter

def test_write_all(tmp_path):
    writer = FileWriter(target_dir=tmp_path)
    writer.write_all()
