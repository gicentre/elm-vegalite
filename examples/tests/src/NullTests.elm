port module NullTests exposing (elmToJS)

import Browser
import Dict
import Html exposing (Html)
import Html.Attributes
import Html.Events
import Json.Encode
import VegaLite exposing (..)


path : String
path =
    "https://cdn.jsdelivr.net/npm/vega-datasets@2.3/data/"


axis1 : Spec
axis1 =
    let
        data =
            dataFromColumns []
                << dataColumn "x" (nums [ 0, 1000, 1000, 0, 0, 1000 ])
                << dataColumn "y" (nums [ 1000, 1000, 0, 0, 1000, 0 ])
                << dataColumn "order" (List.range 1 6 |> List.map toFloat |> nums)

        enc =
            encoding
                << position X [ pName "x", pQuant, pAxis [] ]
                << position Y [ pName "y", pQuant, pAxis [] ]
                << order [ oName "order" ]
    in
    toVegaLite [ data [], enc [], line [] ]


scaleEncode : ( VLProperty, Spec ) -> Spec
scaleEncode enc =
    let
        data =
            dataFromColumns []
                << dataColumn "x" (nums [ 10, 20, 30, 40, 50, 60, 70, 80, 90, 100 ])
                << dataColumn "y" (nums [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ])
                << dataColumn "val" (nums [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ])
                << dataColumn "cat" (strs [ "a", "b", "c", "d", "e", "f", "g", "h", "i", "j" ])
    in
    toVegaLite [ width 400, height 400, data [], enc, point [] ]


scale0 : Spec
scale0 =
    (encoding
        << position X [ pName "x", pQuant ]
        << position Y [ pName "y", pQuant ]
        << color [ mName "val", mOrdinal ]
        << size [ mName "val", mQuant ]
        << shape [ mName "cat" ]
    )
        []
        |> scaleEncode


scale1 : Spec
scale1 =
    (encoding
        << position X [ pName "x", pQuant, pScale [] ]
        << position Y [ pName "y", pQuant ]
        << color [ mName "val", mOrdinal ]
        << size [ mName "val", mQuant ]
        << shape [ mName "cat" ]
    )
        []
        |> scaleEncode


scale2 : Spec
scale2 =
    (encoding
        << position X [ pName "x", pQuant ]
        << position Y [ pName "y", pQuant, pScale [] ]
        << color [ mName "val", mOrdinal ]
        << size [ mName "val", mQuant ]
        << shape [ mName "cat" ]
    )
        []
        |> scaleEncode


scale3 : Spec
scale3 =
    (encoding
        << position X [ pName "x", pQuant ]
        << position Y [ pName "y", pQuant ]
        << color [ mName "val", mOrdinal, mScale [] ]
        << size [ mName "val", mQuant ]
        << shape [ mName "cat" ]
    )
        []
        |> scaleEncode


scale4 : Spec
scale4 =
    (encoding
        << position X [ pName "x", pQuant ]
        << position Y [ pName "y", pQuant ]
        << color [ mName "val", mOrdinal ]
        << size [ mName "val", mQuant, mScale [] ]
        << shape [ mName "cat" ]
    )
        []
        |> scaleEncode


scale5 : Spec
scale5 =
    (encoding
        << position X [ pName "x", pQuant ]
        << position Y [ pName "y", pQuant ]
        << color [ mName "val", mOrdinal ]
        << size [ mName "val", mQuant ]
        << shape [ mName "cat", mScale [] ]
    )
        []
        |> scaleEncode


filter1 : Spec
filter1 =
    let
        cfg =
            configure
                << configuration (coMark [ maRemoveInvalid False ])

        data =
            dataFromUrl (path ++ "movies.json") []

        enc =
            encoding
                << position X [ pName "IMDB Rating", pQuant ]
                << position Y [ pName "Rotten Tomatoes Rating", pQuant ]
                << color
                    [ mCondition (prTest (expr "datum['IMDB Rating'] === null || datum['Rotten Tomatoes Rating'] === null"))
                        [ mStr "#ddd" ]
                        [ mStr "rgb(76,120,168)" ]
                    ]
    in
    toVegaLite
        [ cfg [], data, enc [], point [] ]


filter2 : Spec
filter2 =
    let
        cfg =
            configure
                << configuration (coMark [ maRemoveInvalid False ])

        data =
            dataFromUrl (path ++ "movies.json") []

        trans =
            transform
                << filter (fiValid "IMDB Rating")
                << filter (fiValid "Rotten Tomatoes Rating")

        enc =
            encoding
                << position X [ pName "IMDB Rating", pQuant ]
                << position Y [ pName "Rotten Tomatoes Rating", pQuant ]
                << color
                    [ mCondition (prTest (expr "datum['IMDB Rating'] === null || datum['Rotten Tomatoes Rating'] === null"))
                        [ mStr "#ddd" ]
                        [ mStr "rgb(76,120,168)" ]
                    ]
    in
    toVegaLite [ cfg [], data, trans [], enc [], point [] ]



{- Ids and specifications to be provided to the Vega-Lite runtime. -}


specs : List ( String, Spec )
specs =
    [ ( "axis1", axis1 )
    , ( "scale0", scale0 )
    , ( "scale1", scale1 )
    , ( "scale2", scale2 )
    , ( "scale3", scale3 )
    , ( "scale4", scale4 )
    , ( "scale5", scale5 )
    , ( "filter1", filter1 )
    , ( "filter2", filter2 )
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
