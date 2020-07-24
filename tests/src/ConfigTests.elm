port module ConfigTests exposing (elmToJS)

import Browser
import Dict exposing (Dict)
import Html exposing (Html)
import Html.Attributes
import Html.Events
import Json.Encode
import VegaLite exposing (..)


singleVis : (List a -> ( VLProperty, Spec )) -> Spec
singleVis config =
    let
        cars =
            dataFromUrl "https://vega.github.io/vega-lite/data/cars.json" []

        scatterEnc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]
                << color [ mName "Cylinders", mOrdinal ]
                << shape [ mName "Origin" ]
    in
    toVegaLite
        [ title "Car Scatter" []
        , config []
        , cars
        , width 200
        , height 200
        , point [ maSize 100 ]
        , scatterEnc []
        ]


histoVis : (List a -> ( VLProperty, Spec )) -> Spec
histoVis config =
    let
        data =
            dataFromColumns [ parse [ ( "date", foDate "%Y/%m/%d" ) ] ]
                << dataColumn "rating" (nums [ 4, 5, 4, 2, 6, 4, 5, 8, 4, 9, 3, 7 ])
                << dataColumn "date"
                    (strs
                        [ "2020/01/31"
                        , "2020/02/29"
                        , "2020/03/31"
                        , "2020/04/30"
                        , "2020/05/31"
                        , "2020/06/30"
                        , "2020/07/31"
                        , "2020/08/31"
                        , "2020/09/30"
                        , "2020/10/31"
                        , "2020/11/30"
                        , "2020/12/31"
                        ]
                    )
                << dataColumn "preference" (List.range 1 12 |> List.map toFloat |> nums)

        -- Use a variety of axis scale types for axis config testing
        barEnc =
            encoding
                << position X [ pName "rating", pBin [], pOrdinal ]
                << position Y [ pAggregate opCount ]

        barSpec =
            asSpec [ barEnc [], bar [ maOpacity 0.3 ] ]

        dotEnc =
            encoding
                << position X [ pName "preference", pOrdinal ]
                << position Y [ pName "rating", pQuant, pAxis [ axOrient siRight ] ]

        dotSpec =
            asSpec [ dotEnc [], circle [ maFilled True ] ]

        lineEnc1 =
            encoding
                << position X [ pName "date", pTemporal ]
                << position Y [ pName "preference", pOrdinal, pAxis [ axOrient siRight ] ]

        lineSpec1 =
            asSpec [ lineEnc1 [], line [] ]

        lineEnc2 =
            encoding
                << position X [ pName "date", pTemporal, pAxis [ axOrient siTop ] ]
                << position Y [ pName "preference", pOrdinal ]

        lineSpec2 =
            asSpec [ lineEnc2 [], line [] ]

        lineEnc3 =
            encoding
                << position X [ pName "preference", pOrdinal ]
                << position Y [ pName "date", pTemporal ]

        lineSpec3 =
            asSpec [ lineEnc3 [], line [] ]
    in
    toVegaLite
        [ config []
        , data []
        , hConcat [ barSpec, dotSpec, lineSpec1, lineSpec2, lineSpec3 ]
        ]


compositeVis : (List a -> ( VLProperty, Spec )) -> Spec
compositeVis config =
    let
        cars =
            dataFromUrl "https://vega.github.io/vega-lite/data/cars.json" []

        scatterEnc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]
                << color [ mName "Cylinders", mOrdinal ]
                << shape [ mName "Origin" ]

        scatterSpec =
            asSpec
                [ title "Car Scatter" []
                , width 200
                , height 200
                , point [ maSize 100 ]
                , scatterEnc []
                ]

        barEnc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pAggregate opCount ]
                << color [ mName "Origin" ]

        streamEnc =
            encoding
                << position X [ pName "Year", pTemporal, pTimeUnit year ]
                << position Y [ pAggregate opCount, pStack stCenter, pAxis [] ]
                << color [ mName "Origin" ]

        barSpec =
            asSpec
                [ title "Car Histogram" []
                , width 200
                , height 200
                , bar []
                , barEnc []
                ]

        streamSpec =
            asSpec
                [ title "Car Streamgraph" []
                , width 200
                , height 200
                , area []
                , streamEnc []
                ]

        res =
            resolve
                << resolution (reScale [ ( chColor, reIndependent ), ( chShape, reIndependent ) ])
    in
    toVegaLite [ config [], cars, hConcat [ scatterSpec, barSpec, streamSpec ], res [] ]


