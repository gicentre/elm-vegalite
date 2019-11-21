port module GalleryRepeat exposing (elmToJS)

import Platform
import VegaLite exposing (..)



-- NOTE: All data sources in these examples originally provided at
-- https://github.com/vega/vega-datasets
-- The examples themselves reproduce those at https://vega.github.io/vega-lite/examples/


repeat1 : Spec
repeat1 =
    let
        des =
            description "Monthly weather information for individual years and overall average for Seatle and New York"

        enc1 =
            encoding
                << position X [ pName "date", pOrdinal, pTimeUnit month ]
                << position Y [ pRepeat arColumn, pQuant, pAggregate opMean ]
                << detail [ dName "date", dTemporal, dTimeUnit year ]
                << color [ mName "location", mNominal ]
                << opacity [ mNum 0.2 ]

        spec1 =
            asSpec [ line [], enc1 [] ]

        enc2 =
            encoding
                << position X [ pName "date", pOrdinal, pTimeUnit month ]
                << position Y [ pRepeat arColumn, pQuant, pAggregate opMean ]
                << color [ mName "location", mNominal ]

        spec2 =
            asSpec [ line [], enc2 [] ]

        spec =
            asSpec [ layer [ spec1, spec2 ] ]
    in
    toVegaLite
        [ des
        , dataFromUrl "https://vega.github.io/vega-lite/data/weather.csv" []
        , repeat [ columnFields [ "temp_max", "precipitation", "wind" ] ]
        , specification spec
        ]


repeat2 : Spec
repeat2 =
    let
        desc =
            description "Two vertically concatenated charts that show a histogram of precipitation in Seattle and the relationship between min and max temperature"

        trans =
            transform
                << filter (fiExpr "datum.location === 'Seattle'")

        enc1 =
            encoding
                << position X [ pName "date", pTimeUnit month, pOrdinal ]
                << position Y [ pName "precipitation", pQuant, pAggregate opMean ]

        spec1 =
            asSpec [ bar [], enc1 [] ]

        enc2 =
            encoding
                << position X [ pName "temp_min", pQuant, pBin [] ]
                << position Y [ pName "temp_max", pQuant, pBin [] ]
                << size [ mAggregate opCount, mQuant ]

        spec2 =
            asSpec [ point [], enc2 [] ]
    in
    toVegaLite
        [ desc
        , trans []
        , dataFromUrl "https://vega.github.io/vega-lite/data/weather.csv" []
        , vConcat [ spec1, spec2 ]
        ]


repeat3 : Spec
repeat3 =
    let
        des =
            description "Horizontally repeated charts that show the histograms of different parameters of cars in different countries"

        enc =
            encoding
                << position X [ pRepeat arColumn, pQuant, pBin [] ]
                << position Y [ pQuant, pAggregate opCount ]
                << color [ mName "Origin", mNominal ]

        spec =
            asSpec
                [ dataFromUrl "https://vega.github.io/vega-lite/data/cars.json" []
                , bar []
                , enc []
                ]
    in
    toVegaLite
        [ des
        , repeat [ columnFields [ "Horsepower", "Miles_per_Gallon", "Acceleration" ] ]
        , specification spec
        ]


repeat4 : Spec
repeat4 =
    let
        des =
            description "Scatterplot matrix"

        sel =
            selection
                << select "myBrush"
                    seInterval
                    [ seOn "[mousedown[event.shiftKey], window:mouseup] > window:mousemove!"
                    , seTranslate "[mousedown[event.shiftKey], window:mouseup] > window:mousemove!"
                    , seZoom "wheel![event.shiftKey]"
                    , seResolve seUnion
                    ]
                << select "grid"
                    seInterval
                    [ seBindScales
                    , seTranslate "[mousedown[!event.shiftKey], window:mouseup] > window:mousemove!"
                    , seZoom "wheel![event.shiftKey]"
                    , seResolve seGlobal
                    ]

        enc =
            encoding
                << position X [ pRepeat arColumn, pQuant ]
                << position Y [ pRepeat arRow, pQuant ]
                << color
                    [ mSelectionCondition (selectionName "myBrush")
                        [ mName "Origin", mNominal ]
                        [ mStr "grey" ]
                    ]

        spec =
            asSpec
                [ dataFromUrl "https://vega.github.io/vega-lite/data/cars.json" []
                , point []
                , sel []
                , enc []
                ]
    in
    toVegaLite
        [ des
        , repeat
            [ rowFields [ "Horsepower", "Acceleration", "Miles_per_Gallon" ]
            , columnFields [ "Miles_per_Gallon", "Acceleration", "Horsepower" ]
            ]
        , specification spec
        ]


