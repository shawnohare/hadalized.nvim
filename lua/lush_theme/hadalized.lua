-- Enable lush.ify on this file, run:
--
--  `:Lushify`
--
--  or
--
--  `:lua require('lush').ify()`
--
-- TODO: [ ] Define LSP groups.
-- TODO: [ ] Define package groups.
-- TODO: [ ] Export non-Lush version?.
-- TODO: [x] Make palette definition non-dependent on lush itself (i.e., remove)
--       calls to hsluv and then construct a lushified version?
-- TODO: [ ] Use same color base for light and dark?

vim.cmd([[ highlight clear ]]) vim.g.colors_name = 'hadalized'
local lush = require('lush')
local hsluv = lush.hsluv

-- ---------------------------------------------------------------------------
-- solarized reference values
-- ---------------------------------------------------------------------------
--
-- --------|----------|----------|-----------|--------------------------------------------
-- NAME    | HEX      | L*A*B    | sRGB      |
-- --------|----------|----------|-----------|--------------------------------------------
-- base03  |  #002b36 |15 -12 -12|000 043  054|
-- base02  |  #073642 |20 -12 -12|007 054  066|
-- base01  |  #586e75 |45 -07 -07|088 110  117|
-- base00  |  #657b83 |50 -07 -07|101 123  131|
-- base10  |  #839496 |60 -06 -03|131 148  150|
-- base11  |  #93a1a1 |65 -05 -02|147 161  161|
-- base12  |  #eee8d5 |92 -00  10|238 232  213|
-- base13  |  #fdf6e3 |97  00  10|253 246  227|
-- yellow  |  #b58900 |60  10  65|181 137  000|
-- orange  |  #cb4b16 |50  50  55|203 075  022|
-- red     |  #dc322f |50  65  45|220 050  047|
-- magenta |  #d33682 |50  65 -05|211 054  130|
-- violet  |  #6c71c4 |50  15 -45|108 113  196|
-- blue    |  #268bd2 |55 -10 -45|038 139  210|
-- cyan    |  #2aa198 |60 -35 -05|042 161  152|
-- green   |  #859900 |60 -20  65|133 153  000|
-- --------------------------------------------------------------------------

