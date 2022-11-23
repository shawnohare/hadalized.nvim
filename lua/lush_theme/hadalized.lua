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
local color = {
    -- okhsl hue values for color.
    hues = {
        red     = 025,
        orange  = 055,
        yellow  = 110,
        green   = 130,
        spring  = 155,
        cyan    = 185,
        blue    = 245,
        violet  = 290,
        magenta = 330,
        cerise  = 345,
        rose    = 360,
    },
    -- okhsl(h, 100, 50)
    l50 = {
        red     = hsluv('#df0024'),
        orange  = hsluv('#b45c00'),
        yellow  = hsluv('#7c7d00'),
        green   = hsluv('#588800'),
        spring  = hsluv('#008e50'),
        cyan    = hsluv('#008a7f'),
        blue    = hsluv('#007dc5'),
        violet  = hsluv('#7e43ff'),
        magenta = hsluv('#c300bd'),
        rose    = hsluv('#d70072'),
    },
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
    -- okhsl(h, 100, 70)
    -- l70 = {
    --     red     = hsluv('#ff7f78'),
    --     orange  = hsluv('#ff8610'),
    --     yellow  = hsluv('#b3b300'),
    --     green   = hsluv('#80c200'), -- h=130
    --     spring  = hsluv('#00cc76'), -- h=155
    --     cyan    = hsluv('#00c6b6'), -- h=185
    --     blue    = hsluv('#52b3ff'),
    --     violet  = hsluv('#ab9aff'), -- h=290
    --     magenta = hsluv('#ff5cf6'),
    --     cerise  = hsluv('#ff6ec8'),
    --     rose    = hsluv('#ff77a7'), -- h=360,
    --     -- green   = hsluv('#68c700'), -- h=135
    --     -- green   = hsluv('#00cd5f'), -- h=150
    --     -- cyan    = hsluv('#00c5bd'), -- h=190
    --     -- cyan    = hsluv('#00c7af'), -- h=180
    -- },
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
    -- gray05 = hsluv('#111111'), -- l=05,
    -- gray10 = hsluv('#1b1b1b'), -- l=10,
    -- gray15 = hsluv('#262626'), -- l=15,
    -- gray20 = hsluv('#303030'), -- l=20,
    -- gray25 = hsluv('#3b3b3b'), -- l=25,
    -- gray30 = hsluv('#474747'), -- l=30,
    -- gray35 = hsluv('#525252'), -- l=35,
    -- gray40 = hsluv('#5e5e5e'), -- l=40,
    -- gray45 = hsluv('#6a6a6a'), -- l=45,
    -- gray50 = hsluv('#777777'), -- l=50,
    -- gray55 = hsluv('#848484'), -- l=55,
    -- gray60 = hsluv('#919191'), -- l=60,
    -- gray65 = hsluv('#9e9e9e'), -- l=65,
    -- gray70 = hsluv('#ababab'), -- l=70,
    -- gray75 = hsluv('#b9b9b9'), -- l=75,
    -- gray80 = hsluv('#c6c6c6'), -- l=80,
    -- gray85 = hsluv('#d4d4d4'), -- l=85,
    -- gray90 = hsluv('#e2e2e2'), -- l=90,
    -- gray95 = hsluv('#f1f1f1'), -- l=95.

    -- base values (saturation mostly 10)
    -- -- base08 = hsluv('#051318'), -- s=50,
    -- -- base10 = hsluv('#08191e'), -- s=50,
    -- -- base15 = hsluv('#0f262d'), -- s=50,
    -- -- base20 = hsluv('#16333b'), -- s=50,
    -- base08 = hsluv('#00141b'), -- s=100,
    -- base10 = hsluv('#001a22'), -- s=100,
    -- base15 = hsluv('#002732'), -- s=100,
    -- base20 = hsluv('#003441'), -- s=100,
    -- -- base25 = hsluv('#1d3f4a'), -- s=50,
    -- -- base25 = hsluv('#004151'), -- s=100,
    -- -- base25 = hsluv('#2a3d43'), -- s=25,
    -- base25 = hsluv('#333c3e'), -- s=10
    -- base30 = hsluv('#3e484b'), -- s=10
    -- base35 = hsluv('#495457'), -- s=10
    -- base40 = hsluv('#556064'), -- s=10
    -- base45 = hsluv('#606d71'), -- s=10
    -- base50 = hsluv('#6c7a7e'), -- s=10
    -- base55 = hsluv('#79878b'), -- s=10
    -- base60 = hsluv('#859499'), -- s=10
    -- base65 = hsluv('#93a1a6'), -- s=10
    -- base70 = hsluv('#a1aeb3'), -- s=10,
    -- base75 = hsluv('#afbbc0'), -- s=10
    -- base80  = hsluv('#bec9cc'),  -- s=10
    -- base85  = hsluv('#ced6d9'),  -- s=10,
    -- base90  =  hsluv('#dee4e6'), -- s=10,
    -- -- base92  =  hsluv('#e4e9eb'), -- s=10,
    -- base95  =  hsluv('#eef1f2'), -- s=10,
    -- base97  =  hsluv('#f5f7f7'), -- s=10,
    -- base87  =  hsluv('#d4dcde'), -- l=87,
    -- base82  =  hsluv('#c4ced1'), -- l=82
    --
    -- base (saturation mostly 5)
    -- base05 = hsluv('#000b0f'),
    base08 = hsluv('#00141b'), -- s=100,
    base10 = hsluv('#001a22'), -- s=100,
    base12 = hsluv('#001f28'), -- s=100,
    base15 = hsluv('#002732'), -- s=100,
    -- base20 = hsluv('#16333b'), -- s=50,
    -- base20 = hsluv('#0b343f'), -- s=75, hsluv(221, 90, 19),
    base20 = hsluv('#003441'), -- s=100,
    base25 = hsluv('#004151'), -- s=100
    -- base25s25 = hsluv('#2a3d43'), -- s=25,
    -- base25s50 = hsluv('#1d3f4a'), -- s=50,
    -- base25 = hsluv('#363b3c'), -- s=05,
    base27 = hsluv('#3b4041'), -- s=05,
    base28 = hsluv('#3d4243'),
    base30 = hsluv('#424748'),
    base35 = hsluv('#4d5355'),
    base40 = hsluv('#595f61'),
    base45 = hsluv('#656c6e'),
    base50 = hsluv('#71787b'),
    base55 = hsluv('#7e8588'),
    base60 = hsluv('#8b9295'),
    base65 = hsluv('#989fa2'),
    base70 = hsluv('#a6adaf'),
    base75 = hsluv('#b4babc'),
    base80 = hsluv('#c2c8c9'),
    base85 = hsluv('#d1d5d7'),
    base90 = hsluv('#e0e3e4'),
    -- base93 = hsluv('#e9ebec'), -- s=05
    -- base95 = hsluv('#f0f1f1'),
    base97 = hsluv('#f6f7f7'),
}

