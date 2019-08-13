port module GalleryTable exposing (elmToJS)

import Platform
import VegaLite exposing (..)



-- NOTE: All data sources in these examples originally provided at
-- https://github.com/vega/vega-datasets
-- The examples themselves reproduce those at https://vega.github.io/vega-lite/examples/


table1 : Spec
table1 =
    let
        des =
            description "'Table heatmap' showing engine size/power for three countries."

        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/cars.json" []

        enc =
            encoding
                << position X [ pName "Cylinders", pOrdinal ]
                << position Y [ pName "Origin", pNominal ]
                << color [ mName "Horsepower", mQuant, mAggregate opMean ]
    in
    toVegaLite [ des, data, rect [], enc [] ]


table2 : Spec
table2 =
    let
        des =
            description "Annual weather 'heatmap'"

        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/seattle-temps.csv" []

        cfg =
            configure
                << configuration (coView [ vicoStrokeWidth 0 ])
                << configuration (coScale [ sacoRangeStep (Just 13) ])
                << configuration (coAxis [ axcoDomain False ])

        enc =
            encoding
                << position X [ pName "date", pOrdinal, pTimeUnit date, pAxis [ axTitle "Day", axLabelAngle 0, axFormat "%e" ] ]
                << position Y [ pName "date", pOrdinal, pTimeUnit month, pAxis [ axTitle "Month" ] ]
                << color [ mName "temp", mQuant, mAggregate opMax, mLegend [ leTitle "" ] ]
    in
    toVegaLite [ des, cfg [], data, enc [], rect [] ]


table3 : Spec
table3 =
    let
        des =
            description "'Binned heatmap' comparing movie ratings."

        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/movies.json" []

        trans =
            transform
                << filter
                    (fiCompose
                        (and
                            (fiValid "IMDB_Rating" |> fiOp)
                            (fiValid "Rotten_Tomatoes_Rating" |> fiOp)
                        )
                    )

        enc =
            encoding
                << position X [ pName "IMDB_Rating", pQuant, pBin [ biMaxBins 60 ] ]
                << position Y [ pName "Rotten_Tomatoes_Rating", pQuant, pBin [ biMaxBins 40 ] ]
                << color [ mQuant, mAggregate opCount ]

        cfg =
            configure
                << configuration (coRange [ racoHeatmap "greenblue" ])
                << configuration (coView [ vicoStroke Nothing ])
    in
    toVegaLite [ des, cfg [], width 300, height 200, data, trans [], enc [], rect [] ]


table4 : Spec
table4 =
    let
        des =
            description "Table bubble plot in the style of a Github punched card."

        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/github.csv" []

        enc =
            encoding
                << position X [ pName "time", pOrdinal, pTimeUnit hours ]
                << position Y [ pName "time", pOrdinal, pTimeUnit day ]
                << size [ mName "count", mQuant, mAggregate opSum ]
    in
    toVegaLite [ des, data, enc [], circle [] ]


table5 : Spec
table5 =
    let
        des =
            description "Layering text over 'heatmap'."

        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/cars.json" []

        encPosition =
            encoding
                << position X [ pName "Cylinders", pOrdinal ]
                << position Y [ pName "Origin", pOrdinal ]

        encRect =
            encoding
                << color [ mName "*", mQuant, mAggregate opCount ]

        specRect =
            asSpec [ encRect [], rect [] ]

        encText =
            encoding
                << color [ mStr "white" ]
                << text [ tName "*", tQuant, tAggregate opCount ]

        specText =
            asSpec [ encText [], textMark [] ]

        cfg =
            configure
                << configuration (coScale [ sacoBandPaddingInner 0, sacoBandPaddingOuter 0 ])
                << configuration (coText [ maBaseline vaMiddle ])
    in
    toVegaLite [ des, cfg [], data, encPosition [], layer [ specRect, specText ] ]


table6 : Spec
table6 =
    let
        des =
            description "Lasagna Plot (Dense Time-Series Heatmap)."

        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/stocks.csv" []

        trans =
            transform
                << filter (fiExpr "datum.symbol !== 'GOOG'")

        enc =
            encoding
                << position X
                    [ pName "date"
                    , pOrdinal
                    , pTimeUnit yearMonthDate
                    , pTitle "Time"
                    , pAxis
                        [ axFormat "%Y"
                        , axLabelAngle 0
                        , axLabelOverlap osNone
                        , axDataCondition
                            (fiEqual "value" (dt [ dtMonth Jan, dtDate 1 ]) |> fiOpTrans (mTimeUnit monthDate))
                            (axLabelColor "black")
                            (axLabelColor "")
                        , axDataCondition
                            (fiEqual "value" (dt [ dtMonth Jan, dtDate 1 ]) |> fiOpTrans (mTimeUnit monthDate))
                            (axTickColor "black")
                            (axTickColor "")
                        ]
                    ]
                << position Y [ pName "symbol", pNominal, pTitle "" ]
                << color [ mAggregate opSum, mName "price", mQuant, mTitle "Price" ]

        cfg =
            configure
                << configuration (coScale [ sacoBandPaddingInner 0, sacoBandPaddingOuter 0 ])
                << configuration (coText [ maBaseline vaMiddle ])
    in
    toVegaLite [ des, width 300, height 100, cfg [], data, trans [], enc [], rect [] ]



{- This list comprises the specifications to be provided to the Vega-Lite runtime. -}


mySpecs : Spec
mySpecs =
    combineSpecs
        [ ( "table1", table1 )
        , ( "table2", table2 )
        , ( "table3", table3 )
        , ( "table4", table4 )
        , ( "table5", table5 )
        , ( "table6", table6 )
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
