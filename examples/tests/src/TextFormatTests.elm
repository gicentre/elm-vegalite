port module TextFormatTests exposing (elmToJS)

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


textFormat1 : Spec
textFormat1 =
    let
        data =
            dataFromColumns []
                << dataColumn "a" (strs (List.range 1981 2001 |> List.map String.fromInt))
                << dataColumn "b" (nums (List.range 1991 2011 |> List.map (\n -> toFloat (2011 + (1991 - n)))))

        encSym =
            encoding
                << position X [ pName "a", pTemporal ]
                << position Y [ pName "b", pQuant ]

        specSym =
            asSpec [ circle [], encSym [] ]

        encLabel =
            encoding
                << position X
                    [ pName "a"
                    , pTemporal
                    , pAxis [ axFormatAsTemporal, axFormat "%y" ]
                    ]
                << position Y
                    [ pName "b"
                    , pQuant
                    , pScale [ scZero False ]
                    , pAxis [ axFormatAsNum, axFormat ".2f" ]
                    ]
                << text
                    [ tName "a"
                    , tTemporal
                    , tFormatAsTemporal
                    , tFormat "%b `%y"
                    ]
                << color
                    [ mName "a"
                    , mTemporal
                    , mLegend [ leFormatAsTemporal, leFormat "%b %Y" ]
                    ]

        specLabel =
            asSpec
                [ encLabel []
                , textMark [ maDy 4, maDx 22, maBaseline vaMiddle, maLimit 30, maEllipsis "~ ", maDir tdRightToLeft ]
                ]
    in
    toVegaLite
        [ width 600
        , height 400
        , title "A title over\ntwo lines with an \\n escaped new line on the second line." []
        , data []
        , layer [ specSym, specLabel ]
        ]


textFormat2 : Spec
textFormat2 =
    let
        data =
            dataFromUrl "https://gicentre.github.io/data/westMidlands/westMidsCrimesAggregated.tsv"

        trans =
            transform
                << filter (fiExpr "year(datum.month) >= '2016'")

        enc =
            encoding
                << position X [ pName "crimeType", pTitle "" ]
                << position Y [ pName "reportedCrimes", pAggregate opSum ]
                << color [ mName "crimeType", mLegend [] ]
                << column [ fName "month", fTemporal, fHeader [ hdFormatAsTemporal, hdFormat "%b %y" ] ]
    in
    toVegaLite [ width 100, data [], trans [], bar [], enc [] ]


textAlign1 : Spec
textAlign1 =
    let
        cfg =
            configure
                << configuration (coMark [ maFontSize 20 ])
                << configuration (coText [ maLineHeight 40 ])

        data =
            dataFromColumns []
                << dataColumn "x" (nums [ 10, 20 ])
                << dataColumn "y" (nums [ 10, 20 ])

        enc =
            encoding
                << position X
                    [ pName "x"
                    , pQuant
                    , pTitle ""
                    , pScale [ scDomain (doNums [ 5, 25 ]), scNice niFalse ]
                    , pAxis [ axLabelLineHeight 40, axLabelBaseline vaLineTop ]
                    ]
                << position Y
                    [ pName "y"
                    , pQuant
                    , pTitle ""
                    , pScale [ scDomain (doNums [ 5, 25 ]), scNice niFalse ]
                    ]
                << text [ tStr "Xxgqh" ]

        mk va =
            case va of
                "top" ->
                    asSpec [ title va [], data [], enc [], textMark [ maBaseline vaTop ] ]

                "lineTop" ->
                    asSpec [ title va [], data [], enc [], textMark [ maBaseline vaLineTop ] ]

                "middle" ->
                    asSpec [ title va [], data [], enc [], textMark [ maBaseline vaMiddle ] ]

                "alphabetic" ->
                    asSpec [ title va [], data [], enc [], textMark [ maBaseline vaAlphabetic ] ]

                "bottom" ->
                    asSpec [ title va [], data [], enc [], textMark [ maBaseline vaBottom ] ]

                "lineBottom" ->
                    asSpec [ title va [], data [], enc [], textMark [ maBaseline vaLineBottom ] ]

                _ ->
                    asSpec []
    in
    toVegaLite
        [ cfg []
        , columns 2
        , concat (List.map mk [ "top", "lineTop", "middle", "alphabetic", "bottom", "lineBottom" ])
        ]


