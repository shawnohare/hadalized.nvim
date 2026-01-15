# hadalized palette and color themes

A darker Solarized-inspired theme primarily for neovim 0.11+ (and others) that
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
            italic = false, -- will disable italic text.
        },
        priority = 1000,
        dependencies = { },
    },
}
```

## python generator package

The underlying color palettes are defined as oklch values in the included
python [hadalized.config](./src/hadalized/config.py) module. The `hadalied`
python package generates themes for different applications, which can be
copied to their respective application config folders (or dotfiles repo)
manually. As the python application is generated


To generate all theme files, assuming `uv` and `just` are installed

```sh
just
```

### Overriding configuration defaults

To generate your own hadalized variants during generation

```py
from hadalized.writer import ThemeWritter
from hadalized.config import Config

if __name__ == "__main__":
    config = Config(...)  # set your overrides
    with ThemeWriter(config) as writer:
        writer.run()
```
