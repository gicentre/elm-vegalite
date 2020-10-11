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
    "https://cdn.jsdelivr.net/npm/vega-datasets@2.1/data/"


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
        << color
            [ mSelectionCondition (selectionName "mySelection")
                [ mName "crimeType", mScale cScale ]
                [ mStr "black" ]
            ]
        << opacity
            [ mSelectionCondition (selectionName "mySelection")
                [ mNum 1 ]
                [ mNum 0.1 ]
            ]


interaction1 : Spec
interaction1 =
    let
        sel =
            selection << select "mySelection" seSingle []
    in
    toVegaLite [ width 540, data, sel [], encHighlight [], line [] ]


interaction2 : Spec
interaction2 =
    let
        sel =
            selection << select "mySelection" seMulti []
    in
    toVegaLite [ width 540, data, sel [], encHighlight [], line [] ]


interaction3 : Spec
interaction3 =
    let
        sel =
            selection
                << select "mySelection" seSingle [ seNearest True, seFields [ "crimeType" ] ]
    in
    toVegaLite [ width 540, data, sel [], encHighlight [], circle [] ]


interaction4 : Spec
interaction4 =
    let
        sel =
            selection
                << select "mySelection" seInterval [ seEmpty, seEncodings [ chX ] ]
    in
    toVegaLite [ width 540, data, sel [], encHighlight [], circle [] ]


interaction5 : Spec
interaction5 =
    let
        sel =
            selection
                << select "mySelection"
                    seInterval
                    [ seInitInterval (Just ( dt [ dtYear 2013 ], dt [ dtYear 2015 ] ))
                        (Just ( num 4000, num 8000 ))
                    ]
    in
    toVegaLite [ width 540, data, sel [], encHighlight [], circle [] ]


interaction6 : Spec
interaction6 =
    let
        sel =
            selection
                << select "mySelection"
                    seInterval
                    [ seInitInterval Nothing (Just ( num 4000, num 8000 )) ]
    in
    toVegaLite [ width 540, data, sel [], encHighlight [], circle [] ]


interaction7 : Spec
interaction7 =
    let
        sel =
            selection
                << select "mySelection"
                    seInterval
                    [ seEncodings [ chX ]
                    , seInitInterval (Just ( dt [ dtYear 2013 ], dt [ dtYear 2015 ] )) Nothing
                    ]
    in
    toVegaLite [ width 540, data, sel [], encHighlight [], circle [] ]


interaction8 : Spec
interaction8 =
    let
        sel =
            selection
                << select "mySelection"
                    seInterval
                    [ seInitInterval Nothing Nothing ]
    in
    toVegaLite [ width 540, data, sel [], encHighlight [], circle [] ]


interaction9 : Spec
interaction9 =
    let
        sel =
            selection
                << select "mySelection" seInterval [ seBindScales, seEncodings [ chX ] ]
    in
    toVegaLite [ width 540, data, sel [], encHighlight [], circle [] ]


interaction10 : Spec
interaction10 =
    let
        sel =
            selection
                << select "mySelection" seInterval [ seBindScales ]
    in
    toVegaLite [ width 540, data, sel [], encHighlight [], circle [] ]


interaction11 : Spec
interaction11 =
    let
        sel =
            selection
                << select "mySelection" seSingle [ seBindLegend [ blField "crimeType" ] ]

        cfg =
            configure
                << configuration (coLegend [ lecoUnselectedOpacity 0.1 ])
    in
    toVegaLite [ cfg [], width 540, data, sel [], encHighlight [], circle [] ]


interaction12 : Spec
interaction12 =
    let
        sel =
            selection
                << select "mySelection" seSingle [ seBindLegend [ blChannel chColor, blEvent "dblclick" ] ]
    in
    toVegaLite [ width 540, data, sel [], encHighlight [], circle [] ]


interaction13 : Spec
interaction13 =
    let
        sel =
            selection
                << select "mySelection"
                    seMulti
                    [ seOn "click"
                    , seBindLegend [ blField "crimeType", blEvent "dblclick" ]
                    ]
    in
    toVegaLite [ width 540, data, sel [], encHighlight [], circle [] ]


interaction14 : Spec
interaction14 =
    let
        sel =
            selection
                << select "mySelection"
                    seSingle
                    [ seFields [ "crimeType" ]
                    , seNearest True
                    , seBind
                        [ iRadio "crimeType"
                            [ inName " "
                            , inOptions
                                [ "Anti-social behaviour"
                                , "Criminal damage and arson"
                                , "Drugs"
                                , "Robbery"
                                , "Vehicle crime"
                                ]
                            ]
                        ]
                    ]
    in
    toVegaLite [ width 540, data, sel [], encHighlight [], circle [] ]


interaction15 : Spec
interaction15 =
    let
        sel =
            selection
                << select "maxSlider"
                    seSingle
                    [ seInit [ ( "maxReported", num 14000 ) ]
                    , seBind [ iRange "maxReported" [ inName "Max", inMin 400, inMax 14000 ] ]
                    ]
                << select "minSlider"
                    seSingle
                    [ seInit [ ( "minReported", num 0 ) ]
                    , seBind [ iRange "minReported" [ inName "Min", inMax 12800 ] ]
                    ]

        trans =
            transform
                << filter (fiExpr "datum.reportedCrimes >= minSlider_minReported && maxSlider_maxReported >= datum.reportedCrimes")
    in
    toVegaLite [ width 540, data, trans [], sel [], enc [], circle [] ]


interaction16 : Spec
interaction16 =
    let
        stockData =
            dataFromUrl (path ++ "stocks.csv") [ csv, parse [ ( "date", foDate "" ) ] ]

        sel =
            selection
                << select "index"
                    seSingle
                    [ seOn "mouseover"
                    , seEncodings [ chX ]
                    , seNearest True
                    , seInit [ ( "x", dt [ dtYear 2005, dtMonthNum Jan, dtDate 1 ] ) ]
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
            asSpec [ sel [], pointEnc [], point [ maOpacity 0 ] ]

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

        sel =
            selection
                << select "myBrush"
                    seInterval
                    [ seEncodings [ chX ]
                    , seSelectionMark [ smCursor cuPointer ]
                    ]

        encLine =
            encoding
                << position X [ pName "date", pTemporal ]
                << position Y [ pName "price", pQuant ]
    in
    toVegaLite [ width 400, cfg [], stockData, trans [], sel [], encLine [], line [] ]


interaction18 : Spec
interaction18 =
    let
        angleData =
            dataSequenceAs 0 (2 * pi) 0.1 "theta"

        trans =
            transform
                << calculateAs "cos(datum.theta)" "y"

        sel =
            selection
                << select "myBrush"
                    seInterval
                    [ seEncodings [ chX, chY ]
                    , seInitInterval
                        (Just ( num 0.4, num 1 ))
                        (Just ( num 0.6, num 0.8 ))
                    ]

        overviewEnc =
            encoding
                << position X [ pName "theta", pQuant, pAxis [] ]
                << position Y [ pName "y", pQuant, pAxis [] ]

        overviewSpec =
            asSpec [ sel [], overviewEnc [], line [] ]

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
   a drop-down list. Useful for viewin specs that might generate invalid Vega-Lite.
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
