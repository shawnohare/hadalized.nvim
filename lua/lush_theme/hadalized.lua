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

vim.cmd([[ highlight clear ]])
vim.g.colors_name = 'hadalized'
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
local p = {
    -- okhsl hue values for colors.
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
    -- okhsl(h, 100, 55)
    c55 = {
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
    c60 = {
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
    c65 = {
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
    c70 = {
        red     = hsluv('#ff7f78'),
        orange  = hsluv('#ff8610'),
        yellow  = hsluv('#b3b300'),
        green   = hsluv('#80c200'), -- h=130
        spring  = hsluv('#00cc76'), -- h=155
        cyan    = hsluv('#00c6b6'), -- h=185
        blue    = hsluv('#52b3ff'),
        violet  = hsluv('#ab9aff'), -- h=290
        magenta = hsluv('#ff5cf6'),
        cerise  = hsluv('#ff6ec8'),
        rose    = hsluv('#ff77a7'), -- h=360,
        -- green   = hsluv('#68c700'), -- h=135
        -- green   = hsluv('#00cd5f'), -- h=150
        -- cyan    = hsluv('#00c5bd'), -- h=190
        -- cyan    = hsluv('#00c7af'), -- h=180
    },
    -- okhsl(h, 100, 75) for backgrounds
    c75 = {
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
    c80 = {
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
    c85 = {
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
    gray05 = hsluv('#111111'), -- l=05,
    gray10 = hsluv('#1b1b1b'), -- l=10,
    gray15 = hsluv('#262626'), -- l=15,
    gray20 = hsluv('#303030'), -- l=20,
    gray25 = hsluv('#3b3b3b'), -- l=25,
    gray30 = hsluv('#474747'), -- l=30,
    gray35 = hsluv('#525252'), -- l=35,
    gray40 = hsluv('#5e5e5e'), -- l=40,
    gray45 = hsluv('#6a6a6a'), -- l=45,
    gray50 = hsluv('#777777'), -- l=50,
    gray55 = hsluv('#848484'), -- l=55,
    gray60 = hsluv('#919191'), -- l=60,
    gray65 = hsluv('#9e9e9e'), -- l=65,
    gray70 = hsluv('#ababab'), -- l=70,
    gray75 = hsluv('#b9b9b9'), -- l=75,
    gray80 = hsluv('#c6c6c6'), -- l=80,
    gray85 = hsluv('#d4d4d4'), -- l=85,
    gray90 = hsluv('#e2e2e2'), -- l=90,
    gray95 = hsluv('#f1f1f1'), -- l=95.
}

local contrasts = {
    bgl08 = {
        gray45 = 3.47,
        gray50 = 4.2,
        gray55 = 5.07,
        gray60 = 6.01,
        gray65 = 7.07,
        gray70 = 8.25,
        gray75 = 9.66,
        gray80 = 11.1,
    },
    bgl10 = {
        gray45 = 3.31,
        gray50 = 4,
        gray55 = 4.79,
        gray60 = 5.69,
        gray65 = 6.69,
        gray70 = 7.81,
        gray75 = 9.14,
    },
}

p.light = {
    -- okhsl(220, 10, l)
    bg = {
        hsluv('#f5f7f7'), -- l=97,
        hsluv('#eef1f2'), -- l=95,
        hsluv('#e4e9eb'), -- l=92,
        hsluv('#d4dcde'), -- l=87,
        hsluv('#c4ced1'), -- l=82
    },
    fg = {
        p.gray50,
        p.gray40,
        p.gray30,
        p.gray20,
        p.gray05,
    },
    color = {
        dim = p.c55,
        main = p.c55,
        br   = p.c65,
    },

}

p.dark = {
    -- okhsl(220, 100, l)
    bg = {

        hsluv('#00141b'), -- l=8
        hsluv('#001a22'), -- l=10,
        -- hsluv('#00222b'), -- l=13,
        hsluv('#002732'), -- l=15, hsluv(222, 100, 14),
        hsluv('#003441'), -- l=20, hsluv(222, 100, 19)
        hsluv('#004151'), -- l=25, hsluv(222, 100, 25)
        -- hsluv('#004e60'), -- l=30,
    },
    fg = {
        p.gray45,
        p.gray55,
        p.gray70,
        p.gray75,
        p.gray90,
    },
    color = {
        dim = p.c55,
        main = p.c60,
        br   = p.c75,
    },
}


if (vim.opt.bg:get() == 'light')
then
    p.mode = p.light
    p.op   = p.dark
else
    p.mode = p.dark
    p.op = p.light
end

local fg = p.mode.fg
local bg = p.mode.bg
local dim = p.mode.color.dim
local c = p.mode.color.main
local br = p.mode.color.br

-- local term = {
--     color1 = c.red,     color9 = c.orange,
--     color3 = c.yellow,  color11 = c.ygreen,
--     color5 = c.magenta, color13 = c.rose,

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
local theme = lush(function()
    return {
        -- The following are all the Neovim default highlight groups from the docs
        -- as of 0.5.0-nightly-446, to aid your theme creation. Your themes should
        -- probably style all of these at a bare minimum.
        --
        -- Referenced/linked groups must come before being referenced/lined,
        -- so the order shown ((mostly) alphabetical) is likely
        -- not the order you will end up with.
        --
        -- You can uncomment these and leave them empty to disable any
        -- styling for that group (meaning they mostly get styled as Normal)
        -- or leave them commented to apply vims default colouring or linking.
        Bold { fg=nil, bg=nil, gui='bold'},
        Italic { fg=nil, bg=nil, gui='italic'},
        Underline { fg=nil, bg=nil, gui='underline' },
        Undercurl { fg=nil, bg=nil, gui='undercurl' },
        Swap { gui='reverse' },
        Standout { gui='standout' },
        Strikethrough { gui='strikethrough' },


        Comment      { fg=fg[2] }, -- any comment
        ColorColumn  { bg=bg[2] }, -- used for the columns set with 'colorcolumn'
        -- Conceal      { }, -- placeholder characters substituted for concealed text (see 'conceallevel')
        -- Cursor       { }, -- character under the cursor
        -- lCursor      { }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
        -- CursorIM     { }, -- like Cursor, but used when in IME mode |CursorIM|
        -- CursorColumn { }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
        CursorLine   { bg=bg[3] }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
        Directory    { fg=c.blue, Bold }, -- directory names (and other special names in listings)
        DiffAdd      { fg=c.green }, -- diff mode: Added line |diff.txt|
        DiffChange   { fg=c.yellow }, -- diff mode: Changed line |diff.txt|
        DiffDelete   { fg=c.red }, -- diff mode: Deleted line |diff.txt|
        DiffText     { fg=c.blue, Underline }, -- diff mode: Changed text within a changed line |diff.txt|
        -- GitSignsAdd   { fg=green},
        EndOfBuffer  { fg=fg[1] }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
        -- TermCursor   { }, -- cursor in a focused terminal
        -- TermCursorNC { }, -- cursor in an unfocused terminal
        ErrorMsg     { fg=c.red, Bold }, -- error messages on the command line
        VertSplit    { fg=bg[5] }, -- the column separating vertically split windows
        Folded       { bg=bg[3] }, -- line used for closed folds
        -- FoldColumn   { }, -- 'foldcolumn'
        SignColumn   { bg=bg[1]}, -- column where |signs| are displayed
        -- GitSignsDelete { fg=c.red, bg=bg[2] },
        -- GitSignsDeleteNr { fg=c.red },
        LineNr       { bg=bg[3], fg=fg[2]}, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
        CursorLineNr { bg=bg[3], fg=c.yellow }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
        MatchParen   { bg=p.c85.yellow }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
        -- ModeMsg      { bg=fg[1],  }, -- 'showmode' message (e.g., "-- INSERT -- ")
        -- MsgArea      { }, -- Area for messages and cmdline
        -- MsgSeparator { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
        MoreMsg      { fg=c.green }, -- |more-prompt|
        NonText      { fg=fg[1] }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
        Normal       {fg=fg[4], bg=bg[1] }, -- normal text
        NormalFloat  { fg=fg[4], bg=bg[2]}, -- Normal text in floating windows.
        -- NormalNC     {fg=fg[2], bg=bg[2]}, -- normal text in non-current windows
        Pmenu        { bg=bg[2]}, -- Popup menu: normal item.
        PmenuSel     { bg=bg[4]}, -- Popup menu: selected item.
        -- PmenuSbar    { }, -- Popup menu: scrollbar.
        -- PmenuThumb   { }, -- Popup menu: Thumb of the scrollbar.
        Question     { fg=c.green }, -- |hit-enter| prompt and yes/no questions
        -- QuickFixLine { }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
        IncSearch    { fg=p.light.fg[4], bg=p.c85.blue }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
        Search       { fg=p.light.fg[4], bg=p.c85.yellow }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
        Substitute   { fg=c.red, bg=p.c85.yellow, Italic }, -- |:substitute| replacement text highlighting
        SpecialKey   { fg=c.red, Bold }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
        SpellBad     { fg=c.red, Underline }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
        SpellCap     { fg=c.orange, Underline }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
        SpellLocal   { fg=c.orange, Underline }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
        SpellRare    { fg=c.yellow, Underline }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
        StatusLine   { bg=bg[3], fg=fg[4], Bold}, -- status line of current window
        StatusLineNC { bg=bg[1], fg=fg[2]}, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
        -- TabLine      { }, -- tab pages line, not active tab page label
        -- TabLineFill  { }, -- tab pages line, where there are no labels
        -- TabLineSel   { }, -- tab pages line, active tab page label
        Title        { fg=fg[5] }, -- titles for output from ":set all", ":autocmd" etc.
        Visual       { bg=bg[4] }, -- Visual mode selection
        VisualNOS    { bg=bg[3] }, -- Visual mode selection when vim is "Not Owning the Selection".
        WarningMsg   { fg=c.red }, -- warning messages
        Whitespace   { fg=fg[1]}, -- "nbsp", "space", "tab" and "trail" in 'listchars'
        -- WildMenu     { }, -- current match in 'wildmenu' completion

        -- These groups are not listed as default vim groups,
        -- but they are defacto standard group names for syntax highlighting.
        -- commented out groups should chain up to their "preferred" group by
        -- default,
        -- Uncomment and edit if you want more specific syntax highlighting.

        Constant       { fg=c.magenta }, -- (preferred) any constant
        String         { fg=c.cyan }, --   a string constant: "this is a string"
        Character      { fg=c.spring, }, --  a character constant: 'c', '\n'
        Number         { fg=c.violet }, --   a number constant: 234, 0xff
        Float          { fg=c.violet }, --    a floating point constant: 2.3e10
        Boolean        { fg=c.rose }, --  a boolean constant: TRUE, false

        Identifier     { fg=c.yellow}, -- (preferred) any variable name
        Function       { fg=c.blue}, -- function name (also: methods for classes)

        Statement      { fg=c.green }, -- (preferred) any statement
        Conditional    { fg=c.rose }, --  if, then, else, endif, switch, etc.
        Repeat         { fg=c.orange }, --   for, do, while, etc.
        Label          { fg=c.yellow }, --    case, default, etc.
        Operator       { fg=c.blue, Bold }, -- "sizeof", "+", "*", etc.
        Keyword        { fg=c.violet }, --  any other keyword
        Exception      { fg=c.magenta, Bold }, --  try, catch, throw

        PreProc        { fg=c.orange }, -- (preferred) generic Preprocessor
        Include        { fg=c.red, Italic }, --  preprocessor #include
        Define         { fg=c.violet, Italic }, --   preprocessor #define
        Macro          { fg=c.violet, Italic }, --    same as Define
        PreCondit      { Conditional }, --  preprocessor #if, #else, #endif, etc.

        Type           { fg=c.yellow }, -- (preferred) int, long, char, etc.
        StorageClass   { fg=c.green }, -- static, register, volatile, etc.
        Structure      { fg=c.spring }, --  struct, union, enum, etc.
        -- Typedef        { fg=c.violet }, --  A typedef

        Special        { fg=c.red }, -- (preferred) any special symbol
        SpecialChar    { fg=c.red, Bold }, --  special character in a constant
        Tag            { fg=c.blue, Underline }, --    you can use CTRL-] on this
        Delimiter      { fg=c.red }, --  character that needs attention
        SpecialComment { fg=c.orange }, -- special things inside a comment
        Debug          { fg=c.rose }, --    debugging statements

        -- ("Ignore", below, may be invisible...)
        Ignore         { fg=fg[1] }, -- (preferred) left blank, hidden  |hl-Ignore|

        Error          { fg=c.red }, -- (preferred) any erroneous construct
        Todo           { fg=c.yellow, Bold }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX

        -- -------------------------------------------------------------------
        -- Treesitter Groups
        -- These groups are for the neovim tree-sitter highlights.
        -- As of writing, tree-sitter support is a WIP, group names may change.
        -- By default, most of these groups link to an appropriate Vim group,
        -- TSError -> Error for example, so you do not have to define these unless
        -- you explicitly want to support Treesitter's improved syntax awareness.
        -- -------------------------------------------------------------------
        TSComment            { Comment },    -- For comment blocks.
        TSText               { fg=fg[4] },    -- For strings considered text in a markup language.
        TSTextReference      { fg=fg[3] }, -- footnote, citations, etc.
        TSMath               { fg=c.yellow}, -- mathenv
        TSEmphasis           { fg=fg[5], Italic },    -- For text to be represented with emphasis.
        TSUnderline          { Underline },    -- For text to be represented with an underline.
        -- TSStrike             { gui='strikethrough' },    -- For strikethrough text.
        TSTitle              { fg=fg[5] },    -- Text that is part of a title.
        TSLiteral            { fg=c.cyan },    -- Literal text.
        TSURI                { fg=c.blue, Underline },    -- Any URI like a link or email.
        TSAttribute          { fg=c.orange },
        -- types
        TSBoolean            { Boolean },    -- For booleans.
        TSCharacter          { Character },    -- For characters.
        TSString             { String },    -- For strings.
        TSStringSpecial      { fg=c.yellow},
        TSStringRegex        { fg=c.orange },    -- For regexes.
        TSStringEscape       { fg=dim.red },    -- For escape characters within a string.
        TSFloat              { Float },    -- For floats.
        TSNumber             { Number },    -- For all numbers
        --
        TSConstructor        { fg=c.blue, Bold },    -- For constructor calls and definitions: ` { }` in Lua, and Java constructors.
        TSConditional        { Conditional },    -- For keywords related to conditionnals.
        TSConstant           { Constant };    -- For constants
        TSConstBuiltin       { fg=c.rose, Italic },    -- For constant that are built in the language: `nil` in Lua.
        TSConstMacro         { fg=c.rose, Bold },    -- For constants that are defined by macros: `NULL` in C.
        TSError              { fg=dim.red },    -- For syntax/parser errors.
        TSException          { Exception },    -- For exception related keywords.
        TSFunction           { Function },    -- For function (calls and definitions).
        TSFuncBuiltin        { fg=c.blue, Italic },    -- For builtin functions: `table.insert` in Lua.
        TSFuncMacro          { fg=c.blue, Bold },    -- For macro defined fuctions (calls and definitions): each `macro_rules` in Rust.
        TSMethod             { fg=c.blue },    -- For method calls and definitions.
        TSOperator           { fg=c.orange},    -- For any operator: `+`, but also `->` and `*` in C.
        TSInclude            { Include },    -- For includes: `#include` in C, `use` or `extern crate` in Rust, or `require` in Lua.
        TSKeyword            { fg=c.violet },    -- For keywords that don't fall in previous categories.
        TSKeywordFunction    { fg=c.violet, Italic },    -- For keywords used to define a fuction.
        TSKeywordOperator { fg=c.orange, Italic }, -- unary and binary operators that are english words
        TSKeywordReturn   { fg=c.red, Italic },
        TSLabel              { fg=c.orange },    -- For labels: `label:` in C and `:label:` in Lua.
        TSNamespace          { fg=c.yellow, Bold },    -- For identifiers referring to modules and namespaces.
        -- TSNone               { },    -- per docs: Do not change
        TSParameter          { fg=c.green },    -- For parameters of a function.
        TSParameterReference { fg=c.green },    -- For references to parameters of a function.
        TSField              { fg=c.yellow },    -- For fields.
        -- TSProperty           { },    -- Same as `TSField`.
        TSPunctDelimiter     { fg=c.rose},    -- For delimiters ie: `.`
        TSPunctBracket       { fg=c.red },    -- For brackets and parens.
        TSPunctSpecial       { fg=c.magenta },    -- For special punctutation that does not fall in the catagories before.
        TSRepeat             { Repeat },    -- For keywords related to loops.
        TSSymbol             { fg=c.red },    -- For identifiers referring to symbols or atoms.
        TSType               { Type },    -- For types.
        TSTypeBuiltin        { fg=c.yellow, Italic },    -- For builtin types.
        TSVariable           { fg=fg[4] },    -- Any variable name that does not have another highlight.
        TSVariableBuiltin    { fg=c.orange, Italic},    -- Variable names that are defined by the languages, like `this` or `self`.

        TSTag                { fg=c.violet },    -- Tags like html tag names.
        TSTagAttribute       { TSParameter },    -- html tag attribute
        TSTagDelimiter       { Delimiter },    -- Tag delimiter like `<` `>` `/`
        --
        TSEnvironment { fg=c.violet }, -- text environments in markup languages, e.g., \begin in LaTeX.
        TSEnvironmentName { fg=c.yellow }, -- e.g., theorem in \begin{theorem} block in LaTeX.
        --
        -- NOTE: This is just a note.
        -- TODO: Hellow
        -- FIXME: Oh no!
        -- WARNING: Error
        TSNote { fg=c.green, Italic }, -- informational note
        TSWarning { fg=c.orange, Italic}, -- warning note
        TSDanger { fg=c.red, Italic }, -- danger note

        -- -------------------------------------------------------------------
        -- LSP groups
        -- These groups are for the native LSP client. Some other LSP clients may
        -- use these groups, or use their own. Consult your LSP client's
        -- documentation.
        -- -------------------------------------------------------------------


        -- LspReferenceText                     { }, -- used for highlighting "text" references
        -- LspReferenceRead                     { }, -- used for highlighting "read" references
        -- LspReferenceWrite                    { }, -- used for highlighting "write" references

        -- LspDiagnosticsDefaultError           { }, -- Used as the base highlight grou Other LspDiagnostic highlights link to this by default (except Underline)
        -- LspDiagnosticsDefaultWarning         { }, -- Used as the base highlight grou Other LspDiagnostic highlights link to this by default (except Underline)
        -- LspDiagnosticsDefaultInformation     { }, -- Used as the base highlight grou Other LspDiagnostic highlights link to this by default (except Underline)
        -- LspDiagnosticsDefaultHint            { }, -- Used as the base highlight grou Other LspDiagnostic highlights link to this by default (except Underline)

        -- LspDiagnosticsVirtualTextError       { }, -- Used for "Error" diagnostic virtual text
        -- LspDiagnosticsVirtualTextWarning     { }, -- Used for "Warning" diagnostic virtual text
        -- LspDiagnosticsVirtualTextInformation { }, -- Used for "Information" diagnostic virtual text
        -- LspDiagnosticsVirtualTextHint        { }, -- Used for "Hint" diagnostic virtual text

        -- LspDiagnosticsUnderlineError         { }, -- Used to underline "Error" diagnostics
        -- LspDiagnosticsUnderlineWarning       { }, -- Used to underline "Warning" diagnostics
        -- LspDiagnosticsUnderlineInformation   { }, -- Used to underline "Information" diagnostics
        -- LspDiagnosticsUnderlineHint          { }, -- Used to underline "Hint" diagnostics

        -- LspDiagnosticsFloatingError          { }, -- Used to color "Error" diagnostic messages in diagnostics float
        -- LspDiagnosticsFloatingWarning        { }, -- Used to color "Warning" diagnostic messages in diagnostics float
        -- LspDiagnosticsFloatingInformation    { }, -- Used to color "Information" diagnostic messages in diagnostics float
        -- LspDiagnosticsFloatingHint           { }, -- Used to color "Hint" diagnostic messages in diagnostics float

        -- LspDiagnosticsSignError              { }, -- Used for "Error" signs in sign column
        -- LspDiagnosticsSignWarning            { }, -- Used for "Warning" signs in sign column
        -- LspDiagnosticsSignInformation        { }, -- Used for "Information" signs in sign column
        -- LspDiagnosticsSignHint               { }, -- Used for "Hint" signs in sign column

        -- LspCodeLens                          { }, -- Used to color the virtual text of the codelens


    }
end)

-- return our parsed theme for extension or use else where.
return theme

-- vi:nowrap
