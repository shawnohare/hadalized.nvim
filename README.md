# hadalized.nvim colorscheme

A darker Solarized-inspired Lush Theme for neovim 0.8+ that uses the okhsl
color space. The name references the
[oceanic hadopelagic zones](https://en.wikipedia.org/wiki/Hadal_zone)
to emphasize our preference of a darker background and a homage to the original
choice of Solarized's blue.

# Installation

With `packer`, add

```lua
use { "shawnohare/hadalized.nvim", requires = { "rktjmp/lush.nvim" } }
```

# Differenes from Solarized

Hadalized takes Solarized as an inspiration for the basic choices but
diverges in a number of ways.

- Utilize the `okhsl` colorspace with fixed lightness for colors palettes.
- All base colors are the same fixed hue, rather than shifting  from a
  cooloer to warmer tones.
- Bases are generally less saturated.
- Use 10 color palette with dim, bright, neutral and highlight variants.
- Orange is made more distinct from red.
- Yellow is less brown.
- Green is less yellow.
