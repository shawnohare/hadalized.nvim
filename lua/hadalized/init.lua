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


local palettes = require('hadalized.palettes')
local _cache = {}


---Fetch the user configuration with the defaults merged in.
---@return table
local function get_config()
    -- Merge user colorscheme configed with the default.
    local config = {
        palette = 'hadalized',
        colorspace = 'p3',
    }
    for key, val in pairs(vim.g.hadalized or {}) do
        config[key] = val
    end
    -- Inspect config values and get the underlying palette colors.
    -- Define dynamic base variables. The light version simply reverses the
    -- array of bases.
    local mode = vim.o.bg
    if (mode == nil) then
        mode = "dark"
        vim.o.bg = mode
    end
    local pkey = string.format("%s.%s.%s", config.palette, mode, config.colorspace)
    config.__pkey = pkey
    config.mode = mode
    return config
end


---Produce a theme table from which highlights are set.
---@param colors table
---@return table
local function make_theme(colors)
    local p = colors
    return {
        Boolean = { fg=p.orange, italic=true}, --  a boolean constant: TRUE, false
        Character = { fg=p.cyan }, --  a character constant: 'c'
        ColorColumn = { bg=p.bg1 }, -- used for the columns set with 'colorcolumn'
        Comment = { fg=p.fg1 }, -- any comment
        Conceal = { fg=p.fg0}, -- placeholder characters substituted for concealed text (see 'conceallevel')
        Conditional = { fg=p.orange}, --  if, then, else, endif, switch, etp.
        Constant = { fg=p.magenta }, -- (preferred) any constant
        Cursor = { bg=p.op1, fg=p.bg0 }, -- character under the cursor
        CursorColumn = { }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
        CursorIM = { }, -- like Cursor, but used when in IME mode |CursorIM|
        CursorLine = { bg=p.bg1 }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
        CursorLineNr = { bg=p.bg1, fg=p.yellow }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
        Debug = { fg=p.red}, --    debugging statements
        Define = { fg=p.violet, italic=true }, --   preprocessor #define
        Delimiter = { fg=p.red }, --  character that needs attention
        DiffAdd = { fg=p.green }, -- diff mode: Added line |diff.txt|
        DiffChange = { fg=p.yellow }, -- diff mode: Changed line |diff.txt|
        DiffDelete = { fg=p.red }, -- diff mode: Deleted line |diff.txt|
        DiffText = { fg=p.blue, underline=true }, -- diff mode: Changed text within a changed line |diff.txt|
        Directory = { fg=p.blue, bold=true }, -- directory names (and other special names in listings)
        EndOfBuffer = { fg=p.fg1 }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
        Error = { fg=p.red }, -- (preferred) any erroneous construct
        ErrorMsg = { fg=p.red, bold=true }, -- error messages on the command line
        Exception = { fg=p.magenta }, --  try, catch, throw
        Float = { fg=p.violet }, --    a floating point constant: 2.3e10
        FoldColumn = { }, -- 'foldcolumn'
        Folded = { bg=p.bg2 }, -- line used for closed folds
        Function = { fg=p.blue}, -- function name (also: methods for classes)
        Identifier = { fg=p.yellow}, -- (preferred) any variable name
        Ignore = { fg=p.fg1 }, -- (preferred) left blank, hidden  |hl-Ignore|
        IncSearch = { bg=p.blue, fg=p.bg0}, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
        Include = { fg=p.red, bold=true }, --  preprocessor #include
        Italic = { fg=nil, bg=nil, italic=true},
        Keyword = { fg=p.violet }, --  any other keyword
        Label = { fg=p.green }, --    case, default, etp.
        LineNr = { bg=p.bg1, fg=p.fg1}, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
        Macro = { fg=p.violet, italic=true }, --   preprocessor #define
        MatchParen = { fg=p.red, bold=true }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
        ModeMsg = { fg=p.orange, bold=true }, -- 'showmode' message (e.g., "-- INSERT -- ")
        MoreMsg = { fg=p.green }, -- |more-prompt|
        MsgArea = { bg=p.bg1 }, -- Area for messages and cmdline
        MsgSeparator = { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
        NonText = { fg=p.fg0 }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
        Normal = { fg=p.fg2, bg=p.bg0 }, -- normal text
        NormalFloat = { fg=p.fg2, bg=p.bg1}, -- Normal text in floating windows.
        NormalNC = { fg=p.fg2, bg=p.bg0 }, -- normal text in non-current windows
        Number = { fg=p.violet }, --   a number constant: 234, 0xff
        Operator = { fg=p.blue }, -- "sizeof", "+", "*", etp.
        Pmenu = { bg=p.bg1 }, -- Popup menu: normal item.
        PmenuSbar = { }, -- Popup menu: scrollbar.
        PmenuSel = { bg=p.bg2 }, -- Popup menu: selected item.
        PmenuThumb = { }, -- Popup menu: Thumb of the scrollbar.
        PreCondit = { fg=p.magenta }, --  preprocessor #if, #else, #endif, etp.
        PreProc = { fg=p.orange }, -- (preferred) generic Preprocessor
        Question = { fg=p.green }, -- |hit-enter| prompt and yes/no questions
        QuickFixLine = { }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
        Repeat = { fg=p.orange }, --   for, do, while, etp.
        Search = { bg=p.yellow, fg=p.bg0}, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
        SignColumn = { bg=p.bg0}, -- column where |signs| are displayed
        Special = { fg=p.red }, -- (preferred) any special symbol
        SpecialChar = { fg=p.red, bold=true }, --  special character in a constant
        SpecialComment = { fg=p.orange }, -- special things inside a comment
        SpecialKey = { fg=p.red, bold=true }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
        SpellBad = { fg=p.red, undercurl=true }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
        SpellCap = { fg=p.orange, underline=true}, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
        SpellLocal = { fg=p.orange, underdotted=true }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
        SpellRare = { fg=p.yellow,  underdashed=true }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
        Standout = { standout=true },
        Statement = { fg=p.yellow }, -- (preferred) any statement
        StatusLine = { bg=p.bg1, fg=p.fg2, }, -- status line of current window
        StatusLineNC = { bg=p.bg0, fg=p.fg1}, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
        StorageClass = { fg=p.green }, -- static, register, volatile, etp.
        Strikethrough = { strikethrough=true },
        String = { fg=p.cyan }, --   a string constant: "this is a string"
        Structure = { fg=p.green}, --  struct, union, enum, etp.
        Substitute = { fg=p.bg0, bg=p.yellow, italic=true}, -- |:substitute| replacement text highlighting
        Swap = { reverse=true },
        TabLine = { }, -- tab pages line, not active tab page label
        TabLineFill = { }, -- tab pages line, where there are no labels
        TabLineSel = { }, -- tab pages line, active tab page label
        Tag = { fg=p.blue, underline=true}, --    you can use CTRL-] on this
        TermCursor = { fg=p.fg2 }, -- cursor in a focused terminal
        TermCursorNC = { }, -- cursor in an unfocused terminal
        Title = { fg=p.fg2 }, -- titles for output from ":set all", ":autocmd" etp.
        Todo = { fg=p.yellow, bold=true }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX
        Type = { fg=p.yellow }, -- (preferred) int, long, char, etp.
        Typedef = { fg=p.violet }, --  A typedef
        VertSplit = { fg=p.op0 }, -- the column separating vertically split windows
        Visual = { bg=p.bg2 }, -- Visual mode selection
        VisualNOS = { bg=p.bg2 }, -- Visual mode selection when vim is "Not Owning the Selection".
        WarningMsg = { fg=p.red }, -- warning messages
        Whitespace = { fg=p.fg1}, -- "nbsp", "space", "tab" and "trail" in 'listchars'
        WildMenu = { }, -- current match in 'wildmenu' completion
        lCursor = { }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
        -- -------------------------------------------------------------------
        -- Treesitter Groups
        -- -------------------------------------------------------------------
        ['@annotation'] = { fg=p.green },
        ['@attribute'] = { fg=p.orange },
        ['@boolean'] = { link='Boolean' },    -- For booleans.
        ['@character'] = { link='Character' },    -- For characters.
        ['@comment'] = { link='Comment' },    -- For comment blocks.
        ['@conditional'] = { link='Conditional' },    -- For keywords related to conditionnals.
        ['@constant'] = { link='Constant' },    -- For constants
        ['@constant.builtin'] = { fg=p.magenta, link='Italic' },    -- For constant that are built in the language: `nil` in Lua.
        ['@constant.macro'] = { fg=p.magenta, bold=true },    -- For constants that are defined by macros: `NULL` in p.
        ['@constructor'] = { fg=p.blue, bold=true },    -- For constructor calls and definitions: ` { }` in Lua, and Java constructors.
        ['@danger'] = { fg=p.red },
        ['@emphasis'] = { fg=p.fg2, italic=true},    -- For text to be represented with emphasis.
        ['@environment'] = { fg=p.violet }, -- text environments in markup languages, e.g.,egin in LaTeX.
        ['@environment.name'] = { fg=p.yellow }, -- e.g., theorem inegin                               {theorem} block in LaTeX.
        ['@error'] = { fg=p.red },
        ['@exception'] = { link='Exception' },
        ['@field'] = { fg=p.yellow },    -- For fields.
        ['@float'] = { link='Float' },    -- For floats.
        ['@function'] = { link='Function' },    -- For function (calls and definitions).
        ['@function.builtin'] = { fg=p.blue, italic=true},    -- For builtin functions: `table.insert` in Lua.
        ['@function.macro'] = { fg=p.blue, bold=true },    -- For macro defined fuctions (calls and definitions): each `macro_rules` in Rust.
        ['@include'] = { link='Include' },    -- For includes: `#include` in C, `use` or `extern crate` in Rust, or `require` in Lua.
        ['@keyword'] = { fg=p.violet },    -- For keywords that don't fall in previous categories.
        ['@keyword.function'] = { fg=p.violet, italic=true },    -- For keywords used to define a fuction.
        ['@keyword.operator'] = { fg=p.orange, italic=true }, -- unary and binary operators that are english words
        ['@keyword.return'] = { fg=p.red, italic=true },
        ['@label'] = { fg=p.orange },    -- For labels: `label:` in C and `:label:` in Lua.
        ['@literal'] = { fg=p.cyan },    -- Literal text.
        ['@math'] = { fg=p.yellow}, -- mathenv
        ['@method'] = { fg=p.blue },    -- For method calls and definitions.
        ['@namespace'] = { fg=p.yellow, bold=true },    -- For identifiers referring to modules and namespaces.
        ['@note'] = { fg=p.yellow },
        ['@number'] = { link='Number' },    -- For all numbers
        ['@operator'] = { fg=p.orange},    -- For any operator: `+`, but also `->` and `*` in p.
        ['@parameter'] = { fg=p.green },    -- For parameters of a function.
        ['@parameter.reference'] = { fg=p.green },    -- For references to parameters of a function.
        ['@punctuation.bracket'] = { fg=p.red },    -- For brackets and parens.
        ['@punctuation.delimiter'] = { fg=p.magenta},    -- For delimiters ie: `.`
        ['@punctuation.special'] = { fg=p.magenta },    -- For special punctutation that does not fall in the catagories before.
        ['@repeat'] = { link='Repeat' },    -- For keywords related to loops.
        ['@strikethrough'] = { strikethrough=true },    -- For strikethrough text.
        ['@string'] = { link='String' },    -- For strings.
        ['@string.escape'] = { fg=p.red },    -- For escape characters within a string.
        ['@string.regex'] = { fg=p.orange },    -- For regexes.
        ['@string.special'] = { fg=p.yellow},
        ['@symbol'] = { fg=p.violet },    -- For identifiers referring to symbols or atoms.
        ['@tag'] = { fg=p.violet },    -- Tags like html tag names.
        ['@tag.attribute'] = { fg=p.magenta },    -- html tag attribute
        ['@tag.delimter'] = { link='Delimiter' },    -- Tag delimiter like `<` `>` `/`
        ['@text'] = { fg=p.fg2 },    -- For strings considered text in a markup language.
        ['@text.reference'] = { fg=p.fg1 }, -- footnote, citations, etp.
        ['@title'] = { fg=p.fg2 },    -- Text that is part of a title.
        ['@type'] = { link='Type' },    -- For types.
        ['@type.builtin'] = { fg=p.yellow, italic=true},    -- For builtin types.
        ['@underline'] = { underline=true },
        ['@uri'] = { fg=p.blue, underline=true },
        ['@variable'] = { fg=p.fg2 },    -- Any variable name that does not have another highlight.
        ['@variable.builtin'] = { fg=p.orange, italic=true},    -- Variable names that are defined by the languages, like `this` or `self`.
        ['@warning'] = { fg=p.orange },
        -- gui
        -- Menu = { },
        -- Scrollbar = { },
        -- Tooltip = { },
        ---- -------------------------------------------------------------------
        ---- LSP groups
        ---- These groups are for the native LSP client. Some other LSP clients may
        ---- use these groups, or use their own. Consult your LSP client's
        ---- documentation.
        ---- -------------------------------------------------------------------
        ---- LspReferenceText = { }, -- used for highlighting "text" references
        ---- LspReferenceRead = { }, -- used for highlighting "read" references
        ---- LspReferenceWrite = { }, -- used for highlighting "write" references
        ---- LspCodeLens = { }, -- Used to color the virtual text of the codelens
        ---- LspCodeLensSeparator = { }, -- Used to color the virtual text of the codelens
        ---- LspSignatureActiveParameter = { },
        ---- -------------------------------------------------------------------
        ---- Diagnostic groups
        ---- -------------------------------------------------------------------
        DiagnosticError = { link='@danger' },
        DiagnosticWarn = { link='@warning' },
        DiagnosticInfo = { link='@note'    },
        DiagnosticHint = { fg=p.green },
        -- DiagnosticVirtualTextError = { }, -- Used for "Error" diagnostic virtual text
        -- DiagnosticVirtualTextWarn = { }, -- Used for "Warning" diagnostic virtual text
        -- DiagnosticVirtualTextInfo = { }, -- Used for "Information" diagnostic virtual text
        -- DiagnosticVirtualTextHint = { }, -- Used for "Hint" diagnostic virtual text
        DiagnosticUnderlineError = { fg=p.red, underdouble=true }, -- Used for "Error" diagnostic virtual text
        DiagnosticUnderlineWarn = { fg=p.orange, underline=true }, -- Used for "Warning" diagnostic virtual text
        DiagnosticUnderlineInfo = { fg=p.yellow, underline=true }, -- Used for "Information" diagnostic virtual text
        DiagnosticUnderlineHint = { fg=p.green, underline=true }, -- Used for "Hint" diagnostic virtual text
        -- DiagnosticFloatingError = { }, -- Used for "Error" diagnostic virtual text
        -- DiagnosticFloatingWarn = { }, -- Used for "Warning" diagnostic virtual text
        -- DiagnosticFloatingInfo = { }, -- Used for "Information" diagnostic virtual text
        -- DiagnosticFloatingHint = { }, -- Used for "Hint" diagnostic virtual text
        -- DiagnosticSignError = { },
        -- DiagnosticSignWarn = { },
        -- DiagnosticSignInfo = { },
        -- DiagnosticSignHint = { },
    }
end


---Obtain a table defining highlight groups.
---@return table
local function get_theme()
    local config = get_config()
    local theme = _cache[config.__pkey]
    if (theme == nil) then
        local colors = palettes[config.__pkey]
        theme = make_theme(colors)
    end
    return theme
end


---Get a theme defining highlight groups from a user's configuration
---and set the actual highlights.
---@return table
local function set_highlights()
    vim.cmd([[ highlight clear ]])
    vim.g.colors_name = 'hadalized'
    local theme = get_theme()
    for group, colors in pairs(theme) do
        -- Ensure fg and bg from Normal are used as defaults.
        -- if (colors.fg == nil) then
        --     colors.fg = "fg"
        -- end
        -- if (colors.bg == nil) then
        --     colors.bg = "bg"
        -- end
        vim.api.nvim_set_hl(0, group, colors)
    end

    return theme
end


return set_highlights()