-- ---------------------------------------------------------------------------
-- palette
-- Colors are drawn from the okhsl(h, 100, l) color space
-- ---------------------------------------------------------------------------
--
-- okhsl(h, 100, l).
-- Static colors used in both light and dark modes.
local colors = {
    -- okhsl hue values for color.
    -- hues = {
    --     red     = 025,
    --     orange  = 055,
    --     yellow  = 110,
    --     green   = 130,
    --     spring  = 155,
    --     cyan    = 185,
    --     blue    = 245,
    --     violet  = 290,
    --     magenta = 330,
    --     cerise  = 345,
    --     rose    = 360,
    -- },
    -- okhsl(h, 100, 55)
    l55 = {
        red     = hsluv('#f60029'),
        orange  = hsluv('#c76600'),
        yellow  = hsluv('#898a00'),
        green   = hsluv('#629600'), -- h=130
        spring  = hsluv('#009d5a'), -- h=155
        cyan    = hsluv('#00988c'),
        blue    = hsluv('#008ad9'),
        violet  = hsluv('#885eff'),
        magenta = hsluv('#d700d0'), -- h=330
        cerise  = hsluv('#e400a6'),
        rose    = hsluv('#ed007e'), -- h=360
        -- green   = hsluv('#4f9a00'),
        -- green   = hsluv('#009e48'), -- h=150
        -- violet  = hsluv('#716aff'),
    },
    -- okhsl(h, 100, 60)
    l60 = {
        red     = hsluv('#ff3b41'),
        orange  = hsluv('#da7000'),
        yellow  = hsluv('#979700'),
        green   = hsluv('#6ca500'), -- h=130,
        spring  = hsluv('#00ad63'), -- h=155,
        cyan    = hsluv('#00a79a'),  -- h=185
        blue    = hsluv('#0098ee'),
        violet  = hsluv('#9374ff'),
        magenta = hsluv('#eb00e4'),
        cerise  = hsluv('#f900b7'), -- h=345
        rose    = hsluv('#ff1f8b'),
        -- green   = hsluv('#57a900'), -- h=135
        -- green   = hsluv('#00af2f'), -- h=145,
        -- green   = hsluv('#00ae50'), -- h=150
    },
    -- okhsl(h, 100, 65)
    l65 = {
        red = hsluv('#ff625e'),
        orange = hsluv('#ed7b00'),
        yellow = hsluv('#a5a500'),
        green  = hsluv('#76b300'),
        spring  = hsluv('#00bc6c'), -- h=155
        cyan   = hsluv('#00b6a8'),
        blue   = hsluv('#1aa5ff'),
        violet = hsluv('#9e88ff'),
        magenta = hsluv('#ff0bf7'),
        rose    = hsluv('#ff5699'),
    },
    -- okhsl(h, 100, 75) for backgrounds
    l75 = {
        red     = hsluv('#ff9890'),
        orange  = hsluv('#ff9e57'),
        yellow  = hsluv('#c1c100'),
        green   = hsluv('#8ad200'), -- h=130
        spring  = hsluv('#00dc7f'), -- h=155
        cyan    = hsluv('#00d5c5'),
        blue    = hsluv('#75c1ff'),
        violet  = hsluv('#b8acff'),
        magenta = hsluv('#ff82f6'),
        cerise  = hsluv('#ff8cd0'),
        rose    = hsluv('#ff92b5'),
    },
    -- okhsl(h, 100, 80) for backgrounds
    l80 = {
        red     = hsluv('#ffafa7'),
        orange  = hsluv('#ffb37f'),
        yellow  = hsluv('#cfd000'),
        green   = hsluv('#95e100'),
        spring  = hsluv('#00ec89'),
        cyan    = hsluv('#00e5d3'),
        blue    = hsluv('#94ceff'),
        violet  = hsluv('#c5bdff'),
        magenta = hsluv('#ff9ff7'),
        rose    = hsluv('#ffaac4'),
    },
    -- okhsl(h, 100, 85)
    l85 = {
        red     = hsluv('#ffc4be'),
        orange  = hsluv('#ffc7a2'),
        yellow  = hsluv('#ddde00'),
        green   = hsluv('#9ff100'),
        spring  = hsluv('#00fc93'),
        cyan    = hsluv('#00f3ea'),
        blue    = hsluv('#b0daff'),
        violet  = hsluv('#d3ceff'),
        magenta = hsluv('#ffbaf8'),
        rose    = hsluv('#ffc1d2'),
    },
}

