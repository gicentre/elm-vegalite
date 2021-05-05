port module ConfigTests exposing (elmToJS)

import Browser
import Dict
import Html exposing (Html)
import Html.Attributes
import Html.Events
import Json.Encode
import VegaLite exposing (..)


path : String
path =
    "https://cdn.jsdelivr.net/npm/vega-datasets@2.2/data/"


singleVis : (List a -> ( VLProperty, Spec )) -> Spec
singleVis config =
    let
        data =
            dataFromUrl (path ++ "cars.json") []

        scatterEnc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]
                << color [ mName "Cylinders", mOrdinal ]
                << shape [ mName "Origin" ]
    in
    toVegaLite
        [ title "Car Scatter" []
        , config []
        , data
        , width 200
        , height 200
        , point [ maSize 100 ]
        , scatterEnc []
        ]


histoVis : (List a -> ( VLProperty, Spec )) -> Spec
histoVis config =
    let
        data =
            dataFromColumns [ parse [ ( "date", foDate "%Y/%m/%d" ) ] ]
                << dataColumn "rating" (nums [ 4, 5, 4, 2, 6, 4, 5, 8, 4, 9, 3, 7 ])
                << dataColumn "date"
                    (strs
                        [ "2020/01/31"
                        , "2020/02/29"
                        , "2020/03/31"
                        , "2020/04/30"
                        , "2020/05/31"
                        , "2020/06/30"
                        , "2020/07/31"
                        , "2020/08/31"
                        , "2020/09/30"
                        , "2020/10/31"
                        , "2020/11/30"
                        , "2020/12/31"
                        ]
                    )
                << dataColumn "preference" (List.range 1 12 |> List.map toFloat |> nums)

        -- Use a variety of axis scale types for axis config testing
        barEnc =
            encoding
                << position X [ pName "rating", pBin [], pOrdinal ]
                << position Y [ pAggregate opCount ]

        barSpec =
            asSpec [ barEnc [], bar [ maOpacity 0.3 ] ]

        dotEnc =
            encoding
                << position X [ pName "preference", pOrdinal ]
                << position Y [ pName "rating", pQuant, pAxis [ axOrient siRight ] ]

        dotSpec =
            asSpec [ dotEnc [], circle [ maFilled True ] ]

        lineEnc1 =
            encoding
                << position X [ pName "date", pTemporal ]
                << position Y [ pName "preference", pOrdinal, pAxis [ axOrient siRight ] ]

        lineSpec1 =
            asSpec [ lineEnc1 [], line [] ]

        lineEnc2 =
            encoding
                << position X [ pName "date", pTemporal, pAxis [ axOrient siTop ] ]
                << position Y [ pName "preference", pOrdinal ]

        lineSpec2 =
            asSpec [ lineEnc2 [], line [] ]

        lineEnc3 =
            encoding
                << position X [ pName "preference", pOrdinal ]
                << position Y [ pName "date", pTemporal ]

        lineSpec3 =
            asSpec [ lineEnc3 [], line [] ]
    in
    toVegaLite
        [ config []
        , data []
        , hConcat [ barSpec, dotSpec, lineSpec1, lineSpec2, lineSpec3 ]
        ]


compositeVis : (List a -> ( VLProperty, Spec )) -> Spec
compositeVis cfg =
    let
        data =
            dataFromUrl (path ++ "cars.json") []

        scatterEnc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]
                << color [ mName "Cylinders", mOrdinal ]
                << shape [ mName "Origin" ]

        scatterSpec =
            asSpec
                [ title "Car Scatter" []
                , width 200
                , height 200
                , point [ maSize 100 ]
                , scatterEnc []
                ]

        barEnc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pAggregate opCount ]
                << color [ mName "Origin" ]

        streamEnc =
            encoding
                << position X [ pName "Year", pTimeUnit year ]
                << position Y [ pAggregate opCount, pStack stCenter, pAxis [] ]
                << color [ mName "Origin" ]

        barSpec =
            asSpec
                [ title "Car Histogram" []
                , width 200
                , height 200
                , bar []
                , barEnc []
                ]

        streamSpec =
            asSpec
                [ title "Car Streamgraph" []
                , width 200
                , height 200
                , area []
                , streamEnc []
                ]

        res =
            resolve
                << resolution (reScale [ ( chColor, reIndependent ), ( chShape, reIndependent ) ])
    in
    toVegaLite [ cfg [], data, hConcat [ scatterSpec, barSpec, streamSpec ], res [] ]


