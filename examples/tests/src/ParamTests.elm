port module ParamTests exposing (elmToJS)

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


param1 : Spec
param1 =
    let
        data =
            dataFromColumns []
                << dataColumn "a" (strs [ "A", "B", "C", "D", "E", "F", "G", "H", "I" ])
                << dataColumn "b" (nums [ 28, 55, 43, 91, 81, 53, 19, 87, 52 ])

        ps =
            params
                << param "radius" [ paValue (num 5) ]

        enc =
            encoding
                << position X [ pName "a", pAxis [ axLabelAngle 0 ] ]
                << position Y [ pName "b", pQuant ]
    in
    toVegaLite [ ps [], data [], enc [], bar [ maCornerRadius |> maNumExpr "radius" ] ]


param2 : Spec
param2 =
    let
        solid =
            nums []

        shortDash =
            nums [ 2, 2 ]

        longDash =
            nums [ 8, 8 ]

        data =
            dataFromColumns []
                << dataColumn "a" (strs [ "A", "B", "C", "D", "E", "F", "G", "H", "I" ])
                << dataColumn "b" (nums [ 28, 55, 43, 91, 81, 53, 19, 87, 52 ])

        ps =
            params
                << param "dashStyle" [ paValues solid, paBind (ipSelect [ inDataOptions [ solid, shortDash, longDash ] ]) ]
                << param "radius" [ paValue (num 0), paBind (ipRange [ inMin 0, inMax 20 ]) ]
                << param "strokeWidth" [ paValue (num 2), paBind (ipRange [ inMin 0, inMax 10 ]) ]

        enc =
            encoding
                << position X [ pName "a", pAxis [ axLabelAngle 0 ] ]
                << position Y [ pName "b", pQuant ]
    in
    toVegaLite
        [ ps []
        , width 600
        , data []
        , enc []
        , bar
            [ maStroke "black"
            , maNumExpr "strokeWidth" maStrokeWidth
            , maWidth 40
            , maNumExpr "radius" maCornerRadius
            , maNumsExpr "dashStyle" maStrokeDash
            ]
        ]


param3 : Spec
param3 =
    let
        cfg =
            configure
                << configuration (coTick [ maThickness 2 ])

        data =
            jsonToSpec
                """{"ranges": [150,225,300],"measures": [220,270],"markers": [250]}"""
                |> dataFromJson

        ps =
            params
                << param "innerBarSize" [ paExpr "height/2" ]
                << param "height" [ paValue (num 20), paBind (ipRange [ inMin 1, inMax 100, inStep 1 ]) ]

        enc =
            encoding
                << position X [ pQuant, pScale [ scNice niFalse ], pTitle "" ]

        enc1 =
            encoding << position X [ pName "ranges[2]" ]

        spec1 =
            asSpec [ enc1 [], bar [ maColor "#eee", maSize |> maNumExpr "height" ] ]

        enc2 =
            encoding << position X [ pName "ranges[1]" ]

        spec2 =
            asSpec [ enc2 [], bar [ maColor "#ddd", maSize |> maNumExpr "height" ] ]

        enc3 =
            encoding << position X [ pName "ranges[0]" ]

        spec3 =
            asSpec [ enc3 [], bar [ maColor "#ccc", maSize |> maNumExpr "height" ] ]

        enc4 =
            encoding << position X [ pName "measures[1]" ]

        spec4 =
            asSpec [ enc4 [], bar [ maColor "lightsteelblue", maSize |> maNumExpr "innerBarSize" ] ]

        enc5 =
            encoding << position X [ pName "measures[0]" ]

        spec5 =
            asSpec [ enc5 [], bar [ maColor "steelblue", maSize |> maNumExpr "innerBarSize" ] ]

        enc6 =
            encoding << position X [ pName "markers[0]" ]

        spec6 =
            asSpec [ enc6 [], tick [ maColor "black", maSize |> maNumExpr "height" ] ]
    in
    toVegaLite [ cfg [], ps [], data [], enc [], layer [ spec1, spec2, spec3, spec4, spec5, spec6 ] ]


param4 : Spec
param4 =
    let
        data =
            dataFromUrl (path ++ "cars.json") []

        ps =
            params
                << param "pts" [ paSelect seInterval [] ]

        enc =
            encoding
                << position X [ pName "Cylinders" ]
                << position Y [ pName "Origin" ]
                << color [ mCondition (prParamEmpty "pts") [ mAggregate opCount ] [ mStr "grey" ] ]
    in
    toVegaLite [ width 240, ps [], data, enc [], rect [] ]


