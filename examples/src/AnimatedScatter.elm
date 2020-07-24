port module AnimatedScatter exposing (elmToJS)

import Browser
import Html exposing (Html, div, pre)
import Html.Attributes exposing (id)
import Json.Encode
import VegaLite exposing (..)


animatedScatter1 : Spec
animatedScatter1 =
    let
        filterData =
            dataFromSource "table" [ parse [ ( "fYears", foNum ) ] ]

        incomeData =
            dataFromUrl "https://gicentre.github.io/data/incomeInequality2018.csv" []

        guideData =
            dataFromColumns []
                << dataColumn "x1" (nums (List.repeat 10 0))
                << dataColumn "y1" (nums (List.repeat 10 0))
                << dataColumn "x2" (nums [ 130, 130, 130, 130, 130, 130, 130, 130, 118, 108 ])
                << dataColumn "y2" (nums [ 130, 520, 650, 780, 910, 1040, 1170, 1300, 1300, 1300 ])
                << dataColumn "year" (nums [ 0, 0, 0, 1985, 1987, 1989, 1991, 2005, 2006, 2008 ])
                << dataColumn "annotation"
                    (strs
                        [ "1x: Equality of income"
                        , "4x: Richest have 4 times more income than poorest"
                        , "5x"
                        , "6x"
                        , "7x"
                        , "8x"
                        , "9x"
                        , "10x"
                        , "11x"
                        , "12x"
                        ]
                    )

        transJoin =
            transform
                << lookup "fYears" incomeData "Year" (luFields [ "Year", "5pcIncome", "95pcIncome" ])

        scatterEnc =
            encoding
                << position X
                    [ pName "5pcIncome"
                    , pQuant
                    , pAxis [ axTitle "Poorest 5% (£)", axGrid False ]
                    , pScale [ scZero True ]
                    ]
                << position Y
                    [ pName "95pcIncome"
                    , pQuant
                    , pAxis [ axTitle "Richest 5% (£)", axGrid False ]
                    , pScale [ scZero True ]
                    ]
                << order [ oName "Year", oTemporal ]

        scatterSpec =
            asSpec
                [ transJoin []
                , scatterEnc []
                , line
                    [ maInterpolate miMonotone
                    , maPoint (pmMarker [ maFill "black", maStroke "white", maStrokeWidth 1.5 ])
                    ]
                ]

        transLatest =
            transform
                << aggregate [ opAs opMax "fYears" "year" ] []

        yearEnc =
            encoding
                << text [ tName "year" ]

        yearSpec =
            asSpec [ transLatest [], yearEnc [], textMark [ maX 120, maY 42, maSize 100, maFill "#eee" ] ]

        initGuideSpec =
            asSpec [ guideData [], transInit [], layer [ guidelineSpec, guideAnnotationSpec ] ]

        transInit =
            transform
                << filter (fiExpr "datum.year == 0")

        guideSpec =
            asSpec [ transGuide [], layer [ guidelineSpec, guideAnnotationSpec ] ]

        transGuide =
            transform
                << lookup "fYears" (guideData []) "year" (luFields [ "x1", "y1", "x2", "y2", "annotation" ])

        guidelineEnc =
            encoding
                << position X [ pName "x1", pQuant ]
                << position X2 [ pName "x2" ]
                << position Y [ pName "y1", pQuant ]
                << position Y2 [ pName "y2" ]

        guidelineSpec =
            asSpec [ guidelineEnc [], rule [ maStrokeWidth 2, maStrokeDash [ 8, 4 ], maStrokeOpacity 0.3 ] ]

        guideAnnotationEnc =
            encoding
                << position X [ pName "x2", pQuant ]
                << position Y [ pName "y2", pQuant ]
                << text [ tName "annotation" ]

        guideAnnotationSpec =
            asSpec [ guideAnnotationEnc [], textMark [ maAlign haLeft, maDx 4 ] ]

        cfg =
            configure
                << configuration (coView [ vicoStroke Nothing ])
    in
    toVegaLite
        [ cfg []
        , width 400
        , height 400
        , title "Household income of richest and poorest five percent" []
        , filterData
        , layer [ initGuideSpec, guideSpec, scatterSpec, yearSpec ]
        ]



{- This list comprises tuples of the label for each embedded visualization and
   corresponding Vega-Lite specification. It assembles all the listed specs into
   a single JSON object.
-}


mySpecs : Spec
mySpecs =
    combineSpecs
        [ ( "animatedScatter1", animatedScatter1 )
        ]


sourceExample : Spec
sourceExample =
    animatedScatter1



{- The code below is boilerplate for creating a headless Elm module that opens
   an outgoing port to Javascript and sends the specs to it.
-}


main : Program () Spec msg
main =
    Browser.element
        { init = always ( mySpecs, elmToJS mySpecs )
        , view = view
        , update = \_ model -> ( model, Cmd.none )
        , subscriptions = always Sub.none
        }



-- View


view : Spec -> Html msg
view spec =
    div []
        [ div [ id "specSource" ] []
        , pre []
            [ Html.text (Json.Encode.encode 2 sourceExample) ]
        ]


port elmToJS : Spec -> Cmd msg
