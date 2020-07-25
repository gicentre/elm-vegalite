port module GalleryLabel exposing (elmToJS)

import Platform
import VegaLite exposing (..)



-- NOTE: All data sources in these examples originally provided at
-- https://github.com/vega/vega-datasets
-- The examples themselves reproduce those at https://vega.github.io/vega-lite/examples/


path : String
path =
    "https://cdn.jsdelivr.net/npm/vega-datasets@2.1/data/"


label1 : Spec
label1 =
    let
        desc =
            description "A simple bar chart with embedded data labels"

        cfg =
            configure
                << configuration (coMarkStyles [ ( "label", [ maAlign haLeft, maBaseline vaMiddle, maDx 3 ] ) ])

        data =
            dataFromColumns []
                << dataColumn "a" (strs [ "A", "B", "C" ])
                << dataColumn "b" (nums [ 28, 55, 43 ])

        enc =
            encoding
                << position X [ pName "b", pQuant ]
                << position Y [ pName "a", pOrdinal ]

        specBar =
            asSpec [ bar [] ]

        specText =
            asSpec [ encoding (text [ tName "b", tQuant ] []), textMark [ maStyle [ "label" ] ] ]
    in
    toVegaLite [ desc, cfg [], data [], enc [], layer [ specBar, specText ] ]


label2 : Spec
label2 =
    let
        desc =
            description "Version of bar chart from https://observablehq.com/@d3/learn-d3-scales."

        cfg =
            configure
                << configuration (coView [ vicoStroke Nothing ])

        data =
            dataFromColumns []
                << dataColumn "fruit" (strs [ "🍊", "🍇", "🍏", "🍌", "🍐", "🍋", "🍎", "🍉" ])
                << dataColumn "count" (nums [ 21, 13, 8, 5, 3, 2, 1, 1 ])

        enc =
            encoding
                << position X
                    [ pName "count"
                    , pQuant
                    , pAxis [ axGrid False, axTitle "" ]
                    ]
                << position Y
                    [ pName "fruit"
                    , pOrdinal
                    , pSort [ soByChannel chX, soDescending ]
                    , pAxis [ axTitle "", axTicks False ]
                    ]

        barEnc =
            encoding
                << color [ mName "count", mQuant, mLegend [] ]

        specBar =
            asSpec [ barEnc [], bar [] ]

        labelEnc =
            encoding
                << text [ tName "count", tQuant ]
                << color
                    [ mDataCondition [ ( expr "datum.count > 10", [ mStr "white" ] ) ]
                        [ mStr "black" ]
                    ]

        specText =
            asSpec [ labelEnc [], textMark [ maAlign haRight, maXOffset -4 ] ]
    in
    toVegaLite [ desc, cfg [], width 400, data [], enc [], layer [ specBar, specText ] ]


label3 : Spec
label3 =
    let
        desc =
            description "Layering text over 'heatmap'"

        cfg =
            configure
                << configuration (coScale [ sacoBandPaddingInner 0, sacoBandPaddingOuter 0 ])
                << configuration (coText [ maBaseline vaMiddle ])

        data =
            dataFromUrl (path ++ "cars.json") []

        encPos =
            encoding
                << position X [ pName "Cylinders", pOrdinal ]
                << position Y [ pName "Origin", pOrdinal ]

        encRect =
            encoding
                << color [ mName "*", mAggregate opCount ]

        specRect =
            asSpec [ rect [], encRect [] ]

        encText =
            encoding
                << color [ mStr "white" ]
                << text [ tName "*", tAggregate opCount ]

        specText =
            asSpec [ textMark [], encText [] ]
    in
    toVegaLite
        [ desc, cfg [], data, encPos [], layer [ specRect, specText ] ]


