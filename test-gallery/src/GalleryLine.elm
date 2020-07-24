port module GalleryLine exposing (elmToJS)

import Platform
import VegaLite exposing (..)



-- NOTE: All data sources in these examples originally provided at
-- https://github.com/vega/vega-datasets
-- The examples themselves reproduce those at https://vega.github.io/vega-lite/examples/


path : String
path =
    "https://cdn.jsdelivr.net/npm/vega-datasets@2.1/data/"


line1 : Spec
line1 =
    let
        desc =
            description "Google's stock price over time."

        data =
            dataFromUrl (path ++ "stocks.csv") []

        trans =
            transform << filter (fiExpr "datum.symbol === 'GOOG'")

        enc =
            encoding
                << position X [ pName "date", pTemporal, pAxis [ axFormat "%Y" ] ]
                << position Y [ pName "price", pQuant ]
    in
    toVegaLite [ desc, data, trans [], enc [], line [] ]


line2 : Spec
line2 =
    let
        desc =
            description "Line chart with point markers."

        data =
            dataFromUrl (path ++ "stocks.csv") []

        enc =
            encoding
                << position X [ pName "date", pTemporal, pTimeUnit year ]
                << position Y [ pName "price", pAggregate opMean ]
                << color [ mName "symbol" ]
    in
    toVegaLite [ desc, data, enc [], line [ maPoint (pmMarker []) ] ]


line3 : Spec
line3 =
    let
        desc =
            description "Line chart with stroked point markers."

        data =
            dataFromUrl (path ++ "stocks.csv") []

        enc =
            encoding
                << position X [ pName "date", pTemporal, pTimeUnit year ]
                << position Y [ pName "price", pAggregate opMean ]
                << color [ mName "symbol" ]
    in
    toVegaLite [ desc, data, enc [], line [ maPoint (pmMarker [ maFilled False, maFill "white" ]) ] ]


line4 : Spec
line4 =
    let
        desc =
            description "Stock prices of 5 tech companies over time."

        data =
            dataFromUrl (path ++ "stocks.csv") []

        enc =
            encoding
                << position X [ pName "date", pTemporal, pAxis [ axFormat "%Y" ] ]
                << position Y [ pName "price", pQuant ]
                << color [ mName "symbol" ]
    in
    toVegaLite [ desc, data, enc [], line [] ]


line5 : Spec
line5 =
    let
        desc =
            description "Repeated layers to show different weather measures."

        data =
            dataFromUrl (path ++ "movies.json") []

        enc =
            encoding
                << position X [ pName "IMDB Rating", pQuant, pBin [] ]
                << position Y [ pRepeat arLayer, pAggregate opMean, pTitle "Mean of US and Worldwide Gross" ]
                << color [ mRepeatDatum arLayer ]

        spec =
            asSpec [ data, enc [], line [] ]
    in
    toVegaLite
        [ desc
        , repeat [ layerFields [ "US Gross", "Worldwide Gross" ] ]
        , specification spec
        ]


line6 : Spec
line6 =
    let
        desc =
            description "Multi-series line chart with halo. Uses pivot and repeat-layer as a workaround to facet groups of lines and their halo strokes."

        data =
            dataFromUrl (path ++ "stocks.csv") []

        trans =
            transform
                << pivot "symbol" "price" [ piGroupBy [ "date" ] ]

        encHalo =
            encoding
                << position X [ pName "date", pTemporal ]
                << position Y [ pRepeat arLayer, pQuant, pTitle "price" ]
                << color [ mRepeatDatum arLayer ]

        specHalo =
            asSpec [ encHalo [], line [ maStroke "white", maStrokeWidth 4 ] ]

        encLine =
            encoding
                << position X [ pName "date", pTemporal ]
                << position Y [ pRepeat arLayer, pQuant, pTitle "price" ]
                << stroke [ mRepeatDatum arLayer ]

        specLine =
            asSpec [ encLine [], line [] ]
    in
    toVegaLite
        [ desc
        , data
        , trans []
        , repeat [ layerFields [ "AAPL", "AMZN", "GOOG", "IBM", "MSFT" ] ]
        , specification (asSpec [ layer [ specHalo, specLine ] ])
        ]


