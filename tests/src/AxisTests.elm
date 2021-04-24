port module AxisTests exposing (elmToJS)

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


data : List DataColumn -> Data
data =
    dataFromColumns []
        << dataColumn "x" (List.range 1 100 |> List.map toFloat |> nums)
        << dataColumn "catX" (List.range 1 100 |> List.map String.fromInt |> strs)
        << dataColumn "y" (List.range 1 10 |> List.map toFloat |> nums)


temporalData : List DataColumn -> Data
temporalData =
    dataFromColumns [ parse [ ( "date", foDate "%Y-%m-%d %H:%M:%S" ) ] ]
        << dataColumn "date"
            (strs
                [ "2019-01-01 09:00:00"
                , "2019-01-02 09:00:00"
                , "2019-01-03 09:00:00"
                , "2019-01-04 09:00:00"
                , "2019-01-05 09:00:00"
                , "2019-01-06 09:00:00"
                , "2019-01-07 09:00:00"
                , "2019-01-08 09:00:00"
                , "2019-01-09 09:00:00"
                , "2019-01-10 09:00:00"
                , "2019-01-11 09:00:00"
                , "2019-01-12 09:00:00"
                ]
            )
        << dataColumn "y" (nums [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 ])


qAxisBase : Maybe ConfigurationProperty -> Spec
qAxisBase maybeCfg =
    let
        cfg =
            case maybeCfg of
                Just axCfg ->
                    configure
                        << configuration axCfg

                Nothing ->
                    configure

        enc =
            encoding
                << position X [ pName "x", pQuant ]
                << position Y [ pName "y", pOrdinal ]
    in
    toVegaLite [ cfg [], data [], enc [], line [ maPoint (pmMarker []) ] ]


axis1 : Spec
axis1 =
    qAxisBase Nothing


axis1a : Spec
axis1a =
    qAxisBase (Just (coAxisQuant [ axcoGridColor "red" ]))


axis2 : Spec
axis2 =
    let
        enc =
            encoding
                << position X [ pName "x", pQuant ]
                << position Y [ pName "y", pQuant ]
    in
    toVegaLite [ widthOfContainer, data [], enc [], line [ maPoint (pmMarker []) ] ]


axis3 : Spec
axis3 =
    let
        enc =
            encoding
                << position X [ pName "catX", pOrdinal ]
                << position Y [ pName "y", pQuant ]
    in
    toVegaLite [ data [], enc [], line [ maPoint (pmMarker []) ] ]


tAxisBase : Maybe ConfigurationProperty -> Spec
tAxisBase maybeCfg =
    let
        cfg =
            case maybeCfg of
                Just axCfg ->
                    configure
                        << configuration axCfg

                Nothing ->
                    configure

        enc =
            encoding
                << position X [ pName "date", pTemporal ]
                << position Y [ pName "y", pQuant ]
    in
    toVegaLite [ cfg [], temporalData [], enc [], line [ maPoint (pmMarker []) ] ]


axis4 : Spec
axis4 =
    tAxisBase Nothing


axis4a : Spec
axis4a =
    tAxisBase
        (Just
            (coAxisTemporal
                [ axcoGridColor "red"
                , axcoDomainDash [ 6, 6 ]
                , axcoDomainDashOffset 6
                , axcoGridDash [ 3, 3 ]
                , axcoGridDashOffset 3
                , axcoTickSize 10
                , axcoTickDash [ 2, 2 ]
                , axcoTickDashOffset 2
                ]
            )
        )


axis5 : Spec
axis5 =
    let
        enc =
            encoding
                << position X
                    [ pName "x"
                    , pQuant
                    , pAxis [ axValues (nums [ 1, 2, 4.5, 9, 11 ]) ]
                    ]
                << position Y [ pName "y", pQuant ]
    in
    toVegaLite [ data [], enc [], line [ maPoint (pmMarker []) ] ]


