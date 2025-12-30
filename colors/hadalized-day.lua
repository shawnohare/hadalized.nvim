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
  name = "hadalized-day",
  desc = "Light theme variant with sunny backgrounds.",
  mode = "light",
  gamut = "srgb",
  hue = {
    red = "#c73335",
    orange = "#d0750a",
    yellow = "#a0902a",
    lime = "#8d982b",
    green = "#578a00",
    mint = "#3fa66b",
    cyan = "#008474",
    azure = "#2d9dc1",
    blue = "#297cc7",
    violet = "#7456d4",
    magenta = "#aa3ea4",
    rose = "#b96d85",
  },
  base = {
    black = "#010405",
    darkgray = "#282f31",
    gray = "#5d6567",
    lightgray = "#98a0a3",
    white = "#f7ffff",
    bg = "#fffef6",
    bgvar = "#fdfcf5",
    bg1 = "#f1efe0",
    bg2 = "#e9e7d8",
    bg3 = "#fdfcf5",
    bg4 = "#d0cec0",
    bg5 = "#c0beb0",
    hidden = "#a7b0b2",
    comment = "#7a8284",
    fg = "#282f31",
    emph = "#111719",
    op2 = "#04191f",
    op1 = "#021015",
    op = "#000a0f",
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