vbTest : Spec
vbTest =
    let
        data =
            dataFromUrl (path ++ "cars.json") []

        scatterEnc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]
                << color [ mName "Cylinders", mOrdinal ]
                << shape [ mName "Origin" ]

        barEnc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pAggregate opCount ]
                << color [ mName "Origin" ]

        streamEnc =
            encoding
                << position X [ pName "Year", pTimeUnit year ]
                << position Y [ pAggregate opCount, pStack stCenter, pAxis [] ]
                << color [ mName "Origin" ]

        scatterSpec =
            asSpec
                [ title "Car Scatter" []
                , width 200
                , height 200
                , point [ maSize 100 ]
                , scatterEnc []
                ]

        barSpec =
            asSpec
                [ title "Car Histogram" []
                , width 200
                , height 200
                , viewBackground
                    [ viewFill (Just "white")
                    , viewCornerRadius 18
                    , viewStroke (Just "red")
                    , viewStrokeWidth 4
                    , viewStrokeCap caRound
                    , viewStrokeDash [ 10, 10 ]
                    , viewStrokeJoin joBevel
                    ]
                , bar []
                , barEnc []
                ]

        cfg =
            configure
                << configuration
                    (coMarkStyles
                        [ ( "myStyle", [ maFill "red", maFillOpacity 0.1, maStrokeOpacity 1 ] )
                        , ( "mySecondStyle", [ maFill "black", maStroke "blue" ] )
                        ]
                    )
                << configuration (coView [ vicoBackground [ viewFill (Just "#feb") ] ])

        streamSpec =
            asSpec
                [ title "Car Streamgraph" []
                , width 200
                , height 200
                , viewBackground [ viewStyle [ "myStyle", "mySecondStyle" ] ]
                , area []
                , streamEnc []
                ]

        res =
            resolve
                << resolution (reScale [ ( chColor, reIndependent ), ( chShape, reIndependent ) ])
    in
    toVegaLite
        [ cfg []
        , background "yellow"
        , data
        , hConcat [ scatterSpec, barSpec, streamSpec ]
        , res []
        ]


defaultCfg : Spec
defaultCfg =
    configure
        |> compositeVis


darkCfg : Spec
darkCfg =
    configure
        << configuration (coBackground "black")
        << configuration (coFont "serif")
        << configuration (coTitle [ ticoFont "Roboto", ticoColor "#fff" ])
        << configuration (coAxis [ axcoDomainColor "yellow", axcoGridColor "rgb(255,255,200)", axcoGridOpacity 0.2, axcoLabelColor "#fcf", axcoTickColor "white", axcoTitleColor "rgb(200,255,200)" ])
        << configuration (coLegend [ lecoFillColor "#333", lecoStrokeColor "#444", lecoTitleColor "rgb(200,200,200)", lecoLabelColor "white", lecoSymbolFillColor "red", lecoGradientStrokeColor "yellow" ])
        |> compositeVis


markCfg1 : Spec
markCfg1 =
    configure
        << configuration (coMark [ maFilled False ])
        |> compositeVis


markCfg2 : Spec
markCfg2 =
    configure
        << configuration (coMark [ maFilled True, maFill "black", maOpacity 1 ])
        << configuration (coBar [ maFilled True ])
        << configuration (coArea [ maFilled False ])
        << configuration (coPoint [ maFilled True, maStroke "white", maStrokeOpacity 0.2 ])
        |> compositeVis


paddingCfg : Spec
paddingCfg =
    configure
        << configuration (coAutosize [ asFit ])
        << configuration (coPadding (paEdges 90 60 30 0))
        |> singleVis


