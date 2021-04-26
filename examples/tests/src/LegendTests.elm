port module LegendTests exposing (elmToJS)

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


legendCore : List LegendProperty -> Spec
legendCore legProps =
    let
        data =
            dataFromUrl (path ++ "cars.json") []

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]
                << color [ mName "Origin", mLegend legProps ]
                << size [ mName "Horsepower", mQuant, mLegend legProps ]
                << opacity [ mName "Weight_in_lbs", mQuant, mLegend legProps ]
    in
    toVegaLite [ width 300, height 300, data, enc [], circle [] ]


legendCoreCfg : List LegendConfig -> Spec
legendCoreCfg cfg =
    let
        data =
            dataFromUrl (path ++ "cars.json") []

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]
                << color [ mName "Origin" ]
                << size [ mName "Horsepower", mQuant ]
                << opacity [ mName "Weight_in_lbs", mQuant ]
    in
    toVegaLite
        [ (configure << configuration (coLegend cfg)) []
        , width 300
        , height 300
        , data
        , enc []
        , circle []
        ]


legend1 : Spec
legend1 =
    legendCoreCfg []


legend2 : Spec
legend2 =
    legendCore [ leOrient loTop ]


legend3 : Spec
legend3 =
    legendCore [ leOrient loTopRight ]


legend4 : Spec
legend4 =
    legendCore [ leOrient loRight ]


legend5 : Spec
legend5 =
    legendCore [ leOrient loBottomRight ]


legend6 : Spec
legend6 =
    legendCore [ leOrient loBottom ]


legend7 : Spec
legend7 =
    legendCore [ leOrient loBottomLeft ]


legend8 : Spec
legend8 =
    legendCore [ leOrient loLeft ]


legend9 : Spec
legend9 =
    legendCore [ leOrient loTopLeft ]


legend10 : Spec
legend10 =
    let
        data =
            dataFromUrl (path ++ "cars.json") []

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]
                << color [ mName "Origin", mLegend [ leOrient loNone, leX 232, leY 5 ] ]
    in
    toVegaLite [ width 300, height 300, data, enc [], circle [] ]


legend11 : Spec
legend11 =
    legendCoreCfg
        [ lecoSymbolStrokeWidth 3
        , lecoSymbolStrokeColor "black"
        , lecoRowPadding 15
        , lecoTitlePadding 20
        , lecoStrokeColor "lightgrey"
        , lecoStrokeWidth 5
        , lecoPadding 30
        , lecoStrokeDash [ 4, 2, 6, 1 ]
        ]


legend12 : Spec
legend12 =
    legendCore [ leLabelBaseline vaLineTop ]


legend13 : Spec
legend13 =
    legendCore [ leSymbolLimit 4 ]


legend14 : Spec
legend14 =
    legendCoreCfg [ lecoSymbolLimit 4 ]


