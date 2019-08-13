port module GalleryError exposing (elmToJS)

import Platform
import VegaLite exposing (..)



-- NOTE: All data sources in these examples originally provided at
-- https://github.com/vega/vega-datasets
-- The examples themselves reproduce those at https://vega.github.io/vega-lite/examples/


error1 : Spec
error1 =
    let
        des =
            description "Error bars showing confidence intervals"

        encVariety =
            encoding << position Y [ pName "variety", pOrdinal ]

        encPoints =
            encoding
                << position X
                    [ pName "yield"
                    , pQuant
                    , pAggregate opMean
                    , pScale [ scZero False ]
                    , pAxis [ axTitle "Barley Yield" ]
                    ]
                << color [ mStr "black" ]

        specPoints =
            asSpec [ point [ maFilled True ], encPoints [] ]

        encCIs =
            encoding
                << position X
                    [ pName "yield"
                    , pQuant
                    , pAggregate opCI0
                    ]
                << position X2 [ pName "yield", pAggregate opCI1 ]

        specCIs =
            asSpec [ rule [], encCIs [] ]
    in
    toVegaLite
        [ des
        , dataFromUrl "https://vega.github.io/vega-lite/data/barley.json" []
        , encVariety []
        , layer [ specPoints, specCIs ]
        ]


error2 : Spec
error2 =
    let
        des =
            description "Error bars showing standard deviations"

        trans =
            transform
                << aggregate [ opAs opMean "yield" "mean", opAs opStdev "yield" "stdev" ] [ "variety" ]
                << calculateAs "datum.mean-datum.stdev" "lower"
                << calculateAs "datum.mean+datum.stdev" "upper"

        encVariety =
            encoding << position Y [ pName "variety", pOrdinal ]

        encMeans =
            encoding
                << position X
                    [ pName "mean"
                    , pQuant
                    , pScale [ scZero False ]
                    , pAxis [ axTitle "Barley Yield" ]
                    ]
                << color [ mStr "black" ]

        specMeans =
            asSpec [ point [ maFilled True ], encMeans [] ]

        encStdevs =
            encoding
                << position X [ pName "upper", pQuant ]
                << position X2 [ pName "lower", pQuant ]

        specStdevs =
            asSpec [ rule [], encStdevs [] ]
    in
    toVegaLite
        [ des
        , dataFromUrl "https://vega.github.io/vega-lite/data/barley.json" []
        , trans []
        , encVariety []
        , layer [ specMeans, specStdevs ]
        ]


error3 : Spec
error3 =
    let
        des =
            description "Line chart with confidence interval band."

        encTime =
            encoding << position X [ pName "Year", pTemporal, pTimeUnit year ]

        encBand =
            encoding
                << position Y
                    [ pName "Miles_per_Gallon"
                    , pQuant
                    , pAggregate opCI0
                    , pAxis [ axTitle "Miles/Gallon" ]
                    ]
                << position Y2 [ pName "Miles_per_Gallon", pAggregate opCI1 ]
                << opacity [ mNum 0.3 ]

        specBand =
            asSpec [ area [], encBand [] ]

        encLine =
            encoding
                << position Y
                    [ pName "Miles_per_Gallon"
                    , pQuant
                    , pAggregate opMean
                    ]

        specLine =
            asSpec [ line [], encLine [] ]
    in
    toVegaLite
        [ des
        , dataFromUrl "https://vega.github.io/vega-lite/data/cars.json" []
        , encTime []
        , layer [ specBand, specLine ]
        ]


error4 : Spec
error4 =
    let
        des =
            description "A scatterplot showing horsepower and miles per gallon for various cars with a global mean and standard deviation overlay."

        encPoints =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]

        specPoints =
            asSpec [ point [], encPoints [] ]

        trans =
            transform
                << aggregate
                    [ opAs opMean "Miles_per_Gallon" "mean_MPG"
                    , opAs opStdev "Miles_per_Gallon" "dev_MPG"
                    ]
                    []
                << calculateAs "datum.mean_MPG+datum.dev_MPG" "upper"
                << calculateAs "datum.mean_MPG-datum.dev_MPG" "lower"

        encMean =
            encoding << position Y [ pName "mean_MPG", pQuant ]

        specMean =
            asSpec [ rule [], encMean [] ]

        encRect =
            encoding
                << position Y [ pName "lower", pQuant ]
                << position Y2 [ pName "upper" ]
                << opacity [ mNum 0.2 ]

        specRect =
            asSpec [ rect [], encRect [] ]

        specSpread =
            asSpec [ trans [], layer [ specMean, specRect ] ]
    in
    toVegaLite
        [ des
        , dataFromUrl "https://vega.github.io/vega-lite/data/cars.json" []
        , layer [ specPoints, specSpread ]
        ]



{- This list comprises the specifications to be provided to the Vega-Lite runtime. -}


mySpecs : Spec
mySpecs =
    combineSpecs
        [ ( "error1", error1 )
        , ( "error2", error2 )
        , ( "error3", error3 )
        , ( "error4", error4 )
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
