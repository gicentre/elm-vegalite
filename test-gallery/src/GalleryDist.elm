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

        enc =
            encoding
                << position X [ pName "IMDB_Rating", pQuant, pBin [] ]
                << position Y [ pQuant, pAggregate opCount ]
    in
    toVegaLite
        [ des
        , dataFromUrl "https://vega.github.io/vega-lite/data/movies.json" []
        , bar [ maBinSpacing 0 ]
        , enc []
        ]


dist2 : Spec
dist2 =
    let
        des =
            description "Cumulative frequency distribution"

        trans =
            transform
                << window [ ( [ wiAggregateOp opCount, wiField "count" ], "cumulativeCount" ) ]
                    [ wiSort [ wiAscending "IMDB_Rating" ], wiFrame Nothing (Just 0) ]

        enc =
            encoding
                << position X [ pName "IMDB_Rating", pQuant ]
                << position Y [ pName "cumulativeCount", pQuant ]
    in
    toVegaLite
        [ des
        , dataFromUrl "https://vega.github.io/vega-lite/data/movies.json" []
        , trans []
        , area []
        , enc []
        ]


dist3 : Spec
dist3 =
    let
        des =
            description "A layered histogram and cumulative histogram."

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
        , dataFromUrl "https://vega.github.io/vega-lite/data/movies.json" []
        , trans []
        , layer [ specCumulative, specDist ]
        , enc []
        ]


dist4 : Spec
dist4 =
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


dist5 : Spec
dist5 =
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



{- This list comprises the specifications to be provided to the Vega-Lite runtime. -}


mySpecs : Spec
mySpecs =
    combineSpecs
        [ ( "dist1", dist1 )
        , ( "dist2", dist2 )
        , ( "dist3", dist3 )
        , ( "dist4", dist4 )
        , ( "dist5", dist5 )
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
