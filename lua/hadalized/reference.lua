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
local hsl = lush.hsl

local defs = {
    hues8 = {
        red     = 025,
        orange  = 055,
        yellow  = 110,
        green   = 140,
        cyan    = 185,
        blue    = 245,
        violet  = 290,
        magenta = 340,
    },
    l55s75 = {
        red = hsl('#d35450'),
        orange = hsl('#bd6d2f'),
        yellow = hsl('#88892f'),
        green = hsl('#58964a'),
        cyan = hsl('#33968b'),
        blue = hsl('#388ac9'),
        violet=hsl('#856ce3'),
        magenta = hsl('#cb49a8'),
    },
    l60s75 = {
        red = hsl('#e0645e'),
        orange = hsl('#cd7938'),
        yellow = hsl('#969735'),
        green = hsl('#61a452'),
        cyan = hsl('#3aa499'),
        blue = hsl('#4498d8'),
        violet = hsl('#917cea'),
        magenta = hsl('#d859b5'),
    },
    l65s75 = {
        red = hsl('#e97770'),
        orange = hsl('#dc8545'),
        yellow = hsl('#a3a43c'),
        green = hsl('#6bb35b'),
        cyan = hsl('#41b3a6'),
        blue = hsl('#55a5e5'),
        violet = hsl('#9e8def'),
        magenta = hsl('#e26dbf'),
    },
    l85s75 = {
        red = hsl('#f8c7c2'),
        orange = hsl('#f9caab'),
        yellow = hsl('#dadc6c'),
        green = hsl('#9fec8e'),
        cyan = hsl('#77ecde'),
        blue = hsl('#b6d9f9'),
        violet = hsl('#d3cff9'),
        magenta = hsl('#f4c4e3'),
    },
    h220s15 = {
        l05 = hsl('#06090a'),
        l07 = hsl('#0a0f11'),
        l08 = hsl('#0d1214'),
        l10 = hsl('#111719'),
        l12 = hsl('#161d1f'),
        l15 = hsl('#1c2427'),
        l17 = hsl('#20292c'),
        l18 = hsl('#222b2e'),
        l20 = hsl('#263033'),
        l25 = hsl('#303c40'),
        l30 = hsl('#3b484d'),
        l35 = hsl('#45555a'),
        l40 = hsl('#506167'),
        l45 = hsl('#5b6e74'),
        l50 = hsl('#677b82'),
        l55 = hsl('#73888f'),
        l60 = hsl('#80959c'),
        l65 = hsl('#8da2a9'),
        l70 = hsl('#9bafb6'),
        l75 = hsl('#aabdc3'),
        l80 = hsl('#bacacf'),
        l83 = hsl('#c4d2d7'),
        l85 = hsl('#cad7db'),
        l88 = hsl('#d5dfe3'),
        l90 = hsl('#dce4e7'),
        l92 = hsl('#e3eaec'),
        l93 = hsl('#e6ecee'),
        l95 = hsl('#edf2f3'),
    },
    h220s25 = {
        l05 = hsl('#05090b'),
        l07 = hsl('#081012'),
        l08 = hsl('#0a1315'),
        l10 = hsl('#0e181b'),
        l12 = hsl('#121d21'),
        l15 = hsl('#182529'),
        l17 = hsl('#1c2a2e'),
        l20 = hsl('#213136'),
        l25 = hsl('#2a3d43'),
        l28 = hsl('#30454b'),
        l30 = hsl('#344a51'),
        l35 = hsl('#3e565e'),
        l40 = hsl('#48636c'),
        l45 = hsl('#52707a'),
        l50 = hsl('#5d7d87'),
        l55 = hsl('#698a95'),
        l60 = hsl('#7597a3'),
        l65 = hsl('#82a5b0'),
        l70 = hsl('#90b2bd'),
        l75 = hsl('#a0bfc9'),
        l80 = hsl('#b1ccd5'),
        l85 = hsl('#c4d9e0'),
        l90 = hsl('#d7e6ea'),
        l95 = hsl('#ebf2f5'),
    },
    h220s05 = {
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
    h90s05 = {
        l75 = hsl('#adaba5'),
        l80 = hsl('#c8c6c2'),
        l85 = hsl('#d6d4d1'),
        l88 = hsl('#deddda'),
        l90 = hsl('#e3e2e0'),
        l93 = hsl('#ecebe9'),
        l95 = hsl('#f1f1ef'),
        l97 = hsl('#f7f6f6'),
    },
}

-- Different theme variants in light / dark pairs, e.g., to support
-- multiple contrast or saturation values.
local palettes = {
    default = {
        -- accents
        -- l65s75
        red      = defs.l60s75.red,
        orange   = defs.l60s75.orange,
        yellow   = defs.l60s75.yellow,
        green    = defs.l60s75.green,
        cyan     = defs.l60s75.cyan,
        blue     = defs.l60s75.blue,
        violet   = defs.l60s75.violet,
        magenta  = defs.l60s75.magenta,
        dark0 = defs.h220s25.l07,
        dark1 = defs.h220s25.l12,
        dark2 = defs.h220s25.l17,
        gray0 = defs.h220s05.l25,
        gray1 = defs.h220s05.l50,
        gray2 = defs.h220s05.l75,
        light0 = defs.h220s15.l85,
        light1 = defs.h220s15.l90,
        light2 = defs.h220s15.l92,
    },
}

-- okhsl hue values for color.
local hues11 = {
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
}

local hues8_equal = {
    red = 25,
    orange = 70,
    yellow = 115,
    green = 160,
    cyan = 205,
    blue = 250,
    violet = 295,
    magenta = 340,

}

local hues8 = {
    red     = 025,
    orange  = 055,
    yellow  = 110,
    green   = 140,
    cyan    = 185,
    blue    = 245,
    violet  = 290,
    magenta = 340,

}


-- okhsl(h, 100, l) for each hue value in hues.
-- Static colors used in both light and dark modes.
local colors = {
    l45 = {
        red     = hsl('#c80020'),
        orange  = hsl('#a25200'),
        yellow  = hsl('#6f6f00'),
        green   = hsl('#4e7900'),
        spring  = hsl('#007f47'),
        cyan    = hsl('#007f47'),
        blue    = hsl('#0070b1'),
        violet  = hsl('#7516ff'),
        magenta = hsl('#af00a9'),
        cerise  = hsl('#ba0087'),
        rose    = hsl('#c10065'),
    },
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
    l55s100 = {
        red     = hsl('#f60029'),
        orange  = hsl('#c76600'),
        yellow  = hsl('#898a00'),
        green_old   = hsl('#629600'),
        spring  = hsl('#009d5a'),
        green = hsl('#2f9e00'),  -- 140
        cyan    = hsl('#00988c'),
        blue    = hsl('#008ad9'),
        violet  = hsl('#885eff'),
        magenta_old = hsl('#d700d0'),
        cerise  = hsl('#e400a6'),
        rose    = hsl('#ed007e'),
        magenta = hsl('#e000b4'),  -- 340
        green145 = hsl('#00a02a'),
    },
    -- okhsl(h, 100, 60)
    l60s100 = {
        red     = hsl('#ff3b41'),
        orange  = hsl('#da7000'),
        yellow  = hsl('#979700'),
        green   = hsl('#6ca500'),
        green140 = hsl('#34ad00'), -- 140
        green145 = hsl('#00af2f'), -- 145
        spring  = hsl('#00ad63'),
        cyan    = hsl('#00a79a'),
        blue    = hsl('#0098ee'),
        violet  = hsl('#9374ff'),
        magenta_old = hsl('#eb00e4'),
        magenta = hsl('#f500c5'),  -- 340
        cerise  = hsl('#f900b7'),
        rose    = hsl('#ff1f8b'),
    },
    l60s75 = {
        red = hsl('#e0645e'),
        orange = hsl('#cd7938'),
        yellow = hsl('#969735'),
        green = hsl('#61a452'),
        cyan = hsl('#3aa499'),
        blue = hsl('#4498d8'),
        violet = hsl('#917cea'),
        magenta = hsl('#d859b5'),

    },
    l65s75 = {
        red = hsl('#e97770'),
        orange = hsl('#dc8545'),
        yellow = hsl('#a3a43c'),
        magenta = hsl('#e26dbf'),

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
        cerise  = hsl('#ff47c0'),
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
    l85s75 = {
        red = hsl('#f8c7c2'),
        orange = hsl('#f9caab'),
        yellow = hsl('#dadc6c'),
        green = hsl('#9fec8e'),
        cyan = hsl('#77ecde'),
        blue = hsl('#b6d9f9'),
        violet = hsl('#d3cff9'),
        magenta = hsl('#f4c4e3'),
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
            l03 = hsl('#020405'),
            l05 = hsl('#000b0f'),
            l07 = hsl('#041014'),
            l08 = hsl('#00141b'),
            l10 = hsl('#001a22'),
            l12 = hsl('#001f28'),
            l15 = hsl('#002732'),
            l20 = hsl('#003441'),
            l25 = hsl('#004151'),
        },
        s75 = {
            l05 = hsl('#010a0f'),
            l10 = hsl('#031a20'),
            l15 = hsl('#062730'),
            l20 = hsl('#0b343f'),
            l25 = hsl('#10404e'),
        },
        s50 = {
            l05 = hsl('#020a0d'),
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
            l05 = hsl('#05090b'),
            l08 = hsl('#0a1315'),
            l10 = hsl('#0e181b'),
            l12 = hsl('#121d21'),
            l15 = hsl('#182529'),
            l20 = hsl('#213136'),
            l25 = hsl('#2a3d43'),
            l28 = hsl('#30454b'),
            l30 = hsl('#344a51'),
            l35 = hsl('#3e565e'),
            l40 = hsl('#48636c'),
            l45 = hsl('#52707a'),
            l50 = hsl('#5d7d87'),
            l55 = hsl('#698a95'),
            l60 = hsl('#7597a3'),
            l65 = hsl('#82a5b0'),
            l70 = hsl('#90b2bd'),
            l75 = hsl('#a0bfc9'),
            l80 = hsl('#b1ccd5'),
            l85 = hsl('#c4d9e0'),
            l90 = hsl('#d7e6ea'),
            l95 = hsl('#ebf2f5'),
        },
        s20 = {
            l05 = hsl('#05090b'),
            l10 = hsl('#10181a'),
            l15 = hsl('#1a2428'),
            l20 = hsl('#243135'),
            l25 = hsl('#2d3d42'),

        },
        s15 = {
            l05 = hsl('#06090a'),
            l08 = hsl('#0d1214'),
            l10 = hsl('#111719'),
            l12 = hsl('#161d1f'),
            l15 = hsl('#1c2427'),
            l20 = hsl('#263033'),
            l25 = hsl('#303c40'),
            l30 = hsl('#3b484d'),
            l35 = hsl('#45555a'),
            l40 = hsl('#506167'),
            l45 = hsl('#5b6e74'),
            l50 = hsl('#677b82'),
            l55 = hsl('#73888f'),
            l60 = hsl('#80959c'),
            l65 = hsl('#8da2a9'),
            l70 = hsl('#9bafb6'),
            l75 = hsl('#aabdc3'),
            l80 = hsl('#bacacf'),
            l85 = hsl('#cad7db'),
            l90 = hsl('#dce4e7'),
            l95 = hsl('#edf2f3'),

        },
        s10 = {
            l05 = hsl('#07090a'),
            l08 = hsl('#0e1213'),
            l10 = hsl('#131718'),
            l12 = hsl('#171c1e'),
            l15 = hsl('#1e2425'),
            l20 = hsl('#293032'),
            l25 = hsl('#333c3e'),
            l30 = hsl('#3e484b'),
            l35 = hsl('#495457'),
            l40 = hsl('#556064'),
            l45 = hsl('#606d71'),
            l50 = hsl('#6c7a7e'),
            l55 = hsl('#79878b'),
            l60 = hsl('#859499'),
            l65 = hsl('#93a1a6'),
            l70 = hsl('#a1aeb3'),
            l75 = hsl('#afbbc0'),
            l80 = hsl('#bec9cc'),
            l85 = hsl('#ced6d9'),
            l90 = hsl('#dee4e6'),
            l95 = hsl('#eef1f2'),
        },
        -- NOTE: Main neutral base.
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
            l75 = hsl('#c1b9a3'),
            l80 = hsl('#cdc6b3'),
            l85 = hsl('#dad4c5'),
            l90 = hsl('#e6e2d8'),
            l93 = hsl('#eeebe3'),
            l95 = hsl('#f3f1eb'),
            l97 = hsl('#f8f6f3'),

        },
        s15 = {
            l75 = hsl('#bfb9a9'),
            l80 = hsl('#ccc6b8'),
            l85 = hsl('#d8d4c9'),
            l90 = hsl('#e5e2db'),
            l93 = hsl('#edebe5'),
            l95 = hsl('#f2f1ed'),
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
            l75 = hsl('#adaba5'),
            l80 = hsl('#c8c6c2'),
            l85 = hsl('#d6d4d1'),
            l88 = hsl('#deddda'),
            l90 = hsl('#e3e2e0'),
            l93 = hsl('#ecebe9'),
            l95 = hsl('#f1f1ef'),
            l97 = hsl('#f7f6f6'),
        },
        s00 = {
            l75 = hsl('#b9b9b9'),
            l80 = hsl('#c7c7c6'),
            l85 = hsl('#d4d4d4'),
            l90 = hsl('#e2e2e2'),
            l95 = hsl('#f1f1f1')

        }
    },
}
