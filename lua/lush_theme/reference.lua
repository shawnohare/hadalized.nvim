-- ---------------------------------------------------------------------------
-- solarized reference values
-- ---------------------------------------------------------------------------
--
-- --------|----------|----------|-----------|--------------------------------
-- NAME    | HEX      | L*A*B    | sRGB      |
-- --------|----------|----------|-----------|--------------------------------
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
--
local lush = require('lush')
local hsluv = lush.hsluv

 local okhsl9065 = {
     red     = hsluv(014, 88, 63), -- 025, '#f66c66'
     orange  = hsluv(033, 93, 64), -- 055, '#3e77f28'
     yellow  = hsluv(086, 96, 66), -- 110, '#a4a51c'
     green   = hsluv(128, 82, 67), -- 140, '#5ab743'
     cyan    = hsluv(192, 96, 67), -- 195, '#20b4b4'
     blue    = hsluv(244, 89, 65), -- 245, '#3ea5f2'
     violet  = hsluv(265, 95, 64), -- 280, '#8d91fa'
     magenta = hsluv(311, 80, 62), -- 330, '#ea58e2'
     rose    = hsluv(353, 92, 62), -- 360, '#f85f99'
 }

 local okhsl9060 = {
     red     = hsluv(013, 82, 57), -- 025, '#f05250'
     orange  = hsluv(033, 95, 59), -- 055, '#d6731c'
     yellow  = hsluv(086, 96, 61), -- 110, '#96971a'
     green   = hsluv(124, 81, 62), -- 140, '#52a83e'
     cyan    = hsluv(192, 96, 61), -- 195, '#1da5a5'
     blue    = hsluv(245, 93, 60), -- 245, '#2b98e5'
     violet  = hsluv(266, 95, 59), -- 280, '#7f80f9'
     magenta = hsluv(311, 83, 56), -- 330, '#de41d7'
     rose    = hsluv(353, 88, 57), -- 360, '#f43f8b'
 }

 -- main (neutral) colors, okhsl(*, 90, 65)
 local c2 = {
     red     = hsluv(014, 88, 63), -- 025, '#f66c66'
     orange  = hsluv(033, 93, 64), -- 055, '#3e77f28'
     yellow  = hsluv(086, 96, 66), -- 110, '#a4a51c'
     green   = hsluv(128, 82, 67), -- 140, '#5ab743'
     cyan    = hsluv(192, 96, 67), -- 195, '#20b4b4'
     blue    = hsluv(244, 89, 65), -- 245, '#3ea5f2'
     violet  = hsluv(265, 95, 64), -- 280, '#8d91fa'
     magenta = hsluv(311, 80, 62), -- 330, '#ea58e2'
     rose    = hsluv(353, 92, 62), -- 360, '#f85f99'
 }

 dim colors, okhsl(*, 90, 45)
 local dim = {
     red     = hsluv(012, 80, 42), -- 025 #bd2a2e
     orange  = hsluv(032, 97, 44), -- 055 #a0530d
     yellow  = hsluv(086, 95, 45), -- 110 #6f6f11
     green   = hsluv(124, 80, 46), -- 140 #3c7c2d
     cyan    = hsluv(192, 96, 46), -- 195 #14797a
     blue    = hsluv(245, 97, 45), -- 245 #1170ae
     violet  = hsluv(268, 87, 42), -- 280 #5a4ae7
     magenta = hsluv(310, 95, 41), -- 330 #ac16a6
     rose    = hsluv(353, 94, 42), -- 360 #bd1766
 }


 okhsl(*, 90, 50)
 local dim = {
     red     = hsluv(016, 84, 52), -- #e04730
     orange  = hsluv(032, 96, 49), -- #b25d10
     yellow  = hsluv(086, 96, 50), -- #7c7c14
     green   = hsluv(124, 80, 52), -- #448a33
     cyan    = hsluv(192, 96, 51), -- #178888
     blue    = hsluv(245, 97, 58), -- #167dc1
     violet  = hsluv(267, 91, 48), -- #655bf0
     magenta = hsluv(310, 93, 46), -- #be20b8
     rose    = hsluv(353, 92, 47), -- #d11f72
 }



 okhsl(*, 90, 70)
 color2 = {
     red     = hsluv(015, 92, 68), -- 025, '#fa847c'
     orange  = hsluv(034, 87, 69), -- 055, '#f58d3b'
     yellow  = hsluv(086, 96, 71), -- 110, '#b2b31e'
     green   = hsluv(124, 83, 72), -- 140, '#61c748'
     cyan    = hsluv(192, 96, 72), -- 195, '#23c3c3'
     blue    = hsluv(242, 92, 70), -- 245, '#5cb3f8'
     violet  = hsluv(264, 96, 69), -- 280, '#9ca1fb'
     magenta = hsluv(312, 80, 67), -- 330, '#ed77e5'
     rose    = hsluv(353, 94, 68), -- 360, '#fb7ba7'
 },


 bright colors, okhsl(*, 90, 75)
 local br = {
     red     = hsluv(016, 94, 74), -- 025 #fb9b93
     orange  = hsluv(036, 91, 74), -- 055 #faa060
     yellow  = hsluv(086, 96, 76), -- 110 #c0c121
     green   = hsluv(124, 83, 77), -- 140 #68d74d
     cyan    = hsluv(192, 96, 77), -- 195 #28d2d2
     blue    = hsluv(241, 94, 75), -- 245 #7ac0fb
     violet  = hsluv(263, 96, 74), -- 280 #abb2fc
     magenta = hsluv(312, 79, 73), -- 330 #f092e8
     rose    = hsluv(353, 96, 73), -- 360 #fc94b6
 }


 -------------------------------------------------------------------------
 solarized reference
 -------------------------------------------------------------------------
 local sol = {
     base03  = hsluv(222, 100, 15),
     base02  = hsluv(221, 94, 20),
     base01  = hsluv(215, 35, 45),
     base00  = hsluv(218, 32, 50),
     base10  = hsluv(201, 20, 60),
     base11  = hsluv(192, 15, 65),
     base12  = hsluv(73, 23, 92),
     base13  = hsluv(71, 76, 97),
     red     = hsluv(13, 82, 49),
     orange  = hsluv(21, 95, 49),
     yellow  = hsluv(59, 100, 60),
     green   = hsluv(97, 100, 60),
     cyan    = hsluv(182, 92, 60),
     blue    = hsluv(245, 93, 56),
     violet  = hsluv(264, 57, 51),
     magenta = hsluv(348, 81, 50),
 }


 -------------------------------------------------------------------------
 Compute some bg:fg contrast ratios.
 -------------------------------------------------------------------------
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

 ---------------------------------------------------------------------------
 palette
 Colors are drawn from the okhsl(h, 100, l) color space
 ---------------------------------------------------------------------------

 okhsl(h, 100, l).
 Static colors used in both light and dark modes.
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
    base93 = hsluv('#e9ebec'), -- s=05
    base95 = hsluv('#f0f1f1'),
    base97 = hsluv('#f6f7f7'),
}