axisCfg1 : Spec
axisCfg1 =
    configure
        << configuration
            (coAxis
                [ axcoTitleFontStyle "italic"
                , axcoTitleFont "serif"
                , axcoLabelFontStyle "italic"
                , axcoLabelFont "serif"
                , axcoTitleAnchor anEnd
                ]
            )
        |> singleVis


redAxis : List AxisConfig
redAxis =
    [ axcoDomainColor "red", axcoTitleColor "red", axcoLabelColor "red", axcoTickColor "red" ]


axisCfg2 : Spec
axisCfg2 =
    configure
        << configuration (coAxis redAxis)
        |> histoVis


axisCfg3 : Spec
axisCfg3 =
    configure
        << configuration (coAxis redAxis |> coAxisXFilter)
        |> histoVis


axisCfg4 : Spec
axisCfg4 =
    configure
        << configuration (coAxis redAxis |> coAxisYFilter)
        |> histoVis


axisCfg5 : Spec
axisCfg5 =
    configure
        << configuration (coAxisBottom redAxis)
        |> histoVis


axisCfg6 : Spec
axisCfg6 =
    configure
        << configuration (coAxisLeft redAxis)
        |> histoVis


axisCfg7 : Spec
axisCfg7 =
    configure
        << configuration (coAxisTop redAxis)
        |> histoVis


axisCfg8 : Spec
axisCfg8 =
    configure
        << configuration (coAxisRight redAxis)
        |> histoVis


axisCfg9 : Spec
axisCfg9 =
    configure
        << configuration (coAxisBand redAxis)
        |> histoVis


axisCfg10 : Spec
axisCfg10 =
    configure
        << configuration (coAxisQuant redAxis)
        |> histoVis


axisCfg11 : Spec
axisCfg11 =
    configure
        << configuration (coAxisTemporal redAxis)
        |> histoVis


axisCfg12 : Spec
axisCfg12 =
    configure
        << configuration (coAxisDiscrete redAxis)
        |> histoVis


axisCfg13 : Spec
axisCfg13 =
    configure
        << configuration (coAxisPoint redAxis)
        |> histoVis


titleCfg1 : Spec
titleCfg1 =
    let
        data =
            dataFromUrl (path ++ "cars.json") []

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]
    in
    toVegaLite
        [ title "Car\nScatter" [ tiSubtitle "A subtitle\nalso over two lines" ]
        , data
        , width 200
        , height 200
        , enc []
        , circle []
        ]


titleCfg2 : Spec
titleCfg2 =
    let
        data =
            dataFromUrl (path ++ "cars.json") []

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]
    in
    toVegaLite
        [ title "Car\nScatter"
            [ tiSubtitle "A subtitle\nalso over two lines"
            , tiAnchor anEnd
            , tiSubtitleColor "red"
            , tiSubtitleFont "serif"
            , tiSubtitleFontSize 10
            , tiSubtitleFontStyle "italic"
            , tiSubtitleFontWeight (fwValue 900)
            , tiSubtitleLineHeight 18
            , tiSubtitlePadding 60
            ]
        , data
        , width 200
        , height 200
        , enc []
        , circle []
        ]


titleCfg3 : Spec
titleCfg3 =
    let
        data =
            dataFromUrl (path ++ "cars.json") []

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]

        cfg =
            configure
                << configuration
                    (coTitle
                        [ ticoAnchor anEnd
                        , ticoSubtitleColor "red"
                        , ticoSubtitleFont "serif"
                        , ticoSubtitleFontSize 10
                        , ticoSubtitleFontStyle "italic"
                        , ticoSubtitleFontWeight (fwValue 900)
                        , ticoSubtitleLineHeight 18
                        , ticoSubtitlePadding 60
                        ]
                    )
    in
    toVegaLite
        [ cfg []
        , title "Car\nScatter" [ tiSubtitle "A subtitle\nalso over two lines" ]
        , data
        , width 200
        , height 200
        , enc []
        , circle []
        ]