line7 : Spec
line7 =
    let
        desc =
            description "Slope graph showing the change in yield for different barley sites. It shows the error in the year labels for the Morris site."

        data =
            dataFromUrl (path ++ "barley.json") []

        enc =
            encoding
                << position X [ pName "year", pOrdinal, pScale [ scPadding 0.5 ] ]
                << position Y [ pName "yield", pAggregate opMedian ]
                << color [ mName "site" ]
    in
    toVegaLite [ desc, widthStep 50, data, enc [], line [] ]


line8 : Spec
line8 =
    let
        desc =
            description "Google's stock price over time (quantized as a step-chart)."

        data =
            dataFromUrl (path ++ "stocks.csv") []

        trans =
            transform << filter (fiExpr "datum.symbol === 'GOOG'")

        enc =
            encoding
                << position X [ pName "date", pTemporal, pAxis [ axFormat "%Y" ] ]
                << position Y [ pName "price", pQuant ]
    in
    toVegaLite [ desc, data, trans [], enc [], line [ maInterpolate miStepAfter ] ]


line9 : Spec
line9 =
    let
        desc =
            description "Google's stock price over time (smoothed with monotonic interpolation)."

        data =
            dataFromUrl (path ++ "stocks.csv") []

        trans =
            transform << filter (fiExpr "datum.symbol === 'GOOG'")

        enc =
            encoding
                << position X [ pName "date", pTemporal, pAxis [ axFormat "%Y" ] ]
                << position Y [ pName "price", pQuant ]
    in
    toVegaLite [ desc, data, trans [], enc [], line [ maInterpolate miMonotone ] ]


line10 : Spec
line10 =
    let
        desc =
            description "Line chart with conditional grid dash."

        data =
            dataFromUrl (path ++ "stocks.csv") []

        trans =
            transform
                << filter (fiExpr "datum.symbol === 'GOOG'")
                << filter
                    (fiRange "date" (dtRange [ dtYear 2006 ] [ dtYear 2008 ])
                        |> fiOpTrans (mTimeUnit year)
                        |> fiCompose
                    )

        enc =
            encoding
                << position X
                    [ pName "date"
                    , pTemporal
                    , pAxis
                        [ axTickCount (niTickCount 20)
                        , axDataCondition
                            (fiEqual "value" (dt [ dtMonth Jan, dtDate 1 ])
                                |> fiOpTrans (mTimeUnit monthDate)
                            )
                            (cAxGridDash [] [ 2, 2 ])
                        ]
                    ]
                << position Y [ pName "price", pQuant ]
    in
    toVegaLite [ desc, data, trans [], enc [], line [] ]


line11 : Spec
line11 =
    let
        desc =
            description "Line chart with conditional axis ticks, labels, and grid."

        cfg =
            configure
                << configuration (coAxis [ axcoDomainColor "#ddd", axcoTickColor "#ddd" ])

        data =
            dataFromUrl (path ++ "stocks.csv") []

        trans =
            transform
                << filter (fiExpr "datum.symbol === 'GOOG'")
                << filter
                    (fiRange "date" (dtRange [ dtYear 2006 ] [ dtYear 2008 ])
                        |> fiOpTrans (mTimeUnit year)
                        |> fiCompose
                    )

        enc =
            encoding
                << position X
                    [ pName "date"
                    , pTemporal
                    , pAxis
                        [ axTitle ""
                        , axTickCount (niTickCount 8)
                        , axLabelAlign haLeft
                        , axLabelExpr "[timeFormat(datum.value, '%b'), timeFormat(datum.value, '%m') == '01' ? timeFormat(datum.value, '%Y') : '']"
                        , axLabelOffset 4
                        , axLabelPadding -24
                        , axTickSize 30
                        , axDataCondition
                            (fiEqual "value" (dt [ dtMonth Jan ]) |> fiOpTrans (mTimeUnit monthDate))
                            (cAxGridDash [] [ 2, 2 ])
                        , axDataCondition
                            (fiEqual "value" (dt [ dtMonth Jan ]) |> fiOpTrans (mTimeUnit monthDate))
                            (cAxTickDash [] [ 2, 2 ])
                        ]
                    ]
                << position Y [ pName "price", pQuant ]
    in
    toVegaLite [ desc, cfg [], width 400, data, trans [], enc [], line [] ]


line12 : Spec
line12 =
    let
        desc =
            description "A connected scatterplot can be created by customizing line order and adding point marker in the line mark definition."

        data =
            dataFromUrl (path ++ "driving.json") []

        enc =
            encoding
                << position X [ pName "miles", pQuant, pScale [ scZero False ] ]
                << position Y [ pName "gas", pQuant, pScale [ scZero False ] ]
                << order [ oName "year", oTemporal ]
    in
    toVegaLite [ desc, data, enc [], line [ maPoint (pmMarker []) ] ]


