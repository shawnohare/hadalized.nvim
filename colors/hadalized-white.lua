-- Auto-generated from hadalized v0.3.0
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
  name = "hadalized-white",
  desc = "Light theme variant with whiter backgrounds.",
  version = "2.0.2",
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
  bright = {
    red = "#fa5654",
    orange = "#fa8f00",
    yellow = "#dcbd00",
    lime = "#aecf00",
    green = "#81d943",
    mint = "#00e282",
    cyan = "#00e1c3",
    azure = "#36d0ff",
    blue = "#85c0ff",
    violet = "#c1aaff",
    magenta = "#ff88fa",
    rose = "#ff8eb8",
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
  base = {
    bg = "#fefefa",
    bg1 = "#fcfcf8",
    bg2 = "#efefeb",
    bg3 = "#e7e6e3",
    bg4 = "#fcfcf8",
    bg5 = "#cececa",
    bg6 = "#bebeba",
    hidden = "#a7b0b2",
    subfg = "#7a8284",
    fg = "#282f31",
    emph = "#111719",
    op2 = "#04191f",
    op1 = "#021015",
    op = "#00090e",
  },
  gs = {
    black = "#010405",
    darkgray = "#282f31",
    neutralgray = "#5d6567",
    lightgray = "#98a0a3",
    white = "#f7ffff",
  },
}


package.loaded['hadalized'] = nil
require('hadalized').load({palette = palette})