scaleCfg1 : Spec
scaleCfg1 =
    configure
        << configuration (coScale [ sacoXReverse True ])
        |> singleVis


axisLegendCfg1 : Spec
axisLegendCfg1 =
    configure
        << configuration (coLegend [ lecoDisable True ])
        << configuration (coAxis [ axcoDisable True ])
        |> singleVis


interactionCfg1 : Spec
interactionCfg1 =
    let
        cfg =
            configure
                << configuration (coSelection [ ( sePoint, [ seOn "mouseover" ] ) ])

        data =
            dataFromUrl (path ++ "cars.json") []

        ps =
            params
                << param "sel" [ paSelect sePoint [ seEncodings [ chColor ] ] ]

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]
                << color [ mCondition (prParam "sel") [ mName "Origin" ] [ mStr "#ccc" ] ]
    in
    toVegaLite
        [ cfg []
        , data
        , ps []
        , enc []
        , circle [ maSize 200, maStroke "white", maStrokeWidth 0.5, maOpacity 1 ]
        ]


paramCfg1 : Spec
paramCfg1 =
    let
        solid =
            nums []

        shortDash =
            nums [ 2, 2 ]

        longDash =
            nums [ 8, 8 ]

        cfg =
            configure
                << configuration
                    (coView
                        [ vicoBooExpr "clip" vicoClip
                        , vicoNumExpr "cornerRadius" vicoCornerRadius
                        , vicoCursor (cuExpr "cursor")
                        , vicoStrExpr "fill" vicoFill
                        , vicoNumExpr "fillOpacity" vicoFillOpacity
                        , vicoStrExpr "stroke" vicoStroke
                        , vicoNumsExpr "strokeDash" vicoStrokeDash
                        , vicoNumExpr "strokeDashOffset" vicoStrokeDashOffset
                        , vicoNumExpr "strokeMiterLimit" vicoStrokeMiterLimit
                        , vicoNumExpr "strokeOpacity" vicoStrokeOpacity
                        , vicoNumExpr "strokeWidth" vicoStrokeWidth
                        , vicoNumExpr "viewOpacity" vicoOpacity
                        , vicoStrokeCap (caExpr "strokeCap")
                        , vicoStrokeJoin (joExpr "strokeJoin")
                        ]
                    )

        data =
            dataFromColumns []
                << dataColumn "wavelength" (nums [ 250, 300, 420, 450, 500 ])
                << dataColumn "power" (nums [ 1, 2, 4, 1.8, 1.1 ])

        ps =
            params
                << param "clip" [ paValue (boo False), paBind (ipCheckbox []) ]
                << param "cornerRadius" [ paValue (num 0), paBind (ipRange [ inMin 0, inMax 60 ]) ]
                << param "cursor" [ paValue (str "default"), paBind (ipSelect [ inOptions [ "default", "crosshair", "help" ] ]) ]
                << param "fill" [ paValue (str "#ff0"), paBind (ipColor []) ]
                << param "fillOpacity" [ paValue (num 1), paBind (ipRange [ inMin 0, inMax 1 ]) ]
                << param "stroke" [ paValue (str "black"), paBind (ipColor []) ]
                << param "strokeCap" [ paValue (str "butt"), paBind (ipSelect [ inOptions [ "butt", "round", "square" ] ]) ]
                << param "strokeJoin" [ paValue (str "miter"), paBind (ipSelect [ inOptions [ "miter", "round", "bevel" ] ]) ]
                << param "strokeDash" [ paValues solid, paBind (ipSelect [ inDataOptions [ solid, shortDash, longDash ] ]) ]
                << param "strokeDashOffset" [ paValue (num 0), paBind (ipRange [ inMin -30, inMax 30 ]) ]
                << param "strokeMiterLimit" [ paValue (num 0), paBind (ipRange [ inMin 0, inMax 30 ]) ]
                << param "strokeOpacity" [ paValue (num 1), paBind (ipRange [ inMin 0, inMax 1 ]) ]
                << param "strokeWidth" [ paValue (num 6), paBind (ipRange [ inMin 0, inMax 20 ]) ]
                << param "viewOpacity" [ paValue (num 1), paBind (ipRange [ inMin 0, inMax 1 ]) ]

        enc =
            encoding
                << position X [ pName "wavelength", pQuant, pScale [ scDomain (doNums [ 300, 450 ]) ] ]
                << position Y [ pName "power", pQuant ]
    in
    toVegaLite
        [ cfg [], data [], ps [], enc [], line [] ]


