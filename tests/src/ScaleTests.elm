port module ScaleTests exposing (elmToJS)

import Browser
import Dict exposing (Dict)
import Html exposing (Html)
import Html.Attributes
import Html.Events
import Json.Encode
import VegaLite exposing (..)


scale1 : Spec
scale1 =
    let
        cars =
            dataFromUrl "https://vega.github.io/vega-lite/data/cars.json" []

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]
                << color [ mStr "rgb(203,24,29)" ]
                << size [ mName "Acceleration", mQuant, mBin [] ]
                << opacity [ mName "Acceleration", mQuant, mBin [] ]
    in
    toVegaLite [ cars, enc [], point [ maFilled True, maStroke "white", maStrokeWidth 0.4 ] ]


scale2 : Spec
scale2 =
    let
        conf =
            configure
                << configuration (coRange [ racoRamp "reds" ])

        cars =
            dataFromUrl "https://vega.github.io/vega-lite/data/cars.json" []

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]
                << color [ mName "Acceleration", mQuant, mBin [] ]
    in
    toVegaLite [ conf [], cars, enc [], point [] ]


scale3 : Spec
scale3 =
    let
        data =
            dataFromColumns []
                << dataColumn "b" (nums [ 28, 55, 43, 91, 81, 53, 19, 87, 52 ])

        enc =
            encoding
                << position Y
                    [ pName "b"
                    , pNominal
                    , pSort []
                    , pAxis [ axTicks False, axDomain False, axTitle "" ]
                    ]
                << size
                    [ mName "b"
                    , mQuant
                    , mScale [ scType scQuantile ]
                    ]
                << color
                    [ mName "b"
                    , mQuant
                    , mScale [ scType scQuantile ]
                    , mLegend [ leTitle "Quantile" ]
                    ]
    in
    toVegaLite [ data [], enc [], circle [] ]


scale4 : Spec
scale4 =
    let
        data =
            dataFromColumns []
                << dataColumn "b" (nums [ 28, 55, 43, 91, 81, 53, 19, 87, 52 ])

        enc =
            encoding
                << position Y
                    [ pName "b"
                    , pNominal
                    , pSort []
                    , pAxis [ axTicks False, axDomain False, axTitle "" ]
                    ]
                << size
                    [ mName "b"
                    , mQuant
                    , mScale [ scType scQuantize ]
                    ]
                << color
                    [ mName "b"
                    , mQuant
                    , mScale [ scType scQuantize, scZero True ]
                    , mLegend [ leTitle "Quantize" ]
                    ]
    in
    toVegaLite [ data [], enc [], circle [] ]


scale5 : Spec
scale5 =
    let
        data =
            dataFromColumns []
                << dataColumn "b" (nums [ 28, 55, 43, 91, 81, 53, 19, 87, 52 ])

        enc =
            encoding
                << position Y
                    [ pName "b"
                    , pNominal
                    , pSort []
                    , pAxis [ axTicks False, axDomain False, axTitle "" ]
                    ]
                << size
                    [ mName "b"
                    , mQuant
                    , mScale
                        [ scType scThreshold
                        , scDomain (doNums [ 30, 70 ])
                        , scRange (raNums [ 80, 200, 320 ])
                        ]
                    ]
                << color
                    [ mName "b"
                    , mQuant
                    , mScale
                        [ scType scThreshold
                        , scDomain (doNums [ 30, 70 ])
                        , scScheme "viridis" []
                        ]
                    , mLegend [ leTitle "Threshold" ]
                    ]
    in
    toVegaLite [ data [], enc [], circle [] ]


scale6 : Spec
scale6 =
    let
        data =
            dataFromColumns []
                << dataColumn "r" (nums [ 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000 ])

        enc =
            encoding
                << size
                    [ mName "r"
                    , mQuant
                    , mScale [ scRange (raNums [ 0, 80000 ]) ]
                    , mLegend []
                    ]
    in
    toVegaLite [ data [], point [], enc [] ]


scale7 : Spec
scale7 =
    let
        data =
            dataFromColumns []
                << dataColumn "r" (nums [ 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000 ])

        enc =
            encoding
                << size
                    [ mName "r"
                    , mQuant
                    , mScale [ scRange (raNums [ 0, 80000 ]), scType scPow, scExponent 2 ]
                    , mLegend []
                    ]
    in
    toVegaLite [ data [], point [], enc [] ]


scale8 : Spec
scale8 =
    let
        data =
            dataFromColumns []
                << dataColumn "r" (nums [ 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000 ])

        enc =
            encoding
                << size
                    [ mName "r"
                    , mQuant
                    , mScale [ scRange (raNums [ 0, 80000 ]), scType scPow, scExponent 1.2 ]
                    , mLegend []
                    ]
    in
    toVegaLite [ data [], point [], enc [] ]


scale9 : Spec
scale9 =
    let
        data =
            dataFromColumns []
                << dataColumn "r" (nums [ 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000 ])

        enc =
            encoding
                << size
                    [ mName "r"
                    , mQuant
                    , mScale [ scRange (raNums [ 0, 80000 ]), scType scLog, scBase e ]
                    , mLegend []
                    ]
    in
    toVegaLite [ data [], point [], enc [] ]


divergingData =
    dataFromColumns []
        << dataColumn "category" (strs [ "A", "B", "C", "D", "E", "F", "G", "H", "I" ])
        << dataColumn "value" (nums [ -28.6, -1.6, -13.6, 34.4, 24.4, -3.6, -57.6, 30.4, -4.6 ])


scale10 : Spec
scale10 =
    let
        enc =
            encoding
                << position X [ pName "category", pOrdinal ]
                << position Y [ pName "value", pQuant ]
                << color
                    [ mName "value"
                    , mQuant
                    , mScale [ scScheme "redblue" [] ]
                    ]
    in
    toVegaLite [ divergingData [], enc [], bar [] ]


scale11 : Spec
scale11 =
    let
        enc =
            encoding
                << position X [ pName "category", pOrdinal ]
                << position Y [ pName "value", pQuant ]
                << color
                    [ mName "value"
                    , mQuant
                    , mScale [ scScheme "redblue" [], scDomainMid 0 ]
                    ]
    in
    toVegaLite [ divergingData [], enc [], bar [] ]



{- This list comprises the specifications to be provided to the Vega-Lite runtime. -}


specs : List ( String, Spec )
specs =
    [ ( "scale1", scale1 )
    , ( "scale2", scale2 )
    , ( "scale3", scale3 )
    , ( "scale4", scale4 )
    , ( "scale5", scale5 )
    , ( "scale6", scale6 )
    , ( "scale7", scale7 )
    , ( "scale8", scale8 )
    , ( "scale9", scale9 )
    , ( "scale10", scale10 )
    , ( "scale11", scale11 )
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