vbTest : Spec
vbTest =
    let
        cars =
            dataFromUrl "https://vega.github.io/vega-lite/data/cars.json" []

        scatterEnc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]
                << color [ mName "Cylinders", mOrdinal ]
                << shape [ mName "Origin" ]

        barEnc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pAggregate opCount ]
                << color [ mName "Origin" ]

        streamEnc =
            encoding
                << position X [ pName "Year", pTemporal, pTimeUnit year ]
                << position Y [ pAggregate opCount, pStack stCenter, pAxis [] ]
                << color [ mName "Origin" ]

        scatterSpec =
            asSpec
                [ title "Car Scatter" []
                , width 200
                , height 200
                , point [ maSize 100 ]
                , scatterEnc []
                ]

        barSpec =
            asSpec
                [ title "Car Histogram" []
                , width 200
                , height 200
                , viewBackground
                    [ viewFill (Just "white")
                    , viewCornerRadius 18
                    , viewStroke (Just "red")
                    , viewStrokeWidth 4
                    , viewStrokeCap caRound
                    , viewStrokeDash [ 10, 10 ]
                    , viewStrokeJoin joBevel
                    ]
                , bar []
                , barEnc []
                ]

        cfg =
            configure
                << configuration
                    (coMarkStyles
                        [ ( "myStyle", [ maFill "red", maFillOpacity 0.1, maStrokeOpacity 1 ] )
                        , ( "mySecondStyle", [ maFill "black", maStroke "blue" ] )
                        ]
                    )
                << configuration (coView [ vicoBackground [ viewFill (Just "#feb") ] ])

        streamSpec =
            asSpec
                [ title "Car Streamgraph" []
                , width 200
                , height 200
                , viewBackground [ viewStyle [ "myStyle", "mySecondStyle" ] ]
                , area []
                , streamEnc []
                ]

        res =
            resolve
                << resolution (reScale [ ( chColor, reIndependent ), ( chShape, reIndependent ) ])
    in
    toVegaLite
        [ cfg []
        , background "yellow"
        , cars
        , hConcat [ scatterSpec, barSpec, streamSpec ]
        , res []
        ]


defaultCfg : Spec
defaultCfg =
    configure
        |> compositeVis


darkCfg : Spec
darkCfg =
    configure
        << configuration (coBackground "black")
        << configuration (coFont "serif")
        << configuration (coTitle [ ticoFont "Roboto", ticoColor "#fff" ])
        << configuration (coAxis [ axcoDomainColor "yellow", axcoGridColor "rgb(255,255,200)", axcoGridOpacity 0.2, axcoLabelColor "#fcf", axcoTickColor "white", axcoTitleColor "rgb(200,255,200)" ])
        << configuration (coLegend [ lecoFillColor "#333", lecoStrokeColor "#444", lecoTitleColor "rgb(200,200,200)", lecoLabelColor "white", lecoSymbolFillColor "red", lecoGradientStrokeColor "yellow" ])
        |> compositeVis


markCfg1 : Spec
markCfg1 =
    configure
        << configuration (coMark [ maFilled False ])
        |> compositeVis


markCfg2 : Spec
markCfg2 =
    configure
        << configuration (coMark [ maFilled True, maFill "black", maOpacity 1 ])
        << configuration (coBar [ maFilled True ])
        << configuration (coArea [ maFilled False ])
        << configuration (coPoint [ maFilled True, maStroke "white", maStrokeOpacity 0.2 ])
        |> compositeVis


paddingCfg : Spec
paddingCfg =
    configure
        << configuration (coAutosize [ asFit ])
        << configuration (coPadding (paEdges 90 60 30 0))
        |> singleVis


axisCfg1 : Spec
axisCfg1 =
    configure
        << configuration
            (coAxis
                [ axcoTitleFontStyle "italic"
                , axcoTitleFont "serif"
                , axcoLabelFontStyle "italic"
                , axcoLabelFont "serif"
                , axcoTitleAnchor anEnd
                ]
            )
        |> singleVis


redAxis : List AxisConfig
redAxis =
    [ axcoDomainColor "red", axcoTitleColor "red", axcoLabelColor "red", axcoTickColor "red" ]


axisCfg2 : Spec
axisCfg2 =
    configure
        << configuration (coAxis redAxis)
        |> histoVis


axisCfg3 : Spec
axisCfg3 =
    configure
        << configuration (coAxis redAxis |> coAxisXFilter)
        |> histoVis


axisCfg4 : Spec
axisCfg4 =
    configure
        << configuration (coAxis redAxis |> coAxisYFilter)
        |> histoVis


axisCfg5 : Spec
axisCfg5 =
    configure
        << configuration (coAxisBottom redAxis)
        |> histoVis