-- Compute some bg:fg contrast ratios.
local contrasts = {
    base08 = {
        base55 = 5.01,
        base60 = 5.95,
        base65 = 7,
        base70 = 8.26,
        base75 = 9.58,
        base75s10 = 9.58,
    },
    base10 = {
        base75 = 9.13,
        base70 = 7.87,
        base65 = 6.67,
        base60 = 5.67,
        base55 = 4.02,

    },
    base97 = {
        base25 = 10.58,
        base27 = 9.8,
        base28 = 9.5,
        base30 = 8.78,
        base35 = 7.28,
        base40 = 6.04,
        base45 = 4.98,
        base55 = 3.49,
    },
}


local light = {
    -- okhsl(220, 10, l)
    bg = {
        color.base97,
        -- color.base95,
        color.base93,
        color.base90,
        color.base85,
        color.base80,
    },
    fg = {
        color.base55,
        color.base45,
        color.base35,
        color.base28,
        color.base08,
    },
    bg0 = color.base97,
    bg1 = color.base93,
    bg2 = color.base90,
    bg3 = color.base85,
    bg4 = color.base80,
    fg4 = color.base55,
    fg3 = color.base45,
    fg2 = color.base35,
    fg1 = color.base28,
    dim = color.l55,
    hue = color.l55,
    red = color.l55.red,
    orange = color.l55.orange,
    yellow = color.l55.yellow,
    green = color.l55.green,
    spring = color.l55.spring,
    cyan = color.l55.cyan,
    blue = color.l55.blue,
    violet = color.l55.violet,
    magenta = color.l55.magenta,
    rose = color.l55.rose,
    br = color.l65,
    hl = color.l85,
}

