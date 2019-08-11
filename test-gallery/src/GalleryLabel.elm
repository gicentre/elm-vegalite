port module GalleryLabel exposing (elmToJS)

import Platform
import VegaLite exposing (..)



-- NOTE: All data sources in these examples originally provided at
-- https://github.com/vega/vega-datasets
-- The examples themselves reproduce those at https://vega.github.io/vega-lite/examples/


label1 : Spec
label1 =
    let
        des =
            description "A simple bar chart with embedded data labels"

        data =
            dataFromColumns []
                << dataColumn "a" (strs [ "A", "B", "C" ])
                << dataColumn "b" (nums [ 28, 55, 43 ])

        enc =
            encoding
                << position X [ pName "b", pMType Quantitative ]
                << position Y [ pName "a", pMType Ordinal ]

        specBar =
            asSpec [ bar [] ]

        specText =
            asSpec [ textMark [ maStyle [ "label" ] ], encoding (text [ tName "b", tMType Quantitative ] []) ]

        config =
            configure << configuration (coNamedStyle "label" [ maAlign haLeft, maBaseline vaMiddle, maDx 3 ])
    in
    toVegaLite [ des, data [], enc [], layer [ specBar, specText ], config [] ]


label2 : Spec
label2 =
    let
        des =
            description "Layering text over 'heatmap'"

        encPosition =
            encoding
                << position X [ pName "Cylinders", pMType Ordinal ]
                << position Y [ pName "Origin", pMType Ordinal ]

        encRect =
            encoding
                << color [ mName "*", mMType Quantitative, mAggregate opCount ]

        specRect =
            asSpec [ rect [], encRect [] ]

        encText =
            encoding
                << color [ mStr "white" ]
                << text [ tName "*", tMType Quantitative, tAggregate opCount ]

        specText =
            asSpec [ textMark [], encText [] ]

        config =
            configure
                << configuration (coScale [ sacoBandPaddingInner 0, sacoBandPaddingOuter 0 ])
                << configuration (coText [ maBaseline vaMiddle ])
    in
    toVegaLite
        [ des
        , dataFromUrl "https://vega.github.io/vega-lite/data/cars.json" []
        , encPosition []
        , layer [ specRect, specText ]
        , config []
        ]