axis6 : Spec
axis6 =
    let
        enc =
            encoding
                << position X
                    [ pName "catX"
                    , pOrdinal
                    , pAxis [ axValues (strs [ "1", "2", "4", "dummy", "9", "11" ]) ]
                    ]
                << position Y [ pName "y", pQuant ]
    in
    toVegaLite [ data [], enc [], line [ maPoint (pmMarker []) ] ]


axis7 : Spec
axis7 =
    let
        enc =
            encoding
                << position X
                    [ pName "date"
                    , pTemporal
                    , pAxis
                        [ axValues
                            (dts
                                [ [ dtYear 2019, dtMonth Jan, dtDate 4 ]
                                , [ dtYear 2019, dtMonth Jan, dtDate 8 ]
                                , [ dtYear 2019, dtMonth Jan, dtDate 20 ]
                                ]
                            )
                        ]
                    ]
                << position Y [ pName "y", pQuant ]
    in
    toVegaLite [ temporalData [], enc [], line [ maPoint (pmMarker []) ] ]


axis8 : Spec
axis8 =
    let
        enc =
            encoding
                << position X
                    [ pName "x"
                    , pQuant
                    , pAxis [ axLabelExpr "datum.value / 100" ]
                    ]
                << position Y [ pName "y", pQuant ]
    in
    toVegaLite [ data [], enc [], line [ maPoint (pmMarker []) ] ]


axis9 : Spec
axis9 =
    let
        enc =
            encoding
                << position X
                    [ pName "catX"
                    , pOrdinal
                    , pAxis [ axLabelExpr "'number '+ datum.label" ]
                    ]
                << position Y [ pName "y", pQuant ]
    in
    toVegaLite [ data [], enc [], line [ maPoint (pmMarker []) ] ]


axis10 : Spec
axis10 =
    let
        cfg =
            configure
                << configuration (coAxis [ axcoLabelExpr "'number '+ datum.label" ] |> coAxisXFilter)

        enc =
            encoding
                << position X [ pName "catX", pOrdinal ]
                << position Y [ pName "y", pQuant ]
    in
    toVegaLite [ cfg [], data [], enc [], line [ maPoint (pmMarker []) ] ]


axis11 : Spec
axis11 =
    let
        cfg =
            configure
                << configuration (coAxis [ axcoLabelExpr "'number '+ datum.label" ] |> coAxisXFilter)
                << configuration (coAxis [ axcoTickCount (niTickCount 10) ] |> coAxisYFilter)

        enc =
            encoding
                << position X [ pName "catX", pOrdinal ]
                << position Y [ pName "y", pQuant ]
    in
    toVegaLite [ cfg [], data [], enc [], line [ maPoint (pmMarker []) ] ]


axis12 : Spec
axis12 =
    let
        cfg =
            configure
                << configuration
                    (coAxisStyles
                        [ ( "redStyle"
                          , [ axDomainColor "red"
                            , axLabelColor "red"
                            , axTitleColor "red"
                            , axTickCount (niTickCount 10)
                            , axDomainDash [ 4, 2, 8, 4 ]
                            ]
                          )
                        , ( "blueStyle"
                          , [ axDomainColor "blue"
                            , axLabelColor "blue"
                            , axTitleColor "blue"
                            , axTickCount (niTickCount 10)
                            ]
                          )
                        ]
                    )

        enc =
            encoding
                << position X [ pName "catX", pOrdinal, pAxis [ axStyle [ "redStyle" ] ] ]
                << position Y [ pName "y", pQuant, pAxis [ axStyle [ "blueStyle" ] ] ]
    in
    toVegaLite [ cfg [], data [], enc [], line [ maPoint (pmMarker []) ] ]



