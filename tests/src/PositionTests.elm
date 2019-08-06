port module PositionTests exposing (elmToJS)

import Browser
import Html exposing (Html, div, pre)
import Html.Attributes exposing (id)
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
                << position X [ pName "cat", pMType Ordinal ]
                << position Y [ pName "val", pMType Quantitative ]
    in
    toVegaLite [ width 300, data [], enc [], bar [ maWidth 20 ] ]


position7 : Spec
position7 =
    let
        enc =
            encoding
                << position X [ pName "val", pMType Quantitative ]
                << position Y [ pName "cat", pMType Ordinal ]
    in
    toVegaLite [ height 300, data [], enc [], bar [ maHeight 20 ] ]


barAlign : Float -> Spec
barAlign x =
    let
        enc =
            encoding
                << position X
                    [ pName "cat"
                    , pMType Ordinal
                    , pScale [ scAlign x, scPaddingInner 0.5 ]
                    ]
                << position Y [ pName "val", pMType Quantitative ]
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


sourceExample : Spec
sourceExample =
    position12



{- This list comprises the specifications to be provided to the Vega-Lite runtime. -}


mySpecs : Spec
mySpecs =
    combineSpecs
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