paramCfg2 : Spec
paramCfg2 =
    let
        ttl1 =
            strs [ "A medium length title", "over two lines" ]

        ttl2 =
            strs [ "Short title" ]

        ttl3 =
            strs [ "" ]

        ttl4 =
            strs [ "A longer title laid out over a single line." ]

        cfg =
            configure
                << configuration
                    (coTitle
                        [ ticoNumExpr "angle" ticoAngle
                        , ticoStrExpr "color" ticoColor
                        , ticoNumExpr "dx" ticoDx
                        , ticoNumExpr "dy" ticoDy
                        , ticoStrExpr "font" ticoFont
                        , ticoNumExpr "fontSize" ticoFontSize
                        , ticoStrExpr "fontStyle" ticoFontStyle
                        , ticoFontWeight (fwExpr "fontWeight")
                        , ticoFrame (tfExpr "frame")
                        , ticoNumExpr "limit" ticoLimit
                        , ticoNumExpr "lineHeight" ticoLineHeight
                        , ticoNumExpr "offset" ticoOffset
                        , ticoOrient (siExpr "orient")
                        , ticoStrExpr "subtitleFont" ticoSubtitleFont
                        , ticoNumExpr "subtitleFontSize" ticoSubtitleFontSize
                        , ticoStrExpr "subtitleFontStyle" ticoSubtitleFontStyle
                        , ticoSubtitleFontWeight (fwExpr "subtitleFontWeight")
                        , ticoNumExpr "subtitleLineHeight" ticoSubtitleLineHeight
                        , ticoNumExpr "subtitlePadding" ticoSubtitlePadding
                        ]
                    )

        data =
            dataFromColumns []
                << dataColumn "x" (nums [ 1, 2, 3, 4, 5 ])

        ps =
            params
                << param "title" [ paValues ttl1, paBind (ipSelect [ inDataOptions [ ttl1, ttl2, ttl3, ttl4 ] ]) ]
                << param "angle" [ paValue (num 0), paBind (ipRange [ inMin -90, inMax 90 ]) ]
                << param "color" [ paValue (str "black"), paBind (ipColor []) ]
                << param "dx" [ paValue (num 0), paBind (ipRange [ inMin -50, inMax 50 ]) ]
                << param "dy" [ paValue (num 0), paBind (ipRange [ inMin -50, inMax 50 ]) ]
                << param "font" [ paValue (str "sans-serif"), paBind (ipSelect [ inOptions [ "sans-serif", "serif", "monospace" ] ]) ]
                << param "fontSize" [ paValue (num 12), paBind (ipRange [ inMin 0, inMax 50 ]) ]
                << param "fontStyle" [ paValue (str "normal"), paBind (ipSelect [ inOptions [ "normal", "italic" ] ]) ]
                << param "fontWeight" [ paValue (str "normal"), paBind (ipSelect [ inOptions [ "normal", "bold", "lighter" ] ]) ]
                << param "frame" [ paValue (str "bounds"), paBind (ipSelect [ inOptions [ "bounds", "group" ] ]) ]
                << param "limit" [ paValue (num 0), paBind (ipRange [ inMin 0, inMax 300 ]) ]
                << param "lineHeight" [ paValue (num 12), paBind (ipRange [ inMin -60, inMax 60 ]) ]
                << param "offset" [ paValue (num 0), paBind (ipRange [ inMin -60, inMax 60 ]) ]
                << param "orient" [ paValue (str "top"), paBind (ipSelect [ inOptions [ "top", "bottom", "left", "right" ] ]) ]
                << param "subtitleFont" [ paValue (str "sans-serif"), paBind (ipSelect [ inOptions [ "sans-serif", "serif", "monospace" ] ]) ]
                << param "subtitleFontSize" [ paValue (num 12), paBind (ipRange [ inMin 0, inMax 50 ]) ]
                << param "subtitleFontStyle" [ paValue (str "normal"), paBind (ipSelect [ inOptions [ "normal", "italic" ] ]) ]
                << param "subtitleFontWeight" [ paValue (str "normal"), paBind (ipSelect [ inOptions [ "normal", "bold", "lighter" ] ]) ]
                << param "subtitleLineHeight" [ paValue (num 12), paBind (ipRange [ inMin -60, inMax 60 ]) ]
                << param "subtitlePadding" [ paValue (num 0), paBind (ipRange [ inMin -60, inMax 60 ]) ]

        enc =
            encoding
                << position X [ pName "x" ]
    in
    toVegaLite
        [ width 300
        , height 100
        , padding (paSize 80)
        , titleExpr "title" [ tiSubtitle "And this is a\nmultiline\nsubtitle" ]
        , cfg []
        , data []
        , ps []
        , enc []
        , circle []
        ]


