port module TrailTests exposing (elmToJS)

import Browser
import Dict exposing (Dict)
import Html exposing (Html)
import Html.Attributes
import Html.Events
import Json.Encode
import VegaLite exposing (..)


path : String
path =
    "https://cdn.jsdelivr.net/npm/vega-datasets@2.1/data/"


trail1 : Spec
trail1 =
    let
        data =
            dataFromUrl (path ++ "stocks.csv") []

        enc =
            encoding
                << position X [ pName "date", pTemporal, pAxis [ axFormat "%Y" ] ]
                << position Y [ pName "price", pQuant ]
                << size [ mName "price", mQuant ]
                << color [ mName "symbol" ]
    in
    toVegaLite [ width 400, height 400, data, enc [], trail [] ]


trail2 : Spec
trail2 =
    let
        data =
            dataFromUrl (path ++ "driving.json") []

        enc =
            encoding
                << position X [ pName "miles", pQuant, pScale [ scZero False ] ]
                << position Y [ pName "gas", pQuant, pScale [ scZero False ] ]
                << size [ mName "year", mTemporal, mLegend [] ]
    in
    toVegaLite [ data, enc [], trail [ maOrder False ] ]



{- Ids and specifications to be provided to the Vega-Lite runtime. -}


specs : List ( String, Spec )
specs =
    [ ( "trail1", trail1 )
    , ( "trail2", trail2 )
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