textAlign2 : Spec
textAlign2 =
    let
        ps =
            params
                << param "angle" [ paValue (num 0), paBind (ipRange [ inMin -180, inMax 180, inStep 1 ]) ]
                << param "dx" [ paValue (num 5), paBind (ipRange [ inMin -20, inMax 20, inStep 1 ]) ]
                << param "dy" [ paValue (num 0), paBind (ipRange [ inMin -20, inMax 20, inStep 1 ]) ]
                << param "xOffset" [ paValue (num 0), paBind (ipRange [ inMin -20, inMax 20, inStep 1 ]) ]
                << param "yOffset" [ paValue (num 0), paBind (ipRange [ inMin -20, inMax 20, inStep 1 ]) ]
                << param "fontSize" [ paValue (num 14), paBind (ipRange [ inMin 1, inMax 36, inStep 1 ]) ]
                << param "limit" [ paValue (num 0), paBind (ipRange [ inMin 0, inMax 150, inStep 1 ]) ]
                << param "align" [ paValue (str "left"), paBind (ipSelect [ inOptions [ "left", "center", "right" ] ]) ]
                << param "baseline" [ paValue (str "middle"), paBind (ipSelect [ inOptions [ "alphabetic", "top", "middle", "bottom" ] ]) ]
                << param "font" [ paValue (str "sans-serif"), paBind (ipSelect [ inOptions [ "sans-serif", "serif", "monospace" ] ]) ]
                << param "fontWeight" [ paValue (str "normal"), paBind (ipSelect [ inOptions [ "normal", "bold" ] ]) ]
                << param "fontStyle" [ paValue (str "normal"), paBind (ipSelect [ inOptions [ "normal", "italic" ] ]) ]
                << param "axisAngle" [ paExpr "0" ]
                << param "cSize" [ paValue (num 100), paBind (ipRange [ inMin 0, inMax 1000, inStep 5 ]) ]
                << param "strokeWidth" [ paValue (num 4), paBind (ipRange [ inMin 0, inMax 12, inStep 0.1 ]) ]
                << param "fill" [ paValue (str "grey"), paBind (ipColor []) ]
                << param "stroke" [ paValue (str "black"), paBind (ipColor []) ]

        data =
            dataFromColumns []
                << dataColumn "a" (nums [ 30, 25, 70 ])
                << dataColumn "b" (nums [ 28, 65, 43 ])
                << dataColumn "label" (strs [ "Alice", "Bob", "Carol" ])

        enc =
            encoding
                << position X
                    [ pName "a"
                    , pQuant
                    , pAxis [ axLabelAngle 0 ]
                    , pScale [ scDomain (doNums [ 0, 100 ]) ]
                    ]
                << position Y
                    [ pName "b"
                    , pQuant
                    , pScale [ scDomain (doNums [ 0, 100 ]) ]
                    ]

        specCircle =
            asSpec
                [ circle
                    [ maSize |> maNumExpr "cSize"
                    , maFill |> maStrExpr "fill"
                    , maStroke |> maStrExpr "stroke"
                    , maStrokeWidth |> maNumExpr "strokeWidth"
                    ]
                ]

        encText =
            encoding
                << text [ tName "label" ]

        specText =
            asSpec
                [ encText []
                , textMark
                    [ maDx |> maNumExpr "dx"
                    , maDy |> maNumExpr "dy"
                    , maXOffset |> maNumExpr "xOffset"
                    , maYOffset |> maNumExpr "yOffset"
                    , maAngle |> maNumExpr "angle"
                    , maAlign (haExpr "align")
                    , maBaseline (vaExpr "baseline")
                    , maFont |> maStrExpr "font"
                    , maFontSize |> maNumExpr "fontSize"
                    , maFontStyle |> maStrExpr "fontStyle"
                    , maFontWeight (fwExpr "fontWeight")
                    , maLimit |> maNumExpr "limit"
                    ]
                ]
    in
    toVegaLite [ ps [], data [], enc [], layer [ specCircle, specText ] ]


multiline1 : Spec
multiline1 =
    let
        cfg =
            configure
                << configuration (coTitle [ ticoSubtitleLineHeight 24 ])
                << configuration (coAxis [ axcoTitleLineHeight 24 ])
                << configuration (coLegend [ lecoTitleLineHeight 24 ])
                << configuration (coMark [ maLineHeight 16 ])

        data1 =
            dataFromColumns []
                << dataColumn "x" (nums [ 8, 12 ])
                << dataColumn "y" (nums [ 5, 15 ])
                << dataColumn "label" (strs [ "data on\ntwo lines", "data on\nthree\nlines" ])
                << dataColumn "cat" (strs [ "A", "B" ])

        data2 =
            dataFromColumns []
                << dataColumn "x" (nums [ 15 ])
                << dataColumn "y" (nums [ 10 ])
                << dataColumn "cat" (strs [ "C" ])

        encBase =
            encoding
                << position X
                    [ pName "x"
                    , pQuant
                    , pScale [ scDomain (doNums [ 0, 20 ]) ]
                    , pTitle "Axis title on\ntwo lines"
                    ]
                << position Y
                    [ pName "y"
                    , pQuant
                    , pScale [ scDomain (doNums [ 0, 20 ]) ]
                    , pTitle "Axis title on\ntwo lines"
                    ]
                << color [ mName "cat", mTitle "Legend title on\ntwo lines" ]

        enc1 =
            encBase
                << text [ tName "label" ]

        spec1 =
            asSpec [ data1 [], enc1 [], textMark [] ]

        enc2 =
            encBase
                << text [ tStr "literal\non\nthree lines" ]

        spec2 =
            asSpec [ data2 [], enc2 [], textMark [] ]
    in
    toVegaLite
        [ cfg []
        , title "Main title on\ntwo lines" [ tiLineHeight 24, tiSubtitle "Subtitle on\ntwo lines" ]
        , layer [ spec1, spec2 ]
        ]


