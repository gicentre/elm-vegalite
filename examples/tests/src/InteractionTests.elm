port module InteractionTests exposing (elmToJS)

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


data : Data
data =
    dataFromUrl "https://gicentre.github.io/data/westMidlands/westMidsCrimesAggregated.tsv" []


cScale : List ScaleProperty
cScale =
    categoricalDomainMap
        [ ( "Anti-social behaviour", "rgb(59,118,175)" )
        , ( "Burglary", "rgb(81,157,62)" )
        , ( "Criminal damage and arson", "rgb(141,106,184)" )
        , ( "Drugs", "rgb(239,133,55)" )
        , ( "Robbery", "rgb(132,88,78)" )
        , ( "Vehicle crime", "rgb(213,126,190)" )
        ]


enc : List LabelledSpec -> ( VLProperty, Spec )
enc =
    encoding
        << position X [ pName "month", pTemporal, pTitle "" ]
        << position Y [ pName "reportedCrimes", pQuant, pTitle "Reported crimes" ]
        << color [ mName "crimeType", mScale cScale ]


encHighlight : List LabelledSpec -> ( VLProperty, Spec )
encHighlight =
    encoding
        << position X [ pName "month", pTemporal, pTitle "" ]
        << position Y [ pName "reportedCrimes", pQuant, pTitle "Reported crimes" ]
        << color [ mCondition (prParam "mySelection") [ mName "crimeType", mScale cScale ] [ mStr "black" ] ]
        << opacity [ mCondition (prParam "mySelection") [ mNum 1 ] [ mNum 0.1 ] ]


interaction1 : Spec
interaction1 =
    let
        ps =
            params
                << param "mySelection" [ paSelect sePoint [ seToggle tpFalse ] ]
    in
    toVegaLite [ width 540, data, ps [], encHighlight [], line [] ]


interaction2 : Spec
interaction2 =
    let
        ps =
            params
                << param "mySelection" [ paSelect sePoint [] ]
    in
    toVegaLite [ width 540, data, ps [], encHighlight [], line [] ]


interaction3 : Spec
interaction3 =
    let
        ps =
            params
                << param "mySelection"
                    [ paSelect sePoint
                        [ seToggle tpFalse
                        , seNearest True
                        , seFields [ "crimeType" ]
                        ]
                    ]
    in
    toVegaLite [ width 540, data, ps [], encHighlight [], circle [] ]


interaction4 : Spec
interaction4 =
    let
        ps =
            params
                << param "mySelection" [ paSelect seInterval [ seEncodings [ chX ] ] ]
    in
    toVegaLite [ width 540, data, ps [], encHighlight [], circle [] ]


interaction5 : Spec
interaction5 =
    let
        ps =
            params
                << param "mySelection"
                    [ paSelect seInterval []
                    , paValue
                        (dataObject
                            [ ( "x", dts [ [ dtYear 2013 ], [ dtYear 2015 ] ] |> daConcat )
                            , ( "y", nums [ 4000, 8000 ] |> daConcat )
                            ]
                        )
                    ]
    in
    toVegaLite [ width 540, data, ps [], encHighlight [], circle [] ]


interaction6 : Spec
interaction6 =
    let
        ps =
            params
                << param "mySelection"
                    [ paSelect seInterval []
                    , paValue (dataObject [ ( "y", daConcat (nums [ 4000, 8000 ]) ) ])
                    ]
    in
    toVegaLite [ width 540, data, ps [], encHighlight [], circle [] ]


interaction7 : Spec
interaction7 =
    let
        ps =
            params
                << param "mySelection"
                    [ paSelect seInterval [ seEncodings [ chX ] ]
                    , paValue (dataObject [ ( "x", daConcat (dts [ [ dtYear 2013 ], [ dtYear 2015 ] ]) ) ])
                    ]
    in
    toVegaLite [ width 540, data, ps [], encHighlight [], circle [] ]


interaction8 : Spec
interaction8 =
    let
        ps =
            params
                << param "mySelection"
                    [ paSelect seInterval [ seEncodings [ chX ] ]
                    , paValue (dataObject [ ( "x", daConcat (dts [ [ dtYear 2013 ], [ dtYear 2013 ] ]) ) ])
                    ]
    in
    toVegaLite [ width 540, data, ps [], encHighlight [], circle [] ]


