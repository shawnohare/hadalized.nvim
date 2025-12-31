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
python `hadalized.config` module. The `hadalied` python package generates
themes for

- neovim (output to [colors/](colors/))
- wezterm terminal emulator (output to [wezterm/](wezterm/))

To generate (all) hadalized files utilize
```
just gen
```
This utilizes `uv run`.

### Overriding configuration defaults

To generate your own hadalized variants during generation

```py
from hadalized.writer import FileWritter
from hadalized.config import Config

if __name__ == "__main__":
    config = Config(...)  # set your overrides
    writer FileWritter(config)
    writer.write_all()
```

