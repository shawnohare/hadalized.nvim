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
-- TODO: [ ] Define LSP groups.
-- TODO: [ ] Define package groups.
-- TODO: [ ] Export non-Lush version?.
-- TODO: [x] Make palette definition non-dependent on lush itself (i.e., remove)
--       calls to hsluv and then construct a lushified version?
-- TODO: [ ] Use same color base for light and dark?

-- vim.cmd([[ highlight clear ]])
-- vim.g.colors_name = 'hadalized'

-- When :Lushify is invoked it parses the current file and looks for
-- instances of hsl or hsluv to render the underlying colors. This is handy
-- for non-hex values but for us is somewhat annoying, since convert
-- from okhsl to hsluv first.
local lush = require('lush')
local hsl = lush.hsl

-- local palette_name = vim.g.hadalized_palette
-- if (palette_name == nil) then
--     palette_name = vim.o.bg
-- end
-- if (palette_name == nil) then
--     palette_name = 'dark'
-- end


-- ---------------------------------------------------------------------------
-- palette
-- Colors are drawn from the okhsl(h, 100, l) color space
-- ---------------------------------------------------------------------------
--
-- okhsl hue values for color.
-- local hues = {
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
-- okhsl(h, 100, l).
-- Static colors used in both light and dark modes.
local colors = {
    s100 = {
        l50 = {
            red     = hsl('#df0024'),
            orange  = hsl('#b45c00'),
            yellow  = hsl('#7c7d00'),
            green   = hsl('#588800'),
            spring  = hsl('#008e50'),
            cyan    = hsl('#008a7f'),
            blue    = hsl('#007dc5'),
            violet  = hsl('#7e43ff'),
            magenta = hsl('#c300bd'),
            cerise  = hsl('#cf0097'),
            rose    = hsl('#d70072'),

        },
        l55 = {
            red     = hsl('#f60029'),
            orange  = hsl('#c76600'),
            yellow  = hsl('#898a00'),
            green   = hsl('#629600'),
            spring  = hsl('#009d5a'),
            cyan    = hsl('#00988c'),
            blue    = hsl('#008ad9'),
            violet  = hsl('#885eff'),
            magenta = hsl('#d700d0'),
            cerise  = hsl('#e400a6'),
            rose    = hsl('#ed007e'),
        },
        -- okhsl(h, 100, 60)
        l60 = {
            red     = hsl('#ff3b41'),
            orange  = hsl('#da7000'),
            yellow  = hsl('#979700'),
            green   = hsl('#6ca500'),
            spring  = hsl('#00ad63'),
            cyan    = hsl('#00a79a'),
            blue    = hsl('#0098ee'),
            violet  = hsl('#9374ff'),
            magenta = hsl('#eb00e4'),
            cerise  = hsl('#f900b7'),
            rose    = hsl('#ff1f8b'),
            -- green   = hsl('#57a900'), -- h=135
            -- green   = hsl('#00af2f'), -- h=145,
            -- green   = hsl('#00ae50'), -- h=150
        },
        -- okhsl(h, 100, 65)
        l65 = {
            red     = hsl('#ff625e'),
            orange  = hsl('#ed7b00'),
            yellow  = hsl('#a5a500'),
            green   = hsl('#76b300'),
            spring  = hsl('#00bc6c'),
            cyan    = hsl('#00b6a8'),
            blue    = hsl('#1aa5ff'),
            violet  = hsl('#9e88ff'),
            magenta = hsl('#ff0bf7'),
            rose    = hsl('#ff5699'),
        },
        l70 = {
            red     = hsl('#ff7f78'),
            orange  = hsl('#ff8610'),
            yellow  = hsl('#b3b300'),
            green   = hsl('#80c200'),
            spring  = hsl('#00cc76'),
            cyan    = hsl('#00c6b6'),
            blue    = hsl('#52b3ff'),
            violet  = hsl('#ab9aff'),
            magenta = hsl('#ff5cf6'),
            rose    = hsl('#ff77a7'),
        },
        -- okhsl(h, 100, 75) for backgrounds
        l75 = {
            red     = hsl('#ff9890'),
            orange  = hsl('#ff9e57'),
            yellow  = hsl('#c1c100'),
            green   = hsl('#8ad200'),
            spring  = hsl('#00dc7f'),
            cyan    = hsl('#00d5c5'),
            blue    = hsl('#75c1ff'),
            violet  = hsl('#b8acff'),
            magenta = hsl('#ff82f6'),
            cerise  = hsl('#ff8cd0'),
            rose    = hsl('#ff92b5'),
        },
        -- okhsl(h, 100, 80) for backgrounds
        l80 = {
            red     = hsl('#ffafa7'),
            orange  = hsl('#ffb37f'),
            yellow  = hsl('#cfd000'),
            green   = hsl('#95e100'),
            spring  = hsl('#00ec89'),
            cyan    = hsl('#00e5d3'),
            blue    = hsl('#94ceff'),
            violet  = hsl('#c5bdff'),
            magenta = hsl('#ff9ff7'),
            rose    = hsl('#ffaac4'),
        },
        -- okhsl(h, 100, 85)
        l85 = {
            red     = hsl('#ffc4be'),
            orange  = hsl('#ffc7a2'),
            yellow  = hsl('#ddde00'),
            green   = hsl('#9ff100'),
            spring  = hsl('#00fc93'),
            cyan    = hsl('#00f3ea'),
            blue    = hsl('#b0daff'),
            violet  = hsl('#d3ceff'),
            magenta = hsl('#ffbaf8'),
            rose    = hsl('#ffc1d2'),
        },
    },
}

-- okhsl(220, *, *)
local base = {
    h285 = {
        s20 = {
            l08 = hsl('#101018'),
            l10 = hsl('#14141d'),
            l12 = hsl('#1a1a24'),
            l15 = hsl('#21212c'),
            l20 = hsl('#2d2d3b'),
            l25 = hsl('#383849'),

        },
        s10 = {
            l08 = hsl('#111114'),
            l10 = hsl('#16161a'),
            l12 = hsl('#1b1b20'),
            l15 = hsl('#222227'),
            l20 = hsl('#2d2d34'),
            l25 = hsl('#393941'),

        },
    },
    h220 = {
        s100 = {
            l05 = hsl('#000b0f'),
            l07 = hsl('#041014'),
            l08 = hsl('#00141b'),
            l10 = hsl('#001a22'),
            l12 = hsl('#001f28'),
            l15 = hsl('#002732'),
            l20 = hsl('#003441'),
            l25 = hsl('#004151'),
        },
        s50 = {
            l08 = hsl('#051318'),
            l10 = hsl('#08191e'),
            l12 = hsl('#0b1e24'),
            l15 = hsl('#0f262d'),
            l20 = hsl('#16333b'),
            l25 = hsl('#1d3f4a'),
        },
        s33 = {
            l05 = hsl('#040a0c'),
            l06 = hsl('#050d10'),
            l07 = hsl('#071013'),
            l08 = hsl('#081316'),
            l10 = hsl('#0c181c'),
            l12 = hsl('#101e22'),
            l15 = hsl('#132328'),
            l20 = hsl('#1e3238'),
            l25 = hsl('#263e46'),
            l40 = hsl('#41646f'),
            l45 = hsl('#4b717d'),
            l50 = hsl('#557e8b'),
            l55 = hsl('#608c9a'),
            l60 = hsl('#6c99a8'),
            l65 = hsl('#79a6b5'),
            l70 = hsl('#87b4c2'),
            l75 = hsl('#97c1cf'),
            l80 = hsl('#aaceda'),
            l85 = hsl('#bedae4'),
            l90 = hsl('#d3e7ed'),
            l97 = hsl('#f2f8fa'),
        },
        s25 = {
            l08 = hsl('#0a1315'),
            l10 = hsl('#0e181b'),
            l12 = hsl('#121d21'),
            l15 = hsl('#182529'),
            l20 = hsl('#213136'),
            l25 = hsl('#2a3d43'),
            l28 = hsl('#30454b'),
        },
        s15 = {
            l08 = hsl('#0d1214'),
            l10 = hsl('#111719'),
            l12 = hsl('#161d1f'),
            l15 = hsl('#1c2427'),
            l20 = hsl('#263033'),
            l25 = hsl('#303c40'),

        },
        s10 = {
            l08 = hsl('#0e1213'),
            l12 = hsl('#171c1e'),
            l15 = hsl('#1e2425'),
            l20 = hsl('#293032'),
            l25 = hsl('#333c3e'),
        },
        s05 = {
            l05 = hsl('#070909'),
            l06 = hsl('#0a0c0c'),
            l07 = hsl('#0d0f0f'),
            l08 = hsl('#101112'),
            l10 = hsl('#141717'),
            l12 = hsl('#191c1d'),
            l15 = hsl('#202324'),
            l20 = hsl('#2b2f30'),
            l25 = hsl('#363b3c'),
            l27 = hsl('#3b4041'),
            l28 = hsl('#3d4243'),
            l30 = hsl('#424748'),
            l35 = hsl('#4d5355'),
            l40 = hsl('#595f61'),
            l45 = hsl('#656c6e'),
            l50 = hsl('#71787b'),
            l55 = hsl('#7e8588'),
            l60 = hsl('#8b9295'),
            l65 = hsl('#989fa2'),
            l70 = hsl('#a6adaf'),
            l75 = hsl('#b4babc'),
            l80 = hsl('#c2c8c9'),
            l85 = hsl('#d1d5d7'),
            l90 = hsl('#e0e3e4'),
            l93 = hsl('#e9ebec'),
            l95 = hsl('#f0f1f1'),
            l97 = hsl('#f6f7f7'),
        },
    },
    h90 = {
        s33 = {
            l80 = hsl('#d2c6a5'),
            l85 = hsl('#ded4b9'),
            l90 = hsl('#e9e2cf'),
            l93 = hsl('#f0ebdd'),
            l95 = hsl('#f4f1e7'),
            l97 = hsl('#fdf6e3'),

        },
        s25 = {
            l80 = hsl('#cfc6ae'),
            l85 = hsl('#dcd4c0'),
            l90 = hsl('#e7e2d5'),
            l93 = hsl('#efebe1'),
            l97 = hsl('#f8f6f2'),
        },
        s20 = {
            l80 = hsl('#cdc6b3'),
            l85 = hsl('#dad4c5'),
            l90 = hsl('#e6e2d8'),
            l93 = hsl('#eeebe3'),
            l97 = hsl('#f8f6f3'),

        },
        s15 = {
            l80 = hsl('#ccc6b8'),
            l85 = hsl('#d8d4c9'),
            l90 = hsl('#e5e2db'),
            l93 = hsl('#edebe5'),
            l97 = hsl('#f7f6f4'),

        },
        s10 = {
            l80 = hsl('#cac6bd'),
            l85 = hsl('#d7d4cd'),
            l90 = hsl('#e4e2dd'),
            l93 = hsl('#ecebe7'),
            l97 = hsl('#f7f6f5'),

        },
        s05 = {
            l80 = hsl('#c8c6c2'),
            l85 = hsl('#d6d4d1'),
            l90 = hsl('#e3e2e0'),
            l93 = hsl('#ecebe9'),
            l97 = hsl('#f7f6f6'),
        },
    },
}

-- Define partial base function with hue and saturation fixed.
base.cool = base.h220.s33
base.neutral = base.h220.s05
base.warm = base.h90.s05


-- Define a collection of palette variants using a standard config for each.
-- For now only light and dark variants are supported.
local palettes = {
    light = {
        bg0 = base.warm.l97,
        bg1 = base.warm.l93,
        bg2 = base.warm.l90,
        bg3 = base.warm.l85,
        bg4 = base.warm.l80,
        fg5 = base.neutral.l70,
        fg4 = base.neutral.l55,
        fg3 = base.neutral.l45,
        fg2 = base.neutral.l35,
        fg1 = base.neutral.l28,
        fg0 = base.neutral.l05,
        dim = colors.s100.l50,
        color = colors.s100.l55,
        br = colors.s100.l65,
        hl = colors.s100.l85,
    },
    dark = {
        bg0 = base.cool.l08,
        bg1 = base.cool.l12,
        bg2 = base.cool.l15,
        bg3 = base.cool.l20,
        bg4 = base.cool.l25,
        fg5 = base.neutral.l30,
        fg4 = base.neutral.l45,
        fg3 = base.neutral.l55,
        fg2 = base.neutral.l65,
        fg1 = base.neutral.l75,
        fg0 = base.neutral.l90,
        dim = colors.s100.l55,
        color = colors.s100.l65,
        br = colors.s100.l75,
        hl = colors.s100.l85,
    }
}

-- local term = {
--     color1 = p.red,     color9 = p.orange,
--     color2 = p.green,   color10 = p.spring,
--     color3 = p.yellow,  color11 = p.br.yellow,
--     color4 = p.blue,    color12 = p.violet,
--     color5 = p.magenta, color13 = p.rose,
--     color6 = p.cyan,    color14 = p.br.cyan

-- }
--

local function generate(palette_name)
    vim.cmd([[ highlight clear ]])
    vim.g.colors_name = 'hadalized'
    -- Generates a lush theme from the given palette string.
    if (palette_name == nil) then
        palette_name = 'dark'
    end

    local p = palettes[palette_name]
    if (p == nil) then
        error('invalid palette. Options are {"dark", "light"}')
    end

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
            NormalNC       { Normal }, -- normal text in non-current windows
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

    return theme
end

-- Return background based palette and inject the generate function for use
-- in generating static variants.
local theme = generate(vim.o.bg)
return theme
