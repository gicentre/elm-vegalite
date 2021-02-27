port module HyperlinkTests exposing (elmToJS)

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


hyperlink1 : Spec
hyperlink1 =
    let
        data =
            dataFromColumns []
                << dataColumn "label" (strs [ "Vega", "Vega-Lite" ])
                << dataColumn "url" (strs [ "https://vega.github.io/vega", "https://vega.github.io/vega-lite" ])

        encCircle =
            encoding
                << position X [ pName "label", pAxis [] ]
                << size [ mNum 8000 ]
                << color [ mName "label", mLegend [] ]
                << hyperlink [ hName "url" ]

        encLabel =
            encoding
                << position X [ pName "label", pAxis [] ]
                << text [ tName "label" ]
                << color [ mStr "white" ]
                << size [ mNum 16 ]

        symbolSpec =
            asSpec [ circle [ maCursor cuPointer ], encCircle [] ]

        labelSpec =
            asSpec [ textMark [], encLabel [] ]
    in
    toVegaLite
        [ data [], layer [ symbolSpec, labelSpec ] ]


hyperlink2 : Spec
hyperlink2 =
    let
        data =
            dataFromUrl (path ++ "movies.json") []

        enc =
            encoding
                << position X [ pName "IMDB Rating", pQuant ]
                << position Y [ pName "Rotten Tomatoes Rating", pQuant ]
                << hyperlink [ hStr "http://www.imdb.com" ]
    in
    toVegaLite [ data, point [ maCursor cuPointer ], enc [] ]


hyperlink3 : Spec
hyperlink3 =
    let
        data =
            dataFromUrl (path ++ "movies.json") []

        enc =
            encoding
                << position X [ pName "IMDB Rating", pQuant ]
                << position Y [ pName "Rotten Tomatoes Rating", pQuant ]
                << color
                    [ mDataCondition
                        [ ( expr "datum['IMDB Rating']*10 > datum['Rotten Tomatoes Rating']"
                          , [ mStr "steelblue" ]
                          )
                        ]
                        [ mStr "red" ]
                    ]
                << hyperlink
                    [ hDataCondition (expr "datum['IMDB Rating']*10 > datum['Rotten Tomatoes Rating']")
                        [ hStr "http://www.imdb.com" ]
                        [ hStr "https://www.rottentomatoes.com" ]
                    ]
    in
    toVegaLite [ data, point [ maCursor cuPointer ], enc [] ]



{- Ids and specifications to be provided to the Vega-Lite runtime. -}


specs : List ( String, Spec )
specs =
    [ ( "hyperlink1", hyperlink1 )
    , ( "hyperlink2", hyperlink2 )
    , ( "hyperlink3", hyperlink3 )
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
