port module AxisTests exposing (elmToJS)

import Platform
import VegaLite exposing (..)


data : List DataColumn -> Data
data =
    dataFromColumns []
        << dataColumn "x" (List.range 1 100 |> List.map toFloat |> nums)
        << dataColumn "catX" (List.range 1 100 |> List.map String.fromInt |> strs)
        << dataColumn "y" (List.range 1 10 |> List.map toFloat |> nums)


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


qAxisBase : Maybe ConfigurationProperty -> Spec
qAxisBase maybeCfg =
    let
        cfg =
            case maybeCfg of
                Just axCfg ->
                    configure
                        << configuration axCfg

                Nothing ->
                    configure

        enc =
            encoding
                << position X [ pName "x", pQuant ]
                << position Y [ pName "y", pOrdinal ]
    in
    toVegaLite [ cfg [], data [], enc [], line [ maPoint (pmMarker []) ] ]


axis1 : Spec
axis1 =
    qAxisBase Nothing


axis1a : Spec
axis1a =
    qAxisBase (Just (coAxisQuant [ axcoGridColor "red" ]))


axis2 : Spec
axis2 =
    let
        enc =
            encoding
                << position X [ pName "x", pQuant ]
                << position Y [ pName "y", pQuant ]
    in
    toVegaLite [ widthOfContainer, data [], enc [], line [ maPoint (pmMarker []) ] ]


axis3 : Spec
axis3 =
    let
        enc =
            encoding
                << position X [ pName "catX", pOrdinal ]
                << position Y [ pName "y", pQuant ]
    in
    toVegaLite [ data [], enc [], line [ maPoint (pmMarker []) ] ]


tAxisBase : Maybe ConfigurationProperty -> Spec
tAxisBase maybeCfg =
    let
        cfg =
            case maybeCfg of
                Just axCfg ->
                    configure
                        << configuration axCfg

                Nothing ->
                    configure

        enc =
            encoding
                << position X [ pName "date", pTemporal ]
                << position Y [ pName "y", pQuant ]
    in
    toVegaLite [ cfg [], temporalData [], enc [], line [ maPoint (pmMarker []) ] ]


axis4 : Spec
axis4 =
    tAxisBase Nothing


axis4a : Spec
axis4a =
    tAxisBase (Just (coAxisTemporal [ axcoGridColor "red" ]))


axis5 : Spec
axis5 =
    let
        enc =
            encoding
                << position X
                    [ pName "x"
                    , pQuant
                    , pAxis [ axValues (nums [ 1, 25, 39, 90 ]) ]
                    ]
                << position Y [ pName "y", pQuant ]
    in
    toVegaLite [ data [], enc [], line [ maPoint (pmMarker []) ] ]


axis6 : Spec
axis6 =
    let
        enc =
            encoding
                << position X
                    [ pName "catX"
                    , pOrdinal
                    , pAxis [ axValues (strs [ "1", "25", "39", "dummy", "90" ]) ]
                    ]
                << position Y [ pName "y", pQuant ]
    in
    toVegaLite [ data [], enc [], line [ maPoint (pmMarker []) ] ]


axis7 : Spec
axis7 =
    let
        enc =
            encoding
                << position X
                    [ pName "date"
                    , pTemporal
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
                << position Y [ pName "y", pQuant ]
    in
    toVegaLite [ temporalData [], enc [], line [ maPoint (pmMarker []) ] ]


axis8 : Spec
axis8 =
    let
        enc =
            encoding
                << position X
                    [ pName "x"
                    , pQuant
                    , pAxis [ axLabelExpr "datum.value / 100" ]
                    ]
                << position Y [ pName "y", pQuant ]
    in
    toVegaLite [ data [], enc [], line [ maPoint (pmMarker []) ] ]


axis9 : Spec
axis9 =
    let
        enc =
            encoding
                << position X
                    [ pName "catX"
                    , pOrdinal
                    , pAxis [ axLabelExpr "'number '+ datum.label" ]
                    ]
                << position Y [ pName "y", pQuant ]
    in
    toVegaLite [ data [], enc [], line [ maPoint (pmMarker []) ] ]


axis10 : Spec
axis10 =
    let
        cfg =
            configure
                << configuration (coAxisX [ axcoLabelExpr "'number '+ datum.label" ])

        enc =
            encoding
                << position X [ pName "catX", pOrdinal ]
                << position Y [ pName "y", pQuant ]
    in
    toVegaLite [ cfg [], data [], enc [], line [ maPoint (pmMarker []) ] ]


axis11 : Spec
axis11 =
    let
        cfg =
            configure
                << configuration (coAxisX [ axcoLabelExpr "'number '+ datum.label" ])
                << configuration (coAxisY [ axcoTickCount 10 ])

        enc =
            encoding
                << position X [ pName "catX", pOrdinal ]
                << position Y [ pName "y", pQuant ]
    in
    toVegaLite [ cfg [], data [], enc [], line [ maPoint (pmMarker []) ] ]


axis12 : Spec
axis12 =
    let
        cfg =
            configure
                << configuration
                    (coAxisStyles
                        [ ( "redStyle", [ axDomainColor "red", axLabelColor "red", axTitleColor "red", axTickCount 10 ] )
                        , ( "blueStyle", [ axDomainColor "blue", axLabelColor "blue", axTitleColor "blue", axTickCount 10 ] )
                        ]
                    )

        enc =
            encoding
                << position X [ pName "catX", pOrdinal, pAxis [ axStyle [ "redStyle" ] ] ]
                << position Y [ pName "y", pQuant, pAxis [ axStyle [ "blueStyle" ] ] ]
    in
    toVegaLite [ cfg [], data [], enc [], line [ maPoint (pmMarker []) ] ]



-- Unlike titles, it would appear Vega-Lite does not allow axis styles to reference other named styles.
-- axis13 : Spec
-- axis13 =
--     let
--         cfg =
--             configure
--                 << configuration
--                     (coAxisStyles
--                         [ ( "tickStyle", [ axTickCount 10 ] )
--                         , ( "redStyle", [ axDomainColor "red", axLabelColor "red", axTitleColor "red" ] )
--                         , ( "blueStyle", [ axDomainColor "blue", axLabelColor "blue", axTitleColor "blue" ] )
--                         ]
--                     )
--                 << configuration (coAxis [ axcoStyle [ "tickStyle" ] ])
--                 << configuration (coAxisX [ axcoStyle [ "redStyle" ] ])
--                 << configuration (coAxisY [ axcoStyle [ "blueStyle" ] ])
--
--         enc =
--             encoding
--                 << position X [ pName "catX", pOrdinal ]
--                 << position Y [ pName "y", pQuant ]
--     in
--     toVegaLite [ cfg [], data [], enc [], line [ maPoint (pmMarker []) ] ]
{- This list comprises the specifications to be provided to the Vega-Lite runtime. -}


mySpecs : Spec
mySpecs =
    combineSpecs
        [ ( "axis1", axis1 )
        , ( "axis1a", axis1a )
        , ( "axis2", axis2 )
        , ( "axis3", axis3 )
        , ( "axis4", axis4 )
        , ( "axis4a", axis4a )
        , ( "axis5", axis5 )
        , ( "axis6", axis6 )
        , ( "axis7", axis7 )
        , ( "axis8", axis8 )
        , ( "axis9", axis9 )
        , ( "axis10", axis10 )
        , ( "axis11", axis11 )
        , ( "axis12", axis12 )

        -- , ( "axis13", axis13 )
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