customFormatter1 : Spec
customFormatter1 =
    let
        data =
            dataFromUrl "https://gicentre.github.io/data/westMidlands/westMidsCrimesAggregated.tsv"

        trans =
            transform
                << filter (fiExpr "datum.month >= '2016'")

        enc =
            encoding
                << position X [ pName "crimeType", pAxis [ axFormatAsCustom "axTest" ] ]
                << position Y [ pName "reportedCrimes", pAggregate opSum ]
                << color [ mName "crimeType", mLegend [ leFormatAsCustom "leTest" ] ]
                << column [ fName "month", fTemporal, fHeader [ hdFormatAsCustom "hdTest" ] ]
    in
    toVegaLite [ width 100, data [], trans [], bar [], enc [] ]


title1 : Spec
title1 =
    let
        t1 =
            strs [ "This is the visualization title", "that is split over two lines" ]

        t2 =
            strs [ "Short title" ]

        t3 =
            strs [ "A Title", "over", "three lines" ]

        ps =
            params
                << param "angle" [ paValue (num 0), paBind (ipRange [ inMin -90, inMax 90, inStep 1 ]) ]
                << param "dx" [ paValue (num 0), paBind (ipRange [ inMin -40, inMax 40 ]) ]
                << param "dy" [ paValue (num 0), paBind (ipRange [ inMin -40, inMax 40 ]) ]
                << param "color" [ paValue (str "black"), paBind (ipColor []) ]
                << param "font" [ paValue (str "sans-serif"), paBind (ipSelect [ inOptions [ "sans-serif", "serif", "monospace" ] ]) ]
                << param "fontSize" [ paValue (num 24), paBind (ipRange [ inMin 0, inMax 64 ]) ]
                << param "fontStyle" [ paValue (str "normal"), paBind (ipSelect [ inOptions [ "normal", "italic" ] ]) ]
                << param "fontWeight" [ paValue (str "normal"), paBind (ipSelect [ inOptions [ "normal", "bold", "lighter" ] ]) ]
                << param "limit" [ paValue (num 0), paBind (ipRange [ inMax 300, inStep 1 ]) ]
                << param "offset" [ paValue (num 0), paBind (ipRange [ inMin -100, inMax 100, inStep 1 ]) ]
                << param "subtitle"
                    [ paValue (str "A subtitle")
                    , paBind (ipSelect [ inOptions [ "A subtitle", "A different subtitle", "And a third subtitle" ] ])
                    ]
                << param "subtitleColour" [ paValue (str "black"), paBind (ipColor []) ]
                << param "subtitlePadding" [ paValue (num 5), paBind (ipRange [ inMin -50, inMax 50, inStep 1 ]) ]
                << param "title" [ paValues t1, paBind (ipSelect [ inDataOptions [ t1, t2, t3 ] ]) ]

        data =
            dataFromUrl (path ++ "cars.json") []

        enc =
            encoding
                << position X [ pName "Weight_in_lbs", pQuant ]
                << position Y [ pName "Horsepower", pQuant ]
    in
    toVegaLite
        [ ps []
        , padding (paEdges 5 250 5 5)
        , titleExpr "title"
            [ tiAngle |> tiNumExpr "angle"
            , tiColor |> tiStrExpr "color"
            , tiDx |> tiNumExpr "dx"
            , tiDy |> tiNumExpr "dy"
            , tiFont |> tiStrExpr "font"
            , tiFontSize |> tiNumExpr "fontSize"
            , tiFontStyle |> tiStrExpr "fontStyle"
            , tiFontWeight (fwExpr "fontWeight")
            , tiLineHeight |> tiNumExpr "fontSize"
            , tiLimit |> tiNumExpr "limit"
            , tiOffset |> tiNumExpr "offset"
            , tiSubtitle |> tiStrExpr "subtitle"
            , tiSubtitleColor |> tiStrExpr "subtitleColour"
            , tiSubtitleFontSize |> tiNumExpr "fontSize/2"
            , tiSubtitleLineHeight |> tiNumExpr "fontSize/2"
            , tiSubtitlePadding |> tiNumExpr "subtitlePadding"
            ]
        , width 400
        , height 400
        , data
        , enc []
        , circle []
        ]



{- Ids and specifications to be provided to the Vega-Lite runtime. -}


specs : List ( String, Spec )
specs =
    [ ( "textFormat1", textFormat1 )
    , ( "textFormat2", textFormat2 )
    , ( "textAlign1", textAlign1 )
    , ( "textAlign2", textAlign2 )
    , ( "multiline1", multiline1 )
    , ( "customFormatter1", customFormatter1 )
    , ( "title1", title1 )
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