label4 : Spec
label4 =
    let
        desc =
            description "Carbon dioxide in the atmosphere."

        data =
            dataFromUrl (path ++ "co2-concentration.csv") [ parse [ ( "Date", foUtc "%Y-%m-%d" ) ] ]

        trans =
            transform
                << calculateAs "year(datum.Date)" "year"
                << calculateAs "floor(datum.year / 10)" "decade"
                << calculateAs "(datum.year % 10) + (month(datum.Date)/12)" "scaled_date"
                << window
                    [ ( [ wiOp woFirstValue, wiField "scaled_date" ], "first_date" )
                    , ( [ wiOp woLastValue, wiField "scaled_date" ], "last_date" )
                    ]
                    [ wiSort [ wiAscending "scaled_date" ], wiGroupBy [ "decade" ], wiFrame Nothing Nothing ]
                << calculateAs "datum.first_date === datum.scaled_date ? 'first' : datum.last_date === datum.scaled_date ? 'last' : null" "end"

        encPosition =
            encoding
                << position X
                    [ pName "scaled_date"
                    , pQuant
                    , pAxis [ axTitle "Year into decade", axTickCount (niTickCount 11) ]
                    ]
                << position Y
                    [ pName "CO2"
                    , pTitle "CO₂ concentration in ppm"
                    , pQuant
                    , pScale [ scZero False ]
                    ]

        encLine =
            encoding
                << color
                    [ mName "decade"
                    , mOrdinal
                    , mScale [ scScheme "magma" [] ]
                    , mLegend []
                    ]

        specLine =
            asSpec [ encLine [], line [] ]

        transTextMin =
            transform
                << filter (fiEqual "end" (str "first"))

        encTextMin =
            encoding
                << text [ tName "year" ]

        specTextMin =
            asSpec [ transTextMin [], encTextMin [], textMark [ maBaseline vaTop ] ]

        transTextMax =
            transform
                << filter (fiEqual "end" (str "last"))

        encTextMax =
            encoding
                << text [ tName "year" ]

        specTextMax =
            asSpec [ transTextMax [], encTextMax [], textMark [ maBaseline vaBottom ] ]

        cfg =
            configure << configuration (coText [ maAlign haLeft, maDx 3, maDy 1 ])
    in
    toVegaLite
        [ desc
        , cfg []
        , width 800
        , height 500
        , data
        , trans []
        , encPosition []
        , layer [ specLine, specTextMin, specTextMax ]
        ]


label5 : Spec
label5 =
    let
        desc =
            description "Bar chart that highlights values beyond a threshold. The PM2.5 value of Beijing observed 15 days, highlighting the days when PM2.5 level is hazardous to human health. Data source https://chartaccent.github.io/chartaccent.html"

        data =
            dataFromColumns []
                << dataColumn "Day" (List.range 1 15 |> List.map toFloat |> nums)
                << dataColumn "Value" (nums [ 54.8, 112.1, 63.6, 37.6, 79.7, 137.9, 120.1, 103.3, 394.8, 199.5, 72.3, 51.1, 112.0, 174.5, 130.5 ])

        encBar =
            encoding
                << position X [ pName "Day", pOrdinal, pAxis [ axLabelAngle 0 ] ]
                << position Y [ pName "Value", pQuant ]

        specBar =
            asSpec [ bar [], encBar [] ]

        trans =
            transform
                << filter (fiExpr "datum.Value >= 300")
                << calculateAs "300" "baseline"

        encUpperBar =
            encoding
                << position X [ pName "Day", pOrdinal, pAxis [ axLabelAngle 0 ] ]
                << position Y [ pName "baseline", pQuant ]
                << position Y2 [ pName "Value" ]
                << color [ mStr "#e45755" ]

        specUpperBar =
            asSpec [ trans [], bar [], encUpperBar [] ]

        layer0 =
            asSpec [ data [], layer [ specBar, specUpperBar ] ]

        thresholdData =
            dataFromRows []
                << dataRow [ ( "ThresholdValue", num 300 ), ( "Threshold", str "hazardous" ) ]

        specRule =
            asSpec [ rule [], encRule [] ]

        encRule =
            encoding
                << position Y [ pName "ThresholdValue", pQuant ]

        specText =
            asSpec [ textMark [ maAlign haRight, maDx -2, maDy -4 ], encText [] ]

        encText =
            encoding
                << position X [ pWidth ]
                << position Y [ pName "ThresholdValue", pQuant, pTitle "PM2.5 Value" ]
                << text [ tName "Threshold", tOrdinal ]

        layer1 =
            asSpec [ thresholdData [], layer [ specRule, specText ] ]
    in
    toVegaLite [ desc, layer [ layer0, layer1 ] ]


