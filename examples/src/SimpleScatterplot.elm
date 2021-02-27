port module SimpleScatterplot exposing (elmToJS)

import Platform
import VegaLite exposing (..)


path : String
path =
    "https://cdn.jsdelivr.net/npm/vega-datasets@2.2/data/"


scatter : Spec
scatter =
    let
        data =
            dataFromUrl (path ++ "penguins.json") []

        enc =
            encoding
                << position X [ pName "Beak Length (mm)", pQuant ]
                << position Y [ pName "Body Mass (g)", pQuant ]
                << color [ mName "Species" ]
    in
    toVegaLite [ data, enc [], circle [] ]



{- This list comprises the specifications to be provided to the Vega-Lite runtime. -}


mySpecs : Spec
mySpecs =
    combineSpecs [ ( "scatter", scatter ) ]



{- The code below is boilerplate for creating a headless Elm module that opens
   an outgoing port to JavaScript and sends the specs to it.
-}


main : Program () Spec msg
main =
    Platform.worker
        { init = always ( mySpecs, elmToJS mySpecs )
        , update = \_ model -> ( model, Cmd.none )
        , subscriptions = always Sub.none
        }


port elmToJS : Spec -> Cmd msg
