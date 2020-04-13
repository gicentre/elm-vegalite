port module AxisTests exposing (elmToJS)

import Browser
import Dict exposing (Dict)
import Html exposing (Html)
import Html.Attributes
import Html.Events
import Json.Encode
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
                << configuration (coAxisY [ axcoTickCount (niTickCount 10) ])

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
                        [ ( "redStyle", [ axDomainColor "red", axLabelColor "red", axTitleColor "red", axTickCount (niTickCount 10) ] )
                        , ( "blueStyle", [ axDomainColor "blue", axLabelColor "blue", axTitleColor "blue", axTickCount (niTickCount 10) ] )
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
--                         [ ( "tickStyle", [ axTickCount (niTickCount 10) ] )
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


axis14 : Spec
axis14 =
    let
        enc =
            encoding
                << position X
                    [ pName "catX"
                    , pOrdinal
                    , pAxis
                        [ axLabelAngle 0
                        , axDataCondition (expr "datum.label < 10") (cAxLabelOffset 0 -4)
                        ]
                    ]
                << position Y [ pName "y", pQuant ]
    in
    toVegaLite [ data [], enc [], line [ maPoint (pmMarker []) ] ]



{- Ids and specifications to be provided to the Vega-Lite runtime. -}


specs : List ( String, Spec )
specs =
    [ ( "axis01", axis1 )
    , ( "axis01a", axis1a )
    , ( "axis02", axis2 )
    , ( "axis03", axis3 )
    , ( "axis04", axis4 )
    , ( "axis04a", axis4a )
    , ( "axis05", axis5 )
    , ( "axis06", axis6 )
    , ( "axis07", axis7 )
    , ( "axis08", axis8 )
    , ( "axis09", axis9 )
    , ( "axis10", axis10 )
    , ( "axis11", axis11 )
    , ( "axis12", axis12 )

    -- , ( "axis13", axis13 )
    , ( "axis14", axis14 )
    ]



{- ---------------------------------------------------------------------------
   BOILERPLATE: NO NEED TO EDIT

   The code below creates an Elm module that opens an outgoing port to Javascript
   and sends both the specs and DOM node to it.
   It allows the source code of any of the generated specs to be selected from
   a drop-down list. Useful for viewin specs that might generate invalid Vega-Lite.
-}


type Msg
    = NewSource String
    | NoSource


main : Program () Spec Msg
main =
    Browser.element
        { init = always ( Json.Encode.null, specs |> combineSpecs |> elmToJS )
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }


view : Spec -> Html Msg
view spec =
    Html.div []
        [ Html.select [ Html.Events.onInput NewSource ]
            (( "Select source", Json.Encode.null )
                :: specs
                |> List.map (\( s, _ ) -> Html.option [ Html.Attributes.value s ] [ Html.text s ])
            )
        , Html.div [ Html.Attributes.id "specSource" ] []
        , if spec == Json.Encode.null then
            Html.div [] []

          else
            Html.pre [] [ Html.text (Json.Encode.encode 2 spec) ]
        ]


update : Msg -> Spec -> ( Spec, Cmd Msg )
update msg model =
    case msg of
        NewSource srcName ->
            ( specs |> Dict.fromList |> Dict.get srcName |> Maybe.withDefault Json.Encode.null, Cmd.none )

        NoSource ->
            ( Json.Encode.null, Cmd.none )


port elmToJS : Spec -> Cmd msg
