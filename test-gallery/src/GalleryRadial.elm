port module GalleryRadial exposing (elmToJS)

import Dict exposing (Dict)
import Platform
import VegaLite exposing (..)



-- NOTE: All data sources in these examples originally provided at
-- https://github.com/vega/vega-datasets
-- The examples themselves reproduce those at https://vega.github.io/vega-lite/examples/


radial : String -> Float -> Spec
radial dText innerR =
    let
        des =
            description dText

        cfg =
            configure
                << configuration (coView [ vicoStroke Nothing ])

        data =
            dataFromColumns []
                << dataColumn "category" (strs [ "A", "B", "C", "D", "E", "F" ])
                << dataColumn "value" (nums [ 4, 6, 10, 3, 7, 8 ])

        enc =
            encoding
                << position Theta [ pName "value", pQuant ]
                << color [ mName "category", mNominal ]
    in
    toVegaLite [ des, cfg [], data [], enc [], arc [ maInnerRadius innerR ] ]


radial1 : Spec
radial1 =
    radial "A pie chart." 0


radial2 : Spec
radial2 =
    radial "A donut chart" 50


radial3 : Spec
radial3 =
    let
        des =
            description "Pie chart with labels"

        cfg =
            configure
                << configuration (coView [ vicoStroke Nothing ])

        data =
            dataFromColumns []
                << dataColumn "category" (strs [ "A", "B", "C", "D", "E", "F" ])
                << dataColumn "value" (nums [ 4, 6, 10, 3, 7, 8 ])

        enc =
            encoding
                << position Theta [ pName "value", pQuant, pStack stZero ]
                << color [ mName "category", mNominal, mLegend [] ]

        pieSpec =
            asSpec [ arc [ maOuterRadius 80 ] ]

        labelEnc =
            encoding
                << text [ tName "category", tNominal ]

        labelSpec =
            asSpec [ labelEnc [], textMark [ maRadius 90 ] ]
    in
    toVegaLite [ des, cfg [], data [], enc [], layer [ pieSpec, labelSpec ] ]


radial4 : Spec
radial4 =
    let
        des =
            description "Radial plot with labels"

        cfg =
            configure
                << configuration (coView [ vicoStroke Nothing ])

        data =
            dataFromColumns []
                << dataColumn "strength" (nums [ 12, 23, 47, 6, 52, 19 ])

        enc =
            encoding
                << position Theta [ pName "strength", pQuant, pStack stZero ]
                << position R
                    [ pName "strength"
                    , pQuant
                    , pScale [ scZero True, scType scSqrt, scRange (raNums [ 20, 100 ]) ]
                    ]
                << color [ mName "strength", mNominal, mLegend [] ]

        segSpec =
            asSpec [ arc [ maInnerRadius 20, maStroke "white" ] ]

        labelEnc =
            encoding
                << text [ tName "strength", tQuant ]

        labelSpec =
            asSpec [ labelEnc [], textMark [ maRadiusOffset 10 ] ]
    in
    toVegaLite [ des, cfg [], data [], enc [], layer [ segSpec, labelSpec ] ]


radial5 : Spec
radial5 =
    let
        des =
            description "Reproduction of http://robslink.com/SAS/democd91/pyramid_pie.htm"

        cfg =
            configure
                << configuration (coView [ vicoStroke Nothing ])

        sky =
            "Sky"

        shade =
            "Shady side of a pyramid"

        sun =
            "Sunny side of a pyramid"

        data =
            dataFromColumns []
                << dataColumn "category" (strs [ sky, shade, sun ])
                << dataColumn "value" (nums [ 75, 10, 15 ])
                << dataColumn "order" (nums [ 3, 1, 2 ])

        colours =
            categoricalDomainMap
                [ ( sky, "#416D9D" )
                , ( shade, "#674028" )
                , ( sun, "#DEAC58" )
                ]

        enc =
            encoding
                << position Theta
                    [ pName "value"
                    , pQuant
                    , pScale [ scRange (raNums [ 2.356, 8.639 ]) ]
                    , pStack stZero
                    ]
                << color
                    [ mName "category"
                    , mNominal
                    , mScale colours
                    , mLegend [ leOrient loNone, leTitle "", leColumns 1, leX 200, leY 80 ]
                    ]
                << order [ oName "order", oQuant ]
    in
    toVegaLite [ des, cfg [], data [], enc [], arc [ maOuterRadius 80 ] ]



{- This list comprises the specifications to be provided to the Vega-Lite runtime. -}


mySpecs : Spec
mySpecs =
    combineSpecs
        [ ( "radial1", radial1 )
        , ( "radial2", radial2 )
        , ( "radial3", radial3 )
        , ( "radial4", radial4 )
        , ( "radial5", radial5 )
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