-- Unlike titles, it would appear Vega-Lite does not allow axis styles to reference other named styles.
-- axis13 : Spec
-- axis13 =
--     let
--         cfg =
--             configure
--                 << configuration
--                     (coAxisStyles
--                         [ ( "tickStyle", [ axTickCount (niTickCount 10) ] )
--                         , ( "redStyle", [ axDomainColor "red", axLabelColor "red", axTitleColor "red" ] )
--                         , ( "blueStyle", [ axDomainColor "blue", axLabelColor "blue", axTitleColor "blue" ] )
--                         ]
--                     )
--                 << configuration (coAxis [ axcoStyle [ "tickStyle" ] ])
--                 << configuration (coAxis [ axcoStyle [ "redStyle" ] ]|> coAxisXFilter)
--                 << configuration (coAxis [ axcoStyle [ "blueStyle" ] ]|> coAxisYFilter)
--
--         enc =
--             encoding
--                 << position X [ pName "catX", pOrdinal ]
--                 << position Y [ pName "y", pQuant ]
--     in
--     toVegaLite [ cfg [], data [], enc [], line [ maPoint (pmMarker []) ] ]


axis14 : Spec
axis14 =
    let
        enc =
            encoding
                << position X
                    [ pName "catX"
                    , pOrdinal
                    , pAxis
                        [ axLabelAngle 0
                        , axDataCondition (expr "datum.label < 10") (cAxLabelOffset 0 -4)
                        ]
                    ]
                << position Y [ pName "y", pQuant ]
    in
    toVegaLite [ data [], enc [], line [ maPoint (pmMarker []) ] ]


axis15 : Spec
axis15 =
    let
        enc =
            encoding
                << position X
                    [ pName "catX"
                    , pOrdinal
                    , pAxis
                        [ axDomainCap caSquare
                        , axDomainWidth 6
                        , axDomainDash [ 12, 12 ]
                        , axDataCondition (expr "datum.label < '5'") (cAxTickDash [ 2, 2 ] [ 20, 20 ])
                        , axDataCondition (expr "datum.label < '3'") (cAxTickDashOffset 0 8)
                        ]
                    ]
                << position Y
                    [ pName "y"
                    , pQuant
                    , pAxis
                        [ axGridCap caRound
                        , axGridWidth 3
                        , axDataCondition (expr "datum.value < 5") (cAxGridDash [ 2, 2 ] [ 20, 20 ])
                        , axDataCondition (expr "datum.value < 3") (cAxGridDashOffset 0 8)
                        ]
                    ]
    in
    toVegaLite [ data [], enc [], line [ maPoint (pmMarker []) ] ]