local dark = {
    -- okhsl(220, 100, l)
    bg0 = color.base08,
    bg1 = color.base12,
    bg2 = color.base15,
    bg3 = color.base20,
    bg4 = color.base25,
    fg4 = color.base45,
    fg3 = color.base55,
    fg2 = color.base65,
    fg1 = color.base75,
    fg0 = color.base90,
    -- colors
    dim = color.l55,
    hue = color.l60,
    red = color.l60.red,
    orange = color.l60.orange,
    yellow = color.l60.yellow,
    green = color.l60.green,
    spring = color.l60.spring,
    cyan = color.l60.cyan,
    blue = color.l60.blue,
    violet = color.l60.violet,
    magenta = color.l60.magenta,
    rose = color.l60.rose,
    br = color.l75,
    hl = color.l85,
}


local p = dark

if (vim.opt.bg:get() == 'light')
then
    p = light
end

-- DEBUG: Explicitly define these keys.
-- bump palette hues to top level
-- for k, v in pairs(p.hue) do
--     p[k] = v
-- end

-- local term = {
--     color1 = p.red,     color9 = p.orange,
--     color2 = p.green,   color10 = p.spring,
--     color3 = p.yellow,  color11 = p.br.yellow,
--     color4 = p.blue,    color12 = p.violet,
--     color5 = p.magenta, color13 = p.rose,
--     color6 = p.cyan,    color14 = p.br.cyan

-- }


