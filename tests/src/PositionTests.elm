port module PositionTests exposing (elmToJS)

import Browser
import Html exposing (Html, div, pre)
import Html.Attributes exposing (id)
import Json.Encode
import VegaLite exposing (..)


data : List DataColumn -> Data
data =
    dataFromColumns []
        << dataColumn "empty" (nums [ 0 ])


position1 : Spec
position1 =
    toVegaLite [ data [], circle [ maX 150, maY 150, maSize 200 ] ]


position2 : Spec
position2 =
    toVegaLite [ data [], bar [ maX 150, maY 150 ] ]


position3 : Spec
position3 =
    toVegaLite [ data [], bar [ maX 150, maY 150, maX2 200 ] ]


position4 : Spec
position4 =
    toVegaLite [ data [], bar [ maX 150, maY 150, maY2 200 ] ]


position5 : Spec
position5 =
    toVegaLite [ data [], bar [ maX 150, maY 150, maX2 200, maY2 200 ] ]


sourceExample : Spec
sourceExample =
    position5



{- This list comprises the specifications to be provided to the Vega-Lite runtime. -}


mySpecs : Spec
mySpecs =
    combineSpecs
        [ ( "position1", position1 )
        , ( "position2", position2 )
        , ( "position3", position3 )
        , ( "position4", position4 )
        , ( "position5", position5 )
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
