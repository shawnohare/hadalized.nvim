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
    """Obtain a full path to a package resource given a path relative to
    the package. For example
        get_resource_path('data.json') -> Path("/full/package/path/data.json")
    """
    path = resource_filename("hadalized", path)
    return Path(path)


def load_toml(path: Path | str) -> dict:
    with Path(path).open("rb") as fp:
        return tomllib.load(fp)


def load_template_config(app: str) -> dict:
    """Load an application theme template configuration file."""
    subdir_path = Path(app)
    config_path = get_resource_path(str("templates" / subdir_path / "config.toml"))
    return load_toml(config_path)
