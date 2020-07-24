port module GalleryError exposing (elmToJS)

import Platform
import VegaLite exposing (..)



-- NOTE: All data sources in these examples originally provided at
-- https://github.com/vega/vega-datasets
-- The examples themselves reproduce those at https://vega.github.io/vega-lite/examples/


path : String
path =
    "https://cdn.jsdelivr.net/npm/vega-datasets@2.1/data/"


error1 : Spec
error1 =
    let
        desc =
            description "Error bars showing confidence intervals"

        data =
            dataFromUrl (path ++ "barley.json") []

        encVariety =
            encoding
                << position Y [ pName "variety", pOrdinal ]

        encPoints =
            encoding
                << position X
                    [ pName "yield"
                    , pQuant
                    , pAggregate opMean
                    , pScale [ scZero False ]
                    , pTitle "Barley Yield"
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
            asSpec [ encCIs [], rule [] ]
    in
    toVegaLite [ desc, data, encVariety [], layer [ specPoints, specCIs ] ]


error2 : Spec
error2 =
    let
        desc =
            description "Error bars showing standard deviations"

        data =
            dataFromUrl (path ++ "barley.json") []

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
                    , pTitle "Barley Yield"
                    ]
                << color [ mStr "black" ]

        specMeans =
            asSpec [ encMeans [], point [ maFilled True ] ]

        encStdevs =
            encoding
                << position X [ pName "upper", pQuant ]
                << position X2 [ pName "lower", pQuant ]

        specStdevs =
            asSpec [ encStdevs [], rule [] ]
    in
    toVegaLite [ desc, data, trans [], encVariety [], layer [ specMeans, specStdevs ] ]


error3 : Spec
error3 =
    let
        desc =
            description "Line chart with confidence interval band."

        data =
            dataFromUrl (path ++ "cars.json") []

        encTime =
            encoding
                << position X [ pName "Year", pTemporal, pTimeUnit year ]

        encBand =
            encoding
                << position Y
                    [ pName "Miles_per_Gallon"
                    , pQuant
                    , pAggregate opCI0
                    , pTitle "Miles per gallon with 95% CIs"
                    ]
                << position Y2 [ pName "Miles_per_Gallon", pAggregate opCI1 ]
                << opacity [ mNum 0.3 ]

        specBand =
            asSpec [ encBand [], area [] ]

        encLine =
            encoding
                << position Y [ pName "Miles_per_Gallon", pQuant, pAggregate opMean ]

        specLine =
            asSpec [ encLine [], line [] ]
    in
    toVegaLite [ desc, data, encTime [], layer [ specBand, specLine ] ]


error4 : Spec
error4 =
    let
        desc =
            description "A scatterplot showing horsepower and miles per gallon for various cars with a global mean and standard deviation overlay."

        data =
            dataFromUrl (path ++ "cars.json") []

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
            encoding << position Y [ pName "mean_MPG", pQuant, pTitle "Miles per gallon" ]

        specMean =
            asSpec [ encMean [], rule [] ]

        encRect =
            encoding
                << position Y [ pName "lower", pQuant ]
                << position Y2 [ pName "upper" ]
                << opacity [ mNum 0.2 ]

        specRect =
            asSpec [ encRect [], rect [] ]

        specSpread =
            asSpec [ trans [], layer [ specMean, specRect ] ]
    in
    toVegaLite [ desc, data, layer [ specPoints, specSpread ] ]



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
