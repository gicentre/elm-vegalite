port module ConfigTests exposing (elmToJS)

import Platform
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
                << shape [ mName "Origin", mNominal ]
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
                << shape [ mName "Origin", mNominal ]

        scatterSpec =
            asSpec
                [ title "Car Scatter" []
                , width 200
                , height 200
                , padding (paSize 20)
                , point [ maSize 100 ]
                , scatterEnc []
                ]

        barEnc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pAggregate opCount, pQuant ]
                << color [ mName "Origin", mNominal ]

        streamEnc =
            encoding
                << position X [ pName "Year", pTemporal, pTimeUnit year ]
                << position Y [ pAggregate opCount, pQuant, pStack stCenter, pAxis [] ]
                << color [ mName "Origin", mNominal ]

        barSpec =
            asSpec
                [ title "Car Histogram" []
                , width 200
                , height 200
                , padding (paSize 20)
                , bar []
                , barEnc []
                ]

        streamSpec =
            asSpec
                [ title "Car Streamgraph" []
                , width 200
                , height 200
                , padding (paSize 20)
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
                << shape [ mName "Origin", mNominal ]

        barEnc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pAggregate opCount, pQuant ]
                << color [ mName "Origin", mNominal ]

        streamEnc =
            encoding
                << position X [ pName "Year", pTemporal, pTimeUnit year ]
                << position Y [ pAggregate opCount, pQuant, pStack stCenter, pAxis [] ]
                << color [ mName "Origin", mNominal ]

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
                    (coNamedStyles
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
        << configuration (coTitle [ ticoFont "Roboto", ticoColor "#fff" ])
        << configuration (coAxis [ axcoDomainColor "yellow", axcoGridColor "rgb(255,255,200)", axcoGridOpacity 0.2, axcoLabelColor "#fcf", axcoTickColor "white", axcoTitleColor "rgb(200,255,200)", axcoLabelFont "Roboto", axcoTitleFont "Roboto" ])
        << configuration (coLegend [ lecoFillColor "#333", lecoStrokeColor "#444", lecoTitleColor "rgb(200,200,200)", lecoLabelColor "white", lecoSymbolFillColor "red", lecoGradientStrokeColor "yellow", lecoLabelFont "Roboto", lecoTitleFont "Roboto" ])
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



{- This list comprises the specifications to be provided to the Vega-Lite runtime. -}


mySpecs : Spec
mySpecs =
    combineSpecs
        [ ( "default", defaultCfg )
        , ( "dark", darkCfg )
        , ( "mark1", markCfg1 )
        , ( "mark2", markCfg2 )
        , ( "padding", paddingCfg )
        , ( "vbTest", vbTest )
        , ( "axisCfg1", axisCfg1 )
        ]



{- The code below is boilerplate for creating a headless Elm module that opens
   an outgoing port to Javascript and sends the specs to it.
-}


main : Program () Spec msg
main =
    Platform.worker
        { init = always ( mySpecs, elmToJS mySpecs )
        , update = \_ model -> ( model, Cmd.none )
        , subscriptions = always Sub.none
        }


port elmToJS : Spec -> Cmd msg
