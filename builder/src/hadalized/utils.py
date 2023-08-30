from pkg_resources import resource_filename
from pathlib import Path
from copy import deepcopy
from functools import reduce
import tomllib

def merge(*args: dict) -> dict:
    """Recursively merge dictionary inputs.

    For example, to apply default values to a configuration node,
    invoke via `node = merge(default, node)`
    """

    def reducer(d1: dict, d2: dict) -> dict:
        for k2, v2 in d2.items():
            if isinstance(v2, dict) and isinstance(v1 := d1.get(k2), dict):
                v2 = reducer(v1, v2)
            d1[k2] = v2
        return d1

    return reduce(reducer, (deepcopy(d) for d in args), {})


def get_resource_path(path: str) -> Path:
    path = resource_filename(
        "hadalized", str(Path(path)),
    )
    return Path(path)


def load_toml(path: Path | str) -> dict:
    path = Path(path)
    with path.open("rb") as fp:
        return tomllib.load(fp)
