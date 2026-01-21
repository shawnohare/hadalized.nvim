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

The palettes defined in [colors/*](./colors) are generated using the
[hadalized](https://github.com/shawnohare/hadalized) theme builder python
application.

To generate all theme files, assuming `uv` and `just` are installed

```sh
git clone https://github.com/shawnohare/hadalized
just
```
This will invoke the `hadalized` application and copy the built neovim
files into `./colors`.


### Overriding configuration defaults

To generate your own hadalized variants

```py
from hadalized.writer import Config, run

if __name__ == "__main__":
    config = Config(...)  # set your overrides
    run(config)
```