repeat5 : Spec
repeat5 =
    let
        des =
            description "Marginal histograms show the counts along the x and y dimension"

        encPosition =
            encoding
                << position X [ pName "IMDB_Rating", pQuant, pBin [ biMaxBins 10 ] ]
                << position Y [ pName "Rotten_Tomatoes_Rating", pQuant, pBin [ biMaxBins 10 ] ]

        cfg =
            configure
                << configuration (coRange [ racoHeatmap "greenblue" ])
                << configuration (coView [ vicoStroke Nothing ])

        enc1 =
            encoding
                << position X [ pName "IMDB_Rating", pQuant, pAxis [], pBin [] ]
                << position Y
                    [ pAggregate opCount
                    , pQuant
                    , pScale [ scDomain (doNums [ 0, 1000 ]) ]
                    , pAxis [ axTitle "" ]
                    ]

        spec1 =
            asSpec [ height 60, bar [], enc1 [] ]

        spec2 =
            asSpec [ spacing 15, bounds boFlush, hConcat [ spec2_1, spec2_2 ] ]

        enc2_1 =
            encoding
                << position X [ pName "IMDB_Rating", pQuant, pBin [] ]
                << position Y [ pName "Rotten_Tomatoes_Rating", pQuant, pBin [] ]
                << color [ mAggregate opCount, mQuant ]

        spec2_1 =
            asSpec [ rect [], enc2_1 [] ]

        enc2_2 =
            encoding
                << position Y
                    [ pName "Rotten_Tomatoes_Rating"
                    , pQuant
                    , pBin []
                    , pAxis []
                    ]
                << position X
                    [ pAggregate opCount
                    , pQuant
                    , pScale [ scDomain (doNums [ 0, 1000 ]) ]
                    , pAxis [ axTitle "" ]
                    ]

        spec2_2 =
            asSpec [ width 60, bar [], enc2_2 [] ]
    in
    toVegaLite
        [ des
        , cfg []
        , spacing 15
        , bounds boFlush
        , dataFromUrl "https://vega.github.io/vega-lite/data/movies.json" []
        , vConcat [ spec1, spec2 ]
        ]


repeat6 : Spec
repeat6 =
    let
        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/population.json" []

        cfg =
            configure
                << configuration (coAxis [ axcoGrid False ])
                << configuration (coView [ vicoStroke Nothing ])

        trans =
            transform
                << filter (fiExpr "datum.year == 2000")

        transF =
            transform << filter (fiEqual "sex" (num 2))

        encF =
            encoding
                << position Y [ pName "age", pOrdinal, pAxis [], pSort [ soDescending ] ]
                << position X
                    [ pName "people"
                    , pQuant
                    , pAggregate opSum
                    , pAxis [ axTitle "population", axFormat "s" ]
                    , pSort [ soDescending ]
                    ]

        specF =
            asSpec [ title "Female" [], transF [], encF [], bar [ maColor "#675193" ] ]

        encGap =
            encoding
                << position Y [ pName "age", pOrdinal, pAxis [], pSort [ soDescending ] ]
                << text [ tName "age", tQuant ]

        specGap =
            asSpec [ width 20, encGap [], textMark [ maAlign haCenter ] ]

        transM =
            transform << filter (fiEqual "sex" (num 1))

        encM =
            encoding
                << position Y [ pName "age", pOrdinal, pAxis [], pSort [ soDescending ] ]
                << position X
                    [ pName "people"
                    , pQuant
                    , pAggregate opSum
                    , pAxis [ axTitle "population", axFormat "s" ]
                    ]

        specM =
            asSpec [ title "Male" [], transM [], encM [], bar [ maColor "#ca8861" ] ]
    in
    toVegaLite
        [ cfg []
        , data
        , trans []
        , spacing 0
        , hConcat [ specF, specGap, specM ]
        ]



{- This list comprises the specifications to be provided to the Vega-Lite runtime. -}


mySpecs : Spec
mySpecs =
    combineSpecs
        [ ( "repeat1", repeat1 )
        , ( "repeat2", repeat2 )
        , ( "repeat3", repeat3 )
        , ( "repeat4", repeat4 )
        , ( "repeat5", repeat5 )
        , ( "repeat6", repeat6 )
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