-- local sol = {
--     base03  = hsluv(222, 100, 15),
--     base02  = hsluv(221, 94, 20),
--     base01  = hsluv(215, 35, 45),
--     base00  = hsluv(218, 32, 50),
--     base10  = hsluv(201, 20, 60),
--     base11  = hsluv(192, 15, 65),
--     base12  = hsluv(73, 23, 92),
--     base13  = hsluv(71, 76, 97),
--     red     = hsluv(13, 82, 49),
--     orange  = hsluv(21, 95, 49),
--     yellow  = hsluv(59, 100, 60),
--     green   = hsluv(97, 100, 60),
--     cyan    = hsluv(182, 92, 60),
--     blue    = hsluv(245, 93, 56),
--     violet  = hsluv(264, 57, 51),
--     magenta = hsluv(348, 81, 50),
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
        -- Conceal      { }, -- placeholder characters substituted for concealed text (see 'conceallevel')
        -- Cursor       { }, -- character under the cursor
        -- CursorColumn { }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
        -- CursorIM     { }, -- like Cursor, but used when in IME mode |CursorIM|
        -- FoldColumn   { }, -- 'foldcolumn'
        -- ModeMsg      { bg=p.fg4,  }, -- 'showmode' message (e.g., "-- INSERT -- ")
        -- MsgArea      { }, -- Area for messages and cmdline
        -- MsgSeparator { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
        -- NormalNC     {fg=p.fg3, bg=p.bg1}, -- normal text in non-current windows
        -- PmenuSbar    { }, -- Popup menu: scrollbar.
        -- PmenuSel     { Swap }, -- Popup menu: selected item.
        -- PmenuThumb   { }, -- Popup menu: Thumb of the scrollbar.
        -- QuickFixLine { }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
        -- TabLine      { }, -- tab pages line, not active tab page label
        -- TabLineFill  { }, -- tab pages line, where there are no labels
        -- TabLineSel   { }, -- tab pages line, active tab page label
        -- TermCursor   { }, -- cursor in a focused terminal
        -- TermCursorNC { }, -- cursor in an unfocused terminal
        -- WildMenu     { }, -- current match in 'wildmenu' completion
        -- lCursor      { }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
        Bold           { fg=nil, bg=nil, gui='bold'},
        Boolean        { fg=p.rose }, --  a boolean constant: TRUE, false
        Character      { fg=p.spring, }, --  a character constant: 'c', '\n'
        ColorColumn    { bg=p.bg1 }, -- used for the columns set with 'colorcolumn'
        Comment        { fg=p.fg3 }, -- any comment
        Conditional    { fg=p.rose }, --  if, then, else, endif, switch, etp.
        Constant       { fg=p.magenta }, -- (preferred) any constant
        CursorLine     { bg=p.bg1 }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
        CursorLineNr   { bg=p.bg1, fg=p.yellow }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
        Debug          { fg=p.rose }, --    debugging statements
        Define         { fg=p.violet, gui='italic' }, --   preprocessor #define
        Delimiter      { fg=p.red }, --  character that needs attention
        DiffAdd        { fg=p.green }, -- diff mode: Added line |diff.txt|
        DiffChange     { fg=p.yellow }, -- diff mode: Changed line |diff.txt|
        DiffDelete     { fg=p.red }, -- diff mode: Deleted line |diff.txt|
        DiffText       { fg=p.blue, gui='underline' }, -- diff mode: Changed text within a changed line |diff.txt|
        Directory      { fg=p.blue, gui='bold' }, -- directory names (and other special names in listings)
        EndOfBuffer    { fg=p.fg4 }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
        Error          { fg=p.red }, -- (preferred) any erroneous construct
        ErrorMsg       { fg=p.red, gui='bold' }, -- error messages on the command line
        Exception      { fg=p.magenta }, --  try, catch, throw
        Float          { fg=p.violet }, --    a floating point constant: 2.3e10
        Folded         { bg=p.bg2 }, -- line used for closed folds
        Function       { fg=p.blue}, -- function name (also: methods for classes)
        Identifier     { fg=p.yellow}, -- (preferred) any variable name
        Ignore         { fg=p.fg4 }, -- (preferred) left blank, hidden  |hl-Ignore|
        IncSearch      { bg=p.hl.blue }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
        Include        { fg=p.red }, --  preprocessor #include
        Italic         { fg=nil, bg=nil, gui='italic'},
        Keyword        { fg=p.violet }, --  any other keyword
        Label          { fg=p.green }, --    case, default, etp.
        LineNr         { bg=p.bg1, fg=p.fg3}, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
        Macro          { Define }, --    same as Define
        MatchParen     { bg=p.hl.yellow }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
        MoreMsg        { fg=p.green }, -- |more-prompt|
        NonText        { fg=p.fg4 }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
        Normal         { fg=p.fg1, bg=p.bg0 }, -- normal text
        NormalFloat    { fg=p.fg1, bg=p.bg1}, -- Normal text in floating windows.
        Number         { fg=p.violet }, --   a number constant: 234, 0xff
        Operator       { fg=p.blue }, -- "sizeof", "+", "*", etp.
        Pmenu          { bg=p.bg1 }, -- Popup menu: normal item.
        PmenuSel       { bg=p.bg4 }, -- Popup menu: selected item.
        PreCondit      { fg=p.rose }, --  preprocessor #if, #else, #endif, etp.
        PreProc        { fg=p.orange }, -- (preferred) generic Preprocessor
        Question       { fg=p.green }, -- |hit-enter| prompt and yes/no questions
        Repeat         { fg=p.orange }, --   for, do, while, etp.
        Search         { bg=p.hl.yellow }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
        SignColumn     { bg=p.bg0}, -- column where |signs| are displayed
        Special        { fg=p.red }, -- (preferred) any special symbol
        SpecialChar    { fg=p.red, Bold }, --  special character in a constant
        SpecialComment { fg=p.orange }, -- special things inside a comment
        SpecialKey     { fg=p.red, Bold }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
        SpellBad       { fg=p.red, gui='underdouble' }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
        SpellCap       { fg=p.orange, gui='underline'}, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
        SpellLocal     { fg=p.orange, gui='underdotted' }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
        SpellRare      { fg=p.yellow, gui='underdashed' }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
        Standout       { gui='standout' },
        Statement      { fg=p.yellow }, -- (preferred) any statement
        StatusLine     { bg=p.bg2, fg=p.fg1, }, -- status line of current window
        StatusLineNC   { bg=p.bg0, fg=p.fg3}, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
        StorageClass   { fg=p.green }, -- static, register, volatile, etp.
        Strikethrough  { gui='strikethrough' },
        String         { fg=p.cyan }, --   a string constant: "this is a string"
        Structure      { fg=p.spring }, --  struct, union, enum, etp.
        Substitute     { fg=p.red, bg=p.hl.yellow, Italic }, -- |:substitute| replacement text highlighting
        Swap           { gui='reverse' },
        Tag            { fg=p.blue, gui='underline'}, --    you can use CTRL-] on this
        Title          { fg=p.fg0 }, -- titles for output from ":set all", ":autocmd" etp.
        Todo           { fg=p.yellow, gui='bold' }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX
        Type           { fg=p.yellow }, -- (preferred) int, long, char, etp.
        Typedef        { fg=p.violet }, --  A typedef
        Undercurl      { fg=nil, bg=nil, gui='undercurl' },
        Underdashed    { fg=nil, bg=nil, gui='underdashed' },
        Underdotted    { fg=nil, bg=nil, gui='underdotted' },
        Underdouble    { fg=nil, bg=nil, gui='underdouble' },
        Underline      { fg=nil, bg=nil, gui='underline' },
        VertSplit      { fg=p.fg4 }, -- the column separating vertically split windows
        Visual         { bg=p.bg3 }, -- Visual mode selection
        VisualNOS      { bg=p.bg2 }, -- Visual mode selection when vim is "Not Owning the Selection".
        WarningMsg     { fg=p.red }, -- warning messages
        Whitespace     { fg=p.fg4}, -- "nbsp", "space", "tab" and "trail" in 'listchars'

        -- -------------------------------------------------------------------
        -- Treesitter Groups
        -- -------------------------------------------------------------------
        group('@annotation')  { fg=p.green },
        group('@attribute')  { fg=p.orange },
        group('@boolean')    { Boolean },    -- For booleans.
        group('@character')  { Character },    -- For characters.
        group('@comment')            { Comment },    -- For comment blocks.
        group('@conditional')       { Conditional },    -- For keywords related to conditionnals.
        group('@constant')          { Constant },    -- For constants
        group('@constant.builtin')  { fg=p.rose, Italic },    -- For constant that are built in the language: `nil` in Lua.
        group('@constant.macro')    { fg=p.rose, Bold },    -- For constants that are defined by macros: `NULL` in p.
        group('@constructor')       { fg=p.blue, Bold },    -- For constructor calls and definitions: ` { }` in Lua, and Java constructors.
        group('@danger')      { fg=p.red },
        group('@emphasis')  { fg=p.fg0, Italic },    -- For text to be represented with emphasis.
        group('@environment')      { fg=p.violet }, -- text environments in markup languages, e.g., \begin in LaTeX.
        group('@environment.name') { fg=p.yellow }, -- e.g., theorem in \begin{theorem} block in LaTeX.
        group('@error')             { fg=p.red },
        group('@exception')         { Exception },
        group('@field') { fg=p.yellow },    -- For fields.
        group('@float')      { Float },    -- For floats.
        group('@function')         { Function },    -- For function (calls and definitions).
        group('@function.builtin') { fg=p.blue, Italic },    -- For builtin functions: `table.insert` in Lua.
        group('@function.macro')   { fg=p.blue, Bold },    -- For macro defined fuctions (calls and definitions): each `macro_rules` in Rust.
        group('@include')      { Include },    -- For includes: `#include` in C, `use` or `extern crate` in Rust, or `require` in Lua.
        group('@keyword')             { fg=p.violet },    -- For keywords that don't fall in previous categories.
        group('@keyword.function')    { fg=p.violet, Italic },    -- For keywords used to define a fuction.
        group('@keyword.operator')    { fg=p.orange, Italic }, -- unary and binary operators that are english words
        group('@keyword.return')      { fg=p.red, Italic },
        group('@label')        { fg=p.orange },    -- For labels: `label:` in C and `:label:` in Lua.
        group('@literal')    { fg=p.cyan },    -- Literal text.
        group('@math')      { fg=p.yellow}, -- mathenv
        group('@method')       { fg=p.blue },    -- For method calls and definitions.
        group('@namespace')    { fg=p.yellow, Bold },    -- For identifiers referring to modules and namespaces.
        group('@note')        { fg=p.yellow },
        group('@number')     { Number },    -- For all numbers
        group('@operator')     { fg=p.orange},    -- For any operator: `+`, but also `->` and `*` in p.
        group('@parameter')           { fg=p.green },    -- For parameters of a function.
        group('@parameter.reference')  { fg=p.green },    -- For references to parameters of a function.
        group('@punctuation.bracket')      { fg=p.red },    -- For brackets and parens.
        group('@punctuation.delimiter')    { fg=p.rose},    -- For delimiters ie: `.`
        group('@punctuation.special')      { fg=p.magenta },    -- For special punctutation that does not fall in the catagories before.
        group('@repeat')                   { Repeat },    -- For keywords related to loops.
        group('@strikethrough')            { gui='strikethrough' },    -- For strikethrough text.
        group('@string')                   { String },    -- For strings.
        group('@string.escape')            { fg=p.red },    -- For escape characters within a string.
        group('@string.regex')       { fg=p.orange },    -- For regexes.
        group('@string.special')     { fg=p.yellow},
        group('@symbol')             { fg=p.violet },    -- For identifiers referring to symbols or atoms.
        group('@tag')                { fg=p.violet },    -- Tags like html tag names.
        group('@tag.attribute')      { fg=p.magenta },    -- html tag attribute
        group('@tag.delimter')       { Delimiter },    -- Tag delimiter like `<` `>` `/`
        group('@text')               { fg=p.fg1 },    -- For strings considered text in a markup language.
        group('@text.reference')     { fg=p.fg2 }, -- footnote, citations, etp.
        group('@title')              { fg=p.fg0 },    -- Text that is part of a title.
        group('@type')               { Type },    -- For types.
        group('@type.builtin')       { fg=p.yellow, Italic },    -- For builtin types.
        group('@underline')          { Underline },
        group('@uri')                { fg=p.blue, Underline },
        group('@variable')           { fg=p.fg1 },    -- Any variable name that does not have another highlight.
        group('@variable.builtin')   { fg=p.orange, Italic},    -- Variable names that are defined by the languages, like `this` or `self`.
        group('@warning')            { fg=p.orange },


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
        DiagnosticUnderlineError   { fg=p.red, Underdouble }, -- Used for "Error" diagnostic virtual text
        DiagnosticUnderlineWarn    { fg=p.orange, Underline }, -- Used for "Warning" diagnostic virtual text
        DiagnosticUnderlineInfo    { fg=p.yellow, Underline }, -- Used for "Information" diagnostic virtual text
        DiagnosticUnderlineHint    { fg=p.spring, Underline }, -- Used for "Hint" diagnostic virtual text
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
