port module AxisTests exposing (elmToJS)

import Platform
import VegaLite exposing (..)


data : List DataColumn -> Data
data =
    dataFromColumns []
        << dataColumn "x" (List.range 1 100 |> List.map toFloat |> nums)
        << dataColumn "catX" (List.range 1 100 |> List.map String.fromInt |> strs)
        << dataColumn "y" (List.range 1 100 |> List.map toFloat |> nums)


temporalData : List DataColumn -> Data
temporalData =
    dataFromColumns []
        << dataColumn "date"
            (strs
                [ "2019-01-01 09:00:00"
                , "2019-01-02 09:00:00"
                , "2019-01-03 09:00:00"
                , "2019-01-04 09:00:00"
                , "2019-01-05 09:00:00"
                , "2019-01-06 09:00:00"
                , "2019-01-07 09:00:00"
                , "2019-01-08 09:00:00"
                , "2019-01-09 09:00:00"
                , "2019-01-10 09:00:00"
                , "2019-01-11 09:00:00"
                , "2019-01-12 09:00:00"
                ]
            )
        << dataColumn "y" (nums [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 ])


axis1 : Spec
axis1 =
    let
        enc =
            encoding
                << position X [ pName "x", pMType Quantitative ]
                << position Y [ pName "y", pMType Quantitative ]
    in
    toVegaLite [ data [], enc [], line [ maPoint (pmMarker []) ] ]


axis2 : Spec
axis2 =
    let
        enc =
            encoding
                << position X [ pName "catX", pMType Ordinal ]
                << position Y [ pName "y", pMType Quantitative ]
    in
    toVegaLite [ data [], enc [], line [ maPoint (pmMarker []) ] ]


axis3 : Spec
axis3 =
    let
        enc =
            encoding
                << position X [ pName "date", pMType Temporal ]
                << position Y [ pName "y", pMType Quantitative ]
    in
    toVegaLite [ temporalData [], enc [], line [ maPoint (pmMarker []) ] ]


axis4 : Spec
axis4 =
    let
        enc =
            encoding
                << position X
                    [ pName "x"
                    , pMType Quantitative
                    , pAxis [ axValues (nums [ 1, 25, 39, 90 ]) ]
                    ]
                << position Y [ pName "y", pMType Quantitative ]
    in
    toVegaLite [ data [], enc [], line [ maPoint (pmMarker []) ] ]


axis5 : Spec
axis5 =
    let
        enc =
            encoding
                << position X
                    [ pName "catX"
                    , pMType Ordinal
                    , pAxis [ axValues (strs [ "1", "25", "39", "dummy", "90" ]) ]
                    ]
                << position Y [ pName "y", pMType Quantitative ]
    in
    toVegaLite [ data [], enc [], line [ maPoint (pmMarker []) ] ]


axis6 : Spec
axis6 =
    let
        enc =
            encoding
                << position X
                    [ pName "date"
                    , pMType Temporal
                    , pAxis
                        [ axValues
                            (dts
                                [ [ dtYear 2019, dtMonth Jan, dtDate 4 ]
                                , [ dtYear 2019, dtMonth Jan, dtDate 8 ]
                                , [ dtYear 2019, dtMonth Jan, dtDate 20 ]
                                ]
                            )
                        ]
                    ]
                << position Y [ pName "y", pMType Quantitative ]
    in
    toVegaLite [ temporalData [], enc [], line [ maPoint (pmMarker []) ] ]



{- This list comprises the specifications to be provided to the Vega-Lite runtime. -}


mySpecs : Spec
mySpecs =
    combineSpecs
        [ ( "axis1", axis1 )
        , ( "axis2", axis2 )
        , ( "axis3", axis3 )
        , ( "axis4", axis4 )
        , ( "axis5", axis5 )
        , ( "axis6", axis6 )
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
