port module GalleryDist exposing (elmToJS)

import Json.Encode as JE
import Platform
import VegaLite exposing (..)



-- NOTE: All data sources in these examples originally provided at
-- https://github.com/vega/vega-datasets
-- The examples themselves reproduce those at https://vega.github.io/vega-lite/examples/


path : String
path =
    "https://cdn.jsdelivr.net/npm/vega-datasets@2.1/data/"


dist1 : Spec
dist1 =
    let
        desc =
            description "Simple histogram of IMDB ratings."

        data =
            dataFromUrl (path ++ "movies.json") []

        enc =
            encoding
                << position X [ pName "IMDB Rating", pQuant, pBin [] ]
                << position Y [ pAggregate opCount ]
    in
    toVegaLite [ desc, data, enc [], bar [] ]


dist2 : Spec
dist2 =
    let
        desc =
            description "Histogram with relative requency calculcated for the y scale and axis."

        data =
            dataFromUrl (path ++ "cars.json") []

        trans =
            transform
                << binAs [] "Horsepower" "bin_Horsepower"
                << aggregate [ opAs opCount "" "Count" ] [ "bin_Horsepower", "bin_Horsepower_end" ]
                << joinAggregate [ opAs opSum "Count" "totalCount" ] []
                << calculateAs "datum.Count/datum.totalCount" "percentOfTotal"

        enc =
            encoding
                << position X [ pName "bin_Horsepower", pQuant, pBinned, pTitle "Horsepower" ]
                << position X2 [ pName "bin_Horsepower_end" ]
                << position Y
                    [ pName "percentOfTotal"
                    , pQuant
                    , pTitle "Relative frequency"
                    , pAxis [ axFormat ".1~%" ]
                    ]
    in
    toVegaLite [ desc, data, trans [], enc [], bar [ maTooltip ttEncoding ] ]


dist3 : Spec
dist3 =
    let
        desc =
            description "Cumulative frequency distribution"

        data =
            dataFromUrl (path ++ "movies.json") []

        trans =
            transform
                << window [ ( [ wiAggregateOp opCount, wiField "count" ], "cumulativeCount" ) ]
                    [ wiSort [ wiAscending "IMDB Rating" ], wiFrame Nothing (Just 0) ]

        enc =
            encoding
                << position X [ pName "IMDB Rating", pQuant ]
                << position Y [ pName "cumulativeCount", pQuant ]
    in
    toVegaLite [ desc, data, trans [], enc [], area [] ]


dist4 : Spec
dist4 =
    let
        data =
            dataFromUrl (path ++ "movies.json") []

        trans =
            transform
                << density "IMDB Rating" [ dnBandwidth 0.3 ]

        enc =
            encoding
                << position X [ pName "value", pQuant, pTitle "IMDB Rating" ]
                << position Y [ pName "density", pQuant ]
    in
    toVegaLite [ width 400, height 100, data, trans [], enc [], area [] ]


dist5 : Spec
dist5 =
    let
        data =
            dataFromUrl (path ++ "penguins.json") []

        trans =
            transform
                << density "Body Mass (g)"
                    [ dnMinSteps 50
                    , dnGroupBy [ "Species" ]
                    , dnExtent 2500 6500
                    ]

        enc =
            encoding
                << position X [ pName "value", pQuant, pTitle "Body mass (g)" ]
                << position Y [ pName "density", pQuant, pStack stZero ]
                << color [ mName "Species" ]
    in
    toVegaLite
        [ title "Body Mass of Penguins" []
        , width 400
        , height 120
        , data
        , trans []
        , enc []
        , area [ maStroke "white", maStrokeWidth 0.5 ]
        ]


dist6 : Spec
dist6 =
    let
        desc =
            description "A layered histogram and cumulative histogram."

        data =
            dataFromUrl (path ++ "movies.json") []

        trans =
            transform
                << binAs [] "IMDB Rating" "binIMDBRating"
                << aggregate
                    [ opAs opCount "" "count" ]
                    [ "binIMDBRating", "binIMDBRating_end" ]
                << filter (fiExpr "datum.binIMDBRating !== null")
                << window [ ( [ wiAggregateOp opSum, wiField "count" ], "cumulativeCount" ) ]
                    [ wiSort [ wiAscending "binIMDBRating" ], wiFrame Nothing (Just 0) ]

        enc =
            encoding
                << position X
                    [ pName "binIMDBRating"
                    , pQuant
                    , pScale [ scZero False ]
                    , pTitle "IMDB rating"
                    ]
                << position X2 [ pName "binIMDBRating_end" ]

        cdEnc =
            encoding
                << position Y [ pName "cumulativeCount", pQuant, pTitle "" ]

        specCumulative =
            asSpec [ cdEnc [], bar [] ]

        dEnc =
            encoding
                << position Y [ pName "count", pQuant ]

        specDist =
            asSpec [ dEnc [], bar [ maColor "yellow", maOpacity 0.5 ] ]
    in
    toVegaLite
        [ desc
        , data
        , trans []
        , enc []
        , layer [ specCumulative, specDist ]
        ]


dist7 : Spec
dist7 =
    let
        desc =
            description "A vertical 2D box plot showing median, min, and max in the US population distribution of age groups in 2000."

        data =
            dataFromUrl (path ++ "population.json") []

        enc =
            encoding
                << position X [ pName "age", pOrdinal, pAxis [ axLabelAngle 0 ] ]
                << position Y [ pName "people", pQuant, pTitle "population" ]
    in
    toVegaLite [ desc, data, enc [], boxplot [ maExtent exRange ] ]


