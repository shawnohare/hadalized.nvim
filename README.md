# hadalized.nvim colorscheme

A darker Solarized-inspired Lush Theme for neovim 0.8+ that uses the okhsl
color space. The name references the
[oceanic hadopelagic zones](https://en.wikipedia.org/wiki/Hadal_zone)
to emphasize our preference of a darker background and a homage to the original
choice of Solarized's blue.

# Palettes

The theme currently contains a single default palette. Each palette
consists of eight accent colors and nine base tints

The underlying OkHSL hue values for the default palette are a varying set of
hue values for a fixed lightness L=60 and saturation S=75.

| Name     | OkHSL            | sRGB hex   |
|----------|------------------|------------|
| red      | okhsl(025 75 60) | `#e0645e`  |
| orange   | okhsl(055 75 60) | `#cd7938`  |
| yellow   | okhsl(110 75 60) | `#969735`  |
| green    | okhsl(140 75 60) | `#61a452`  |
| cyan     | okhsl(185 75 60) | `#3aa499`  |
| blue     | okhsl(245 75 60) | `#4498d8`  |
| violet   | okhsl(290 75 60) | `#4498d8`  |
| magenta  | okhsl(340 75 60) | `#d859b5`  |
| dark0    | okhsl(220 25 07) | `#081012`  |
| dark1    | okhsl(220 25 12) | `#121d21`  |
| dark2    | okhsl(220 25 17) | `#1c2a2e`  |
| gray0    | okhsl(220 05 25) | `#363b3c`  |
| gray1    | okhsl(220 05 50) | `#71787b`  |
| gray2    | okhsl(220 05 75) | `#b4babc`  |
| light0   | okhsl(220 15 83) | `#c4d2d7`  |
| light1   | okhsl(220 15 88) | `#d5dfe3`  |
| light2   | okhsl(220 15 93) | `#e6ecee`  |



# Installation

With `packer`, add

```lua
use { "shawnohare/hadalized.nvim", requires = { "rktjmp/lush.nvim" } }
```

# Differenes from Solarized

Hadalized takes Solarized as an inspiration for the basic choices but
diverges in a number of ways.

- Utilize the `okhsl` colorspace with fixed lightness for colors palettes.
- Dark bases have decreased lightness values.
- Bases are generally less saturated.
- Use 10 color palette with dim, bright, neutral and highlight variants.
- Orange is made more distinct from red.
- Yellow is less brown.
- Green is less yellow.

# Building

To build the explicit `hadalized_[dark|light]` pure vimscript theme variants
open the `shipwright_build.lua` file and execute `:Shipwright`.

