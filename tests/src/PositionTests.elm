port module PositionTests exposing (elmToJS)

import Browser
import Dict
import Html exposing (Html)
import Html.Attributes
import Html.Events
import Json.Encode
import VegaLite exposing (..)


emptyData : List DataColumn -> Data
emptyData =
    dataFromColumns []
        << dataColumn "empty" (nums [ 0 ])


data : List DataColumn -> Data
data =
    dataFromColumns []
        << dataColumn "cat" (nums [ 1, 2, 3, 4, 5 ])
        << dataColumn "val" (nums [ 10, 20, 30, 20, 10 ])


position1 : Spec
position1 =
    toVegaLite [ emptyData [], circle [ maX 150, maY 150, maSize 200 ] ]


position2 : Spec
position2 =
    toVegaLite [ emptyData [], bar [ maX 150, maY 150 ] ]


position3 : Spec
position3 =
    toVegaLite [ emptyData [], bar [ maX 150, maY 150, maX2 200 ] ]


position4 : Spec
position4 =
    toVegaLite [ emptyData [], bar [ maX 150, maY 150, maY2 200 ] ]


position5 : Spec
position5 =
    toVegaLite [ emptyData [], bar [ maX 150, maY 150, maX2 200, maY2 200 ] ]


position6 : Spec
position6 =
    let
        enc =
            encoding
                << position X [ pName "cat", pOrdinal ]
                << position Y [ pName "val", pQuant ]
    in
    toVegaLite [ width 300, data [], enc [], bar [ maWidth 20 ] ]


position7 : Spec
position7 =
    let
        enc =
            encoding
                << position X [ pName "val", pQuant ]
                << position Y [ pName "cat", pOrdinal ]
    in
    toVegaLite [ height 300, data [], enc [], bar [ maHeight 20 ] ]


barAlign : Float -> Spec
barAlign x =
    let
        enc =
            encoding
                << position X
                    [ pName "cat"
                    , pOrdinal
                    , pScale [ scAlign x, scPaddingInner 0.5 ]
                    ]
                << position Y [ pName "val", pQuant ]
    in
    toVegaLite [ width 400, data [], enc [], bar [] ]


position8 : Spec
position8 =
    barAlign 0


position9 : Spec
position9 =
    barAlign 0.3


position10 : Spec
position10 =
    barAlign 0.5


position11 : Spec
position11 =
    barAlign 0.7


position12 : Spec
position12 =
    barAlign 1



{- Ids and specifications to be provided to the Vega-Lite runtime. -}


specs : List ( String, Spec )
specs =
    [ ( "position1", position1 )
    , ( "position2", position2 )
    , ( "position3", position3 )
    , ( "position4", position4 )
    , ( "position5", position5 )
    , ( "position6", position6 )
    , ( "position7", position7 )
    , ( "position8", position8 )
    , ( "position9", position9 )
    , ( "position10", position10 )
    , ( "position11", position11 )
    , ( "position12", position12 )
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