label6 : Spec
label6 =
    let
        desc =
            description "Monthly precipitation with mean value overlay"

        data =
            dataFromUrl (path ++ "seattle-weather.csv") []

        encBar =
            encoding
                << position X [ pName "date", pOrdinal, pTimeUnit month ]
                << position Y [ pName "precipitation", pAggregate opMean ]

        specBar =
            asSpec [ bar [], encBar [] ]

        encLine =
            encoding
                << position Y [ pName "precipitation", pAggregate opMean ]
                << color [ mStr "red" ]
                << size [ mNum 3 ]

        specLine =
            asSpec [ rule [], encLine [] ]
    in
    toVegaLite [ desc, data, layer [ specBar, specLine ] ]


label7 : Spec
label7 =
    let
        desc =
            description "Histogram with global mean overlay"

        data =
            dataFromUrl (path ++ "movies.json") []

        encBars =
            encoding
                << position X [ pName "IMDB Rating", pBin [], pAxis [] ]
                << position Y [ pAggregate opCount ]

        specBars =
            asSpec [ bar [], encBars [] ]

        encMean =
            encoding
                << position X [ pName "IMDB Rating", pAggregate opMean ]
                << color [ mStr "red" ]
                << size [ mNum 5 ]

        specMean =
            asSpec [ rule [], encMean [] ]
    in
    toVegaLite [ desc, data, layer [ specBars, specMean ] ]


label8 : Spec
label8 =
    let
        desc =
            description "The population of the German city of Falkensee over time with annotated time periods highlighted"

        data =
            dataFromColumns [ parse [ ( "year", foDate "%Y" ) ] ]
                << dataColumn "year" (strs [ "1875", "1890", "1910", "1925", "1933", "1939", "1946", "1950", "1964", "1971", "1981", "1985", "1989", "1990", "1991", "1992", "1993", "1994", "1995", "1996", "1997", "1998", "1999", "2000", "2001", "2002", "2003", "2004", "2005", "2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014" ])
                << dataColumn "population" (nums [ 1309, 1558, 4512, 8180, 15915, 24824, 28275, 29189, 29881, 26007, 24029, 23340, 22307, 22087, 22139, 22105, 22242, 22801, 24273, 25640, 27393, 29505, 32124, 33791, 35297, 36179, 36829, 37493, 38376, 39008, 39366, 39821, 40179, 40511, 40465, 40905, 41258, 41777 ])

        highlights =
            dataFromColumns [ parse [ ( "start", foDate "%Y" ), ( "end", foDate "%Y" ) ] ]
                << dataColumn "start" (strs [ "1933", "1948" ])
                << dataColumn "end" (strs [ "1945", "1989" ])
                << dataColumn "event" (strs [ "Nazi Rule", "GDR (East Germany)" ])

        encRects =
            encoding
                << position X [ pName "start", pTimeUnit year, pAxis [] ]
                << position X2 [ pName "end" ]
                << color [ mName "event" ]

        specRects =
            asSpec [ highlights [], rect [], encRects [] ]

        encPopulation =
            encoding
                << position X [ pName "year", pTimeUnit year, pTitle "" ]
                << position Y [ pName "population", pQuant ]
                << color [ mStr "#333" ]

        specLine =
            asSpec [ line [], encPopulation [] ]

        specPoints =
            asSpec [ point [], encPopulation [] ]
    in
    toVegaLite [ desc, width 500, data [], layer [ specRects, specLine, specPoints ] ]