param5 : Spec
param5 =
    let
        data =
            dataFromUrl (path ++ "cars.json") []

        ps =
            params
                << param "paintbrush"
                    [ paSelect sePoint
                        [ seOn "mouseover"
                        , seToggle (tpExpr "event.shiftKey && event.ctrlKey")
                        ]
                    ]

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]
                << size [ mCondition (prParamEmpty "paintbrush") [ mNum 300 ] [ mNum 50 ] ]
                << fill [ mCondition (prParamEmpty "paintbrush") [ mStr "steelblue" ] [ mStr "white" ] ]
                << opacity [ mCondition (prParamEmpty "paintbrush") [ mNum 1 ] [ mNum 0.4 ] ]
    in
    toVegaLite [ ps [], data, enc [], point [] ]


param6 : Spec
param6 =
    let
        data =
            dataFromUrl (path ++ "cars.json") []

        ps =
            params
                << param "opacityVar" [ paValue (num 50), paBind (ipRange [ inMin 1, inMax 100, inStep 1 ]) ]
                << param "sel" [ paSelect sePoint [ seFields [ "Miles_per_Gallon" ], seToggle tpFalse ] ]

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]
    in
    toVegaLite
        [ ps []
        , data
        , enc []
        , point
            [ maSize |> maNumExpr "sel.Miles_per_Gallon * 10 || 75"
            , maOpacity |> maNumExpr "opacityVar/100"
            ]
        ]


param7 : Spec
param7 =
    let
        data =
            dataFromUrl (path ++ "cars.json") []

        ps =
            params
                << param "toggleOrigin" [ paBind (ipCheckbox []) ]
                << param "paintbrush" [ paSelect sePoint [ seOn "mouseover" ] ]

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]
                << color [ mCondition (prParam "toggleOrigin") [ mName "Origin" ] [ mStr "steelblue" ] ]
                << size [ mCondition (prParamEmpty "paintbrush") [ mNum 300 ] [ mNum 30 ] ]
    in
    toVegaLite [ ps [], data, enc [], point [] ]


param8 : Spec
param8 =
    let
        data =
            dataFromUrl (path ++ "cars.json") []

        ps =
            params
                << param "brush" [ paSelect seInterval [] ]

        enc1 =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]

        spec1 =
            asSpec [ enc1 [], point [] ]

        trans2 =
            transform
                << filter (fiSelection "brush")

        enc2 =
            encoding
                << position X [ pName "Acceleration", pQuant, pScale [ scDomain (doNums [ 0, 25 ]) ] ]
                << position Y [ pName "Displacement", pQuant, pScale [ scDomain (doNums [ 0, 500 ]) ] ]

        spec2 =
            asSpec [ trans2 [], enc2 [], point [] ]
    in
    toVegaLite [ ps [], data, hConcat [ spec1, spec2 ] ]


param9 : Spec
param9 =
    let
        data =
            dataFromUrl (path ++ "flights-5k.json") [ parse [ ( "date", foDate "" ) ] ]

        trans =
            transform
                << calculateAs "hours(datum.date) + minutes(datum.date) / 60" "time"

        ps =
            params
                << param "brush" [ paSelect seInterval [ seEncodings [ chX ] ] ]

        enc1 =
            encoding
                << position X [ pName "time", pBin [ biMaxBins 30, biSelectionExtent "brush" ] ]
                << position Y [ pAggregate opCount ]

        spec1 =
            asSpec [ width 480, height 150, enc1 [], bar [] ]

        enc2 =
            encoding
                << position X [ pName "time", pBin [ biMaxBins 30 ] ]
                << position Y [ pAggregate opCount, pAxis [ axTitle "Count" ] ]

        spec2 =
            asSpec [ ps [], width 480, height 50, enc2 [], bar [] ]
    in
    toVegaLite [ data, trans [], vConcat [ spec1, spec2 ] ]


param10 : Spec
param10 =
    let
        data =
            dataFromUrl (path ++ "sp500.csv") []

        ps =
            params
                << param "brush" [ paSelect seInterval [ seEncodings [ chX ] ] ]

        enc1 =
            encoding
                << position X [ pName "date", pTemporal, pScale [ scDomain (doSelection "brush") ], pTitle "" ]
                << position Y [ pName "price", pQuant ]

        spec1 =
            asSpec [ width 480, enc1 [], area [] ]

        enc2 =
            encoding
                << position X [ pName "date", pTemporal ]
                << position Y [ pName "price", pQuant, pAxis [ axTickCount (niTickCount 3), axGrid False ] ]

        spec2 =
            asSpec [ ps [], width 480, height 60, enc2 [], area [] ]
    in
    toVegaLite [ data, vConcat [ spec1, spec2 ] ]



{- Ids and specifications to be provided to the Vega-Lite runtime. -}


specs : List ( String, Spec )
specs =
    [ ( "param1", param1 )
    , ( "param2", param2 )
    , ( "param3", param3 )
    , ( "param4", param4 )
    , ( "param5", param5 )
    , ( "param6", param6 )
    , ( "param7", param7 )
    , ( "param8", param8 )
    , ( "param9", param9 )
    , ( "param10", param10 )
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
