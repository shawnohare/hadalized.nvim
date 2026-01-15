local M = {}

---Produce a theme table from which highlights are set.
---@param palette Palette
---@param conf Config
---@return table<string, vim.api.keyset.highlight>
function M.make(palette, conf)
    local web = palette.web
    local b = palette.base
    -- local bright = palette.bright
    local h = palette.hue
    local hl = palette.hl
    ---@type table<string, vim.api.keyset.highlight>
    return {
        Boolean = {
            fg=h.orange,
            italic=conf.italic,
            --  a boolean constant: TRUE, false
        },
        Character = { fg=h.cyan }, --  a character constant: 'c'
        ColorColumn = { bg=b.bg2 }, -- used for the columns set with 'colorcolumn'
        Comment = { fg=b.subfg }, -- any comment
        Conceal = { fg=b.hidden }, -- placeholder characters substituted for concealed text (see 'conceallevel')
        Conditional = { fg=h.orange}, --  if, then, else, endif, switch, etp.
        Constant = { fg=h.magenta }, -- (preferred) any constant
        CurSearch = { bg=hl.red, fg=web.offblack},
        -- NOTE: Cursor seems to be overriden by what wezterm sets.
        Cursor = { bg=b.bg6, fg=b.emph }, -- character under the cursor
        lCursor = { bg=b.bg6, fg=h.red}, -- character under the cursor
        CursorColumn = { }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
        CursorIM = { }, -- like Cursor, but used when in IME mode |CursorIM|
        CursorLine = {
            -- bg=p.bgvar,
            -- Screen-line at the cursor, when 'cursorline' is set.
            -- Low-priority if foreground (ctermfg OR guifg) is not set.
        },
        CursorLineNr = {
            bg=b.bg5,
            fg=b.op,
            -- bold=conf.bold,
            -- reverse = true,
            -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
        },
        Debug = { fg=h.red}, --    debugging statements
        Define = { fg=h.violet, italic=conf.italic }, --   preprocessor #define
        Delimiter = { fg=h.red }, --  character that needs attention
        DiffAdd = { fg=h.green }, -- diff mode: Added line |diff.txt|
        DiffChange = { fg=h.yellow }, -- diff mode: Changed line |diff.txt|
        DiffDelete = { fg=h.red }, -- diff mode: Deleted line |diff.txt|
        DiffText = { fg=h.blue, underline=conf.underline}, -- diff mode: Changed text within a changed line |diff.txt|
        Directory = { fg=h.blue, bold=conf.bold}, -- directory names (and other special names in listings)
        EndOfBuffer = { fg=b.subfg }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
        Error = { fg=h.red }, -- (preferred) any erroneous construct
        ErrorMsg = { fg=h.red, bold=conf.bold}, -- error messages on the command line
        Exception = { fg=h.magenta }, --  try, catch, throw
        Float = { fg=h.violet }, --    a floating point constant: 2.3e10
        FoldColumn = { }, -- 'foldcolumn'
        Folded = { bg=b.bg3 }, -- line used for closed folds
        Function = { fg=h.blue}, -- function name (also: methods for classes)
        Identifier = { fg=h.yellow}, -- (preferred) any variable name
        Ignore = { fg=b.hidden }, -- (preferred) left blank, hidden  |hl-Ignore|
        IncSearch = { bg=hl.blue, fg=web.offblack}, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
        Include = { fg=h.red, bold=conf.bold}, --  preprocessor #include
        Italic = { fg=nil, bg=nil, italic=conf.italic },
        Keyword = { fg=h.violet }, --  any other keyword
        Label = { fg=h.green }, --    case, default, etp.
        LineNr = { bg=b.bg2, fg=b.subfg}, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
        Macro = { fg=h.violet, italic=conf.italic }, --   preprocessor #define
        MatchParen = { fg=h.red, bold=conf.bold }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
        ModeMsg = { fg=h.orange, bold=conf.bold }, -- 'showmode' message (e.g., "-- INSERT -- ")
        MoreMsg = { fg=h.green }, -- |more-prompt|
        MsgArea = { bg=b.bg2 }, -- Area for messages and cmdline
        MsgSeparator = { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
        NonText = { fg=b.hidden }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
        Normal = { fg=b.fg, bg=b.bg }, -- normal text
        NormalFloat = { fg=b.fg, bg=b.bg2}, -- Normal text in floating windows.
        NormalNC = {
            fg=b.fg,
            bg=b.bg1,
             -- normal text in non-current windows
        },
        Number = { fg=h.violet }, --   a number constant: 234, 0xff
        Operator = { fg=h.azure }, -- "sizeof", "+", "*", etp.
        Pmenu = { bg=b.bg2 }, -- Popup menu: normal item.
        PmenuSbar = { }, -- Popup menu: scrollbar.
        PmenuSel = { bg=b.bg3 }, -- Popup menu: selected item.
        PmenuThumb = { }, -- Popup menu: Thumb of the scrollbar.
        PreCondit = { fg=h.magenta }, --  preprocessor #if, #else, #endif, etp.
        PreProc = { fg=h.orange }, -- (preferred) generic Preprocessor
        Question = { fg=h.green }, -- |hit-enter| prompt and yes/no questions
        QuickFixLine = { }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
        Repeat = { fg=h.orange }, --   for, do, while, etp.
        Search = { bg=hl.yellow, fg=web.offblack }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
        SignColumn = { bg=b.bg}, -- column where |signs| are displayed
        Special = { fg=h.red }, -- (preferred) any special symbol
        SpecialChar = { fg=h.red, bold=conf.bold }, --  special character in a constant
        SpecialComment = { fg=h.orange }, -- special things inside a comment
        SpecialKey = { fg=h.red, bold=conf.bold }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
        SpellBad = { fg=h.red, undercurl=conf.undercurl }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
        SpellCap = { fg=h.orange, underline=true}, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
        SpellLocal = { fg=h.orange, underdotted=true }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
        SpellRare = { fg=h.yellow,  underdashed=true }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
        Standout = { standout=true },
        Statement = { fg=h.yellow }, -- (preferred) any statement
        StatusLine = {
            bg=b.bg2,
            fg=b.fg,
            -- status line of current window
        },
        StatusLineNC = {
            bg=b.bg3,
            -- bg=h.red,
            fg=b.hidden,
            -- status lines of not-current windows
            -- NOTE: if this is equal to -- "StatusLine" then Vim will use
            -- "^^^" in the current window status line.
        },
        StorageClass = { fg=h.green }, -- static, register, volatile, etp.
        Strikethrough = { strikethrough=true },
        String = { fg=h.cyan }, --   a string constant: "this is a string"
        Structure = { fg=h.green}, --  struct, union, enum, etp.
        Substitute = { fg=web.offblack, bg=hl.yellow, italic=conf.italic}, -- |:substitute| replacement text highlighting
        Swap = { reverse=true },
        TabLine = { }, -- tab pages line, not active tab page label
        TabLineFill = { }, -- tab pages line, where there are no labels
        TabLineSel = { }, -- tab pages line, active tab page label
        Tag = { fg=h.blue, underline=true}, --    you can use CTRL-] on this
        TermCursor = { fg=b.op1 }, -- cursor in a focused terminal
        TermCursorNC = { }, -- cursor in an unfocused terminal
        Title = { fg=b.fg }, -- titles for output from ":set all", ":autocmd" etp.
        Todo = { fg=h.yellow, bold=conf.bold }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX
        Type = { fg=h.yellow }, -- (preferred) int, long, char, etp.
        Typedef = { fg=h.violet }, --  A typedef
        VertSplit = { fg=b.bg6 }, -- the column separating vertically split windows
        Visual = { bg=b.bg3 }, -- Visual mode selection
        VisualNOS = { bg=b.bg3 }, -- Visual mode selection when vim is "Not Owning the Selection".
        WarningMsg = { fg=h.red }, -- warning messages
        Whitespace = { fg=b.subfg}, -- "nbsp", "space", "tab" and "trail" in 'listchars'
        WildMenu = { }, -- current match in 'wildmenu' completion
        -- -------------------------------------------------------------------
        -- Treesitter Groups
        -- -------------------------------------------------------------------
        ['@annotation'] = { fg=h.green },
        ['@attribute'] = { fg=h.orange },  -- attribute annotations (decorators)
        ['@attribute.builtin'] = { fg=h.orange, bold=conf.bold },  -- builtin annotations (@property)
        ['@boolean'] = { link='Boolean' },    -- For booleans.
        ['@character'] = { link='Character' },    -- For characters.
        ['@character.special'] = { fg=h.red },    -- For characters.
        ['@comment'] = { link='Comment' },    -- For comment blocks.
        ['@comment.documentation'] = { link='Comment' },    -- For comment blocks.
        ['@comment.error'] = { fg=h.red, bold=conf.bold, underdouble = true },    -- For comment blocks.
        ['@comment.note'] = { fg=h.green, bold=conf.bold },    -- For comment blocks.
        ['@comment.todo'] = { fg=h.yellow, bold=conf.bold },    -- For comment blocks.
        ['@comment.warning'] = { fg=h.orange, bold=conf.bold },    -- For comment blocks.
        ['@conditional'] = { link='Conditional' },    -- For keywords related to conditionnals.
        ['@constant'] = { link='Constant' },    -- For constants
        ['@constant.builtin'] = { fg=h.magenta, link='Italic' },    -- For constant that are built in the language: `nil` in Lua.
        ['@constant.macro'] = { fg=h.magenta, bold=conf.bold },    -- For constants that are defined by macros: `NULL` in p.
        ['@constructor'] = { fg=h.blue, bold=conf.bold },    -- For constructor calls and definitions: ` { }` in Lua, and Java constructors.
        ['@danger'] = { fg=h.red, undercurl=conf.undercurl },
        ["@diff.plus"] = { fg=h.green },
        ["@diff.minus"] = { fg=h.red },
        ["@diff.delta"] = { fg=h.yellow },
        ['@emphasis'] = { fg=b.fg, italic=conf.italic},    -- For text to be represented with emphasis.
        ['@environment'] = { fg=h.violet }, -- text environments in markup languages, e.g.,egin in LaTeX.
        ['@environment.name'] = { fg=h.yellow }, -- e.g., theorem inegin                               {theorem} block in LaTeX.
        ['@error'] = { fg=h.red },
        ['@exception'] = { link='Exception' },
        ['@field'] = { fg=h.yellow },    -- For fields.
        ['@float'] = { link='Float' },    -- For floats.
        ['@function'] = { link='Function' },    -- For function (calls and definitions).
        ['@function.builtin'] = { fg=h.blue, italic=conf.italic},    -- For builtin functions: `table.insert` in Lua.
        ['@function.macro'] = { fg=h.blue, bold=conf.bold },    -- For macro defined fuctions (calls and definitions): each `macro_rules` in Rust.
        ["@function.call"] = { link="Function" },
        ["@function.method"] = { link="Function" },
        ["@function.method.call"] = { link="Function" },
        ['@include'] = { link='Include' },    -- For includes: `#include` in C, `use` or `extern crate` in Rust, or `require` in Lua.
        ['@keyword'] = { fg=h.violet },    -- For keywords that don't fall in previous categories.
        ["@keyword.conditional"] = { link = "Conditional" },
        ["@keyword.conditional.ternary"] = { link = "Conditional" },
        ["@keyword.coroutine"] = {fg=h.violet, italic=conf.italic },
        ["@keyword.directive"] = { fg=h.green },  -- shebangs
        ["@keyword.directive.define"] = { fg=h.green },
        ['@keyword.debug'] = { fg=h.violet, italic=conf.italic },
        ['@keyword.exception'] = { fg=h.violet, italic=conf.italic }, -- throw, catch, try
        ['@keyword.function'] = { fg=h.violet, italic=conf.italic },    -- For keywords used to define a fuction.
        ['@keyword.import'] = { fg=h.rose, italic=conf.italic },  -- Including / exporting modules (import / from in Python).
        ['@keyword.modifier'] = { fg=h.violet, italic=conf.italic },
        ['@keyword.operator'] = { fg=h.orange, italic=conf.italic }, -- unary and binary operators that are english words
        ['@keyword.return'] = { fg=h.red, italic=conf.italic },
        ['@keyword.type'] = { fg=h.violet, italic=conf.italic },    -- struct, enum
        ['@label'] = { fg=h.orange },    -- For labels: `label:` in C and `:label:` in Lua.
        ['@literal'] = { fg=h.cyan },    -- Literal text.
        -- begin markup
        ["@markup.strong"] = { bold=conf.bold },
        ["@markup.italic"] = { italic=conf.italic },
        ["@markup.strikethrough"] = { strikethrough=true },
        ["@markup.underline"] = { underline=true },
        ["@markup.heading"] = { bold=conf.bold, underdouble=conf.underdouble },
        ["@markup.heading.1"] = { underdouble=conf.underdouble },
        ["@markup.heading.2"] = { underdouble=conf.underdouble },
        ["@markup.heading.3"] = { underdouble=conf.underdouble },
        ["@markup.heading.4"] = { underline=true },
        ["@markup.heading.5"] = { underline=true },
        ["@markup.heading.6"] = { underline=true },
        ['@markup.math'] = { fg=h.yellow}, -- mathenv
        ['@markup.quote'] = { fg=h.yellow},
        ['@markup.link'] = { fg=h.yellow},  -- refs, footnotes
        ['@markup.link.label'] = { fg=h.yellow}, -- ref descriptions (?)
        ['@markup.link.url'] = { link="@string.special.url" },
        ['@markup.list'] = { fg=h.violet },
        ['@markup.list.checked'] = { fg=h.green },
        ['@markup.list.unchecked'] = { fg=h.red },
        ['@markup.raw'] = { fg=h.yellow },
        ['@markup.raw.block'] = { fg=h.yellow },
        -- end markup
        ['@method'] = { fg=h.blue },    -- For method calls and definitions.
        ['@module'] = { fg=h.yellow, bold=conf.bold },    -- Modules and namespaces.
        ['@module.builtin'] = { fg=h.yellow, bold=conf.bold, italic=conf.italic },    -- Modules and namespaces.
        ['@note'] = { fg=h.yellow },
        ['@number'] = { link='Number' },    -- For all numbers
        ['@number.float'] = { link='Float' },    -- For all floating point numbers.
        ['@operator'] = { fg=h.orange},    -- For any operator: `+`, but also `->` and `*` in p.
        ['@parameter'] = { fg=h.green },    -- For parameters of a function.
        ['@parameter.reference'] = { fg=h.green },    -- For references to parameters of a function.
        ["@property"] = { fg=h.yellow },  -- Key in key, value maps.
        ['@punctuation.bracket'] = { fg=h.red },    -- For brackets and parens.
        ['@punctuation.delimiter'] = { fg=h.magenta},    -- For delimiters ie: `.`
        ['@punctuation.special'] = { fg=h.magenta },    -- For special punctutation that does not fall in the catagories before.
        ['@repeat'] = { link='Repeat' },    -- For keywords related to loops.
        ['@strikethrough'] = { strikethrough=true },    -- For strikethrough text.
        ['@string'] = { link='String' },    -- For strings.
        ['@string.escape'] = { fg=h.red },    -- For escape characters within a string.
        ['@string.documentation'] = { link = "Comment" },
        ['@string.regex'] = { fg=h.orange },    -- For regexes.
        ['@string.special'] = { fg=h.yellow },
        ['@string.special.symbol'] = { fg=h.violet },  -- Symbols or atoms.
        ['@string.special.url'] = { fg=h.blue, underline = true},
        ['@string.special.path'] = { fg=h.blue },
        ['@symbol'] = { fg=h.violet },    -- For identifiers referring to symbols or atoms. DEPRECATED?
        ['@tag'] = { fg=h.violet },    -- Tags like html tag names.
        ['@tag.builtin'] = { fg=h.magenta, bold=conf.bold },    -- Tags like html tag names.
        ['@tag.attribute'] = { fg=h.magenta },    -- html tag attribute
        ['@tag.delimter'] = { link='Delimiter' },    -- Tag delimiter like `<` `>` `/`
        ['@text'] = { fg=b.fg },    -- For strings considered text in a markup language.
        ['@text.reference'] = { fg=b.subfg }, -- footnote, citations, etp.
        ['@title'] = { fg=b.emph },    -- Text that is part of a title.
        ['@type'] = { link='Type' },    -- For types.
        ['@type.builtin'] = { fg=h.yellow, italic=conf.italic},
        ['@type.definition'] = { link = "Typedef" },  -- typedef
        ['@underline'] = { underline=true },
        ['@uri'] = { fg=h.blue, underline=true },
        ['@variable'] = { fg=b.fg},    -- Any variable name that does not have another highlight.
        ['@variable.builtin'] = { fg=h.orange, italic=conf.italic},    -- Variable names that are defined by the languages, like `this` or `self`.
        ["@variable.parameter"] = { fg=h.orange},          -- parameters of a function
        ["@variable.parameter.builtin"] = { fg=h.magenta, italic=conf.italic },  -- special parameters (e.g. `_`, `it`)
        ["@variable.member"] = { fg=h.yellow },  --object and struct fields
        ['@warning'] = { fg=h.orange }, -- DEPRECATED?
        -- begin non-highlight captures
        -- ["@conceal"] = { link="Conceal" },
        -- ["@none"] = { link="Conceal" },
        -- ["@spell"] = { link="Conceal" },
        -- ["@nospell"] = { link="Conceal" },
        -- end non-highlight captures
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
        DiagnosticHint = { fg=h.green },
        -- DiagnosticVirtualTextError = { }, -- Used for "Error" diagnostic virtual text
        -- DiagnosticVirtualTextWarn = { }, -- Used for "Warning" diagnostic virtual text
        -- DiagnosticVirtualTextInfo = { }, -- Used for "Information" diagnostic virtual text
        -- DiagnosticVirtualTextHint = { }, -- Used for "Hint" diagnostic virtual text
        DiagnosticUnderlineError = { fg=h.red, underdouble=conf.underdouble }, -- Used for "Error" diagnostic virtual text
        DiagnosticUnderlineWarn = { fg=h.orange, underline=true }, -- Used for "Warning" diagnostic virtual text
        DiagnosticUnderlineInfo = { fg=h.yellow, underline=true }, -- Used for "Information" diagnostic virtual text
        DiagnosticUnderlineHint = { fg=h.green, underline=true }, -- Used for "Hint" diagnostic virtual text
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

return M
