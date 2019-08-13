port module TextFormatTests exposing (elmToJS)

import Browser
import Html exposing (Html, div, pre)
import Html.Attributes exposing (id)
import Json.Encode
import VegaLite exposing (..)


textFormat1 : Spec
textFormat1 =
    let
        data =
            dataFromColumns []
                << dataColumn "a" (strs (List.range 1981 2001 |> List.map String.fromInt))
                << dataColumn "b" (nums (List.range 1991 2011 |> List.map (\n -> toFloat (2011 + (1991 - n)))))

        encSym =
            encoding
                << position X [ pName "a", pTemporal ]
                << position Y [ pName "b", pQuant ]

        specSym =
            asSpec [ circle [], encSym [] ]

        encLabel =
            encoding
                << position X
                    [ pName "a"
                    , pTemporal
                    , pAxis [ axFormatAsTemporal, axFormat "%y" ]
                    ]
                << position Y
                    [ pName "b"
                    , pQuant
                    , pScale [ scZero False ]
                    , pAxis [ axFormatAsNum, axFormat ".2f" ]
                    ]
                << text
                    [ tName "a"
                    , tTemporal
                    , tFormatAsTemporal
                    , tFormat "%b `%y"
                    ]
                << color
                    [ mName "a"
                    , mTemporal
                    , mLegend [ leFormatAsTemporal, leFormat "%b %Y" ]
                    ]

        specLabel =
            asSpec [ textMark [ maDy 4, maDx 22 ], encLabel [] ]
    in
    toVegaLite [ width 600, height 400, data [], layer [ specSym, specLabel ] ]


textFormat2 : Spec
textFormat2 =
    let
        data =
            dataFromUrl "https://gicentre.github.io/data/westMidlands/westMidsCrimesAggregated.tsv"

        trans =
            transform
                << filter (fiExpr "datum.month >= '2016'")

        enc =
            encoding
                << position X [ pName "crimeType", pNominal, pAxis [ axTitle "" ] ]
                << position Y [ pName "reportedCrimes", pQuant, pAggregate opSum ]
                << color [ mName "crimeType", mNominal, mLegend [] ]
                << column [ fName "month", fTemporal, fHeader [ hdFormatAsTemporal, hdFormat "%b %y" ] ]
    in
    toVegaLite [ width 100, data [], trans [], bar [], enc [] ]


sourceExample : Spec
sourceExample =
    textFormat2



{- This list comprises the specifications to be provided to the Vega-Lite runtime. -}


mySpecs : Spec
mySpecs =
    combineSpecs
        [ ( "textFormat1", textFormat1 )
        , ( "textFormat2", textFormat2 )
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
