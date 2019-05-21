port module ApacheArrow exposing (elmToJS)

import Platform
import VegaLite exposing (..)


arrow1 : Spec
arrow1 =
    let
        data =
            dataFromUrl "https://gist.githubusercontent.com/domoritz/0f53a5abde95564c36dfaac623a7a922/raw/cce3719b853e25d5dfff97a270283ba83af3c0e6/flights-10k.arrow"
                [ arrow ]

        enc =
            encoding
                << position X [ pName "DEP_TIME", pMType Quantitative ]
                << position Y [ pName "ARR_DELAY", pMType Quantitative ]
                << color [ mName "DISTANCE", mMType Quantitative ]
    in
    toVegaLite [ width 500, height 300, data, enc [], circle [ maSize 4 ] ]


arrow2 : Spec
arrow2 =
    let
        data =
            dataFromUrl "https://gicentre.github.io/data/scrabble.arrow" [ arrow ]

        trans =
            transform
                << sample 10000

        enc =
            encoding
                << position X [ pName "winnerscore", pMType Quantitative, pScale [ scDomain (doNums [ 0, 700 ]) ] ]
                << position Y [ pName "loserscore", pMType Quantitative, pScale [ scDomain (doNums [ 0, 700 ]) ] ]
    in
    toVegaLite [ width 500, height 500, data, trans [], enc [], circle [ maSize 9, maOpacity 0.4 ] ]



{- This list comprises tuples of the label for each embedded visualization and
   corresponding Vega-Lite specification. It assembles all the listed specs into
   a single JSON object.
-}


mySpecs : Spec
mySpecs =
    combineSpecs
        [ ( "arrow1", arrow1 )
        , ( "arrow2", arrow2 )
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