legend15 : Spec
legend15 =
    let
        lVals1 =
            nums [ 8, 12, 16, 20, 24 ]

        lVals2 =
            nums [ 0, 25 ]

        lVals3 =
            nums [ 5, 10, 15, 20, 25 ]

        ps =
            params
                << param "cornerRadius" [ paValue (num 0), paBind (ipRange [ inMin 0, inMax 60 ]) ]
                << param "fillColor" [ paValue (str "#ccc"), paBind (ipColor [ inName "Fill colour " ]) ]
                << param "gradientLength" [ paValue (num 200), paBind (ipRange [ inMin 0, inMax 400 ]) ]
                << param "gradientOpacity" [ paValue (num 1), paBind (ipRange [ inMin 0, inMax 1 ]) ]
                << param "gradientStrokeColor" [ paValue (str "#006"), paBind (ipColor []) ]
                << param "gradientStrokeWidth" [ paValue (num 1), paBind (ipRange [ inMin 0, inMax 4 ]) ]
                << param "gradientThickness" [ paValue (num 16), paBind (ipRange [ inMin 0, inMax 40 ]) ]
                << param "labelAlign" [ paValue (str "center"), paBind (ipSelect [ inName "Label align ", inOptions [ "center", "left", "right" ] ]) ]
                << param "labelBaseline" [ paValue (str "top"), paBind (ipSelect [ inName "Label baseline ", inOptions [ "alphabetic", "top", "middle", "bottom", "line-top", "line-bottom" ] ]) ]
                << param "labelFont" [ paValue (str "sans-serif"), paBind (ipSelect [ inName "Label font ", inOptions [ "sans-serif", "serif", "monospace" ] ]) ]
                << param "labelFontSize" [ paValue (num 10), paBind (ipRange [ inName "Label font size ", inMin 0, inMax 32, inStep 1 ]) ]
                << param "labelFontStyle" [ paValue (str "normal"), paBind (ipSelect [ inName "Label style ", inOptions [ "normal", "italic" ] ]) ]
                << param "labelFontWeight" [ paValue (str "normal"), paBind (ipSelect [ inName "Label weight ", inOptions [ "normal", "bold", "lighter" ] ]) ]
                << param "offset" [ paValue (num 0), paBind (ipRange [ inMin -60, inMax 60 ]) ]
                << param "padding" [ paValue (num 20), paBind (ipRange [ inMin -60, inMax 60 ]) ]
                << param "strokeColor" [ paValue (str "black"), paBind (ipColor []) ]
                << param "tickCount" [ paValue (num 10), paBind (ipRange [ inMin 0, inMax 30 ]) ]
                << param "titleColor" [ paValue (str "black"), paBind (ipColor []) ]
                << param "values" [ paValues lVals1, paBind (ipSelect [ inName "Values ", inDataOptions [ lVals1, lVals2, lVals3 ] ]) ]
                << param "xPos" [ paValue (num 10), paBind (ipRange [ inMin -300, inMax 300 ]) ]
                << param "yPos" [ paValue (num 10), paBind (ipRange [ inMin -300, inMax 300 ]) ]

        data =
            dataFromUrl (path ++ "cars.json") []

        enc =
            encoding
                << position X [ pName "Weight_in_lbs", pQuant ]
                << position Y [ pName "Horsepower", pQuant ]
                << color
                    [ mName "Acceleration"
                    , mQuant
                    , mLegend
                        [ leCornerRadius |> leNumExpr "cornerRadius"
                        , leFillColor |> leStrExpr "fillColor"
                        , leGradientLength |> leNumExpr "gradientLength"
                        , leGradientOpacity |> leNumExpr "gradientOpacity"
                        , leGradientStrokeColor |> leStrExpr "gradientStrokeColor"
                        , leGradientStrokeWidth |> leNumExpr "gradientStrokeWidth"
                        , leGradientThickness |> leNumExpr "gradientThickness"
                        , leLabelAlign (haExpr "labelAlign")
                        , leLabelBaseline (vaExpr "labelBaseline")
                        , leLabelFont |> leStrExpr "labelFont"
                        , leLabelFontSize |> leNumExpr "labelFontSize"
                        , leLabelFontStyle |> leStrExpr "labelFontStyle"
                        , leLabelFontWeight (fwExpr "labelFontWeight")
                        , leOffset |> leNumExpr "offset"
                        , lePadding |> leNumExpr "padding"
                        , leStrokeColor |> leStrExpr "strokeColor"
                        , leTickCount |> leNumExpr "tickCount"
                        , leTitleColor |> leStrExpr "titleColor"
                        , leValues (dataExpr "values")
                        , leX |> leNumExpr "xPos"
                        , leY |> leNumExpr "yPos"
                        ]
                    ]
                << shape [ mName "Origin" ]
    in
    toVegaLite
        [ ps []
        , width 500
        , height 400
        , autosize [ asFit ]
        , padding (paSize 80)
        , data
        , enc []
        , point []
        ]



{- Ids and specifications to be provided to the Vega-Lite runtime. -}


specs : List ( String, Spec )
specs =
    [ ( "legend1", legend1 )
    , ( "legend2", legend2 )
    , ( "legend3", legend3 )
    , ( "legend4", legend4 )
    , ( "legend5", legend5 )
    , ( "legend6", legend6 )
    , ( "legend7", legend7 )
    , ( "legend8", legend8 )
    , ( "legend9", legend9 )
    , ( "legend10", legend10 )
    , ( "legend11", legend11 )
    , ( "legend12", legend12 )
    , ( "legend13", legend13 )
    , ( "legend14", legend14 )
    , ( "legend15", legend15 )
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
