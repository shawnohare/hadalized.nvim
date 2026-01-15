local M = {}

---@type Config
local default_config = {
        bold = true,
        italic = true,
        standout = true,
        strikethrough = true,
        undercurl = true,
        underdashed = true,
        underdotted = true,
        underdouble = true,
        underline = true,
}

---Fetch the user configuration with the defaults merged in.
---@param opts Config?
---@return Config
local function extend_config(opts)
    return vim.tbl_extend(
        "force", {}, default_config, vim.g.hadalized_config or {}, opts or {}
    )
end

---Fetch the user configuration with the defaults merged in.
---@param opts Config?
---@return Config
function M.setup(opts)
    local conf = extend_config({})
    vim.g.hadalized_config = conf
    return conf
end

---Get a theme defining highlight groups from a user's configuration
---and set the actual highlights.
---@param opts LoadOpts
function M.load(opts)
    opts.config = extend_config(opts.config)
    vim.cmd([[ highlight clear ]])
    vim.o.bg = opts.palette.mode
    local theme = require("hadalized.theme")
    for group, hl in pairs(theme.make(opts.palette, opts.config)) do
        vim.api.nvim_set_hl(0, group, hl)
    end

end

return M