dist8 : Spec
dist8 =
    let
        desc =
            description "Tukey box plot showing median, min, and max in the US population distribution of age groups in 2000."

        data =
            dataFromUrl (path ++ "population.json") []

        enc =
            encoding
                << position X [ pName "age", pOrdinal, pAxis [ axLabelAngle 0 ] ]
                << position Y [ pName "people", pQuant, pTitle "population" ]
                << size [ mNum 5 ]
    in
    toVegaLite [ desc, data, enc [], boxplot [ maExtent (exIqrScale 1.5) ] ]


dist9 : Spec
dist9 =
    let
        desc =
            description "Box plot showing median and range of penguin body mass distributions."

        data =
            dataFromUrl (path ++ "penguins.json") []

        enc =
            encoding
                << position X [ pName "Species", pAxis [ axLabelAngle 0, axTitle "" ] ]
                << position Y [ pName "Body Mass (g)", pQuant, pScale [ scZero False ] ]
                << color [ mName "Species", mLegend [] ]
    in
    toVegaLite [ desc, width 130, data, enc [], boxplot [ maExtent exRange ] ]


dist10 : Spec
dist10 =
    let
        desc =
            description "Tukey box plot showing median and lower and upper quartiles of penguin body mass distributions."

        data =
            dataFromUrl (path ++ "penguins.json") []

        enc =
            encoding
                << position X [ pName "Species", pAxis [ axLabelAngle 0, axTitle "" ] ]
                << position Y [ pName "Body Mass (g)", pQuant, pScale [ scZero False ] ]
                << color [ mName "Species", mLegend [] ]
    in
    toVegaLite [ desc, width 130, data, enc [], boxplot [] ]


dist11 : Spec
dist11 =
    let
        desc =
            description "Box plot with pre-calculated summary statistics for penguin body mass distribution."

        -- This example demonstrates how JSON data structure with arrays may be specified in a typesafe manner.
        jRow sp l q1 m q3 u o =
            JE.object
                [ ( "Species", JE.string sp )
                , ( "lower", JE.float l )
                , ( "q1", JE.float q1 )
                , ( "median", JE.float m )
                , ( "q3", JE.float q3 )
                , ( "upper", JE.float u )
                , ( "outliers", JE.list JE.float o )
                ]

        data =
            dataFromJson
                (JE.list identity
                    [ jRow "Adelie" 2850 3350 3700 4000 4775 []
                    , jRow "Chinstrap" 2700 3487.5 3700 3950 4800 [ 2700, 4800 ]
                    , jRow "Gentoo" 3950 4700 5000 5500 6300 []
                    ]
                )
                []

        enc =
            encoding
                << position Y [ pName "Species", pTitle "" ]

        encRule =
            encoding
                << position X [ pName "lower", pQuant, pScale [ scZero False ], pTitle "" ]
                << position X2 [ pName "upper" ]

        specRule =
            asSpec [ encRule [], rule [] ]

        encBar =
            encoding
                << position X [ pName "q1", pQuant ]
                << position X2 [ pName "q3" ]
                << color [ mName "Species", mLegend [] ]

        specBar =
            asSpec [ encBar [], bar [ maSize 14 ] ]

        encTick =
            encoding
                << position X [ pName "median", pQuant ]

        specTick =
            asSpec [ tick [ maColor "white", maSize 14 ] ]

        encPoint =
            encoding
                << position X [ pName "outliers", pQuant ]

        trans =
            transform
                << flatten [ "outliers" ]

        specPoint =
            asSpec [ trans [], encPoint [], point [ maStyle [ "boxplot-outliers" ] ] ]
    in
    toVegaLite [ desc, data, enc [], layer [ specRule, specBar, specTick, specPoint ] ]


dist12 : Spec
dist12 =
    let
        data =
            dataFromUrl (path ++ "normal-2d.json") []

        trans =
            transform
                << quantile "u" [ qtStep 0.01, qtAs "p" "v" ]
                << calculateAs "quantileUniform(datum.p)" "unif"
                << calculateAs "quantileNormal(datum.p)" "norm"

        enc1 =
            encoding
                << position X [ pName "unif", pQuant ]
                << position Y [ pName "v", pQuant ]

        enc2 =
            encoding
                << position X [ pName "norm", pQuant ]
                << position Y [ pName "v", pQuant ]
    in
    toVegaLite
        [ data
        , trans []
        , hConcat
            [ asSpec [ enc1 [], point [] ]
            , asSpec [ enc2 [], point [] ]
            ]
        ]



{- This list comprises the specifications to be provided to the Vega-Lite runtime. -}


mySpecs : Spec
mySpecs =
    combineSpecs
        [ ( "dist1", dist1 )
        , ( "dist2", dist2 )
        , ( "dist3", dist3 )
        , ( "dist4", dist4 )
        , ( "dist5", dist5 )
        , ( "dist6", dist6 )
        , ( "dist7", dist7 )
        , ( "dist8", dist8 )
        , ( "dist9", dist9 )
        , ( "dist10", dist10 )
        , ( "dist11", dist11 )
        , ( "dist12", dist12 )
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
