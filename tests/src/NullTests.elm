port module NullTests exposing (elmToJS)

import Browser
import Html exposing (Html, div, pre)
import Html.Attributes exposing (id)
import Json.Encode
import VegaLite exposing (..)


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
                << order [ oName "order", oOrdinal ]
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
        << shape [ mName "cat", mNominal ]
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
        << shape [ mName "cat", mNominal ]
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
        << shape [ mName "cat", mNominal ]
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
        << shape [ mName "cat", mNominal ]
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
        << shape [ mName "cat", mNominal ]
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
        << shape [ mName "cat", mNominal, mScale [] ]
    )
        []
        |> scaleEncode


filter1 : Spec
filter1 =
    let
        config =
            configure
                << configuration (coMark [ maRemoveInvalid False ])

        enc =
            encoding
                << position X [ pName "IMDB_Rating", pQuant ]
                << position Y [ pName "Rotten_Tomatoes_Rating", pQuant ]
                << color
                    [ mDataCondition
                        [ ( expr "datum.IMDB_Rating === null || datum.Rotten_Tomatoes_Rating === null"
                          , [ mStr "#ddd" ]
                          )
                        ]
                        [ mStr "rgb(76,120,168)" ]
                    ]
    in
    toVegaLite
        [ config []
        , dataFromUrl "https://vega.github.io/vega-lite/data/movies.json" []
        , point []
        , enc []
        ]


filter2 : Spec
filter2 =
    let
        config =
            configure
                << configuration (coMark [ maRemoveInvalid False ])

        trans =
            transform
                << filter (fiValid "IMDB_Rating")
                << filter (fiValid "Rotten_Tomatoes_Rating")

        enc =
            encoding
                << position X [ pName "IMDB_Rating", pQuant ]
                << position Y [ pName "Rotten_Tomatoes_Rating", pQuant ]
                << color
                    [ mDataCondition
                        [ ( expr "datum.IMDB_Rating === null || datum.Rotten_Tomatoes_Rating === null"
                          , [ mStr "#ddd" ]
                          )
                        ]
                        [ mStr "rgb(76,120,168)" ]
                    ]
    in
    toVegaLite
        [ config []
        , trans []
        , dataFromUrl "https://vega.github.io/vega-lite/data/movies.json" []
        , point []
        , enc []
        ]


sourceExample : Spec
sourceExample =
    axis1



{- This list comprises the specifications to be provided to the Vega-Lite runtime. -}


mySpecs : Spec
mySpecs =
    combineSpecs
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
   The code below creates an Elm module that opens an outgoing port to Javascript
   and sends both the specs and DOM node to it.
   This is used to display the generated Vega specs for testing purposes.
-}


main : Program () Spec msg
main =
    Browser.element
        { init = always ( mySpecs, elmToJS mySpecs )
        , view = view
        , update = \_ model -> ( model, Cmd.none )
        , subscriptions = always Sub.none
        }



-- View


view : Spec -> Html msg
view spec =
    div []
        [ div [ id "specSource" ] []
        , pre []
            [ Html.text (Json.Encode.encode 2 sourceExample) ]
        ]


port elmToJS : Spec -> Cmd msg