paramCfg3 : Spec
paramCfg3 =
    let
        syms1 =
            strs [ "cross", "diamond", "square" ]

        syms2 =
            strs [ "arrow", "triangle", "wedge" ]

        syms3 =
            strs [ "M0,.5L.6,.8L.5,.1L1,-.3L.3,-.4L0,-1L-.3,-.4L-1,-.3L-.5,.1L-.6,.8L0,.5Z" ]

        cfg =
            configure
                << configuration
                    (coScale
                        [ sacoNumExpr "barBandPaddingInner" sacoBarBandPaddingInner
                        , sacoNumExpr "rectBandPaddingInner" sacoRectBandPaddingInner
                        , sacoNumExpr "bandPaddingOuter" sacoBandPaddingOuter
                        , sacoNumExpr "continuousPadding" sacoContinuousPadding
                        , sacoNumExpr "pointPadding" sacoPointPadding
                        , sacoBooExpr "clamp" sacoClamp
                        , sacoBooExpr "round" sacoRound
                        , sacoBooExpr "xReverse" sacoXReverse
                        ]
                    )
                << configuration (coRange [ racoSymbolsExpr "symbols" ])

        data =
            dataFromColumns []
                << dataColumn "x" (strs [ "a", "b", "c", "d", "e", "f", "g", "h", "i" ])
                << dataColumn "y" (nums [ 1, 3, 5, 7, 9, 8, 6, 4, 2 ])
                << dataColumn "y2" (nums [ 15, 14, 13, 12, 11, 10, 9, 8, 7 ])

        ps =
            params
                << param "barBandPaddingInner" [ paValue (num 0.1), paBind (ipRange [ inMin 0, inMax 1 ]) ]
                << param "rectBandPaddingInner" [ paValue (num 0), paBind (ipRange [ inMin 0, inMax 1 ]) ]
                << param "bandPaddingOuter" [ paValue (num 0.05), paBind (ipRange [ inMin 0, inMax 1 ]) ]
                << param "continuousPadding" [ paValue (num 5), paBind (ipRange [ inMin -10, inMax 30 ]) ]
                << param "pointPadding" [ paValue (num 0.5), paBind (ipRange [ inMin 0, inMax 1 ]) ]
                << param "clamp" [ paValue (boo False), paBind (ipCheckbox []) ]
                << param "round" [ paValue (boo False), paBind (ipCheckbox []) ]
                << param "xReverse" [ paValue (boo False), paBind (ipCheckbox []) ]
                << param "symbols" [ paValues syms1, paBind (ipSelect [ inDataOptions [ syms1, syms2, syms3 ] ]) ]

        enc1 =
            encoding
                << position X [ pName "x" ]
                << position Y [ pName "y", pQuant ]
                << color [ mName "x" ]

        enc2 =
            encoding
                << position X [ pName "x" ]
                << position Y [ pName "y", pQuant ]
                << position Y2 [ pName "y2" ]
                << color [ mName "y2", mQuant ]

        enc3 =
            encoding
                << position X [ pName "y2", pQuant ]
                << position Y [ pName "y", pQuant, pScale [ scDomain (doNums [ 0, 8 ]) ] ]
                << color [ mName "x" ]

        enc4 =
            encoding
                << position X [ pName "x" ]
                << position Y [ pName "y", pQuant ]
                << color [ mName "x" ]
                << shape [ mName "x" ]

        spec1 =
            asSpec [ width 300, enc1 [], bar [ maStroke "black" ] ]

        spec2 =
            asSpec [ width 300, enc2 [], rect [ maStroke "black" ] ]

        spec3 =
            asSpec [ width 300, enc3 [], bar [ maStroke "black" ] ]

        spec4 =
            asSpec [ width 300, enc4 [], point [ maSize 300, maFilled True, maStroke "black" ] ]
    in
    toVegaLite [ cfg [], data [], ps [], vConcat [ spec1, spec2, spec3, spec4 ] ]



