port module GalleryLine exposing (elmToJS)

import Platform
import VegaLite exposing (..)



-- NOTE: All data sources in these examples originally provided at
-- https://github.com/vega/vega-datasets
-- The examples themselves reproduce those at https://vega.github.io/vega-lite/examples/


line1 : Spec
line1 =
    let
        des =
            description "Google's stock price over time."

        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/stocks.csv" []

        trans =
            transform << filter (fiExpr "datum.symbol === 'GOOG'")

        enc =
            encoding
                << position X [ pName "date", pMType Temporal, pAxis [ axFormat "%Y" ] ]
                << position Y [ pName "price", pMType Quantitative ]
    in
    toVegaLite [ des, data, trans [], enc [], line [] ]


line2 : Spec
line2 =
    let
        des =
            description "Line chart with point markers."

        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/stocks.csv" []

        enc =
            encoding
                << position X [ pName "date", pMType Temporal, pTimeUnit year ]
                << position Y [ pName "price", pMType Quantitative, pAggregate opMean ]
                << color [ mName "symbol", mMType Nominal ]
    in
    toVegaLite [ des, data, enc [], line [ maPoint (pmMarker []) ] ]


line3 : Spec
line3 =
    let
        des =
            description "Line chart with stroked point markers."

        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/stocks.csv" []

        enc =
            encoding
                << position X [ pName "date", pMType Temporal, pTimeUnit year ]
                << position Y [ pName "price", pMType Quantitative, pAggregate opMean ]
                << color [ mName "symbol", mMType Nominal ]
    in
    toVegaLite [ des, data, enc [], line [ maPoint (pmMarker [ maFilled False, maFill "white" ]) ] ]


line4 : Spec
line4 =
    let
        des =
            description "Stock prices of 5 tech companies over time."

        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/stocks.csv" []

        enc =
            encoding
                << position X [ pName "date", pMType Temporal, pAxis [ axFormat "%Y" ] ]
                << position Y [ pName "price", pMType Quantitative ]
                << color [ mName "symbol", mMType Nominal ]
    in
    toVegaLite [ des, data, enc [], line [] ]


line5 : Spec
line5 =
    let
        des =
            description "Slope graph showing the change in yield for different barley sites. It shows the error in the year labels for the Morris site."

        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/barley.json" []

        enc =
            encoding
                << position X [ pName "year", pMType Ordinal, pScale [ scPadding 0.5 ] ]
                << position Y [ pName "yield", pMType Quantitative, pAggregate opMedian ]
                << color [ mName "site", mMType Nominal ]
    in
    toVegaLite [ des, widthStep 50, data, enc [], line [] ]


line6 : Spec
line6 =
    let
        des =
            description "Google's stock price over time (quantized as a step-chart)."

        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/stocks.csv" []

        trans =
            transform << filter (fiExpr "datum.symbol === 'GOOG'")

        enc =
            encoding
                << position X [ pName "date", pMType Temporal, pAxis [ axFormat "%Y" ] ]
                << position Y [ pName "price", pMType Quantitative ]
    in
    toVegaLite [ des, data, trans [], enc [], line [ maInterpolate miStepAfter ] ]


line7 : Spec
line7 =
    let
        des =
            description "Google's stock price over time (smoothed with monotonic interpolation)."

        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/stocks.csv" []

        trans =
            transform << filter (fiExpr "datum.symbol === 'GOOG'")

        enc =
            encoding
                << position X [ pName "date", pMType Temporal, pAxis [ axFormat "%Y" ] ]
                << position Y [ pName "price", pMType Quantitative ]
    in
    toVegaLite [ des, data, trans [], enc [], line [ maInterpolate miMonotone ] ]


line8 : Spec
line8 =
    let
        des =
            description "Line chart with conditional grid dash."

        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/stocks.csv" []

        trans =
            transform
                << filter (fiExpr "datum.symbol === 'GOOG'")
                << timeUnitAs year "date" "years"
                << filter (fiRange "years" (dtRange [ dtYear 2006 ] [ dtYear 2008 ]))

        enc =
            encoding
                << position X
                    [ pName "date"
                    , pMType Temporal
                    , pAxis
                        [ axTickCount 20

                        -- TODO: Update when we have inline temporal binning
                        --  , axDataCondition (fiOp (fiEqual "value" (dt [ dtMonth Jan, dtDate 1 ]))) (axGridDash []) (axGridDash [ 2, 2 ])
                        , axDataCondition (expr "datum.label === '2007' || datum.label === '2008'") (axGridDash []) (axGridDash [ 2, 2 ])
                        ]
                    ]
                << position Y [ pName "price", pMType Quantitative ]
    in
    toVegaLite [ des, data, trans [], enc [], line [] ]


