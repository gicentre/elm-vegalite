port module ImageTests exposing (elmToJS)

import Browser
import Dict
import Html exposing (Html)
import Html.Attributes
import Html.Events
import Json.Encode
import VegaLite exposing (..)


path : String
path =
    "https://cdn.jsdelivr.net/npm/vega-datasets@2.1/data/"


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
    imageEnc (always []) (url [ hStr (path ++ "ffox.png") ])


image2 : Spec
image2 =
    imageEnc
        (dataColumn "img" (strs [ path ++ "ffox.png", path ++ "gimp.png", path ++ "7zip.png" ]))
        (url [ hName "img" ])


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
    let
        prm =
            params
                [ ( "asp"
                  , [ paValue (boo True)
                    , paBind (ipCheckbox [ inName "maintain aspect ratio" ])
                    ]
                  )
                ]

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
        [ prm
        , data []
        , layer
            [ asSpec
                [ encImage []
                , image
                    [ maWidth 100
                    , maAlign haLeft
                    , maAspect |> markPropertyBooExpr "asp"
                    ]
                ]
            , asSpec [ enc [], circle [ maColor "red" ] ]
            ]
        ]


image12 : Spec
image12 =
    imageEnc
        (dataColumn "img" (strs [ path ++ "ffox.png", path ++ "gimp.png", path ++ "7zip.png" ])
            << dataColumn "mag" (nums [ 1, 1, 1 ])
        )
        (url [ hName "img" ]
            << size [ mName "mag", mQuant ]
        )


image13 : Spec
image13 =
    imageEnc
        (dataColumn "img" (strs [ path ++ "ffox.png", path ++ "gimp.png", path ++ "7zip.png" ])
            << dataColumn "mag" (nums [ 1, 2, 1 ])
        )
        (url [ hName "img" ]
            << size [ mName "mag", mQuant ]
        )



{- Ids and specifications to be provided to the Vega-Lite runtime. -}


specs : List ( String, Spec )
specs =
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
    , ( "image13", image13 )
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