-- okhsl(220, *, *)
local base = {
    s100 = {
        l050 = hsluv('#000b0f'),
        l070 = hsluv('#041014'),
        l080 = hsluv('#00141b'),
        l100 = hsluv('#001a22'),
        l120 = hsluv('#001f28'),
        l150 = hsluv('#002732'),
        l200 = hsluv('#003441'),
        l250 = hsluv('#004151'),
    },
    s50 = {
        l08 = hsluv('#051318'),
        l10 = hsluv('#08191e'),
        l12 = hsluv('#0b1e24'),
        l15 = hsluv('#0f262d'),
        l20 = hsluv('#16333b'),
        l25 = hsluv('#1d3f4a'),
    },
    s33 = {
        l05 = hsluv('#040a0c'),
        l06 = hsluv('#050d10'),
        l07 = hsluv('#071013'),
        l08 = hsluv('#081316'),
        l10 = hsluv('#0c181c'),
        l12 = hsluv('#101e22'),
        l15 = hsluv('#132328'),
        l20 = hsluv('#1e3238'),
        l25 = hsluv('#263e46'),
        l40 = hsluv('#41646f'),
        l45 = hsluv('#4b717d'),
        l50 = hsluv('#557e8b'),
        l55 = hsluv('#608c9a'),
        l60 = hsluv('#6c99a8'),
        l65 = hsluv('#79a6b5'),
        l70 = hsluv('#87b4c2'),
        l75 = hsluv('#97c1cf'),
        l80 = hsluv('#aaceda'),
        l85 = hsluv('#bedae4'),
        l90 = hsluv('#d3e7ed'),
        l97 = hsluv('#f2f8fa'),
    },
    s25 = {
        l08 = hsluv('#0a1315'),
        l10 = hsluv('#0e181b'),
        l12 = hsluv('#121d21'),
        l15 = hsluv('#182529'),
        l20 = hsluv('#213136'),
        l25 = hsluv('#2a3d43'),
        l28 = hsluv('#30454b'),
    },
    s05 = {
        l05 = hsluv('#070909'),
        l06 = hsluv('#0a0c0c'),
        l07 = hsluv('#0d0f0f'),
        l08 = hsluv('#101112'),
        l10 = hsluv('#141717'),
        l12 = hsluv('#191c1d'),
        l15 = hsluv('#202324'),
        l20 = hsluv('#2b2f30'),
        l25 = hsluv('#363b3c'),
        l27 = hsluv('#3b4041'),
        l28 = hsluv('#3d4243'),
        l30 = hsluv('#424748'),
        l35 = hsluv('#4d5355'),
        l40 = hsluv('#595f61'),
        l45 = hsluv('#656c6e'),
        l50 = hsluv('#71787b'),
        l55 = hsluv('#7e8588'),
        l60 = hsluv('#8b9295'),
        l65 = hsluv('#989fa2'),
        l70 = hsluv('#a6adaf'),
        l75 = hsluv('#b4babc'),
        l80 = hsluv('#c2c8c9'),
        l85 = hsluv('#d1d5d7'),
        l90 = hsluv('#e0e3e4'),
        l93 = hsluv('#e9ebec'),
        l95 = hsluv('#f0f1f1'),
        l97 = hsluv('#f6f7f7'),
    }

}

-- Define a collection of palette variants using a standard config for each.
-- For now only light and dark variants are supported.
local palettes = {
    light = {
        bg0 = base.s05.l97,
        bg1 = base.s05.l93,
        bg2 = base.s05.l90,
        bg3 = base.s05.l85,
        bg4 = base.s05.l80,
        fg5 = base.s05.l70,
        fg4 = base.s05.l55,
        fg3 = base.s05.l45,
        fg2 = base.s05.l35,
        fg1 = base.s05.l28,
        fg0 = base.s05.l05,
        dim = colors.l55,
        color = colors.l60,
        br = colors.l65,
        hl = colors.l85,
    },
    dark = {
        bg0 = base.s33.l08,
        bg1 = base.s33.l12,
        bg2 = base.s33.l15,
        bg3 = base.s33.l20,
        bg4 = base.s33.l25,
        fg5 = base.s05.l30,
        fg4 = base.s05.l45,
        fg3 = base.s05.l55,
        fg2 = base.s05.l65,
        fg1 = base.s05.l75,
        fg0 = base.s05.l90,
        dim = colors.l55,
        color = colors.l60,
        br = colors.l75,
        hl = colors.l85,
    }
}


-- Grab the appropriate palette
local p = palettes.dark
if (vim.opt.bg:get() == 'light')
then
    p = palettes.light
end

-- local term = {
--     color1 = p.red,     color9 = p.orange,
--     color2 = p.green,   color10 = p.spring,
--     color3 = p.yellow,  color11 = p.br.yellow,
--     color4 = p.blue,    color12 = p.violet,
--     color5 = p.magenta, color13 = p.rose,
--     color6 = p.cyan,    color14 = p.br.cyan

-- }



