local M = {}

M.__user = nil


---User configuration class.
---@class (exact) Config
---@field name string The name(space) defining a collection of palettes.
---@field style string The style variant, e.g., a colorspace like "p3".
---@field mode string variant, e.g., a colorspace like "p3".
---@field key function


---comment
---@return Config
function M.default()
    return {
        name = "hadalized",
        style = "p3",
        mode = "dark"
    }
end

---@param config Config
function _key(config)
    return string.format("%s.%s.%s", config.name, config.style, config.mode)
end

---Fetch the user configuration with the defaults merged in.
---@params opts Config
---@return Config
function M.setup(opts)
    -- Merge user colorscheme configed with the default.

    local config = M.default()

    for key, val in pairs(opts or {}) do
        config[key] = val
    end

    M.__user = config


    return config
end


---Fetch the user configuration with the defaults merged in.
---@param opts Config | nil
---@return Config
function M.extend(opts)
    -- Merge defaults < user (+ set bg=...) < opts
    local config = {}

    for key, val in pairs(M.__user) do
        if (val ~= nil) then config[key] = val end
    end

    if (vim.o.bg ~= nil) then
        config.mode = vim.o.bg
    end

    for key, val in pairs(opts or {}) do
        if (val ~= nil) then config[key] = val end
    end


    ---@return string
    function config.key(self)
        return _key(self)
    end

    return config
end


return M