interaction9 : Spec
interaction9 =
    let
        ps =
            params
                << param "mySelection"
                    [ paSelect seInterval [ seEncodings [ chX ] ]
                    , paBindScales
                    ]
    in
    toVegaLite [ width 540, data, ps [], encHighlight [], circle [] ]


interaction10 : Spec
interaction10 =
    let
        ps =
            params
                << param "mySelection" [ paSelect seInterval [], paBindScales ]
    in
    toVegaLite [ width 540, data, ps [], encHighlight [], circle [] ]


interaction11 : Spec
interaction11 =
    let
        ps =
            params
                << param "mySelection"
                    [ paSelect sePoint [ seFields [ "crimeType" ] ]
                    , paBindLegend ""
                    ]

        cfg =
            configure
                << configuration (coLegend [ lecoUnselectedOpacity 0.1 ])
    in
    toVegaLite [ cfg [], width 540, data, ps [], encHighlight [], circle [] ]


interaction12 : Spec
interaction12 =
    let
        ps =
            params
                << param "mySelection"
                    [ paSelect sePoint [ seEncodings [ chColor ] ]
                    , paBindLegend "dblclick"
                    ]
    in
    toVegaLite [ width 540, data, ps [], encHighlight [], circle [] ]


interaction13 : Spec
interaction13 =
    let
        ps =
            params
                << param "mySelection"
                    [ paSelect sePoint [ seOn "click", seFields [ "crimeType" ] ]
                    , paBindLegend "dblclick"
                    ]
    in
    toVegaLite [ width 540, data, ps [], encHighlight [], circle [] ]


interaction14 : Spec
interaction14 =
    let
        ps =
            params
                << param "mySelection"
                    [ paSelect sePoint [ seFields [ "crimeType" ] ]
                    , paBind
                        (ipRadio
                            [ inName " "
                            , inOptions
                                [ "Anti-social behaviour"
                                , "Criminal damage and arson"
                                , "Drugs"
                                , "Robbery"
                                , "Vehicle crime"
                                ]
                            ]
                        )
                    ]
    in
    toVegaLite [ width 540, data, ps [], encHighlight [], circle [] ]


interaction15 : Spec
interaction15 =
    let
        ps =
            params
                << param "minSlider"
                    [ paSelect sePoint []
                    , paValue (dataObject [ ( "minReported", num 0 ) ])
                    , paBind (ipRange [ inName "Min", inMax 12800 ])
                    ]
                << param "maxSlider"
                    [ paSelect sePoint []
                    , paValue (dataObject [ ( "maxReported", num 14000 ) ])
                    , paBind (ipRange [ inName "Max", inMin 400, inMax 14000 ])
                    ]

        trans =
            transform
                << filter (fiExpr "datum.reportedCrimes >= minSlider_minReported && maxSlider_maxReported >= datum.reportedCrimes")
    in
    toVegaLite [ width 540, data, trans [], ps [], enc [], circle [] ]


interaction16 : Spec
interaction16 =
    let
        stockData =
            dataFromUrl (path ++ "stocks.csv") [ csv, parse [ ( "date", foDate "" ) ] ]

        ps =
            params
                << param "index"
                    [ paSelect sePoint [ seEncodings [ chX ], seOn "mouseover", seNearest True ]
                    , paValue (dataObject [ ( "x", dt [ dtYear 2005, dtMonthNum Jan, dtDate 1 ] ) ])
                    ]

        trans =
            transform
                << lookupSelection "symbol" "index" "symbol"
                << calculateAs "datum.index && datum.index.price > 0 ? (datum.price - datum.index.price)/datum.index.price : 0"
                    "indexed_price"

        pointEnc =
            encoding
                << position X [ pName "date", pTemporal, pAxis [] ]

        pointSpec =
            asSpec [ ps [], pointEnc [], point [ maOpacity 0 ] ]

        lineEnc =
            encoding
                << position X [ pName "date", pTemporal, pAxis [] ]
                << position Y [ pName "indexed_price", pQuant, pAxis [ axFormat "%" ] ]
                << color [ mName "symbol" ]

        lineSpec =
            asSpec [ trans [], lineEnc [], line [] ]

        ruleTrans =
            transform
                << filter (fiSelection "index")

        ruleEnc =
            encoding
                << position X [ pName "date", pTemporal, pAxis [] ]
                << color [ mStr "firebrick" ]

        textEnc =
            encoding
                << position Y [ pNum 310 ]
                << text [ tName "date", tTimeUnit yearMonth ]

        labelledRuleSpec =
            asSpec
                [ ruleTrans []
                , ruleEnc []
                , layer
                    [ asSpec [ rule [ maStrokeWidth 0.5 ] ]
                    , asSpec [ textEnc [], textMark [ maAlign haCenter, maFontWeight (fwValue 100) ] ]
                    ]
                ]
    in
    toVegaLite [ width 650, height 300, stockData, layer [ pointSpec, lineSpec, labelledRuleSpec ] ]


