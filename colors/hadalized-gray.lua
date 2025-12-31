-- Generated neovom colorscheme.
-- WARNING: Do not edit by hand.

-- By setting our module to nil, we clear lua's cache,
-- which means the require ahead will *always* occur.
--
-- This isn't strictly required but it can be a useful trick if you are
-- incrementally editing your config a lot and want to be sure your themes
-- changes are being picked up without restarting neovim.
--
-- Note if you're working in on your theme and have :Lushify'd the buffer,
-- your changes will be applied with or without the following line.
--
-- The performance impact of this call can be measured in the hundreds of
-- *nanoseconds* and such could be considered "production safe".
--

---@type Palette
local palette = {
  name = "hadalized-gray",
  desc = "Dark theme variant with more grayish backgrounds.",
  mode = "dark",
  gamut = "srgb",
  hue = {
    red = "#d94543",
    orange = "#d0750a",
    yellow = "#b0a03c",
    lime = "#959f40",
    green = "#6da21c",
    mint = "#56bb7f",
    cyan = "#38a391",
    azure = "#4bb4da",
    blue = "#318bde",
    violet = "#896ded",
    magenta = "#c256bc",
    rose = "#d2849c",
  },
  base = {
    black = "#010405",
    darkgray = "#282f31",
    gray = "#5d6567",
    lightgray = "#98a0a3",
    white = "#f7ffff",
    bg = "#060808",
    bgvar = "#070a0a",
    bg1 = "#0b0e0f",
    bg2 = "#141718",
    bg3 = "#1f2223",
    bg4 = "#2b2e30",
    bg5 = "#383b3c",
    hidden = "#4f5759",
    comment = "#4f5759",
    fg = "#bebeba",
    emph = "#cececa",
    op2 = "#bebeba",
    op1 = "#cececa",
    op = "#dfdeda",
  },
  hl = {
    red = "#f8a49d",
    orange = "#ffbe8a",
    yellow = "#ffef96",
    lime = "#cdd88b",
    green = "#b8db96",
    mint = "#a0eab9",
    cyan = "#8ff4e0",
    azure = "#8ee4ff",
    blue = "#93cbff",
    violet = "#c8b4ff",
    magenta = "#ff90ff",
    rose = "#ff9cbf",
  },
  bright = {
    red = "#f8a49d",
    orange = "#ffbe8a",
    yellow = "#ffef96",
    lime = "#cdd88b",
    green = "#b8db96",
    mint = "#a0eab9",
    cyan = "#8ff4e0",
    azure = "#8ee4ff",
    blue = "#93cbff",
    violet = "#c8b4ff",
    magenta = "#ff90ff",
    rose = "#ff9cbf",
  },
}

package.loaded['hadalized'] = nil
require('hadalized').load({palette = palette})
