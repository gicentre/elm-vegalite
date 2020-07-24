port module GalleryRepeat exposing (elmToJS)

import Platform
import VegaLite exposing (..)



-- NOTE: All data sources in these examples originally provided at
-- https://github.com/vega/vega-datasets
-- The examples themselves reproduce those at https://vega.github.io/vega-lite/examples/


path : String
path =
    "https://cdn.jsdelivr.net/npm/vega-datasets@2.1/data/"


repeat1 : Spec
repeat1 =
    let
        desc =
            description "Monthly weather information for individual years and overall average for Seatle and New York"

        data =
            dataFromUrl (path ++ "weather.csv") []

        enc1 =
            encoding
                << position X [ pName "date", pOrdinal, pTimeUnit month ]
                << position Y [ pRepeat arColumn, pQuant, pAggregate opMean ]
                << detail [ dName "date", dTemporal, dTimeUnit year ]
                << color [ mName "location" ]
                << opacity [ mNum 0.2 ]

        spec1 =
            asSpec [ line [], enc1 [] ]

        enc2 =
            encoding
                << position X [ pName "date", pOrdinal, pTimeUnit month ]
                << position Y [ pRepeat arColumn, pQuant, pAggregate opMean ]
                << color [ mName "location" ]

        spec2 =
            asSpec [ line [], enc2 [] ]

        spec =
            asSpec [ layer [ spec1, spec2 ] ]
    in
    toVegaLite
        [ desc
        , data
        , repeat [ columnFields [ "temp_max", "precipitation", "wind" ] ]
        , specification spec
        ]


repeat2 : Spec
repeat2 =
    let
        desc =
            description "Two vertically concatenated charts that show a histogram of precipitation in Seattle and the relationship between min and max temperature"

        data =
            dataFromUrl (path ++ "weather.csv") []

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
    toVegaLite [ desc, data, trans [], vConcat [ spec1, spec2 ] ]


repeat3 : Spec
repeat3 =
    let
        desc =
            description "Horizontally repeated charts that show the histograms of different parameters of cars in different countries"

        data =
            dataFromUrl (path ++ "cars.json") []

        enc =
            encoding
                << position X [ pRepeat arColumn, pQuant, pBin [] ]
                << position Y [ pQuant, pAggregate opCount ]
                << color [ mName "Origin" ]
    in
    toVegaLite
        [ desc
        , repeat [ columnFields [ "Horsepower", "Miles_per_Gallon", "Acceleration" ] ]
        , specification (asSpec [ data, enc [], bar [] ])
        ]


repeat4 : Spec
repeat4 =
    let
        desc =
            description "Scatterplot matrix"

        data =
            dataFromUrl (path ++ "cars.json") []

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
                        [ mName "Origin" ]
                        [ mStr "grey" ]
                    ]
    in
    toVegaLite
        [ desc
        , repeat
            [ rowFields [ "Horsepower", "Acceleration", "Miles_per_Gallon" ]
            , columnFields [ "Miles_per_Gallon", "Acceleration", "Horsepower" ]
            ]
        , specification (asSpec [ data, sel [], enc [], point [] ])
        ]


repeat5 : Spec
repeat5 =
    let
        desc =
            description "Marginal histograms show the counts along the x and y dimension"

        data =
            dataFromUrl (path ++ "movies.json") []

        encPosition =
            encoding
                << position X [ pName "IMDB Rating", pQuant, pBin [ biMaxBins 10 ] ]
                << position Y [ pName "Rotten Tomatoes Rating", pQuant, pBin [ biMaxBins 10 ] ]

        cfg =
            configure
                << configuration (coRange [ racoHeatmap "greenblue" ])
                << configuration (coView [ vicoStroke Nothing ])

        enc1 =
            encoding
                << position X [ pName "IMDB Rating", pQuant, pAxis [], pBin [] ]
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
                << position X [ pName "IMDB Rating", pQuant, pBin [] ]
                << position Y [ pName "Rotten Tomatoes Rating", pQuant, pBin [] ]
                << color [ mAggregate opCount, mQuant ]

        spec2_1 =
            asSpec [ rect [], enc2_1 [] ]

        enc2_2 =
            encoding
                << position Y
                    [ pName "Rotten Tomatoes Rating"
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
        [ desc
        , cfg []
        , spacing 15
        , bounds boFlush
        , data
        , vConcat [ spec1, spec2 ]
        ]


repeat6 : Spec
repeat6 =
    let
        data =
            dataFromUrl (path ++ "population.json") []

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
