port module InteractionTests exposing (elmToJS)

import Platform
import VegaLite exposing (..)


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
        << position X [ pName "month", pMType Temporal, pTitle "" ]
        << position Y [ pName "reportedCrimes", pMType Quantitative, pTitle "Reported crimes" ]
        << color [ mName "crimeType", mMType Nominal, mScale cScale ]


encHighlight : List LabelledSpec -> ( VLProperty, Spec )
encHighlight =
    encoding
        << position X [ pName "month", pMType Temporal, pTitle "" ]
        << position Y [ pName "reportedCrimes", pMType Quantitative, pTitle "Reported crimes" ]
        << color
            [ mSelectionCondition (selectionName "mySelection")
                [ mName "crimeType", mMType Nominal, mScale cScale ]
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
                << select "mySelection" seInterval [ seBindScales, seEncodings [ chX ] ]
    in
    toVegaLite [ width 540, data, sel [], encHighlight [], circle [] ]


interaction6 : Spec
interaction6 =
    let
        sel =
            selection
                << select "mySelection" seInterval [ seBindScales ]
    in
    toVegaLite [ width 540, data, sel [], encHighlight [], circle [] ]


interaction7 : Spec
interaction7 =
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


interaction8 : Spec
interaction8 =
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



{- This list comprises the specifications to be provided to the Vega-Lite runtime. -}


mySpecs : Spec
mySpecs =
    combineSpecs
        [ ( "interaction1", interaction1 )
        , ( "interaction2", interaction2 )
        , ( "interaction3", interaction3 )
        , ( "interaction4", interaction4 )
        , ( "interaction5", interaction5 )
        , ( "interaction6", interaction6 )
        , ( "interaction7", interaction7 )
        , ( "interaction8", interaction8 )
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
