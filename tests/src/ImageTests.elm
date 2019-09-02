port module ImageTests exposing (elmToJS)

import Browser
import Html exposing (Html, div, pre)
import Html.Attributes exposing (id)
import Json.Encode
import VegaLite exposing (..)


base : String
base =
    "https://vega.github.io/vega-lite/data/"


imageEnc : (List DataColumn -> List DataColumn) -> (List LabelledSpec -> List LabelledSpec) -> Spec
imageEnc dataSupp encSupp =
    let
        data =
            dataFromColumns []
                << dataColumn "x" (nums [ 0.5, 1.5, 2.5 ])
                << dataColumn "y" (nums [ 0.5, 1.5, 2.5 ])
                << dataSupp

        enc =
            encoding
                << position X [ pName "x", pQuant ]
                << position Y [ pName "y", pQuant ]
                << encSupp
    in
    toVegaLite [ data [], enc [], image [ maWidth 25, maHeight 25 ] ]


image1 : Spec
image1 =
    imageEnc (always []) (url [ hStr (base ++ "ffox.png") ])


image2 : Spec
image2 =
    imageEnc
        (dataColumn "img" (strs [ base ++ "ffox.png", base ++ "gimp.png", base ++ "7zip.png" ]))
        (url [ hName "img", hNominal ])


lakeImage : List MarkProperty -> Spec
lakeImage mProps =
    let
        data =
            dataFromColumns []
                << dataColumn "x" (nums [ 5 ])
                << dataColumn "y" (nums [ 5 ])

        enc =
            encoding
                << position X [ pName "x", pQuant, pScale [ scDomain (doNums [ 0, 10 ]) ] ]
                << position Y [ pName "y", pQuant, pScale [ scDomain (doNums [ 0, 10 ]) ] ]

        encImage =
            enc << url [ hStr "https://gicentre.github.io/data/images/LillyTarn.jpg" ]
    in
    toVegaLite
        [ data []
        , layer
            [ asSpec [ encImage [], image mProps ]
            , asSpec [ enc [], circle [ maColor "red" ] ]
            ]
        ]


image3 : Spec
image3 =
    lakeImage [ maWidth 100, maAspect True ]


image4 : Spec
image4 =
    lakeImage [ maWidth 100, maHeight 100, maAspect False ]


image5 : Spec
image5 =
    lakeImage [ maWidth 100, maHeight 61, maAlign haLeft ]


image6 : Spec
image6 =
    lakeImage [ maWidth 100, maHeight 61, maAlign haCenter ]


image7 : Spec
image7 =
    lakeImage [ maWidth 100, maHeight 61, maAlign haRight ]


image8 : Spec
image8 =
    lakeImage [ maWidth 100, maHeight 61, maBaseline vaTop ]


image9 : Spec
image9 =
    lakeImage [ maWidth 100, maHeight 61, maBaseline vaMiddle ]


image10 : Spec
image10 =
    lakeImage [ maWidth 100, maHeight 61, maBaseline vaBottom ]


image11 : Spec
image11 =
    imageEnc
        (dataColumn "img" (strs [ base ++ "ffox.png", base ++ "gimp.png", base ++ "7zip.png" ])
            << dataColumn "mag" (nums [ 1, 1, 1 ])
        )
        (url [ hName "img", hNominal ]
            << size [ mName "mag", mQuant ]
        )


image12 : Spec
image12 =
    imageEnc
        (dataColumn "img" (strs [ base ++ "ffox.png", base ++ "gimp.png", base ++ "7zip.png" ])
            << dataColumn "mag" (nums [ 1, 2, 1 ])
        )
        (url [ hName "img", hNominal ]
            << size [ mName "mag", mQuant ]
        )


sourceExample : Spec
sourceExample =
    image12



{- This list comprises the specifications to be provided to the Vega-Lite runtime. -}


mySpecs : Spec
mySpecs =
    combineSpecs
        [ ( "image1", image1 )
        , ( "image2", image2 )
        , ( "image3", image3 )
        , ( "image4", image4 )
        , ( "image5", image5 )
        , ( "image6", image6 )
        , ( "image7", image7 )
        , ( "image8", image8 )
        , ( "image9", image9 )
        , ( "image10", image10 )
        , ( "image11", image11 )
        , ( "image12", image12 )
        ]



{- ---------------------------------------------------------------------------
   The code below creates an Elm module that opens an outgoing port to Javascript
   and sends both the specs and DOM node to it.
   This is used to display the generated Vega specs for testing purposes.
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