axisCfg6 : Spec
axisCfg6 =
    configure
        << configuration (coAxisLeft redAxis)
        |> histoVis


axisCfg7 : Spec
axisCfg7 =
    configure
        << configuration (coAxisTop redAxis)
        |> histoVis


axisCfg8 : Spec
axisCfg8 =
    configure
        << configuration (coAxisRight redAxis)
        |> histoVis


axisCfg9 : Spec
axisCfg9 =
    configure
        << configuration (coAxisBand redAxis)
        |> histoVis


axisCfg10 : Spec
axisCfg10 =
    configure
        << configuration (coAxisQuant redAxis)
        |> histoVis


axisCfg11 : Spec
axisCfg11 =
    configure
        << configuration (coAxisTemporal redAxis)
        |> histoVis


axisCfg12 : Spec
axisCfg12 =
    configure
        << configuration (coAxisDiscrete redAxis)
        |> histoVis


axisCfg13 : Spec
axisCfg13 =
    configure
        << configuration (coAxisPoint redAxis)
        |> histoVis


titleCfg1 : Spec
titleCfg1 =
    let
        cars =
            dataFromUrl "https://vega.github.io/vega-lite/data/cars.json" []

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]
    in
    toVegaLite
        [ title "Car\nScatter" [ tiSubtitle "A subtitle\nalso over two lines" ]
        , cars
        , width 200
        , height 200
        , enc []
        , circle []
        ]


titleCfg2 : Spec
titleCfg2 =
    let
        cars =
            dataFromUrl "https://vega.github.io/vega-lite/data/cars.json" []

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]
    in
    toVegaLite
        [ title "Car\nScatter"
            [ tiSubtitle "A subtitle\nalso over two lines"
            , tiAnchor anEnd
            , tiSubtitleColor "red"
            , tiSubtitleFont "serif"
            , tiSubtitleFontSize 10
            , tiSubtitleFontStyle "italic"
            , tiSubtitleFontWeight W900
            , tiSubtitleLineHeight 18
            , tiSubtitlePadding 60
            ]
        , cars
        , width 200
        , height 200
        , enc []
        , circle []
        ]


titleCfg3 : Spec
titleCfg3 =
    let
        cars =
            dataFromUrl "https://vega.github.io/vega-lite/data/cars.json" []

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]

        cfg =
            configure
                << configuration
                    (coTitle
                        [ ticoAnchor anEnd
                        , ticoSubtitleColor "red"
                        , ticoSubtitleFont "serif"
                        , ticoSubtitleFontSize 10
                        , ticoSubtitleFontStyle "italic"
                        , ticoSubtitleFontWeight W900
                        , ticoSubtitleLineHeight 18
                        , ticoSubtitlePadding 60
                        ]
                    )
    in
    toVegaLite
        [ cfg []
        , title "Car\nScatter" [ tiSubtitle "A subtitle\nalso over two lines" ]
        , cars
        , width 200
        , height 200
        , enc []
        , circle []
        ]


scaleCfg1 : Spec
scaleCfg1 =
    configure
        << configuration (coScale [ sacoXReverse True ])
        |> singleVis


axisLegendCfg1 : Spec
axisLegendCfg1 =
    configure
        << configuration (coLegend [ lecoDisable True ])
        << configuration (coAxis [ axcoDisable True ])
        |> singleVis



{- Ids and specifications to be provided to the Vega-Lite runtime. -}


specs : List ( String, Spec )
specs =
    [ ( "default", defaultCfg )
    , ( "dark", darkCfg )
    , ( "mark1", markCfg1 )
    , ( "mark2", markCfg2 )
    , ( "padding", paddingCfg )
    , ( "vbTest", vbTest )
    , ( "axisCfg1", axisCfg1 )
    , ( "axisCfg2", axisCfg2 )
    , ( "axisCfg3", axisCfg3 )
    , ( "axisCfg4", axisCfg4 )
    , ( "axisCfg5", axisCfg5 )
    , ( "axisCfg6", axisCfg6 )
    , ( "axisCfg7", axisCfg7 )
    , ( "axisCfg8", axisCfg8 )
    , ( "axisCfg9", axisCfg9 )
    , ( "axisCfg10", axisCfg10 )
    , ( "axisCfg11", axisCfg11 )
    , ( "axisCfg12", axisCfg12 )
    , ( "axisCfg13", axisCfg13 )
    , ( "titleCfg1", titleCfg1 )
    , ( "titleCfg2", titleCfg2 )
    , ( "titleCfg3", titleCfg3 )
    , ( "scaleCfg1", scaleCfg1 )
    , ( "axisLegendCfg1", axisLegendCfg1 )
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
