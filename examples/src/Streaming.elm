port module Streaming exposing (elmToJS)

import Platform
import VegaLite exposing (..)


streaming1 : Spec
streaming1 =
    let
        data =
            dataFromSource "table" []

        enc =
            encoding
                << position X [ pName "x", pQuant, pScale [ scZero False ] ]
                << position Y [ pName "y", pQuant ]
                << color [ mName "category", mNominal ]
    in
    toVegaLite [ width 400, data, enc [], line [] ]



{- This list comprises tuples of the label for each embedded visualization and
   corresponding Vega-Lite specification. It assembles all the listed specs into
   a single JSON object.
-}


mySpecs : Spec
mySpecs =
    combineSpecs
        [ ( "streaming1", streaming1 )
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
