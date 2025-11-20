local M = {}

---@class (exact) PaletteMetadata
---@field name  string The palette's namespace
---@field style string The palette's variant / style / colorspace.
---@field mode  string The background, e.g., "dark" or "light".

---@class (exact) Palette
---@field meta    PaletteMetadata Metadata
---@field red     string Hue 01.
---@field orange  string Hue 02.
---@field yellow  string Hue 03.
---@field green   string Hue 04.
---@field cyan    string Hue 05.
---@field blue    string Hue 06.
---@field violet  string Hue 07.
---@field magenta string Hue 08.
---@field dark0   string Graysale dark.
---@field dark1   string Graysale dark.
---@field dark2   string Graysale dark.
---@field gray0   string Graysale medium.
---@field gray1   string Graysale medium.
---@field gray2   string Graysale medium.
---@field light0  string Graysale light.
---@field light1  string Graysale light.
---@field light2  string Graysale light.
---@field bg0     string Background.
---@field bg1     string Background.
---@field bg2     string Background.
---@field fg0     string Foreground (main).
---@field fg1     string Foreground (main).
---@field fg2     string Foreground (main).
---@field op0     string Foreground (emphasis).
---@field op1     string Foreground (emphasis).
---@field op2     string Foreground (emphasis).


---Get a palette.
---@param config Config
---@return Palette
function M.get(config)
    return M.palettes[config:key()]
end


--- Obtain a palette key from its metadata.
---@param palette Palette A palette instance.
---@return string
function M.key(palette)
    local m = palette.meta
    return M.fmt_key(m.name, m.style, m.mode)
end