{- Ids and specifications to be provided to the Vega-Lite runtime. -}


specs : List ( String, Spec )
specs =
    [ ( "default", defaultCfg )
    , ( "dark", darkCfg )
    , ( "mark1", markCfg1 )
    , ( "mark2", markCfg2 )
    , ( "padding", paddingCfg )
    , ( "vbTest", vbTest )
    , ( "axisCfg1", axisCfg1 )
    , ( "axisCfg2", axisCfg2 )
    , ( "axisCfg3", axisCfg3 )
    , ( "axisCfg4", axisCfg4 )
    , ( "axisCfg5", axisCfg5 )
    , ( "axisCfg6", axisCfg6 )
    , ( "axisCfg7", axisCfg7 )
    , ( "axisCfg8", axisCfg8 )
    , ( "axisCfg9", axisCfg9 )
    , ( "axisCfg10", axisCfg10 )
    , ( "axisCfg11", axisCfg11 )
    , ( "axisCfg12", axisCfg12 )
    , ( "axisCfg13", axisCfg13 )
    , ( "titleCfg1", titleCfg1 )
    , ( "titleCfg2", titleCfg2 )
    , ( "titleCfg3", titleCfg3 )
    , ( "scaleCfg1", scaleCfg1 )
    , ( "axisLegendCfg1", axisLegendCfg1 )
    , ( "interactionCfg1", interactionCfg1 )
    , ( "paramCfg1", paramCfg1 )
    , ( "paramCfg2", paramCfg2 )
    , ( "paramCfg3", paramCfg3 )
    ]



{- ---------------------------------------------------------------------------
   BOILERPLATE: NO NEED TO EDIT

   The code below creates an Elm module that opens an outgoing port to Javascript
   and sends both the specs and DOM node to it.
   It allows the source code of any of the generated specs to be selected from
   a drop-down list. Useful for viewing specs that might generate invalid Vega-Lite.
-}


type Msg
    = NewSource String


main : Program () Spec Msg
main =
    Browser.element
        { init = always ( Json.Encode.null, specs |> combineSpecs |> elmToJS )
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }


view : Spec -> Html Msg
view spec =
    Html.div []
        [ Html.select [ Html.Events.onInput NewSource ]
            (( "Select source", Json.Encode.null )
                :: specs
                |> List.map (\( s, _ ) -> Html.option [ Html.Attributes.value s ] [ Html.text s ])
            )
        , Html.div [ Html.Attributes.id "specSource" ] []
        , if spec == Json.Encode.null then
            Html.div [] []

          else
            Html.pre [] [ Html.text (Json.Encode.encode 2 spec) ]
        ]


update : Msg -> Spec -> ( Spec, Cmd Msg )
update msg _ =
    case msg of
        NewSource srcName ->
            ( specs |> Dict.fromList |> Dict.get srcName |> Maybe.withDefault Json.Encode.null, Cmd.none )


port elmToJS : Spec -> Cmd msg
