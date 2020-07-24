port module GalleryDist exposing (elmToJS)

import Platform
import VegaLite exposing (..)



-- NOTE: All data sources in these examples originally provided at
-- https://github.com/vega/vega-datasets
-- The examples themselves reproduce those at https://vega.github.io/vega-lite/examples/


dist1 : Spec
dist1 =
    let
        des =
            description "Simple histogram of IMDB ratings."

        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/movies.json" []

        enc =
            encoding
                << position X [ pName "IMDB_Rating", pQuant, pBin [] ]
                << position Y [ pQuant, pAggregate opCount ]
    in
    toVegaLite [ des, data, enc [], bar [] ]


dist2 : Spec
dist2 =
    let
        des =
            description "Histogram with relative requency calculcated for the y scale and axis."

        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/cars.json" []

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
    toVegaLite [ des, data, trans [], enc [], bar [ maTooltip ttEncoding ] ]


dist3 : Spec
dist3 =
    let
        des =
            description "Cumulative frequency distribution"

        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/movies.json" []

        trans =
            transform
                << window [ ( [ wiAggregateOp opCount, wiField "count" ], "cumulativeCount" ) ]
                    [ wiSort [ wiAscending "IMDB_Rating" ], wiFrame Nothing (Just 0) ]

        enc =
            encoding
                << position X [ pName "IMDB_Rating", pQuant ]
                << position Y [ pName "cumulativeCount", pQuant ]
    in
    toVegaLite [ des, data, trans [], enc [], area [] ]


dist4 : Spec
dist4 =
    let
        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/movies.json" []

        trans =
            transform
                << density "IMDB_Rating" [ dnBandwidth 0.3 ]

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
            dataFromUrl "https://vega.github.io/vega-lite/data/movies.json" []

        trans =
            transform
                << density "IMDB_Rating"
                    [ dnBandwidth 0.3
                    , dnGroupBy [ "Major_Genre" ]
                    , dnExtent 0 10
                    , dnCounts True
                    , dnSteps 50
                    ]

        enc =
            encoding
                << position X [ pName "value", pQuant ]
                << position Y [ pName "density", pQuant, pStack stZero ]
                << color [ mName "Major_Genre", mScale [ scScheme "category20" [] ] ]
    in
    toVegaLite [ width 400, height 100, data, trans [], enc [], area [] ]


dist6 : Spec
dist6 =
    let
        des =
            description "A layered histogram and cumulative histogram."

        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/movies.json" []

        trans =
            transform
                << binAs [] "IMDB_Rating" "bin_IMDB_Rating"
                << aggregate
                    [ opAs opCount "" "count" ]
                    [ "bin_IMDB_Rating", "bin_IMDB_Rating_end" ]
                << filter (fiExpr "datum.bin_IMDB_Rating !== null")
                << window [ ( [ wiAggregateOp opSum, wiField "count" ], "cumulativeCount" ) ]
                    [ wiSort [ wiAscending "bin_IMDB_Rating" ], wiFrame Nothing (Just 0) ]

        enc =
            encoding
                << position X
                    [ pName "bin_IMDB_Rating"
                    , pQuant
                    , pScale [ scZero False ]
                    , pAxis [ axTitle "IMDB rating" ]
                    ]
                << position X2 [ pName "bin_IMDB_Rating_end" ]

        cdEnc =
            encoding
                << position Y [ pName "cumulativeCount", pQuant ]

        specCumulative =
            asSpec [ cdEnc [], bar [] ]

        dEnc =
            encoding
                << position Y [ pName "count", pQuant ]

        specDist =
            asSpec [ dEnc [], bar [ maColor "yellow", maOpacity 0.5 ] ]
    in
    toVegaLite
        [ des
        , data
        , trans []
        , enc []
        , layer [ specCumulative, specDist ]
        ]


dist7 : Spec
dist7 =
    let
        des =
            description "A vertical 2D box plot showing median, min, and max in the US population distribution of age groups in 2000."

        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/population.json" []

        enc =
            encoding
                << position X [ pName "age", pOrdinal ]
                << position Y [ pName "people", pQuant, pTitle "population" ]
    in
    toVegaLite [ des, data, enc [], boxplot [ maExtent exRange ] ]


dist8 : Spec
dist8 =
    let
        des =
            description "Tukey box plot showing median, min, and max in the US population distribution of age groups in 2000."

        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/population.json" []

        enc =
            encoding
                << position X [ pName "age", pOrdinal ]
                << position Y [ pName "people", pQuant, pTitle "population" ]
                << size [ mNum 5 ]
    in
    toVegaLite [ des, data, enc [], boxplot [ maExtent (exIqrScale 1.5) ] ]


dist9 : Spec
dist9 =
    let
        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/normal-2d.json" []

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
