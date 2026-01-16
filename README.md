# hadalized palette and color themes

A darker Solarized-inspired theme primarily for neovim 0.11+ and that
uses the oklch color space for definitions. The name references the [oceanic
hadopelagic zones](https://en.wikipedia.org/wiki/Hadal_zone) to emphasize our
preference of a darker shade of the original Solarized background.


## Use with neovim

With `lazy`, add

```lua
return {
    {
        "shawnohare/hadalized.nvim",
        opts = {
            italic = false, -- disables all italic text.
        },
        priority = 1000,
        dependencies = { },
    },
}
```

## Theme generation

The underlying color palettes are defined as oklch values in the included
python [hadalized.config](./src/hadalized/config.py) module. The `hadalied`
python package generates themes for various applications, which can be
copied to their respective application config folders (or dotfiles repo)
manually. As the python application is generated


To generate all theme files, assuming `uv` and `just` are installed

```sh
just
```

Generated themes are placed in `./build`.

### Overriding configuration defaults

To generate your own hadalized variants

```py
from hadalized.writer import Config, run

if __name__ == "__main__":
    config = Config(...)  # set your overrides
    run(config)
```
