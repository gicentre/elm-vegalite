port module RadialTests exposing (elmToJS)

import Browser
import Html exposing (Html, div, pre)
import Html.Attributes exposing (id)
import Json.Encode
import VegaLite exposing (..)


radial : Float -> Spec
radial innerR =
    let
        data =
            dataFromColumns []
                << dataColumn "category" (strs [ "A", "B", "C", "D", "E", "F" ])
                << dataColumn "value" (nums [ 4, 6, 10, 3, 7, 8 ])

        enc =
            encoding
                << position Theta [ pName "value", pQuant ]
                << color [ mName "category", mNominal ]
    in
    toVegaLite [ data [], enc [], arc [ maTooltip ttEncoding, maInnerRadius innerR ] ]


radial1 : Spec
radial1 =
    radial 0


radial2 : Spec
radial2 =
    radial 50


radial3 : Spec
radial3 =
    let
        data =
            dataFromColumns []
                << dataColumn "category" (strs [ "A", "B", "C", "D", "E", "F" ])
                << dataColumn "value" (nums [ 4, 6, 10, 3, 7, 8 ])

        enc =
            encoding
                << position Theta [ pName "value", pQuant, pStack stZero ]
                << color [ mName "category", mNominal, mLegend [] ]

        pieSpec =
            asSpec [ arc [ maOuterRadius 80 ] ]

        labelEnc =
            encoding
                << text [ tName "category", tNominal ]

        labelSpec =
            asSpec [ labelEnc [], textMark [ maRadius 90 ] ]
    in
    toVegaLite [ data [], enc [], layer [ pieSpec, labelSpec ] ]


radial4 : Spec
radial4 =
    let
        data =
            dataFromColumns []
                << dataColumn "x" (nums [ 0 ])
    in
    toVegaLite
        [ data []
        , arc
            [ maTheta 0.3
            , maTheta2 1.3
            , maInnerRadius 30
            , maOuterRadius 100
            , maX 0
            , maY 200
            ]
        ]


radial5 : Spec
radial5 =
    let
        thetas =
            List.range 0 8 |> List.map (\n -> toFloat n * 45 |> degrees)

        data =
            dataFromColumns []
                << dataColumn "dir" (strs [ "1N", "2NE", "3E", "4SE", "5S", "6SW", "7W", "8NW" ])
                << dataColumn "t" (thetas |> List.take 8 |> nums)
                << dataColumn "t2" (thetas |> List.drop 1 |> nums)

        enc =
            encoding
                << position Theta [ pName "t", pQuant ]
                << position Theta2 [ pName "t2" ]
                << color [ mName "dir", mNominal ]
    in
    toVegaLite [ data [], enc [], arc [] ]


radial6 : Spec
radial6 =
    let
        thetas =
            List.range 0 8 |> List.map (\n -> toFloat n * 45 |> degrees)

        data =
            dataFromColumns []
                << dataColumn "dir" (strs [ "1N", "2NE", "3E", "4SE", "5S", "6SW", "7W", "8NW" ])
                << dataColumn "strength" (nums [ 1, 2, 3, 4, 5, 6, 7, 8 ])
                << dataColumn "t" (thetas |> List.take 8 |> nums)
                << dataColumn "t2" (thetas |> List.drop 1 |> nums)

        enc =
            encoding
                << position R [ pName "strength", pQuant, pScale [ scZero True ] ]
                << position Theta [ pName "t", pQuant ]
                << position Theta2 [ pName "t2" ]
                << position R2 [ pNum 10 ]
                << color [ mName "dir", mNominal ]
    in
    toVegaLite [ data [], enc [], arc [] ]


sourceExample : Spec
sourceExample =
    radial6



{- This list comprises the specifications to be provided to the Vega-Lite runtime. -}


mySpecs : Spec
mySpecs =
    combineSpecs
        [ ( "radial1", radial1 )
        , ( "radial2", radial2 )
        , ( "radial3", radial3 )
        , ( "radial4", radial4 )
        , ( "radial5", radial5 )
        , ( "radial6", radial6 )
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
