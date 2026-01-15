"""Named CSS Colors."""

from functools import cache

from hadalized.color import ColorField, ColorMap, parse


class WebColors(ColorMap):
    """Standard CSS named colors as ColorInfo objects.

    Generally there is only a single instance of this class,
    with the values defined lazily in the `get` method.
    """

    pink: ColorField
    lightpink: ColorField
    snow: ColorField
    rosybrown: ColorField
    crimson: ColorField
    lightcoral: ColorField
    indianred: ColorField
    mistyrose: ColorField
    brown: ColorField
    firebrick: ColorField
    salmon: ColorField
    maroon: ColorField
    darkred: ColorField
    red: ColorField
    tomato: ColorField
    orangered: ColorField
    darksalmon: ColorField
    coral: ColorField
    lightsalmon: ColorField
    sienna: ColorField
    chocolate: ColorField
    saddlebrown: ColorField
    seashell: ColorField
    darkorange: ColorField
    sandybrown: ColorField
    peru: ColorField
    peachpuff: ColorField
    linen: ColorField
    orange: ColorField
    bisque: ColorField
    burlywood: ColorField
    tan: ColorField
    antiquewhite: ColorField
    navajowhite: ColorField
    blanchedalmond: ColorField
    papayawhip: ColorField
    moccasin: ColorField
    darkgoldenrod: ColorField
    wheat: ColorField
    oldlace: ColorField
    goldenrod: ColorField
    floralwhite: ColorField
    gold: ColorField
    cornsilk: ColorField
    lemonchiffon: ColorField
    khaki: ColorField
    palegoldenrod: ColorField
    darkkhaki: ColorField
    ivory: ColorField
    beige: ColorField
    lightyellow: ColorField
    lightgoldenrodyellow: ColorField
    olive: ColorField
    yellow: ColorField
    darkolivegreen: ColorField
    olivedrab: ColorField
    yellowgreen: ColorField
    greenyellow: ColorField
    chartreuse: ColorField
    lawngreen: ColorField
    darkgreen: ColorField
    green: ColorField
    lime: ColorField
    limegreen: ColorField
    forestgreen: ColorField
    palegreen: ColorField
    lightgreen: ColorField
    darkseagreen: ColorField
    honeydew: ColorField
    springgreen: ColorField
    seagreen: ColorField
    mediumseagreen: ColorField
    mediumspringgreen: ColorField
    mintcream: ColorField
    mediumaquamarine: ColorField
    aquamarine: ColorField
    turquoise: ColorField
    lightseagreen: ColorField
    mediumturquoise: ColorField
    darkcyan: ColorField
    teal: ColorField
    aqua: ColorField
    cyan: ColorField
    darkslategray: ColorField
    darkslategrey: ColorField
    paleturquoise: ColorField
    lightcyan: ColorField
    darkturquoise: ColorField
    azure: ColorField
    cadetblue: ColorField
    powderblue: ColorField
    lightblue: ColorField
    skyblue: ColorField
    deepskyblue: ColorField
    lightskyblue: ColorField
    aliceblue: ColorField
    steelblue: ColorField
    slategray: ColorField
    slategrey: ColorField
    lightslategray: ColorField
    lightslategrey: ColorField
    dodgerblue: ColorField
    lightsteelblue: ColorField
    cornflowerblue: ColorField
    blue: ColorField
    darkblue: ColorField
    mediumblue: ColorField
    navy: ColorField
    royalblue: ColorField
    midnightblue: ColorField
    mediumslateblue: ColorField
    slateblue: ColorField
    lavender: ColorField
    darkslateblue: ColorField
    ghostwhite: ColorField
    mediumpurple: ColorField
    blueviolet: ColorField
    indigo: ColorField
    rebeccapurple: ColorField
    darkviolet: ColorField
    darkorchid: ColorField
    mediumorchid: ColorField
    thistle: ColorField
    plum: ColorField
    violet: ColorField
    fuchsia: ColorField
    magenta: ColorField
    darkmagenta: ColorField
    purple: ColorField
    orchid: ColorField
    mediumvioletred: ColorField
    hotpink: ColorField
    lavenderblush: ColorField
    deeppink: ColorField
    palevioletred: ColorField
    # Zero Hue
    black: ColorField
    darkgray: ColorField
    darkgrey: ColorField
    dimgray: ColorField
    dimgrey: ColorField
    gainsboro: ColorField
    gray: ColorField
    grey: ColorField
    lightgray: ColorField
    lightgrey: ColorField
    silver: ColorField
    white: ColorField
    whitesmoke: ColorField
    transparent: ColorField
    # Added
    offblack: ColorField
    offdarkgray: ColorField
    neutralgray: ColorField
    offlightgray: ColorField
    offwhite: ColorField

    @cache
    @staticmethod
    def get() -> WebColors:
        """Get a singleton instance.

        Returns:
            An cached singleton

        """
        return WebColors(
            pink=parse("oklch(0.86774 0.07354 7.0855)"),
            lightpink=parse("oklch(0.84739 0.08579 9.0865)"),
            snow=parse("oklch(0.98894 0.00534 17.247)"),
            rosybrown=parse("oklch(0.69274 0.0548 18.565)"),
            crimson=parse("oklch(0.57119 0.22194 20.087)"),
            lightcoral=parse("oklch(0.72464 0.13774 21.029)"),
            indianred=parse("oklch(0.61544 0.14415 22.228)"),
            mistyrose=parse("oklch(0.94001 0.03008 25.281)"),
            brown=parse("oklch(0.48061 0.15966 25.562)"),
            firebrick=parse("oklch(0.49677 0.17969 26.815)"),
            salmon=parse("oklch(0.735 0.15151 28.06)"),
            maroon=parse("oklch(0.37669 0.15458 29.234)"),
            darkred=parse("oklch(0.39986 0.16408 29.234)"),
            red=parse("oklch(0.62796 0.25768 29.234)"),
            tomato=parse("oklch(0.69622 0.19552 32.321)"),
            orangered=parse("oklch(0.6602 0.22936 35.403)"),
            darksalmon=parse("oklch(0.75074 0.10818 39.394)"),
            coral=parse("oklch(0.73511 0.16799 40.247)"),
            lightsalmon=parse("oklch(0.79376 0.12483 42.425)"),
            sienna=parse("oklch(0.52648 0.11512 44.604)"),
            chocolate=parse("oklch(0.6344 0.15499 50.266)"),
            saddlebrown=parse("oklch(0.47078 0.11214 50.845)"),
            seashell=parse("oklch(0.97602 0.01425 57.592)"),
            darkorange=parse("oklch(0.75054 0.17911 58.283)"),
            sandybrown=parse("oklch(0.784 0.12691 59.71)"),
            peru=parse("oklch(0.67819 0.12275 62.182)"),
            peachpuff=parse("oklch(0.91125 0.06 63.699)"),
            linen=parse("oklch(0.96024 0.01715 67.622)"),
            orange=parse("oklch(0.79269 0.17103 70.67)"),
            bisque=parse("oklch(0.93286 0.05145 71.849)"),
            burlywood=parse("oklch(0.80454 0.07786 73.417)"),
            tan=parse("oklch(0.78619 0.06382 74.619)"),
            antiquewhite=parse("oklch(0.94669 0.03108 75.219)"),
            navajowhite=parse("oklch(0.9164 0.07301 77.436)"),
            blanchedalmond=parse("oklch(0.94844 0.04493 78.06)"),
            papayawhip=parse("oklch(0.95808 0.03826 80.032)"),
            moccasin=parse("oklch(0.92962 0.06754 81.379)"),
            darkgoldenrod=parse("oklch(0.65207 0.1322 81.572)"),
            wheat=parse("oklch(0.90883 0.0615 83.033)"),
            oldlace=parse("oklch(0.97234 0.02156 83.264)"),
            goldenrod=parse("oklch(0.75157 0.14693 83.988)"),
            floralwhite=parse("oklch(0.98623 0.01422 84.583)"),
            gold=parse("oklch(0.88677 0.18219 95.33)"),
            cornsilk=parse("oklch(0.9773 0.03726 95.439)"),
            lemonchiffon=parse("oklch(0.97781 0.05822 102.16)"),
            khaki=parse("oklch(0.91349 0.11192 102.83)"),
            palegoldenrod=parse("oklch(0.92105 0.07981 103.18)"),
            darkkhaki=parse("oklch(0.76747 0.09804 104.51)"),
            ivory=parse("oklch(0.99598 0.01962 106.75)"),
            beige=parse("oklch(0.96357 0.03278 107)"),
            lightyellow=parse("oklch(0.99201 0.04024 107.11)"),
            lightgoldenrodyellow=parse("oklch(0.97501 0.05184 107.32)"),
            olive=parse("oklch(0.58066 0.12658 109.77)"),
            yellow=parse("oklch(0.96798 0.21101 109.77)"),
            darkolivegreen=parse("oklch(0.49552 0.0896 126.19)"),
            olivedrab=parse("oklch(0.59948 0.13738 126.32)"),
            yellowgreen=parse("oklch(0.78485 0.18374 126.64)"),
            greenyellow=parse("oklch(0.91305 0.23346 130.02)"),
            chartreuse=parse("oklch(0.89026 0.2648 136.01)"),
            lawngreen=parse("oklch(0.88175 0.26307 136.17)"),
            darkgreen=parse("oklch(0.43602 0.14837 142.5)"),
            green=parse("oklch(0.51975 0.17686 142.5)"),
            lime=parse("oklch(0.86644 0.29483 142.5)"),
            limegreen=parse("oklch(0.74187 0.22865 142.83)"),
            forestgreen=parse("oklch(0.5578 0.16878 142.89)"),
            palegreen=parse("oklch(0.90354 0.16242 144.09)"),
            lightgreen=parse("oklch(0.868 0.1558 144.09)"),
            darkseagreen=parse("oklch(0.75086 0.07971 144.73)"),
            honeydew=parse("oklch(0.98484 0.02521 145.38)"),
            springgreen=parse("oklch(0.87493 0.23526 151.02)"),
            seagreen=parse("oklch(0.56853 0.11871 154.95)"),
            mediumseagreen=parse("oklch(0.68404 0.14402 155)"),
            mediumspringgreen=parse("oklch(0.86681 0.20674 156.9)"),
            mintcream=parse("oklch(0.99117 0.01237 164.81)"),
            mediumaquamarine=parse("oklch(0.77669 0.10985 168.82)"),
            aquamarine=parse("oklch(0.91499 0.13039 168.99)"),
            turquoise=parse("oklch(0.82233 0.13074 185.09)"),
            lightseagreen=parse("oklch(0.6912 0.11421 188.96)"),
            mediumturquoise=parse("oklch(0.7868 0.11622 191.56)"),
            darkcyan=parse("oklch(0.57652 0.09841 194.77)"),
            teal=parse("oklch(0.54312 0.09271 194.77)"),
            aqua=parse("oklch(0.9054 0.15455 194.77)"),
            cyan=parse("oklch(0.9054 0.15455 194.77)"),
            darkslategray=parse("oklch(0.40296 0.03772 195.76)"),
            darkslategrey=parse("oklch(0.40296 0.03772 195.76)"),
            paleturquoise=parse("oklch(0.90691 0.06323 196.09)"),
            lightcyan=parse("oklch(0.97786 0.03203 196.64)"),
            darkturquoise=parse("oklch(0.77193 0.13144 196.64)"),
            azure=parse("oklch(0.98895 0.01572 196.9)"),
            cadetblue=parse("oklch(0.65768 0.06501 198.3)"),
            powderblue=parse("oklch(0.87508 0.0502 205.73)"),
            lightblue=parse("oklch(0.85623 0.04894 219.65)"),
            skyblue=parse("oklch(0.81482 0.08192 225.75)"),
            deepskyblue=parse("oklch(0.75535 0.15342 231.64)"),
            lightskyblue=parse("oklch(0.82062 0.09453 236.75)"),
            aliceblue=parse("oklch(0.97514 0.01266 244.25)"),
            steelblue=parse("oklch(0.588 0.09934 245.74)"),
            slategray=parse("oklch(0.5925 0.03092 248.35)"),
            slategrey=parse("oklch(0.5925 0.03092 248.35)"),
            lightslategray=parse("oklch(0.61902 0.0325 248.35)"),
            lightslategrey=parse("oklch(0.61902 0.0325 248.35)"),
            dodgerblue=parse("oklch(0.65201 0.19012 253.21)"),
            lightsteelblue=parse("oklch(0.81362 0.04281 255.03)"),
            cornflowerblue=parse("oklch(0.67462 0.14136 261.34)"),
            blue=parse("oklch(0.45201 0.31321 264.05)"),
            darkblue=parse("oklch(0.28782 0.19944 264.05)"),
            mediumblue=parse("oklch(0.38345 0.26571 264.05)"),
            navy=parse("oklch(0.27115 0.18789 264.05)"),
            royalblue=parse("oklch(0.55985 0.18823 266.4)"),
            midnightblue=parse("oklch(0.28812 0.14363 272.76)"),
            mediumslateblue=parse("oklch(0.60447 0.19389 285.5)"),
            slateblue=parse("oklch(0.54357 0.17123 285.54)"),
            lavender=parse("oklch(0.9309 0.02694 285.86)"),
            darkslateblue=parse("oklch(0.41434 0.12484 286.04)"),
            ghostwhite=parse("oklch(0.98112 0.00927 286.23)"),
            mediumpurple=parse("oklch(0.62518 0.15415 297.27)"),
            blueviolet=parse("oklch(0.53376 0.25031 301.37)"),
            indigo=parse("oklch(0.33898 0.17927 301.68)"),
            rebeccapurple=parse("oklch(0.44027 0.1603 303.37)"),
            darkviolet=parse("oklch(0.51491 0.26067 309.81)"),
            darkorchid=parse("oklch(0.54111 0.22724 311.51)"),
            mediumorchid=parse("oklch(0.62558 0.20244 319.23)"),
            thistle=parse("oklch(0.83329 0.04391 325.96)"),
            plum=parse("oklch(0.78328 0.10776 326.54)"),
            violet=parse("oklch(0.7619 0.18612 327.21)"),
            fuchsia=parse("oklch(0.70167 0.32249 328.36)"),
            magenta=parse("oklch(0.70167 0.32249 328.36)"),
            darkmagenta=parse("oklch(0.4468 0.20535 328.36)"),
            purple=parse("oklch(0.42091 0.19345 328.36)"),
            orchid=parse("oklch(0.70213 0.18126 328.71)"),
            mediumvioletred=parse("oklch(0.55337 0.22165 349.69)"),
            hotpink=parse("oklch(0.7283 0.19708 351.99)"),
            lavenderblush=parse("oklch(0.96833 0.01741 355.1)"),
            deeppink=parse("oklch(0.65493 0.26134 356.94)"),
            palevioletred=parse("oklch(0.67397 0.135 359.97)"),
            # Zero Hue
            black=parse("oklch(0 0 0)"),
            darkgray=parse("oklch(0.73481 0 0)"),
            darkgrey=parse("oklch(0.73481 0 0)"),
            dimgray=parse("oklch(0.52081 0 0)"),
            dimgrey=parse("oklch(0.52081 0 0)"),
            gainsboro=parse("oklch(0.89449 0 0)"),
            gray=parse("oklch(0.59987 0 0)"),
            grey=parse("oklch(0.59987 0 0)"),
            lightgray=parse("oklch(0.86686 0 0)"),
            lightgrey=parse("oklch(0.86686 0 0)"),
            silver=parse("oklch(0.8078 0 0)"),
            white=parse("oklch(1 0 0)"),
            whitesmoke=parse("oklch(0.97015 0 0)"),
            transparent=parse("oklch(0 0 0 / 0)"),
            # Added
            offblack=parse("oklch(0.10 0.01 220)"),
            offdarkgray=parse("oklch(0.30 0.01 220)"),
            neutralgray=parse("oklch(0.50 0.01 220)"),
            offlightgray=parse("oklch(0.70 0.01 220)"),
            offwhite=parse("oklch(0.995 0.01 220)"),
        )