label9 : Spec
label9 =
    let
        medians =
            dataFromColumns []
                << dataColumn "name" (strs [ "Identify Errors:", "Fix Errors:", "Easier to Fix:", "Faster to Fix:", "Easier on Phone:", "Easier on Tablet:", "Device Preference:" ])
                << dataColumn "median" (nums [ 1.999976, 2, 1.999969, 2.500045, 1.500022, 2.99998, 4.500007 ])
                << dataColumn "lo" (strs [ "Easy", "Easy", "Toolbar", "Toolbar", "Toolbar", "Toolbar", "Phone" ])
                << dataColumn "hi" (strs [ "Hard", "Hard", "Gesture", "Gesture", "Gesture", "Gesture", "Tablet" ])

        values =
            dataFromColumns []
                << dataColumn "value" (strs [ "P1", "2", "2", "3", "4", "2", "5", "5", "1", "1", "P2", "2", "3", "4", "5", "5", "5", "5", "1", "1", "P3", "2", "2", "2", "1", "2", "1", "5", "1", "0", "P4", "3", "3", "2", "2", "4", "1", "5", "1", "0", "P5", "2", "2", "4", "4", "4", "5", "5", "0", "1", "P6", "1", "3", "3", "4", "4", "4", "4", "0", "1", "P7", "2", "3", "4", "5", "3", "2", "4", "0", "0", "P8", "3", "1", "2", "4", "2", "5", "5", "0", "0", "P9", "2", "3", "2", "4", "1", "4", "4", "1", "1", "P10", "2", "2", "1", "1", "1", "1", "5", "1", "1", "P11", "2", "2", "1", "1", "1", "1", "4", "1", "0", "P12", "1", "3", "2", "3", "1", "3", "3", "0", "1", "P13", "2", "2", "1", "1", "1", "1", "5", "0", "0", "P14", "3", "3", "2", "2", "1", "1", "1", "1", "1", "P15", "4", "5", "1", "1", "1", "1", "5", "1", "0", "P16", "1", "3", "2", "2", "1", "4", "5", "0", "1", "P17", "3", "2", "2", "2", "1", "3", "2", "0", "0" ])
                << dataColumn "name" (strs [ "Participant ID", "Identify Errors:", "Fix Errors:", "Easier to Fix:", "Faster to Fix:", "Easier on Phone:", "Easier on Tablet:", "Device Preference:", "Tablet_First", "Toolbar_First", "Participant ID", "Identify Errors:", "Fix Errors:", "Easier to Fix:", "Faster to Fix:", "Easier on Phone:", "Easier on Tablet:", "Device Preference:", "Tablet_First", "Toolbar_First", "Participant ID", "Identify Errors:", "Fix Errors:", "Easier to Fix:", "Faster to Fix:", "Easier on Phone:", "Easier on Tablet:", "Device Preference:", "Tablet_First", "Toolbar_First", "Participant ID", "Identify Errors:", "Fix Errors:", "Easier to Fix:", "Faster to Fix:", "Easier on Phone:", "Easier on Tablet:", "Device Preference:", "Tablet_First", "Toolbar_First", "Participant ID", "Identify Errors:", "Fix Errors:", "Easier to Fix:", "Faster to Fix:", "Easier on Phone:", "Easier on Tablet:", "Device Preference:", "Tablet_First", "Toolbar_First", "Participant ID", "Identify Errors:", "Fix Errors:", "Easier to Fix:", "Faster to Fix:", "Easier on Phone:", "Easier on Tablet:", "Device Preference:", "Tablet_First", "Toolbar_First", "Participant ID", "Identify Errors:", "Fix Errors:", "Easier to Fix:", "Faster to Fix:", "Easier on Phone:", "Easier on Tablet:", "Device Preference:", "Tablet_First", "Toolbar_First", "Participant ID", "Identify Errors:", "Fix Errors:", "Easier to Fix:", "Faster to Fix:", "Easier on Phone:", "Easier on Tablet:", "Device Preference:", "Tablet_First", "Toolbar_First", "Participant ID", "Identify Errors:", "Fix Errors:", "Easier to Fix:", "Faster to Fix:", "Easier on Phone:", "Easier on Tablet:", "Device Preference:", "Tablet_First", "Toolbar_First", "Participant ID", "Identify Errors:", "Fix Errors:", "Easier to Fix:", "Faster to Fix:", "Easier on Phone:", "Easier on Tablet:", "Device Preference:", "Tablet_First", "Toolbar_First", "Participant ID", "Identify Errors:", "Fix Errors:", "Easier to Fix:", "Faster to Fix:", "Easier on Phone:", "Easier on Tablet:", "Device Preference:", "Tablet_First", "Toolbar_First", "Participant ID", "Identify Errors:", "Fix Errors:", "Easier to Fix:", "Faster to Fix:", "Easier on Phone:", "Easier on Tablet:", "Device Preference:", "Tablet_First", "Toolbar_First", "Participant ID", "Identify Errors:", "Fix Errors:", "Easier to Fix:", "Faster to Fix:", "Easier on Phone:", "Easier on Tablet:", "Device Preference:", "Tablet_First", "Toolbar_First", "Participant ID", "Identify Errors:", "Fix Errors:", "Easier to Fix:", "Faster to Fix:", "Easier on Phone:", "Easier on Tablet:", "Device Preference:", "Tablet_First", "Toolbar_First", "Participant ID", "Identify Errors:", "Fix Errors:", "Easier to Fix:", "Faster to Fix:", "Easier on Phone:", "Easier on Tablet:", "Device Preference:", "Tablet_First", "Toolbar_First", "Participant ID", "Identify Errors:", "Fix Errors:", "Easier to Fix:", "Faster to Fix:", "Easier on Phone:", "Easier on Tablet:", "Device Preference:", "Tablet_First", "Toolbar_First", "Participant ID", "Identify Errors:", "Fix Errors:", "Easier to Fix:", "Faster to Fix:", "Easier on Phone:", "Easier on Tablet:", "Device Preference:", "Tablet_First", "Toolbar_First" ])
                << dataColumn "id" (strs [ "P1", "P1", "P1", "P1", "P1", "P1", "P1", "P1", "P1", "P1", "P2", "P2", "P2", "P2", "P2", "P2", "P2", "P2", "P2", "P2", "P3", "P3", "P3", "P3", "P3", "P3", "P3", "P3", "P3", "P3", "P4", "P4", "P4", "P4", "P4", "P4", "P4", "P4", "P4", "P4", "P5", "P5", "P5", "P5", "P5", "P5", "P5", "P5", "P5", "P5", "P6", "P6", "P6", "P6", "P6", "P6", "P6", "P6", "P6", "P6", "P7", "P7", "P7", "P7", "P7", "P7", "P7", "P7", "P7", "P7", "P8", "P8", "P8", "P8", "P8", "P8", "P8", "P8", "P8", "P8", "P9", "P9", "P9", "P9", "P9", "P9", "P9", "P9", "P9", "P9", "P10", "P10", "P10", "P10", "P10", "P10", "P10", "P10", "P10", "P10", "P11", "P11", "P11", "P11", "P11", "P11", "P11", "P11", "P11", "P11", "P12", "P12", "P12", "P12", "P12", "P12", "P12", "P12", "P12", "P12", "P13", "P13", "P13", "P13", "P13", "P13", "P13", "P13", "P13", "P13", "P14", "P14", "P14", "P14", "P14", "P14", "P14", "P14", "P14", "P14", "P15", "P15", "P15", "P15", "P15", "P15", "P15", "P15", "P15", "P15", "P16", "P16", "P16", "P16", "P16", "P16", "P16", "P16", "P16", "P16", "P17", "P17", "P17", "P17", "P17", "P17", "P17", "P17", "P17", "P17" ])

        enc =
            encoding
                << position Y
                    [ pName "name"
                    , pSort []
                    , pAxis
                        [ axDomain False
                        , axOffset 50
                        , axLabelFontWeight Bold
                        , axTicks False
                        , axGrid True
                        , axTitle ""
                        ]
                    ]

        trans =
            transform
                << filter (fiExpr "datum.name != 'Toolbar_First'")
                << filter (fiExpr "datum.name != 'Tablet_First'")
                << filter (fiExpr "datum.name != 'Participant ID'")

        encCircle =
            encoding
                << position X
                    [ pName "value"
                    , pQuant
                    , pScale [ scDomain (doNums [ 0, 6 ]) ]
                    , pAxis [ axGrid False, axValues (nums [ 1, 2, 3, 4, 5 ]) ]
                    ]
                << size [ mAggregate opCount, mLegend [ leTitle "Number of Ratings", leOffset 75 ] ]

        specCircle =
            asSpec
                [ dataFromSource "values" []
                , trans []
                , encCircle []
                , circle [ maColor "#6eb4fd" ]
                ]

        encTick1 =
            encoding
                << position X
                    [ pName "median"
                    , pQuant
                    , pScale [ scDomain (doNums [ 0, 6 ]) ]
                    , pTitle ""
                    ]

        specTick1 =
            asSpec [ encTick1 [], tick [ maColor "black" ] ]

        encTextLo =
            encoding
                << text [ tName "lo" ]

        specTextLo =
            asSpec [ encTextLo [], textMark [ maX -5, maAlign haRight ] ]

        encTextHi =
            encoding
                << text [ tName "hi" ]

        specTextHi =
            asSpec [ encTextHi [], textMark [ maX 255, maAlign haLeft ] ]

        cfg =
            configure << configuration (coView [ vicoStroke Nothing ])
    in
    toVegaLite
        [ cfg []
        , datasets [ ( "medians", medians [] ), ( "values", values [] ) ]
        , dataFromSource "medians" []
        , title "Questionnaire Ratings" []
        , width 250
        , height 175
        , enc []
        , layer [ specCircle, specTick1, specTextLo, specTextHi ]
        ]