---@type table<string, Palette>
M.palettes = {
	["hadalized.oklch.dark"] = {
        meta = {
            name = "hadalized",
            style = "oklch",
            mode = "dark",
        },
		red = "oklch(0.65 0.15 25)",
		orange = "oklch(0.65 0.15 55)",
		yellow = "oklch(0.65 0.15 110)",
		green = "oklch(0.65 0.15 145)",
		cyan = "oklch(0.65 0.15 185)",
		blue = "oklch(0.65 0.15 235)",
		violet = "oklch(0.65 0.15 290)",
		magenta = "oklch(0.65 0.15 335)",
		dark0 = "oklch(0.13 0.02 220)",
		dark1 = "oklch(0.18 0.02 220)",
		dark2 = "oklch(0.23 0.02 220)",
		gray0 = "oklch(0.45 0.005 220)",
		gray1 = "oklch(0.6 0.005 220)",
		gray2 = "oklch(0.75 0.005 220)",
		light0 = "oklch(0.85 0.01 90)",
		light1 = "oklch(0.9 0.01 90)",
		light2 = "oklch(0.95 0.01 90)",
		bg0 = "oklch(0.13 0.02 220)",
		bg1 = "oklch(0.18 0.02 220)",
		bg2 = "oklch(0.23 0.02 220)",
		fg0 = "oklch(0.45 0.005 220)",
		fg1 = "oklch(0.6 0.005 220)",
		fg2 = "oklch(0.75 0.005 220)",
		op0 = "oklch(0.85 0.01 90)",
		op1 = "oklch(0.9 0.01 90)",
		op2 = "oklch(0.95 0.01 90)",
	},
	["hadalized.p3.dark"] = {
        meta = {
            name = "hadalized",
            style = "p3",
            mode = "dark",
        },
		red = "#cd6c63",
		orange = "#c67735",
		yellow = "#969623",
		green = "#63a45b",
		cyan = "#16a89b",
		blue = "#3999d7",
		violet = "#8c7ddd",
		magenta = "#b96daf",
		dark0 = "#02090c",
		dark1 = "#0a1317",
		dark2 = "#151f23",
		gray0 = "#535657",
		gray1 = "#7e8182",
		gray2 = "#abaeb0",
		light0 = "#d0cec7",
		light1 = "#e0ded7",
		light2 = "#f0eee8",
		bg0 = "#02090c",
		bg1 = "#0a1317",
		bg2 = "#151f23",
		fg0 = "#535657",
		fg1 = "#7e8182",
		fg2 = "#abaeb0",
		op0 = "#d0cec7",
		op1 = "#e0ded7",
		op2 = "#f0eee8",
	},
	["hadalized.srgb.dark"] = {
        meta = {
            name = "hadalized",
            style = "srgb",
            mode = "dark",
        },
		red = "#dc655f",
		orange = "#d3721e",
		yellow = "#969600",
		green = "#4aa651",
		cyan = "#00a99a",
		blue = "#009bdd",
		violet = "#8f7ce3",
		magenta = "#c568b3",
		dark0 = "#01090d",
		dark1 = "#071418",
		dark2 = "#121f23",
		gray0 = "#525657",
		gray1 = "#7d8182",
		gray2 = "#abafb0",
		light0 = "#d0cec7",
		light1 = "#e0ded7",
		light2 = "#f1eee7",
		bg0 = "#01090d",
		bg1 = "#071418",
		bg2 = "#121f23",
		fg0 = "#525657",
		fg1 = "#7d8182",
		fg2 = "#abafb0",
		op0 = "#d0cec7",
		op1 = "#e0ded7",
		op2 = "#f1eee7",
	},
	["hadalized.oklch.light"] = {
        meta = {
            name = "hadalized",
            style = "oklch",
            mode = "light",
        },
		red = "oklch(0.65 0.15 25)",
		orange = "oklch(0.65 0.15 55)",
		yellow = "oklch(0.65 0.15 110)",
		green = "oklch(0.65 0.15 145)",
		cyan = "oklch(0.65 0.15 185)",
		blue = "oklch(0.65 0.15 235)",
		violet = "oklch(0.65 0.15 290)",
		magenta = "oklch(0.65 0.15 335)",
		dark0 = "oklch(0.13 0.02 220)",
		dark1 = "oklch(0.18 0.02 220)",
		dark2 = "oklch(0.23 0.02 220)",
		gray0 = "oklch(0.45 0.005 220)",
		gray1 = "oklch(0.6 0.005 220)",
		gray2 = "oklch(0.75 0.005 220)",
		light0 = "oklch(0.85 0.01 90)",
		light1 = "oklch(0.9 0.01 90)",
		light2 = "oklch(0.95 0.01 90)",
		bg0 = "oklch(0.95 0.01 90)",
		bg1 = "oklch(0.9 0.01 90)",
		bg2 = "oklch(0.85 0.01 90)",
		fg0 = "oklch(0.75 0.005 220)",
		fg1 = "oklch(0.6 0.005 220)",
		fg2 = "oklch(0.45 0.005 220)",
		op0 = "oklch(0.23 0.02 220)",
		op1 = "oklch(0.18 0.02 220)",
		op2 = "oklch(0.13 0.02 220)",
	},
	["hadalized.p3.light"] = {
        meta = {
            name = "hadalized",
            style = "p3",
            mode = "light",
        },
		red = "#cd6c63",
		orange = "#c67735",
		yellow = "#969623",
		green = "#63a45b",
		cyan = "#16a89b",
		blue = "#3999d7",
		violet = "#8c7ddd",
		magenta = "#b96daf",
		dark0 = "#02090c",
		dark1 = "#0a1317",
		dark2 = "#151f23",
		gray0 = "#535657",
		gray1 = "#7e8182",
		gray2 = "#abaeb0",
		light0 = "#d0cec7",
		light1 = "#e0ded7",
		light2 = "#f0eee8",
		bg0 = "#f0eee8",
		bg1 = "#e0ded7",
		bg2 = "#d0cec7",
		fg0 = "#abaeb0",
		fg1 = "#7e8182",
		fg2 = "#535657",
		op0 = "#151f23",
		op1 = "#0a1317",
		op2 = "#02090c",
	},
	["hadalized.srgb.light"] = {
        meta = {
            name = "hadalized",
            style = "srgb",
            mode = "light",
        },
		red = "#dc655f",
		orange = "#d3721e",
		yellow = "#969600",
		green = "#4aa651",
		cyan = "#00a99a",
		blue = "#009bdd",
		violet = "#8f7ce3",
		magenta = "#c568b3",
		dark0 = "#01090d",
		dark1 = "#071418",
		dark2 = "#121f23",
		gray0 = "#525657",
		gray1 = "#7d8182",
		gray2 = "#abafb0",
		light0 = "#d0cec7",
		light1 = "#e0ded7",
		light2 = "#f1eee7",
		bg0 = "#f1eee7",
		bg1 = "#e0ded7",
		bg2 = "#d0cec7",
		fg0 = "#abafb0",
		fg1 = "#7d8182",
		fg2 = "#525657",
		op0 = "#121f23",
		op1 = "#071418",
		op2 = "#01090d",
	},
}

return M
