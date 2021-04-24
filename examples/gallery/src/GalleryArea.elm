port module GalleryArea exposing (elmToJS)

import Platform
import VegaLite exposing (..)



-- NOTE: All data sources in these examples originally provided at
-- https://github.com/vega/vega-datasets
-- The examples themselves reproduce those at https://vega.github.io/vega-lite/examples/


path : String
path =
    "https://cdn.jsdelivr.net/npm/vega-datasets@2.2/data/"


area1 : Spec
area1 =
    let
        desc =
            description "Unemployment over time (area chart)"

        data =
            dataFromUrl (path ++ "unemployment-across-industries.json") []

        enc =
            encoding
                << position X [ pName "date", pTimeUnit yearMonth, pAxis [ axTitle "", axFormat "%Y" ] ]
                << position Y [ pName "count", pAggregate opSum, pTitle "Number of unemployed" ]
    in
    toVegaLite [ desc, width 300, height 200, data, enc [], area [] ]


area2 : Spec
area2 =
    let
        desc =
            description "Area chart with linear gradient"

        data =
            dataFromUrl (path ++ "stocks.csv") []

        trans =
            transform << filter (fiExpr "datum.symbol === 'GOOG'")

        enc =
            encoding
                << position X [ pName "date", pTemporal, pAxis [ axTitle "", axFormat "%Y" ] ]
                << position Y [ pName "price", pQuant ]
    in
    toVegaLite
        [ desc
        , data
        , trans []
        , enc []
        , area
            [ maLine (lmMarker [ maStroke "darkgreen" ])
            , maFillGradient grLinear [ grX1 1, grY1 1, grX2 1, grY2 0, grStops [ ( 0, "white" ), ( 1, "darkgreen" ) ] ]
            ]
        ]


area3 : Spec
area3 =
    let
        desc =
            description "Area chart with overlaid lines and point markers"

        data =
            dataFromUrl (path ++ "stocks.csv") []

        trans =
            transform << filter (fiExpr "datum.symbol === 'GOOG'")

        enc =
            encoding
                << position X [ pName "date", pTemporal, pAxis [ axTitle "", axFormat "%Y" ] ]
                << position Y [ pName "price", pQuant ]
    in
    toVegaLite [ desc, data, trans [], enc [], area [ maPoint (pmMarker []), maLine (lmMarker []) ] ]


area4 : Spec
area4 =
    let
        desc =
            description "Unemployment across industries as a stacked area chart."

        data =
            dataFromUrl (path ++ "unemployment-across-industries.json") []

        enc =
            encoding
                << position X [ pName "date", pTimeUnit yearMonth, pAxis [ axTitle "", axFormat "%Y" ] ]
                << position Y [ pName "count", pAggregate opSum, pTitle "Number unemployed" ]
                << color [ mName "series", mScale [ scScheme "category20b" [] ] ]
    in
    toVegaLite [ desc, data, enc [], area [] ]


area5 : Spec
area5 =
    let
        desc =
            description "Unemployment across industries as a normalised area chart."

        data =
            dataFromUrl (path ++ "unemployment-across-industries.json") []

        enc =
            encoding
                << position X [ pName "date", pTimeUnit yearMonth, pAxis [ axTitle "", axDomain False, axFormat "%Y" ] ]
                << position Y [ pName "count", pAggregate opSum, pAxis [], pStack stNormalize ]
                << color [ mName "series", mScale [ scScheme "category20b" [] ] ]
    in
    toVegaLite [ desc, width 300, height 200, data, enc [], area [] ]


area6 : Spec
area6 =
    let
        desc =
            description "Unemployment across industries as a streamgraph (centred, stacked area chart)."

        data =
            dataFromUrl (path ++ "unemployment-across-industries.json") []

        enc =
            encoding
                << position X [ pName "date", pTimeUnit yearMonth, pAxis [ axTitle "", axDomain False, axFormat "%Y" ] ]
                << position Y [ pName "count", pAggregate opSum, pAxis [], pStack stCenter ]
                << color [ mName "series", mScale [ scScheme "category20b" [] ] ]
    in
    toVegaLite [ desc, width 300, height 200, data, enc [], area [] ]


area7 : Spec
area7 =
    let
        desc =
            description "Horizon chart with 2 layers. (See https://idl.cs.washington.edu/papers/horizon/ for more details on horizon charts.)"

        data =
            dataFromColumns []
                << dataColumn "x" (nums (List.map toFloat <| List.range 1 20))
                << dataColumn "y" (nums [ 28, 55, 43, 91, 81, 53, 19, 87, 52, 48, 24, 49, 87, 66, 17, 27, 68, 16, 49, 15 ])

        trans =
            transform << calculateAs "datum.y - 50" "ny"

        encX =
            encoding
                << position X
                    [ pName "x"
                    , pQuant
                    , pScale [ scZero False, scNice niFalse ]
                    ]

        encLower =
            encoding
                << position Y
                    [ pName "y"
                    , pQuant
                    , pScale [ scDomain (doNums [ 0, 50 ]) ]
                    ]
                << opacity [ mNum 0.6 ]

        specLower =
            asSpec [ area [ maClip True ], encLower [] ]

        encUpper =
            encoding
                << position Y
                    [ pName "ny"
                    , pQuant
                    , pScale [ scDomain (doNums [ 0, 50 ]) ]
                    , pTitle "y"
                    ]
                << opacity [ mNum 0.3 ]

        specUpper =
            asSpec [ trans [], area [ maClip True ], encUpper [] ]

        config =
            configure
                << configuration (coArea [ maInterpolate miMonotone, maOrient moVertical ])
    in
    toVegaLite [ desc, width 300, height 50, data [], encX [], layer [ specLower, specUpper ], config [] ]