-- LSP/Linters mistakenly show `undefined global` errors in the spec, they may
-- support an annotation like the following. Consult your server documentation.
---@diagnostic disable: undefined-global
local theme = lush(function(injected_functions)

    -- NOTE: Current support for treesitter @x.y groups
    -- https://github.com/rktjmp/lush.nvim/issues/109
    local group = injected_functions.sym

    return {
        -- The following are all the Neovim default highlight groups from the docs
        -- as of v0.6.1, to aid your theme creation. Your themes should
        -- probably style all of these at a bare minimum.
        --
        -- Referenced/linked groups must come before being referenced/lined,
        -- so the order shown ((mostly) alphabetical) is likely
        -- not the order you will end up with.
        --
        Boolean        { fg=p.color.rose }, --  a boolean constant: TRUE, false
        Character      { fg=p.color.spring, }, --  a character constant: 'c', '\n'
        ColorColumn    { bg=p.bg1 }, -- used for the columns set with 'colorcolumn'
        Comment        { fg=p.fg3 }, -- any comment
        Conceal        { fg=p.fg5 }, -- placeholder characters substituted for concealed text (see 'conceallevel')
        Conditional    { fg=p.color.rose }, --  if, then, else, endif, switch, etp.
        Constant       { fg=p.color.magenta }, -- (preferred) any constant
        Cursor         { }, -- character under the cursor
        CursorColumn   { }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
        CursorIM       { }, -- like Cursor, but used when in IME mode |CursorIM|
        CursorLine     { bg=p.bg1 }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
        CursorLineNr   { bg=p.bg1, fg=p.color.yellow }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
        Debug          { fg=p.color.rose }, --    debugging statements
        Define         { fg=p.color.violet, gui='italic' }, --   preprocessor #define
        Delimiter      { fg=p.color.red }, --  character that needs attention
        DiffAdd        { fg=p.color.green }, -- diff mode: Added line |diff.txt|
        DiffChange     { fg=p.color.yellow }, -- diff mode: Changed line |diff.txt|
        DiffDelete     { fg=p.color.red }, -- diff mode: Deleted line |diff.txt|
        DiffText       { fg=p.color.blue, gui='underline' }, -- diff mode: Changed text within a changed line |diff.txt|
        Directory      { fg=p.color.blue, gui='bold' }, -- directory names (and other special names in listings)
        EndOfBuffer    { fg=p.fg4 }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
        Error          { fg=p.red }, -- (preferred) any erroneous construct
        ErrorMsg       { fg=p.red, gui='bold' }, -- error messages on the command line
        Exception      { fg=p.color.magenta }, --  try, catch, throw
        Float          { fg=p.color.violet }, --    a floating point constant: 2.3e10
        FoldColumn     { }, -- 'foldcolumn'
        Folded         { bg=p.bg2 }, -- line used for closed folds
        Function       { fg=p.color.blue}, -- function name (also: methods for classes)
        Identifier     { fg=p.color.yellow}, -- (preferred) any variable name
        Ignore         { fg=p.fg4 }, -- (preferred) left blank, hidden  |hl-Ignore|
        IncSearch      { bg=p.hl.blue }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
        Include        { fg=p.color.red }, --  preprocessor #include
        Italic         { fg=nil, bg=nil, gui='italic'},
        Keyword        { fg=p.color.violet }, --  any other keyword
        Label          { fg=p.color.green }, --    case, default, etp.
        LineNr         { bg=p.bg1, fg=p.fg3}, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
        Macro          { Define }, --    same as Define
        MatchParen     { bg=p.hl.yellow }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
        ModeMsg        { fg=p.color.orange, gui='bold' }, -- 'showmode' message (e.g., "-- INSERT -- ")
        MoreMsg        { fg=p.color.green }, -- |more-prompt|
        MsgArea        { }, -- Area for messages and cmdline
        MsgSeparator   { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
        NonText        { fg=p.fg4 }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
        Normal         { fg=p.fg1, bg=p.bg0 }, -- normal text
        NormalFloat    { fg=p.fg1, bg=p.bg1}, -- Normal text in floating windows.
        NormalNC       { fg=p.fg3, bg=p.bg1}, -- normal text in non-current windows
        Number         { fg=p.color.violet }, --   a number constant: 234, 0xff
        Operator       { fg=p.color.blue }, -- "sizeof", "+", "*", etp.
        Pmenu          { bg=p.bg1 }, -- Popup menu: normal item.
        PmenuSbar      { }, -- Popup menu: scrollbar.
        PmenuSel       { bg=p.bg4 }, -- Popup menu: selected item.
        PmenuThumb     { }, -- Popup menu: Thumb of the scrollbar.
        PreCondit      { fg=p.color.rose }, --  preprocessor #if, #else, #endif, etp.
        PreProc        { fg=p.color.orange }, -- (preferred) generic Preprocessor
        Question       { fg=p.color.green }, -- |hit-enter| prompt and yes/no questions
        QuickFixLine   { }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
        Repeat         { fg=p.color.orange }, --   for, do, while, etp.
        Search         { bg=p.hl.yellow }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
        SignColumn     { bg=p.bg0}, -- column where |signs| are displayed
        Special        { fg=p.color.red }, -- (preferred) any special symbol
        SpecialChar    { fg=p.color.red, gui='bold' }, --  special character in a constant
        SpecialComment { fg=p.color.orange }, -- special things inside a comment
        SpecialKey     { fg=p.color.red, gui='bold' }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
        SpellBad       { fg=p.color.red, gui='underdouble' }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
        SpellCap       { fg=p.color.orange, gui='underline'}, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
        SpellLocal     { fg=p.color.orange, gui='underdotted' }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
        SpellRare      { fg=p.color.yellow, gui='underdashed' }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
        Standout       { gui='standout' },
        Statement      { fg=p.color.yellow }, -- (preferred) any statement
        StatusLine     { bg=p.bg2, fg=p.fg1, }, -- status line of current window
        StatusLineNC   { bg=p.bg0, fg=p.fg3}, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
        StorageClass   { fg=p.color.green }, -- static, register, volatile, etp.
        Strikethrough  { gui='strikethrough' },
        String         { fg=p.color.cyan }, --   a string constant: "this is a string"
        Structure      { fg=p.color.spring }, --  struct, union, enum, etp.
        Substitute     { fg=p.color.red, bg=p.hl.yellow, Italic }, -- |:substitute| replacement text highlighting
        Swap           { gui='reverse' },
        TabLine        { }, -- tab pages line, not active tab page label
        TabLineFill    { }, -- tab pages line, where there are no labels
        TabLineSel     { }, -- tab pages line, active tab page label
        Tag            { fg=p.color.blue, gui='underline'}, --    you can use CTRL-] on this
        TermCursor     { fg=p.fg1 }, -- cursor in a focused terminal
        TermCursorNC   { }, -- cursor in an unfocused terminal
        Title          { fg=p.fg0 }, -- titles for output from ":set all", ":autocmd" etp.
        Todo           { fg=p.color.yellow, gui='bold' }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX
        Type           { fg=p.color.yellow }, -- (preferred) int, long, char, etp.
        Typedef        { fg=p.color.violet }, --  A typedef
        VertSplit      { fg=p.fg4 }, -- the column separating vertically split windows
        Visual         { bg=p.bg3 }, -- Visual mode selection
        VisualNOS      { bg=p.bg2 }, -- Visual mode selection when vim is "Not Owning the Selection".
        WarningMsg     { fg=p.dim.red }, -- warning messages
        Whitespace     { fg=p.fg4}, -- "nbsp", "space", "tab" and "trail" in 'listchars'
        WildMenu       { }, -- current match in 'wildmenu' completion
        lCursor        { }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')

        -- -------------------------------------------------------------------
        -- Treesitter Groups
        -- -------------------------------------------------------------------
        group('@annotation')               { fg=p.color.green },
        group('@attribute')                { fg=p.color.orange },
        group('@boolean')                  { Boolean },    -- For booleans.
        group('@character')                { Character },    -- For characters.
        group('@comment')                  { Comment },    -- For comment blocks.
        group('@conditional')              { Conditional },    -- For keywords related to conditionnals.
        group('@constant')                 { Constant },    -- For constants
        group('@constant.builtin')         { fg=p.color.rose, Italic },    -- For constant that are built in the language: `nil` in Lua.
        group('@constant.macro')           { fg=p.color.rose, gui='bold' },    -- For constants that are defined by macros: `NULL` in p.
        group('@constructor')              { fg=p.color.blue, gui='bold' },    -- For constructor calls and definitions: ` { }` in Lua, and Java constructors.
        group('@danger')                   { fg=p.color.red },
        group('@emphasis')                 { fg=p.fg0, Italic },    -- For text to be represented with emphasis.
        group('@environment')              { fg=p.color.violet }, -- text environments in markup languages, e.g., \begin in LaTeX.
        group('@environment.name')         { fg=p.color.yellow }, -- e.g., theorem in \begin                               {theorem} block in LaTeX.
        group('@error')                    { fg=p.color.red },
        group('@exception')                { Exception },
        group('@field')                    { fg=p.color.yellow },    -- For fields.
        group('@float')                    { Float },    -- For floats.
        group('@function')                 { Function },    -- For function (calls and definitions).
        group('@function.builtin')         { fg=p.color.blue, Italic },    -- For builtin functions: `table.insert` in Lua.
        group('@function.macro')           { fg=p.color.blue, gui='bold' },    -- For macro defined fuctions (calls and definitions): each `macro_rules` in Rust.
        group('@include')                  { Include },    -- For includes: `#include` in C, `use` or `extern crate` in Rust, or `require` in Lua.
        group('@keyword')                  { fg=p.color.violet },    -- For keywords that don't fall in previous categories.
        group('@keyword.function')         { fg=p.color.violet, Italic },    -- For keywords used to define a fuction.
        group('@keyword.operator')         { fg=p.color.orange, Italic }, -- unary and binary operators that are english words
        group('@keyword.return')           { fg=p.color.red, Italic },
        group('@label')                    { fg=p.color.orange },    -- For labels: `label:` in C and `:label:` in Lua.
        group('@literal')                  { fg=p.color.cyan },    -- Literal text.
        group('@math')                     { fg=p.color.yellow}, -- mathenv
        group('@method')                   { fg=p.color.blue },    -- For method calls and definitions.
        group('@namespace')                { fg=p.color.yellow, gui='bold' },    -- For identifiers referring to modules and namespaces.
        group('@note')                     { fg=p.color.yellow },
        group('@number')                   { Number },    -- For all numbers
        group('@operator')                 { fg=p.color.orange},    -- For any operator: `+`, but also `->` and `*` in p.
        group('@parameter')                { fg=p.color.green },    -- For parameters of a function.
        group('@parameter.reference')      { fg=p.color.green },    -- For references to parameters of a function.
        group('@punctuation.bracket')      { fg=p.color.red },    -- For brackets and parens.
        group('@punctuation.delimiter')    { fg=p.color.rose},    -- For delimiters ie: `.`
        group('@punctuation.special')      { fg=p.color.magenta },    -- For special punctutation that does not fall in the catagories before.
        group('@repeat')                   { Repeat },    -- For keywords related to loops.
        group('@strikethrough')            { gui='strikethrough' },    -- For strikethrough text.
        group('@string')                   { String },    -- For strings.
        group('@string.escape')            { fg=p.color.red },    -- For escape characters within a string.
        group('@string.regex')             { fg=p.color.orange },    -- For regexes.
        group('@string.special')           { fg=p.color.yellow},
        group('@symbol')                   { fg=p.color.violet },    -- For identifiers referring to symbols or atoms.
        group('@tag')                      { fg=p.color.violet },    -- Tags like html tag names.
        group('@tag.attribute')            { fg=p.color.magenta },    -- html tag attribute
        group('@tag.delimter')             { Delimiter },    -- Tag delimiter like `<` `>` `/`
        group('@text')                     { fg=p.fg1 },    -- For strings considered text in a markup language.
        group('@text.reference')           { fg=p.fg2 }, -- footnote, citations, etp.
        group('@title')                    { fg=p.fg0 },    -- Text that is part of a title.
        group('@type')                     { Type },    -- For types.
        group('@type.builtin')             { fg=p.color.yellow, Italic },    -- For builtin types.
        group('@underline')                { gui='underline' },
        group('@uri')                      { fg=p.color.blue, gui='underline' },
        group('@variable')                 { fg=p.fg1 },    -- Any variable name that does not have another highlight.
        group('@variable.builtin')         { fg=p.color.orange, Italic},    -- Variable names that are defined by the languages, like `this` or `self`.
        group('@warning')                  { fg=p.color.orange },

        -- gui
        -- Menu {},
        -- Scrollbar {},
        -- Tooltip {},

        ---- -------------------------------------------------------------------
        ---- LSP groups
        ---- These groups are for the native LSP client. Some other LSP clients may
        ---- use these groups, or use their own. Consult your LSP client's
        ---- documentation.
        ---- -------------------------------------------------------------------

        ---- LspReferenceText      { }, -- used for highlighting "text" references
        ---- LspReferenceRead      { }, -- used for highlighting "read" references
        ---- LspReferenceWrite     { }, -- used for highlighting "write" references

        ---- LspCodeLens           { }, -- Used to color the virtual text of the codelens
        ---- LspCodeLensSeparator  { }, -- Used to color the virtual text of the codelens
        ---- LspSignatureActiveParameter {},

        ---- -------------------------------------------------------------------
        ---- Diagnostic groups
        ---- -------------------------------------------------------------------
	    DiagnosticError   { group('@danger') },
        DiagnosticWarn    { group('@warning') },
        DiagnosticInfo    { group('@note')    },
        DiagnosticHint { fg=p.spring },
        -- DiagnosticVirtualTextError { }, -- Used for "Error" diagnostic virtual text
        -- DiagnosticVirtualTextWarn  { }, -- Used for "Warning" diagnostic virtual text
        -- DiagnosticVirtualTextInfo  { }, -- Used for "Information" diagnostic virtual text
        -- DiagnosticVirtualTextHint  { }, -- Used for "Hint" diagnostic virtual text
        DiagnosticUnderlineError   { fg=p.red, gui='underdouble' }, -- Used for "Error" diagnostic virtual text
        DiagnosticUnderlineWarn    { fg=p.orange, gui='underline' }, -- Used for "Warning" diagnostic virtual text
        DiagnosticUnderlineInfo    { fg=p.yellow, gui='underline' }, -- Used for "Information" diagnostic virtual text
        DiagnosticUnderlineHint    { fg=p.spring, gui='underline' }, -- Used for "Hint" diagnostic virtual text
        -- DiagnosticFloatingError    { }, -- Used for "Error" diagnostic virtual text
        -- DiagnosticFloatingWarn     { }, -- Used for "Warning" diagnostic virtual text
        -- DiagnosticFloatingInfo     { }, -- Used for "Information" diagnostic virtual text
        -- DiagnosticFloatingHint     { }, -- Used for "Hint" diagnostic virtual text
        -- DiagnosticSignError {},
        -- DiagnosticSignWarn {},
        -- DiagnosticSignInfo {},
        -- DiagnosticSignHint {},

    }
end)

-- return our parsed theme for extension or use else where.
return theme

-- vi:nowrap