line9 : Spec
line9 =
    let
        des =
            description "A connected scatterplot can be created by customizing line order and adding point marker in the line mark definition."

        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/driving.json" []

        enc =
            encoding
                << position X [ pName "miles", pMType Quantitative, pScale [ scZero False ] ]
                << position Y [ pName "gas", pMType Quantitative, pScale [ scZero False ] ]
                << order [ oName "year", oMType Temporal ]
    in
    toVegaLite [ des, data, enc [], line [ maPoint (pmMarker []) ] ]


line10 : Spec
line10 =
    let
        des =
            description "Stock prices of five tech companies over time double encoding price with vertical position and line thickness."

        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/stocks.csv" []

        enc =
            encoding
                << position X [ pName "date", pMType Temporal, pAxis [ axFormat "%Y" ] ]
                << position Y [ pName "price", pMType Quantitative ]
                << size [ mName "price", mMType Quantitative ]
                << color [ mName "symbol", mMType Nominal ]
    in
    toVegaLite [ des, data, enc [], trail [] ]


line11 : Spec
line11 =
    let
        des =
            description "Line chart with markers and invalid values."

        data =
            dataFromColumns []
                << dataColumn "x" (nums [ 1, 2, 3, 4, 5, 6, 7 ])
                << dataColumn "y" (nums [ 10, 30, 0 / 0, 15, 0 / 0, 40, 20 ])

        enc =
            encoding
                << position X [ pName "x", pMType Quantitative ]
                << position Y [ pName "y", pMType Quantitative ]
    in
    toVegaLite [ des, data [], enc [], line [ maPoint (pmMarker []) ] ]


line12 : Spec
line12 =
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


line13 : Spec
line13 =
    let
        des =
            description "Line chart showing ranks over time for thw World Cup 2018 Group F teams"

        data =
            dataFromColumns []
                << dataColumn "team" (strs [ "Germany", "Mexico", "South Korea", "Sweden", "Germany", "Mexico", "South Korea", "Sweden", "Germany", "Mexico", "South Korea", "Sweden" ])
                << dataColumn "matchday" (nums [ 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3 ])
                << dataColumn "point" (nums [ 0, 3, 0, 3, 3, 6, 0, 3, 3, 6, 3, 6 ])
                << dataColumn "diff" (nums [ -1, 1, -1, 1, 0, 2, -2, 0, -2, -1, 0, 3 ])

        trans =
            transform
                << window [ ( [ wiOp woRank ], "rank" ) ]
                    [ wiSort [ wiDescending "point", wiDescending "diff" ], wiGroupBy [ "matchday" ] ]

        enc =
            encoding
                << position X [ pName "matchday", pMType Ordinal ]
                << position Y [ pName "rank", pMType Ordinal ]
                << color [ mName "team", mMType Nominal, mScale teamColours ]

        teamColours =
            categoricalDomainMap
                [ ( "Germany", "black" )
                , ( "Mexico", "#127153" )
                , ( "South Korea", "#c91a3c" )
                , ( "Sweden", "#0c71ab" )
                ]
    in
    toVegaLite [ des, data [], trans [], enc [], line [ maOrient moVertical ] ]


line14 : Spec
line14 =
    let
        des =
            description "Plots a function using a generated sequence"

        data =
            dataSequenceAs 0 12.7 0.1 "u"

        trans =
            transform
                << calculateAs "sin(datum.u)" "v"
                << calculateAs "cos(datum.u)" "w"

        encSin =
            encoding
                << position X [ pName "u", pMType Quantitative, pTitle "x" ]
                << position Y [ pName "v", pMType Quantitative, pTitle "sin(x)" ]

        specSin =
            asSpec [ encSin [], line [] ]

        encCos =
            encoding
                << position X [ pName "u", pMType Quantitative, pTitle "x" ]
                << position Y [ pName "w", pMType Quantitative, pTitle "cos(x)" ]

        specCos =
            asSpec [ encCos [], line [ maStroke "firebrick" ] ]
    in
    toVegaLite [ des, width 300, height 150, data, trans [], layer [ specSin, specCos ] ]



{- This list comprises the specifications to be provided to the Vega-Lite runtime. -}


mySpecs : Spec
mySpecs =
    combineSpecs
        [ ( "line1", line1 )
        , ( "line2", line2 )
        , ( "line3", line3 )
        , ( "line4", line4 )
        , ( "line5", line5 )
        , ( "line6", line6 )
        , ( "line7", line7 )
        , ( "line8", line8 )
        , ( "line9", line9 )
        , ( "line10", line10 )
        , ( "line11", line11 )
        , ( "line12", line12 )
        , ( "line13", line13 )
        , ( "line14", line14 )
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
