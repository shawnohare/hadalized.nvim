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
  name = "hadalized",
  desc = "Main dark theme with blueish solarized inspired backgrounds.",
  version = "2.0.2",
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
    bg = "#00090e",
    bg1 = "#000c12",
    bg2 = "#021015",
    bg3 = "#04191f",
    bg4 = "#10252c",
    bg5 = "#18323a",
    bg6 = "#253f47",
    hidden = "#4f5759",
    subfg = "#98a0a3",
    fg = "#bebeba",
    emph = "#cececa",
    op2 = "#c0beb0",
    op1 = "#d0cec0",
    op = "#e1dfd0",
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