area8 : Spec
area8 =
    let
        data =
            dataFromUrl (path ++ "cars.json") []

        trans =
            transform
                << aggregate [ opAs opCount "" "count_*" ] [ "Origin", "Cylinders" ]
                << stack "count_*"
                    []
                    "stack_count_Origin1"
                    "stack_count_Origin2"
                    [ stOffset stNormalize, stSort [ stAscending "Origin" ] ]
                << window
                    [ ( [ wiAggregateOp opMin, wiField "stack_count_Origin1" ], "x" )
                    , ( [ wiAggregateOp opMax, wiField "stack_count_Origin2" ], "x2" )
                    , ( [ wiOp woDenseRank ], "rank_Cylinders" )
                    , ( [ wiAggregateOp opDistinct, wiField "Cylinders" ], "distinct_Cylinders" )
                    ]
                    [ wiFrame Nothing Nothing, wiGroupBy [ "Origin" ], wiSort [ wiAscending "Cylinders" ] ]
                << window
                    [ ( [ wiOp woDenseRank ], "rank_Origin" ) ]
                    [ wiFrame Nothing Nothing, wiSort [ wiAscending "Origin" ] ]
                << stack "count_*"
                    [ "Origin" ]
                    "y"
                    "y2"
                    [ stOffset stNormalize, stSort [ stAscending "Cylinders" ] ]
                << calculateAs "datum.y + (datum.rank_Cylinders - 1) * datum.distinct_Cylinders * 0.01 / 3" "ny"
                << calculateAs "datum.y2 + (datum.rank_Cylinders - 1) * datum.distinct_Cylinders * 0.01 / 3" "ny2"
                << calculateAs "datum.x + (datum.rank_Origin - 1) * 0.01" "nx"
                << calculateAs "datum.x2 + (datum.rank_Origin - 1) * 0.01" "nx2"
                << calculateAs "(datum.nx+datum.nx2)/2" "xc"
                << calculateAs "(datum.ny+datum.ny2)/2" "yc"

        enc1 =
            encoding
                << position X
                    [ pName "xc"
                    , pAggregate opMin
                    , pTitle "Origin"
                    , pAxis [ axOrient siTop ]
                    ]
                << color [ mName "Origin", mLegend [] ]
                << text [ tName "Origin" ]

        spec1 =
            asSpec [ textMark [ maBaseline vaMiddle, maAlign haCenter ], enc1 [] ]

        enc2 =
            encoding
                << position X [ pName "nx", pQuant, pAxis [] ]
                << position X2 [ pName "nx2" ]
                << position Y [ pName "ny", pQuant, pAxis [] ]
                << position Y2 [ pName "ny2" ]
                << color [ mName "Origin", mLegend [] ]
                << opacity [ mName "Cylinders", mQuant, mLegend [] ]
                << tooltips
                    [ [ tName "Origin" ]
                    , [ tName "Cylinders", tQuant ]
                    ]

        spec2 =
            asSpec [ rect [], enc2 [] ]

        enc3 =
            encoding
                << position X [ pName "xc", pQuant, pAxis [] ]
                << position Y [ pName "yc", pQuant, pTitle "Cylinders" ]
                << text [ tName "Cylinders" ]

        spec3 =
            asSpec [ textMark [ maBaseline vaMiddle ], enc3 [] ]

        cfg =
            configure
                << configuration (coView [ vicoStroke Nothing ])
                << configuration (coAxis [ axcoDomain False, axcoTicks False, axcoLabels False, axcoGrid False ])
                << configuration (coConcat [ cocoSpacing 10 ])

        res =
            resolve
                << resolution (reScale [ ( chX, reShared ) ])
    in
    toVegaLite
        [ cfg []
        , res []
        , data
        , trans []
        , vConcat [ spec1, asSpec [ layer [ spec2, spec3 ] ] ]
        ]



{- This list comprises the specifications to be provided to the Vega-Lite runtime. -}


mySpecs : Spec
mySpecs =
    combineSpecs
        [ ( "area1", area1 )
        , ( "area2", area2 )
        , ( "area3", area3 )
        , ( "area4", area4 )
        , ( "area5", area5 )
        , ( "area6", area6 )
        , ( "area7", area7 )
        , ( "area8", area8 )
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
