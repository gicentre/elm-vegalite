port module ScaleTests exposing (elmToJS)

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


scale1 : Spec
scale1 =
    let
        data =
            dataFromUrl (path ++ "cars.json") []

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]
                << color [ mStr "rgb(203,24,29)" ]
                << size [ mName "Acceleration", mQuant, mBin [] ]
                << opacity [ mName "Acceleration", mQuant, mBin [] ]
    in
    toVegaLite [ data, enc [], point [ maFilled True, maStroke "white", maStrokeWidth 0.4 ] ]


scale2 : Spec
scale2 =
    let
        cfg =
            configure
                << configuration (coRange [ racoRamp "reds" ])

        data =
            dataFromUrl (path ++ "cars.json") []

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]
                << color [ mName "Acceleration", mQuant, mBin [] ]
    in
    toVegaLite [ cfg [], data, enc [], point [] ]


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
                    , mTitle "Quantile"
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
                    , mTitle "Quantize"
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
                    , mTitle "Threshold"
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
                    , mScale [ scRange (raNums [ 0, 80000 ]), scType scLog, scBase e ]
                    , mLegend []
                    ]
    in
    toVegaLite [ data [], point [], enc [] ]


divergingData : List DataColumn -> Data
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
                    , mScale [ scScheme "redblue" [], scDomain (doMid 0) ]
                    ]
    in
    toVegaLite [ divergingData [], enc [], bar [] ]


lineChart : List ScaleProperty -> List ScaleProperty -> Spec
lineChart xScale yScale =
    let
        data =
            dataFromUrl (path ++ "stocks.csv") []

        pxProp =
            if xScale == [] then
                []

            else
                [ pScale xScale ]

        pyProp =
            if yScale == [] then
                []

            else
                [ pScale yScale ]

        enc =
            encoding
                << position X ([ pName "date", pTimeUnit year ] ++ pxProp)
                << position Y ([ pName "price", pAggregate opMean ] ++ pyProp)
                << color [ mName "symbol" ]
    in
    toVegaLite [ width 200, height 200, data, enc [], line [] ]


scale12 : Spec
scale12 =
    lineChart [] []


scale13 : Spec
scale13 =
    lineChart [ scDomain (doDts [ [ dtYear 1990 ], [ dtYear 2020 ] ]) ] [ scDomain (doNums [ -100, 700 ]) ]


scale14 : Spec
scale14 =
    lineChart [ scDomain (doMinDt [ dtYear 1990 ]) ] [ scDomain (doMin -100) ]


scale15 : Spec
scale15 =
    lineChart [ scDomain (doMaxDt [ dtYear 2020 ]) ] [ scDomain (doMax 700) ]


scatterplot : List ScaleProperty -> List ScaleProperty -> Spec
scatterplot cScale sScale =
    let
        data =
            dataFromColumns []
                << dataColumn "x" (nums [ 1, 2, 3, 4 ])
                << dataColumn "c" (strs [ "#000", "#666", "#999", "#ccc" ])

        mcProp =
            if cScale == [] then
                []

            else
                [ mScale cScale ]

        msProp =
            if sScale == [] then
                []

            else
                [ mScale sScale ]

        enc =
            encoding
                << position X [ pName "x", pQuant, pTitle "" ]
                << position Y [ pName "x", pQuant, pTitle "" ]
                << color ([ mName "x", mOrdinal, mTitle "" ] ++ mcProp)
                << size ([ mName "x", mQuant, mTitle "" ] ++ msProp)
    in
    toVegaLite [ width 200, height 200, data [], enc [], circle [] ]


scale16 : Spec
scale16 =
    scatterplot [] []


scale17 : Spec
scale17 =
    scatterplot [ scRange (raStrs [ "orange", "red", "purple", "blue" ]) ]
        [ scRange (raNums [ 100, 1200 ]) ]


scale18 : Spec
scale18 =
    scatterplot
        [ scRange (raStrs [ "orange", "red", "purple", "blue" ]) ]
        [ scRange (raMin 400) ]


scale19 : Spec
scale19 =
    scatterplot
        [ scRange (raStrs [ "orange", "red", "purple", "blue" ]) ]
        [ scRange (raMax 1200) ]


scale20 : Spec
scale20 =
    scatterplot [ scRange (raField "c") ] []


scaleInteractive : Spec
scaleInteractive =
    let
        data =
            dataFromColumns []
                << dataColumn "val" (nums [ 1, 2, 3, 4, 5 ])
                << dataColumn "cat" (strs [ "a", "a", "b", "b", "a" ])
                << dataColumn "date" (strs [ "2021-04-10", "2021-04-11", "2021-04-12", "2021-04-13", "2021-04-14" ])

        ps =
            params
                << param "colorMid" [ paValue (num 3), paBind (ipRange [ inMin 0, inMax 6 ]) ]
                << param "xMax" [ paValue (num 5), paBind (ipRange [ inMin 0, inMax 10, inStep 1 ]) ]
                << param "yMin" [ paValue (num 0), paBind (ipRange [ inMin -5, inMax 5, inStep 1 ]) ]
                << param "minDate" [ paValue (str "2021-04-08"), paBind (ipDate []) ]
                << param "maxDate" [ paValue (str "2021-04-15"), paBind (ipDate []) ]
                << param "shapeB" [ paValue (boo True), paBind (ipCheckbox []) ]

        enc =
            encoding
                << position X [ pName "val", pQuant, pScale [ scDomain (doNumExpr "xMax" doMax) ] ]
                << position Y [ pName "val", pQuant, pScale [ scDomain (doNumExpr "yMin" doMin) ] ]
                << color
                    [ mName "val"
                    , mQuant
                    , mScale [ scScheme "spectral" [], scDomain (doNumExpr "colorMid" doMid) ]
                    ]
                << shape [ mName "cat", mScale [ scDomainExpr "shapeB ? ['a','b'] : ['a']" ] ]
                << size
                    [ mName "date"
                    , mTemporal
                    , mScale [ scDomain (doDtsExpr "[datetime(minDate),datetime(maxDate)]") ]
                    ]
    in
    toVegaLite [ ps [], width 400, height 400, data [], enc [], point [ maFilled True ] ]



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
    , ( "scale12", scale12 )
    , ( "scale13", scale13 )
    , ( "scale14", scale14 )
    , ( "scale15", scale15 )
    , ( "scale16", scale16 )
    , ( "scale17", scale17 )
    , ( "scale18", scale18 )
    , ( "scale19", scale19 )
    , ( "scale20", scale20 )
    , ( "scaleInteractive", scaleInteractive )
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
