port module ParamTests exposing (elmToJS)

import Browser
import Dict
import Html exposing (Html)
import Html.Attributes
import Html.Events
import Json.Encode
import VegaLite exposing (..)


path : String
path =
    "https://cdn.jsdelivr.net/npm/vega-datasets@2.2/data/"


param1 : Spec
param1 =
    let
        data =
            dataFromColumns []
                << dataColumn "a" (strs [ "A", "B", "C", "D", "E", "F", "G", "H", "I" ])
                << dataColumn "b" (nums [ 28, 55, 43, 91, 81, 53, 19, 87, 52 ])

        ps =
            params [ ( "radius", [ paValue (num 5) ] ) ]

        enc =
            encoding
                << position X [ pName "a", pAxis [ axLabelAngle 0 ] ]
                << position Y [ pName "b", pQuant ]
    in
    toVegaLite [ ps, data [], enc [], bar [ maCornerRadius |> maNumExpr "radius" ] ]


param2 : Spec
param2 =
    let
        data =
            dataFromColumns []
                << dataColumn "a" (strs [ "A", "B", "C", "D", "E", "F", "G", "H", "I" ])
                << dataColumn "b" (nums [ 28, 55, 43, 91, 81, 53, 19, 87, 52 ])

        ps =
            params
                [ ( "radius"
                  , [ paValue (num 0)
                    , paBind (ipRange [ inMin 0, inMax 20, inStep 1 ])
                    ]
                  )
                ]

        enc =
            encoding
                << position X [ pName "a", pAxis [ axLabelAngle 0 ] ]
                << position Y [ pName "b", pQuant ]
    in
    toVegaLite [ ps, data [], enc [], bar [ maCornerRadius |> maNumExpr "radius" ] ]


param3 : Spec
param3 =
    let
        cfg =
            configure
                << configuration (coTick [ maThickness 2 ])

        data =
            dataFromJson
                (Json.Encode.list identity
                    [ Json.Encode.object
                        [ ( "ranges", Json.Encode.list Json.Encode.float [ 150, 225, 300 ] )
                        , ( "measures", Json.Encode.list Json.Encode.float [ 220, 270 ] )
                        , ( "markers", Json.Encode.list Json.Encode.float [ 250 ] )
                        ]
                    ]
                )

        ps =
            params
                [ ( "innerBarSize", [ paExpr "height/2" ] )
                , ( "height"
                  , [ paValue (num 20)
                    , paBind (ipRange [ inMin 1, inMax 100, inStep 1 ])
                    ]
                  )
                ]

        enc =
            encoding
                << position X [ pQuant, pScale [ scNice niFalse ], pTitle "" ]

        enc1 =
            encoding << position X [ pName "ranges[2]" ]

        spec1 =
            asSpec [ enc1 [], bar [ maColor "#eee", maSize |> maNumExpr "height" ] ]

        enc2 =
            encoding << position X [ pName "ranges[1]" ]

        spec2 =
            asSpec [ enc2 [], bar [ maColor "#ddd", maSize |> maNumExpr "height" ] ]

        enc3 =
            encoding << position X [ pName "ranges[0]" ]

        spec3 =
            asSpec [ enc3 [], bar [ maColor "#ccc", maSize |> maNumExpr "height" ] ]

        enc4 =
            encoding << position X [ pName "measures[1]" ]

        spec4 =
            asSpec [ enc4 [], bar [ maColor "lightsteelblue", maSize |> maNumExpr "innerBarSize" ] ]

        enc5 =
            encoding << position X [ pName "measures[0]" ]

        spec5 =
            asSpec [ enc5 [], bar [ maColor "steelblue", maSize |> maNumExpr "innerBarSize" ] ]

        enc6 =
            encoding << position X [ pName "markers[0]" ]

        spec6 =
            asSpec [ enc6 [], tick [ maColor "black", maSize |> maNumExpr "height" ] ]
    in
    toVegaLite [ cfg [], ps, data [], enc [], layer [ spec1, spec2, spec3, spec4, spec5, spec6 ] ]


param4 : Spec
param4 =
    let
        data =
            dataFromUrl (path ++ "cars.json") []

        ps =
            params
                [ ( "pts", [ paSelect paInterval ] ) ]

        enc =
            encoding
                << position X [ pName "Cylinders" ]
                << position Y [ pName "Origin" ]
                << color
                    -- TODO: Provide new VL5 selection specification
                    [ mSelectionCondition (selectionName "pts")
                        [ mAggregate opCount ]
                        [ mStr "grey" ]
                    ]
    in
    toVegaLite [ width 240, ps, data, enc [], rect [] ]



{- Ids and specifications to be provided to the Vega-Lite runtime. -}


specs : List ( String, Spec )
specs =
    [ ( "param1", param1 )
    , ( "param2", param2 )
    , ( "param3", param3 )
    , ( "param4", param4 )
    ]



{- ---------------------------------------------------------------------------
   BOILERPLATE: NO NEED TO EDIT

   The code below creates an Elm module that opens an outgoing port to Javascript
   and sends both the specs and DOM node to it.
   It allows the source code of any of the generated specs to be selected from
   a drop-down list. Useful for viewing specs that might generate invalid Vega-Lite.
-}


type Msg
    = NewSource String


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
update msg _ =
    case msg of
        NewSource srcName ->
            ( specs |> Dict.fromList |> Dict.get srcName |> Maybe.withDefault Json.Encode.null, Cmd.none )


port elmToJS : Spec -> Cmd msg
