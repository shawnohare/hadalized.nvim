-- -------------------------------------------------------------------------
-- This module exposes a background-based theme variant and the
-- underlying theme generation function.
--
-- Usage:
-- local hadalized = require('hadalized')
-- local hadalized_light = hadalized.generate('light')
--
-- Enable lush.ify on this file, run:
--
--  `:Lushify`
--
--  or
--
--  `:lua require('lush').ify()`
--  NOTE: Lushify will not automatically reload colors unless they are edited
--  in the same file from which the theme is returned. This seems to couple
--  theme generation logic with the theme itself.
--
-- ---------------------------------------------------------------------------
-- TODO: [x] Export non-Lush version?.
-- TODO: [ ] Allow proper configs and loading via "setup" func.

-- vim.cmd([[ highlight clear ]])
-- vim.g.colors_name = 'hadalized'

-- When :Lushify is invoked it parses the current file and looks for
-- instances of hsl or hsluv to render the underlying colors. This is handy
-- for non-hex values but for us is somewhat annoying, since convert
-- from okhsl to hsluv first.

local M = {}

local themes = require("hadalized.theme")
local configs = require("hadalized.config")


---Setup user configuration defaults.
---@param opts Config | nil
function M.setup(opts)
    configs.setup(opts)
end

---Get a theme defining highlight groups from a user's configuration
---and set the actual highlights.
---@param opts Config | nil
function M.load(opts)
    vim.cmd([[ highlight clear ]])
    vim.g.colors_name = 'hadalized'

    local config = configs.extend(opts)

    vim.o.bg = config.mode

    -- Set highlights.
    for group, colors in pairs(themes.get(config)) do
        -- Ensure fg and bg from Normal are used as defaults.
        -- if (colors.fg == nil) then
        --     colors.fg = "fg"
        -- end
        -- if (colors.bg == nil) then
        --     colors.bg = "bg"
        -- end
        vim.api.nvim_set_hl(0, group, colors)
    end

end

return M