axis16 : Spec
axis16 =
    let
        solid =
            daConcat (nums [])

        shortDash =
            daConcat (nums [ 2, 2 ])

        longDash =
            daConcat (nums [ 8, 8 ])

        ps =
            params
                -- TODO Aria
                -- TODO tickValues
                << param "bandPosition" [ paValue (num 0.5), paBind (ipRange [ inName "Band position ", inMin 0, inMax 1 ]) ]
                << param "minExtent" [ paValue (num 30), paBind (ipRange [ inName "Min extent ", inMin 0, inMax 100 ]) ]
                << param "orient" [ paValue (str "bottom"), paBind (ipSelect [ inName "Orientation ", inOptions [ "top", "bottom" ] ]) ]
                << param "domainCap" [ paValue (str "butt"), paBind (ipSelect [ inName "Domain cap ", inOptions [ "butt", "round", "square" ] ]) ]
                << param "domainColor" [ paValue (str "black"), paBind (ipColor [ inName "Domain colour " ]) ]
                << param "domainDash" [ paValue solid, paBind (ipSelect [ inName "Domain dash ", inDataOptions [ solid, shortDash, longDash ] ]) ]
                << param "domainDashOffset" [ paValue (num 0), paBind (ipRange [ inName "Domain dash offset ", inMin 0, inMax 12 ]) ]
                << param "domainWidth" [ paValue (num 2), paBind (ipRange [ inName "Domain width ", inMin 0.1, inMax 12 ]) ]
                << param "domainOpacity" [ paValue (num 1), paBind (ipRange [ inName "Domain opacity ", inMin 0, inMax 1 ]) ]
                << param "offset" [ paValue (num 0), paBind (ipRange [ inName "Offset ", inMin -10, inMax 10, inStep 1 ]) ]
                << param "position" [ paValue (num 0), paBind (ipRange [ inName "Position ", inMin -30, inMax 30 ]) ]
                << param "translate" [ paValue (num 0.5), paBind (ipRange [ inName "Translate ", inMin -4, inMax 4 ]) ]
                << param "labelAlign" [ paValue (str "center"), paBind (ipSelect [ inName "Label align ", inOptions [ "center", "left", "right" ] ]) ]
                << param "labelBaseline" [ paValue (str "top"), paBind (ipSelect [ inName "Label baseline ", inOptions [ "alphabetic", "top", "middle", "bottom", "line-top", "line-bottom" ] ]) ]
                << param "labelBound" [ paValue (boo False), paBind (ipSelect [ inName "Label bound ", inDataOptions [ boo False, boo True, num 15 ] ]) ]
                << param "labelAngle" [ paValue (num 0), paBind (ipRange [ inName "Label angle ", inMin -90, inMax 90, inStep 1 ]) ]
                << param "labelColor" [ paValue (str "black"), paBind (ipColor [ inName "Label colour " ]) ]
                << param "labelFont" [ paValue (str "sans-serif"), paBind (ipSelect [ inName "Label font ", inOptions [ "sans-serif", "serif", "monospace" ] ]) ]
                << param "labelFlushOffset" [ paValue (num 0), paBind (ipRange [ inName "Label flush offset ", inMin -20, inMax 20 ]) ]
                << param "labelFontSize" [ paValue (num 10), paBind (ipRange [ inName "Label font size ", inMin 0, inMax 32, inStep 1 ]) ]
                << param "labelFontStyle" [ paValue (str "normal"), paBind (ipSelect [ inName "Label style ", inOptions [ "normal", "italic" ] ]) ]
                << param "labelFontWeight" [ paValue (str "normal"), paBind (ipSelect [ inName "Label weight ", inOptions [ "normal", "bold", "lighter" ] ]) ]
                << param "labelLimit" [ paValue (num 200), paBind (ipRange [ inName "Label limit ", inMin 0, inMax 200 ]) ]
                << param "labelOffset" [ paValue (num 0), paBind (ipRange [ inName "Label offset ", inMin -30, inMax 30 ]) ]
                << param "labelOpacity" [ paValue (num 1), paBind (ipRange [ inName "Label opacity ", inMin 0, inMax 1 ]) ]
                << param "labelOverlap" [ paValue (boo False), paBind (ipSelect [ inName "Label overlap ", inDataOptions [ boo False, str "parity", str "greedy" ] ]) ]
                << param "labelPadding" [ paValue (num 2), paBind (ipRange [ inName "Label padding ", inMin -30, inMax 30 ]) ]
                << param "labelSeparation" [ paValue (num 0), paBind (ipRange [ inName "Label separation ", inMin 0, inMax 20 ]) ]
                << param "tickBand" [ paValue (str "center"), paBind (ipSelect [ inName "Tick band ", inOptions [ "center", "extent" ] ]) ]
                << param "tickCap" [ paValue (str "butt"), paBind (ipSelect [ inName "Tick cap ", inOptions [ "butt", "round", "square" ] ]) ]
                << param "tickColor" [ paValue (str "black"), paBind (ipColor [ inName "Tick colour " ]) ]
                << param "tickCount" [ paValue (num 20), paBind (ipRange [ inName "Tick count ", inMin 1, inMax 100 ]) ]
                << param "tickDash" [ paValue solid, paBind (ipSelect [ inName "Tick dash ", inDataOptions [ solid, shortDash, longDash ] ]) ]
                << param "tickDashOffset" [ paValue (num 0), paBind (ipRange [ inName "Tick dash offset ", inMin 0, inMax 12 ]) ]
                << param "tickOffset" [ paValue (num 0), paBind (ipRange [ inName "Tick offset ", inMin -30, inMax 30 ]) ]
                << param "tickOpacity" [ paValue (num 1), paBind (ipRange [ inName "Tick opacity ", inMin 0, inMax 1 ]) ]
                << param "tickSize" [ paValue (num 5), paBind (ipRange [ inName "Tick size ", inMin -20, inMax 20 ]) ]
                << param "tickWidth" [ paValue (num 1), paBind (ipRange [ inName "Tick width ", inMin 0, inMax 12 ]) ]
                << param "titleAlign" [ paValue (str "center"), paBind (ipSelect [ inName "Title align ", inOptions [ "center", "left", "right" ] ]) ]
                << param "titleAnchor" [ paValue (str "middle"), paBind (ipSelect [ inName "Title anchor ", inOptions [ "start", "middle", "end" ] ]) ]
                << param "titleAngle" [ paValue (num 0), paBind (ipRange [ inName "Title angle ", inMin -90, inMax 90, inStep 1 ]) ]
                << param "titleBaseline" [ paValue (str "top"), paBind (ipSelect [ inName "Title baseline ", inOptions [ "alphabetic", "top", "middle", "bottom", "line-top", "line-bottom" ] ]) ]
                << param "titleColor" [ paValue (str "black"), paBind (ipColor [ inName "Title colour " ]) ]
                << param "titleFont" [ paValue (str "sans-serif"), paBind (ipSelect [ inName "Title font ", inOptions [ "sans-serif", "serif", "monospace" ] ]) ]
                << param "titleFontStyle" [ paValue (str "normal"), paBind (ipSelect [ inName "Title style ", inOptions [ "normal", "italic" ] ]) ]
                << param "titleFontWeight" [ paValue (str "normal"), paBind (ipSelect [ inName "Title weight ", inOptions [ "normal", "bold", "lighter" ] ]) ]
                << param "titleLimit" [ paValue (num 200), paBind (ipRange [ inName "Title limit ", inMin 0, inMax 200 ]) ]
                << param "titleLineHeight" [ paValue (num 16), paBind (ipRange [ inName "Title line height ", inMin -50, inMax 50 ]) ]
                << param "titleOpacity" [ paValue (num 1), paBind (ipRange [ inName "Title opacity ", inMin 0, inMax 1 ]) ]
                << param "titlePadding" [ paValue (num 12), paBind (ipRange [ inName "Title padding ", inMin -20, inMax 20 ]) ]
                << param "gridCap" [ paValue (str "butt"), paBind (ipSelect [ inName "Grid cap ", inOptions [ "butt", "round", "square" ] ]) ]
                << param "gridColor" [ paValue (str "black"), paBind (ipColor [ inName "Grid colour " ]) ]
                << param "gridDash" [ paValue solid, paBind (ipSelect [ inName "Grid dash ", inDataOptions [ solid, shortDash, longDash ] ]) ]
                << param "gridDashOffset" [ paValue (num 0), paBind (ipRange [ inName "Grid dash offset ", inMin 0, inMax 12 ]) ]
                << param "gridOpacity" [ paValue (num 1), paBind (ipRange [ inName "Grid opacity ", inMin 0, inMax 1 ]) ]
                << param "gridWidth" [ paValue (num 1), paBind (ipRange [ inName "Grid width ", inMin 0, inMax 12 ]) ]

        dataMovies =
            dataFromUrl (path ++ "movies.json") []

        enc =
            encoding
                << position X
                    [ pName "IMDB Rating"
                    , pBin []
                    , pOrdinal
                    , pTitle "Internet Movie Database (IMDB)\nBinned Rating"
                    , pAxis
                        [ axBandPosition |> axNumExpr "bandPosition"
                        , axOffset |> axNumExpr "offset"
                        , axMinExtent |> axNumExpr "minExtent"
                        , axOrient (siExpr "orient")
                        , axDomainCap (caExpr "domainCap")
                        , axDomainColor |> axStrExpr "domainColor"
                        , axDomainDash |> axNumsExpr "domainDash"
                        , axDomainDashOffset |> axNumExpr "domainDashOffset"
                        , axDomainOpacity |> axNumExpr "domainOpacity"
                        , axDomainWidth |> axNumExpr "domainWidth"
                        , axPosition |> axNumExpr "position"
                        , axTranslate |> axNumExpr "translate"
                        , axLabelAlign (haExpr "labelAlign")
                        , axLabelBaseline (vaExpr "labelBaseline")
                        , axLabelAngle |> axNumExpr "labelAngle"
                        , axLabelColor |> axStrExpr "labelColor"
                        , axLabelFlushOffset |> axNumExpr "labelFlushOffset"
                        , axLabelFont |> axStrExpr "labelFont"
                        , axLabelFontSize |> axNumExpr "labelFontSize"
                        , axLabelFontStyle |> axStrExpr "labelFontStyle"
                        , axLabelFontWeight (fwExpr "labelFontWeight")
                        , axLabelLimit |> axNumExpr "labelLimit"
                        , axLabelOffset |> axNumExpr "labelOffset"
                        , axLabelOpacity |> axNumExpr "labelOpacity"
                        , axLabelOverlap (osExpr "labelOverlap")
                        , axLabelPadding |> axNumExpr "labelPadding"
                        , axLabelSeparation |> axNumExpr "labelSeparation"
                        , axTickBand (tbExpr "tickBand")
                        , axTickCap (caExpr "tickCap")
                        , axTickColor |> axStrExpr "tickColor"
                        , axTickDash |> axNumsExpr "tickDash"
                        , axTickDashOffset |> axNumExpr "tickDashOffset"
                        , axTickOffset |> axNumExpr "tickOffset"
                        , axTickOpacity |> axNumExpr "tickOpacity"
                        , axTickSize |> axNumExpr "tickSize"
                        , axTickWidth |> axNumExpr "tickWidth"
                        , axTitleAnchor (anExpr "titleAnchor")
                        , axTitleAlign (haExpr "titleAlign")
                        , axTitleAngle |> axNumExpr "titleAngle"
                        , axTitleBaseline (vaExpr "titleBaseline")
                        , axTitleColor |> axStrExpr "titleColor"
                        , axTitleFont |> axStrExpr "titleFont"
                        , axTitleFontStyle |> axStrExpr "titleFontStyle"
                        , axTitleFontWeight (fwExpr "titleFontWeight")
                        , axTitleLimit |> axNumExpr "titleLimit"
                        , axTitleLineHeight |> axNumExpr "titleLineHeight"
                        , axTitleOpacity |> axNumExpr "titleOpacity"
                        , axTitlePadding |> axNumExpr "titlePadding"
                        , axGridCap (caExpr "gridCap")
                        , axGridColor |> axStrExpr "gridColor"
                        , axGridOpacity |> axNumExpr "gridOpacity"
                        , axGridWidth |> axNumExpr "gridWidth"
                        ]
                    ]
                << position Y
                    [ pAggregate opCount
                    , pAxis
                        [ axTickCount (niExpr "tickCount")
                        , axGridDash |> axNumsExpr "gridDash"
                        , axGridDashOffset |> axNumExpr "gridDashOffset"
                        , axLabelBoundExpr "labelBound"
                        , axLabelFontSize |> axNumExpr "labelFontSize"
                        ]
                    ]
    in
    toVegaLite [ ps [], width 500, height 400, padding (paSize 80), dataMovies, enc [], bar [] ]



{- Ids and specifications to be provided to the Vega-Lite runtime. -}


specs : List ( String, Spec )
specs =
    [ ( "axis01", axis1 )
    , ( "axis01a", axis1a )
    , ( "axis02", axis2 )
    , ( "axis03", axis3 )
    , ( "axis04", axis4 )
    , ( "axis04a", axis4a )
    , ( "axis05", axis5 )
    , ( "axis06", axis6 )
    , ( "axis07", axis7 )
    , ( "axis08", axis8 )
    , ( "axis09", axis9 )
    , ( "axis10", axis10 )
    , ( "axis11", axis11 )
    , ( "axis12", axis12 )

    -- , ( "axis13", axis13 )
    , ( "axis14", axis14 )
    , ( "axis15", axis15 )
    , ( "axis16", axis16 )
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