line13 : Spec
line13 =
    let
        desc =
            description "Stock prices of five tech companies over time double encoding price with vertical position and line thickness."

        data =
            dataFromUrl (path ++ "stocks.csv") []

        enc =
            encoding
                << position X [ pName "date", pTemporal, pAxis [ axFormat "%Y" ] ]
                << position Y [ pName "price", pQuant ]
                << size [ mName "price", mQuant ]
                << color [ mName "symbol" ]
    in
    toVegaLite [ desc, data, enc [], trail [] ]


line14 : Spec
line14 =
    let
        desc =
            description "Line chart with markers and invalid values."

        data =
            dataFromRows []
                << dataRow [ ( "x", num 1 ), ( "y", num 10 ) ]
                << dataRow [ ( "x", num 2 ), ( "y", num 30 ) ]
                << dataRow [ ( "x", num 3 ), ( "y", nullValue ) ]
                << dataRow [ ( "x", num 4 ), ( "y", num 15 ) ]
                << dataRow [ ( "x", num 5 ), ( "y", nullValue ) ]
                << dataRow [ ( "x", num 6 ), ( "y", num 40 ) ]
                << dataRow [ ( "x", num 7 ), ( "y", num 20 ) ]

        enc =
            encoding
                << position X [ pName "x", pQuant ]
                << position Y [ pName "y", pQuant ]
    in
    toVegaLite [ desc, data [], enc [], line [ maPoint (pmMarker []) ] ]


line15 : Spec
line15 =
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


line16 : Spec
line16 =
    let
        desc =
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
                << position X [ pName "matchday", pOrdinal ]
                << position Y [ pName "rank", pOrdinal ]
                << color [ mName "team", mScale teamColours ]

        teamColours =
            categoricalDomainMap
                [ ( "Germany", "black" )
                , ( "Mexico", "#127153" )
                , ( "South Korea", "#c91a3c" )
                , ( "Sweden", "#0c71ab" )
                ]
    in
    toVegaLite [ desc, data [], trans [], enc [], line [ maOrient moVertical ] ]


line17 : Spec
line17 =
    let
        desc =
            description "Plots a function using a generated sequence"

        data =
            dataSequenceAs 0 12.7 0.1 "u"

        trans =
            transform
                << calculateAs "sin(datum.u)" "v"
                << calculateAs "cos(datum.u)" "w"

        encSin =
            encoding
                << position X [ pName "u", pQuant, pTitle "x" ]
                << position Y [ pName "v", pQuant, pTitle "sin(x)" ]

        specSin =
            asSpec [ encSin [], line [] ]

        encCos =
            encoding
                << position X [ pName "u", pQuant, pTitle "x" ]
                << position Y [ pName "w", pQuant, pTitle "cos(x)" ]

        specCos =
            asSpec [ encCos [], line [ maStroke "firebrick" ] ]
    in
    toVegaLite [ desc, width 300, height 150, data, trans [], layer [ specSin, specCos ] ]


line18 : Spec
line18 =
    let
        data =
            dataFromUrl (path ++ "stocks.csv") []

        enc =
            encoding
                << position X [ pName "date", pTemporal ]
                << position Y [ pName "price", pQuant ]
                << strokeDash [ mName "symbol" ]
    in
    toVegaLite [ data, enc [], line [] ]


line19 : Spec
line19 =
    let
        data =
            dataFromColumns []
                -- Note the duplicate of the 4th data value to join dash to solid line.
                << dataColumn "a" (strs [ "A", "B", "C", "D", "D", "E", "F" ])
                << dataColumn "b" (nums [ 28, 55, 91, 81, 81, 19, 87 ])
                << dataColumn "predicted" (boos [ False, False, False, False, True, True, True ])

        enc =
            encoding
                << position X [ pName "a", pOrdinal, pAxis [ axTitle "", axLabelAngle 0 ] ]
                << position Y [ pName "b", pQuant, pTitle "" ]
                << strokeDash [ mName "predicted" ]
                << color [ mName "predicted" ]
    in
    toVegaLite [ width 200, data [], enc [], line [] ]



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
        , ( "line15", line15 )
        , ( "line16", line16 )
        , ( "line17", line17 )
        , ( "line18", line18 )
        , ( "line19", line19 )
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
