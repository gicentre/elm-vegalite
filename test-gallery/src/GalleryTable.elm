port module GalleryTable exposing (elmToJS)

import Platform
import VegaLite exposing (..)



-- NOTE: All data sources in these examples originally provided at
-- https://github.com/vega/vega-datasets
-- The examples themselves reproduce those at https://vega.github.io/vega-lite/examples/


path : String
path =
    "https://cdn.jsdelivr.net/npm/vega-datasets@2.1/data/"


giCentrePath : String
giCentrePath =
    "https://gicentre.github.io/data/"


table1 : Spec
table1 =
    let
        desc =
            description "'Table heatmap' showing engine size/power for three countries."

        data =
            dataFromUrl (path ++ "cars.json") []

        enc =
            encoding
                << position X [ pName "Cylinders", pOrdinal ]
                << position Y [ pName "Origin" ]
                << color [ mName "Horsepower", mAggregate opMean ]
    in
    toVegaLite [ desc, data, enc [], rect [] ]


table2 : Spec
table2 =
    let
        desc =
            description "Annual temperature 'heatmap'"

        data =
            dataFromUrl (path ++ "seattle-weather.csv") []

        cfg =
            configure
                << configuration (coView [ vicoStrokeWidth 0, vicoStep 13 ])
                << configuration (coAxis [ axcoDomain False ])

        enc =
            encoding
                << position X
                    [ pName "date"
                    , pOrdinal
                    , pTimeUnit date
                    , pAxis [ axTitle "Day", axLabelAngle 0, axFormat "%e" ]
                    ]
                << position Y [ pName "date", pOrdinal, pTimeUnit month, pTitle "Month" ]
                << color [ mName "temp_max", mAggregate opMax, mTitle "" ]
    in
    toVegaLite
        [ desc
        , title "Daily Max Temperatures (C) in Seattle, WA" []
        , cfg []
        , data
        , enc []
        , rect []
        ]


table3 : Spec
table3 =
    let
        desc =
            description "'Binned heatmap' comparing movie ratings."

        data =
            dataFromUrl (path ++ "movies.json") []

        trans =
            transform
                << filter
                    (fiCompose
                        (and
                            (fiValid "IMDB Rating" |> fiOp)
                            (fiValid "Rotten Tomatoes Rating" |> fiOp)
                        )
                    )

        enc =
            encoding
                << position X [ pName "IMDB Rating", pQuant, pBin [ biMaxBins 60 ] ]
                << position Y [ pName "Rotten Tomatoes Rating", pQuant, pBin [ biMaxBins 40 ] ]
                << color [ mAggregate opCount ]

        cfg =
            configure
                << configuration (coRange [ racoHeatmap "greenblue" ])
                << configuration (coView [ vicoStroke Nothing ])
    in
    toVegaLite [ desc, cfg [], width 300, height 200, data, trans [], enc [], rect [] ]


table4 : Spec
table4 =
    let
        desc =
            description "Table bubble plot in the style of a Github punched card."

        data =
            dataFromUrl (path ++ "github.csv") []

        enc =
            encoding
                << position X [ pName "time", pOrdinal, pTimeUnit hours ]
                << position Y [ pName "time", pOrdinal, pTimeUnit day ]
                << size [ mName "count", mAggregate opSum ]
    in
    toVegaLite [ desc, data, enc [], circle [] ]


table5 : Spec
table5 =
    let
        desc =
            description "Layering text over 'heatmap'."

        data =
            dataFromUrl (path ++ "cars.json") []

        encPosition =
            encoding
                << position X [ pName "Cylinders", pOrdinal ]
                << position Y [ pName "Origin", pOrdinal ]

        encRect =
            encoding
                << color [ mName "*", mAggregate opCount ]

        specRect =
            asSpec [ encRect [], rect [] ]

        encText =
            encoding
                << color [ mStr "white" ]
                << text [ tName "*", tAggregate opCount ]

        specText =
            asSpec [ encText [], textMark [] ]

        cfg =
            configure
                << configuration (coScale [ sacoBandPaddingInner 0, sacoBandPaddingOuter 0 ])
                << configuration (coText [ maBaseline vaMiddle ])
    in
    toVegaLite [ desc, cfg [], data, encPosition [], layer [ specRect, specText ] ]


table6 : Spec
table6 =
    let
        desc =
            description "Lasagna Plot (Dense Time-Series Heatmap)."

        data =
            dataFromUrl (path ++ "stocks.csv") []

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
                            (cAxLabelColor "black" "")
                        , axDataCondition
                            (fiEqual "value" (dt [ dtMonth Jan, dtDate 1 ]) |> fiOpTrans (mTimeUnit monthDate))
                            (cAxTickColor "black" "")
                        ]
                    ]
                << position Y [ pName "symbol", pTitle "" ]
                << color [ mAggregate opSum, mName "price", mTitle "Price" ]

        cfg =
            configure
                << configuration (coScale [ sacoBandPaddingInner 0, sacoBandPaddingOuter 0 ])
                << configuration (coText [ maBaseline vaMiddle ])
    in
    toVegaLite [ desc, width 300, height 100, cfg [], data, trans [], enc [], rect [] ]


table7 : Spec
table7 =
    let
        desc =
            description "Vector array map showing wind speed and direction."

        cfg =
            configure
                << configuration (coView [ vicoStep 10, vicoFill (Just "black") ])

        data =
            dataFromUrl (path ++ "windvectors.csv") []

        geoData =
            dataFromUrl (giCentrePath ++ "europe/nwEuropeLand.json") [ topojsonFeature "ne_10m_land" ]

        proj =
            projection [ prType equalEarth ]

        geoSpec =
            asSpec [ geoData, geoshape [ maStroke "white", maStrokeWidth 0.4, maFilled False ] ]

        enc =
            encoding
                << position Longitude [ pName "longitude" ]
                << position Latitude [ pName "latitude" ]
                << color
                    [ mName "dir"
                    , mQuant
                    , mLegend []
                    , mScale [ scDomain (doNums [ 0, 360 ]), scScheme "rainbow" [] ]
                    ]
                << angle
                    [ mName "dir"
                    , mQuant
                    , mScale [ scDomain (doNums [ 0, 360 ]), scRange (raNums [ 180, 540 ]) ]
                    ]
                << size [ mName "speed", mQuant ]

        windSpec =
            asSpec [ data, enc [], point [ maShape symWedge ] ]
    in
    toVegaLite
        [ desc
        , cfg []
        , width 600
        , height 560
        , proj
        , layer [ geoSpec, windSpec ]
        ]



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
        , ( "table7", table7 )
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