label3 : Spec
label3 =
    let
        des =
            description "Carbon dioxide in the atmosphere."

        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/co2-concentration.csv"
                [ parse [ ( "Date", foUtc "%Y-%m-%d" ) ] ]

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
                    , pMType Quantitative
                    , pAxis [ axTitle "Year into decade", axTickCount 11 ]
                    ]
                << position Y
                    [ pName "CO2"
                    , pTitle "CO₂ concentration in ppm"
                    , pMType Quantitative
                    , pScale [ scZero False ]
                    ]

        encLine =
            encoding
                << color
                    [ mName "decade"
                    , mMType Ordinal
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
                << text [ tName "year", tMType Nominal ]

        specTextMin =
            asSpec [ transTextMin [], encTextMin [], textMark [ maBaseline vaTop ] ]

        transTextMax =
            transform
                << filter (fiEqual "end" (str "last"))

        encTextMax =
            encoding
                << text [ tName "year", tMType Nominal ]

        specTextMax =
            asSpec [ transTextMax [], encTextMax [], textMark [ maBaseline vaBottom ] ]

        cfg =
            configure << configuration (coText [ maAlign haLeft, maDx 3, maDy 1 ])
    in
    toVegaLite
        [ des
        , cfg []
        , width 800
        , height 500
        , data
        , trans []
        , encPosition []
        , layer [ specLine, specTextMin, specTextMax ]
        ]


label4 : Spec
label4 =
    let
        des =
            description "Bar chart that highlights values beyond a threshold. The PM2.5 value of Beijing observed 15 days, highlighting the days when PM2.5 level is hazardous to human health. Data source https://chartaccent.github.io/chartaccent.html"

        data =
            dataFromColumns []
                << dataColumn "Day" (List.range 1 15 |> List.map toFloat |> nums)
                << dataColumn "Value" (nums [ 54.8, 112.1, 63.6, 37.6, 79.7, 137.9, 120.1, 103.3, 394.8, 199.5, 72.3, 51.1, 112.0, 174.5, 130.5 ])

        encBar =
            encoding
                << position X [ pName "Day", pMType Ordinal, pAxis [ axLabelAngle 0 ] ]
                << position Y [ pName "Value", pMType Quantitative ]

        specBar =
            asSpec [ bar [], encBar [] ]

        trans =
            transform
                << filter (fiExpr "datum.Value >= 300")
                << calculateAs "300" "baseline"

        encUpperBar =
            encoding
                << position X [ pName "Day", pMType Ordinal, pAxis [ axLabelAngle 0 ] ]
                << position Y [ pName "baseline", pMType Quantitative ]
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
                << position Y [ pName "ThresholdValue", pMType Quantitative ]

        specText =
            asSpec [ textMark [ maAlign haRight, maDx -2, maDy -4 ], encText [] ]

        encText =
            encoding
                << position X [ pWidth ]
                << position Y [ pName "ThresholdValue", pMType Quantitative, pAxis [ axTitle "PM2.5 Value" ] ]
                << text [ tName "Threshold", tMType Ordinal ]

        layer1 =
            asSpec [ thresholdData [], layer [ specRule, specText ] ]
    in
    toVegaLite [ des, layer [ layer0, layer1 ] ]


label5 : Spec
label5 =
    let
        des =
            description "Monthly precipitation with mean value overlay"

        encBar =
            encoding
                << position X [ pName "date", pMType Ordinal, pTimeUnit month ]
                << position Y [ pName "precipitation", pMType Quantitative, pAggregate opMean ]

        specBar =
            asSpec [ bar [], encBar [] ]

        encLine =
            encoding
                << position Y [ pName "precipitation", pMType Quantitative, pAggregate opMean ]
                << color [ mStr "red" ]
                << size [ mNum 3 ]

        specLine =
            asSpec [ rule [], encLine [] ]
    in
    toVegaLite
        [ des
        , dataFromUrl "https://vega.github.io/vega-lite/data/seattle-weather.csv" []
        , layer [ specBar, specLine ]
        ]


label6 : Spec
label6 =
    let
        des =
            description "Histogram with global mean overlay"

        encBars =
            encoding
                << position X [ pName "IMDB_Rating", pMType Quantitative, pBin [], pAxis [] ]
                << position Y [ pMType Quantitative, pAggregate opCount ]

        specBars =
            asSpec [ bar [], encBars [] ]

        encMean =
            encoding
                << position X [ pName "IMDB_Rating", pMType Quantitative, pAggregate opMean ]
                << color [ mStr "red" ]
                << size [ mNum 5 ]

        specMean =
            asSpec [ rule [], encMean [] ]
    in
    toVegaLite
        [ des
        , dataFromUrl "https://vega.github.io/vega-lite/data/movies.json" []
        , layer [ specBars, specMean ]
        ]


label7 : Spec
label7 =
    let
        des =
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
                << position X [ pName "start", pMType Temporal, pTimeUnit year, pAxis [] ]
                << position X2 [ pName "end" ]
                << color [ mName "event", mMType Nominal ]

        specRects =
            asSpec [ highlights [], rect [], encRects [] ]

        encPopulation =
            encoding
                << position X [ pName "year", pMType Temporal, pTimeUnit year, pAxis [ axTitle "" ] ]
                << position Y [ pName "population", pMType Quantitative ]
                << color [ mStr "#333" ]

        specLine =
            asSpec [ line [], encPopulation [] ]

        specPoints =
            asSpec [ point [], encPopulation [] ]
    in
    toVegaLite [ des, width 500, data [], layer [ specRects, specLine, specPoints ] ]


label8 : Spec
label8 =
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
                    , pMType Nominal
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
                    , pMType Quantitative
                    , pScale [ scDomain (doNums [ 0, 6 ]) ]
                    , pAxis [ axGrid False, axValues (nums [ 1, 2, 3, 4, 5 ]) ]
                    ]
                << size
                    [ mAggregate opCount
                    , mMType Quantitative
                    , mLegend [ leTitle "Number of Ratings", leOffset 75 ]
                    ]

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
                    , pMType Quantitative
                    , pScale [ scDomain (doNums [ 0, 6 ]) ]
                    , pAxis [ axTitle "" ]
                    ]

        specTick1 =
            asSpec [ encTick1 [], tick [ maColor "black" ] ]

        encTextLo =
            encoding
                << text [ tName "lo", tMType Nominal ]

        specTextLo =
            asSpec [ encTextLo [], textMark [ maX -5, maAlign haRight ] ]

        encTextHi =
            encoding
                << text [ tName "hi", tMType Nominal ]

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
