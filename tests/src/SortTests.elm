port module SortTests exposing (elmToJS)

import Browser
import Dict exposing (Dict)
import Html exposing (Html)
import Html.Attributes
import Html.Events
import Json.Encode
import VegaLite exposing (..)


sortQuant : String -> List SortProperty -> Spec
sortQuant yField sps =
    let
        data =
            -- dataFromUrl "https://vega.github.io/vega-lite/data/cars.json"
            dataFromColumns []
                << dataColumn "Horsepower" (nums [ 1, 5, 2, 3, 4 ])
                << dataColumn "Weight_in_lbs" (nums [ 19, 21, 58, 12, 13 ])

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant, pSort sps ]
                << position Y [ pName yField, pQuant ]
                << order [ oName yField, oOrdinal ]
    in
    toVegaLite [ height 300, data [], enc [], line [ maStrokeWidth 0.5 ] ]


sortAsc : Spec
sortAsc =
    sortQuant "Horsepower" [ soAscending ]


sortDesc : Spec
sortDesc =
    sortQuant "Horsepower" [ soDescending ]


sortWeight : Spec
sortWeight =
    sortQuant "Weight_in_lbs" [ soByField "Weight_in_lbs" opMean ]


sortCustom : Spec
sortCustom =
    let
        data =
            dataFromColumns []
                << dataColumn "a" (strs [ "A", "B", "C", "Z", "Y", "X" ])
                << dataColumn "b" (nums [ 28, 55, 43, 91, 81, 53 ])

        enc =
            encoding
                << position X [ pName "a", pSort [ soCustom (strs [ "B", "A", "C" ]) ] ]
                << position Y [ pName "b", pQuant ]
    in
    toVegaLite [ data [], enc [], bar [] ]


stack1 : Spec
stack1 =
    let
        cars =
            dataFromUrl "https://vega.github.io/vega-lite/data/cars.json" []

        trans =
            transform
                << aggregate [ opAs opCount "" "count_*" ] [ "Origin", "Cylinders" ]
                << stack "count_*"
                    []
                    "stack_count_Origin1"
                    "stack_count_Origin2"
                    [ stOffset stNormalize, stSort [ stAscending "Origin" ] ]
                << window
                    [ ( [ wiAggregateOp opMin, wiField "stack_count_Origin1" ], "x" )
                    , ( [ wiAggregateOp opMax, wiField "stack_count_Origin2" ], "x2" )
                    ]
                    [ wiFrame Nothing Nothing, wiGroupBy [ "Origin" ] ]
                << stack "count_*"
                    [ "Origin" ]
                    "y"
                    "y2"
                    [ stOffset stNormalize, stSort [ stAscending "Cylinders" ] ]

        enc =
            encoding
                << position X [ pName "x", pQuant, pAxis [] ]
                << position X2 [ pName "x2" ]
                << position Y [ pName "y", pQuant, pAxis [] ]
                << position Y2 [ pName "y2" ]
                << color [ mName "Origin" ]
                << opacity [ mName "Cylinders", mQuant, mLegend [] ]
                << tooltips [ [ tName "Origin" ], [ tName "Cylinders", tQuant ] ]
    in
    toVegaLite [ cars, trans [], enc [], rect [] ]



{- This list comprises the specifications to be provided to the Vega-Lite runtime. -}


specs : List ( String, Spec )
specs =
    [ ( "sortAsc", sortAsc )
    , ( "sortDesc", sortDesc )
    , ( "sortWeight", sortWeight )
    , ( "sortCustom", sortCustom )
    , ( "stack1", stack1 )
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