label10 : Spec
label10 =
    let
        desc =
            description "Comparing Likert scale ratings between two conditions."

        cfg =
            configure
                << configuration (coView [ vicoStroke Nothing ])
                << configuration (coMarkStyles [ ( "arrow-label", [ maDy 12, maFontSize 9.5 ] ) ])
                << configuration (coTitle [ ticoFontSize 12 ])

        likertData =
            dataFromColumns []
                << dataColumn "measure" (strs [ "Open Exploration", "Focused Question Answering", "Open Exploration", "Focused Question Answering" ])
                << dataColumn "mean" (nums [ 1.81, -1.69, 2.19, -0.06 ])
                << dataColumn "lo" (nums [ 1.26, -2.33, 1.67, -0.47 ])
                << dataColumn "hi" (nums [ 2.37, -1.05, 2.71, 0.35 ])
                << dataColumn "study" (strs [ "PoleStar vs Voyager", "PoleStar vs Voyager", "PoleStar vs Voyager 2", "PoleStar vs Voyager 2" ])

        labelData =
            dataFromColumns []
                << dataColumn "from" (nums [ -0.25, 0.25 ])
                << dataColumn "to" (nums [ -2.9, 2.9 ])
                << dataColumn "label" (strs [ "PoleStar", "Voyager / Voyager 2" ])

        encLikert =
            encoding
                << position Y
                    [ pName "study"
                    , pAxis [ axTitle "", axLabelPadding 5, axDomain False, axTicks False, axGrid False ]
                    ]

        encLikertWhiskers =
            encoding
                << position X
                    [ pName "lo"
                    , pQuant
                    , pScale [ scDomain (doNums [ -3, 3 ]) ]
                    , pAxis
                        [ axTitle ""
                        , axGridDash [ 3, 3 ]
                        , axDataCondition (expr "datum.value === 0") (cAxGridColor "#666" "#ccc")
                        ]
                    ]
                << position X2 [ pName "hi" ]

        specLikertWhiskers =
            asSpec [ encLikertWhiskers [], rule [] ]

        encLikertMeans =
            encoding
                << position X [ pName "mean", pQuant ]
                << color [ mName "measure", mScale [ scRange (raStrs [ "black", "white" ]) ], mLegend [] ]

        specLikertMeans =
            asSpec [ encLikertMeans [], circle [ maStroke "black", maOpacity 1 ] ]

        specLikert =
            asSpec
                [ title "Mean of Subject Ratings (95% CIs)" [ tiFrame tfBounds ]
                , encLikert []
                , layer [ specLikertWhiskers, specLikertMeans ]
                ]

        encLabel1 =
            encoding
                << position X [ pName "from", pQuant, pScale [ scZero False ], pAxis [] ]
                << position X2 [ pName "to" ]

        specLabel1 =
            asSpec [ encLabel1 [], rule [] ]

        encLabel2 =
            encoding
                << position X [ pName "to", pQuant, pAxis [] ]
                << shape
                    [ mDataCondition [ ( expr "datum.to > 0", [ mSymbol symTriangleRight ] ) ]
                        [ mSymbol symTriangleLeft ]
                    ]

        specLabel2 =
            asSpec [ encLabel2 [], point [ maFilled True, maSize 60, maFill "black" ] ]

        transLabel3 =
            transform
                << filter (fiExpr "datum.label === 'PoleStar'")

        encLabel3 =
            encoding
                << position X [ pName "from", pQuant, pAxis [] ]

        specLabel3 =
            asSpec
                [ transLabel3 []
                , encLabel3 []
                , textMark
                    [ maText "PoleStar\nmore valuable"
                    , maAlign haRight
                    , maStyle [ "arrow-label" ]
                    ]
                ]

        transLabel4 =
            transform
                << filter (fiExpr "datum.label !== 'PoleStar'")

        encLabel4 =
            encoding
                << position X [ pName "from", pQuant, pAxis [] ]

        specLabel4 =
            asSpec
                [ transLabel4 []
                , encLabel4 []
                , textMark
                    [ maText "Voyager / Voyager 2\nmore valuable"
                    , maAlign haLeft
                    , maStyle [ "arrow-label" ]
                    ]
                ]

        transLabel6 =
            transform
                << filter (fiExpr "datum.label !== 'PoleStar'")

        specLabels =
            asSpec [ labelData [], layer [ specLabel1, specLabel2, specLabel3, specLabel4 ] ]
    in
    toVegaLite [ desc, cfg [], likertData [], spacing 10, vConcat [ specLikert, specLabels ] ]



{- This list comprises the specifications to be provided to the Vega-Lite runtime. -}


mySpecs : Spec
mySpecs =
    combineSpecs
        [ ( "label1", label1 )
        , ( "label2", label2 )
        , ( "label3", label3 )
        , ( "label4", label4 )
        , ( "label5", label5 )
        , ( "label6", label6 )
        , ( "label7", label7 )
        , ( "label8", label8 )
        , ( "label9", label9 )
        , ( "label10", label10 )
        ]



{- The code below is boilerplate for creating a headless Elm module that opens
   an outgoing port to Javascript and sends the specs to it.
-}


main : Program () Spec msg
main =
    Platform.worker
        { init = always ( mySpecs, elmToJS mySpecs )
        , update = \_ model -> ( model, Cmd.none )
        , subscriptions = always Sub.none
        }


port elmToJS : Spec -> Cmd msg