interaction17 : Spec
interaction17 =
    let
        stockData =
            dataFromUrl (path ++ "stocks.csv") [ csv, parse [ ( "date", foDate "" ) ] ]

        cfg =
            configure
                << configuration (coView [ vicoCursor cuText ])

        trans =
            transform
                << filter (fiExpr "datum.symbol==='GOOG'")

        ps =
            params
                << param "myBrush"
                    [ paSelect seInterval
                        [ seEncodings [ chX ], seSelectionMark [ smCursor cuPointer ] ]
                    ]

        encLine =
            encoding
                << position X [ pName "date", pTemporal ]
                << position Y [ pName "price", pQuant ]
    in
    toVegaLite [ width 400, cfg [], stockData, ps [], trans [], encLine [], line [] ]


interaction18 : Spec
interaction18 =
    let
        angleData =
            dataSequenceAs 0 (2 * pi) 0.1 "theta"

        trans =
            transform
                << calculateAs "cos(datum.theta)" "y"

        ps =
            params
                << param "myBrush"
                    [ paSelect seInterval [ seEncodings [ chX, chY ] ]
                    , paValue
                        (dataObject
                            [ ( "x", nums [ 0.4, 1 ] |> daConcat )
                            , ( "y", nums [ 0.6, 0.8 ] |> daConcat )
                            ]
                        )
                    ]

        overviewEnc =
            encoding
                << position X [ pName "theta", pQuant, pAxis [] ]
                << position Y [ pName "y", pQuant, pAxis [] ]

        overviewSpec =
            asSpec [ ps [], overviewEnc [], line [] ]

        detailEnc =
            encoding
                << position X
                    [ pName "theta"
                    , pQuant
                    , pScale [ scDomain (doSelectionChannel "myBrush" chX) ]
                    ]
                << position Y
                    [ pName "y"
                    , pQuant
                    , pScale [ scDomain (doSelectionField "myBrush" "y") ]
                    ]

        detailSpec =
            asSpec [ detailEnc [], line [ maPoint (pmMarker [ maFill "black" ]) ] ]
    in
    toVegaLite [ angleData, trans [], hConcat [ overviewSpec, detailSpec ] ]


interaction19 : Spec
interaction19 =
    let
        stateData =
            dataFromUrl (path ++ "us-10m.json") [ topojsonFeature "states" ]

        countyData =
            dataFromUrl (path ++ "us-10m.json") [ topojsonFeature "counties" ]

        proj =
            projection [ prType albersUsa ]

        countyEnc =
            encoding
                << fill [ mName "id", mLegend [] ]

        countySpec =
            asSpec
                [ countyData
                , countyEnc []
                , geoshape [ maTooltip ttEncoding ]
                ]

        stateSpec =
            asSpec
                [ stateData
                , geoshape [ maFill "", maStroke "white", maStrokeWidth 1 ]
                ]
    in
    toVegaLite
        [ width 600
        , height 400
        , proj
        , layer [ countySpec, stateSpec ]
        ]



{- Ids and specifications to be provided to the Vega-Lite runtime. -}


specs : List ( String, Spec )
specs =
    [ ( "interaction1", interaction1 )
    , ( "interaction2", interaction2 )
    , ( "interaction3", interaction3 )
    , ( "interaction4", interaction4 )
    , ( "interaction5", interaction5 )
    , ( "interaction6", interaction6 )
    , ( "interaction7", interaction7 )
    , ( "interaction8", interaction8 )
    , ( "interaction9", interaction9 )
    , ( "interaction10", interaction10 )
    , ( "interaction11", interaction11 )
    , ( "interaction12", interaction12 )
    , ( "interaction13", interaction13 )
    , ( "interaction14", interaction14 )
    , ( "interaction15", interaction15 )
    , ( "interaction16", interaction16 )
    , ( "interaction17", interaction17 )
    , ( "interaction18", interaction18 )
    , ( "interaction19", interaction19 )
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
