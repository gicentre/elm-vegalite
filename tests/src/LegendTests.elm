port module LegendTests exposing (elmToJS)

import Browser
import Html exposing (Html, div, pre)
import Html.Attributes exposing (id)
import Json.Encode
import VegaLite exposing (..)


legendCore : List LegendProperty -> Spec
legendCore legProps =
    let
        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/cars.json"

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]
                << color [ mName "Origin", mNominal, mLegend legProps ]
                << size [ mName "Horsepower", mQuant, mLegend legProps ]
                << opacity [ mName "Weight_in_lbs", mQuant, mLegend legProps ]
    in
    toVegaLite [ width 300, height 300, data [], enc [], circle [] ]


legendCoreCfg : List LegendConfig -> Spec
legendCoreCfg cfg =
    let
        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/cars.json"

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]
                << color [ mName "Origin", mNominal ]
                << size [ mName "Horsepower", mQuant ]
                << opacity [ mName "Weight_in_lbs", mQuant ]
    in
    toVegaLite
        [ (configure << configuration (coLegend cfg)) []
        , width 300
        , height 300
        , data []
        , enc []
        , circle []
        ]


legend1 : Spec
legend1 =
    legendCoreCfg []


legend2 : Spec
legend2 =
    legendCore [ leOrient loTop ]


legend3 : Spec
legend3 =
    legendCore [ leOrient loTopRight ]


legend4 : Spec
legend4 =
    legendCore [ leOrient loRight ]


legend5 : Spec
legend5 =
    legendCore [ leOrient loBottomRight ]


legend6 : Spec
legend6 =
    legendCore [ leOrient loBottom ]


legend7 : Spec
legend7 =
    legendCore [ leOrient loBottomLeft ]


legend8 : Spec
legend8 =
    legendCore [ leOrient loLeft ]


legend9 : Spec
legend9 =
    legendCore [ leOrient loTopLeft ]


legend10 : Spec
legend10 =
    let
        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/cars.json"

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]
                << color [ mName "Origin", mNominal, mLegend [ leOrient loNone, leX 232, leY 5 ] ]
    in
    toVegaLite [ width 300, height 300, data [], enc [], circle [] ]


legend11 : Spec
legend11 =
    legendCoreCfg
        [ lecoSymbolStrokeWidth 3
        , lecoSymbolStrokeColor "black"
        , lecoRowPadding 15
        , lecoTitlePadding 20
        , lecoStrokeColor "lightgrey"
        , lecoStrokeWidth 5
        , lecoPadding 30
        , lecoStrokeDash [ 4, 2, 6, 1 ]
        ]


legend12 : Spec
legend12 =
    legendCore [ leLabelBaseline vaLineTop ]


sourceExample : Spec
sourceExample =
    legend12



{- This list comprises the specifications to be provided to the Vega-Lite runtime. -}


mySpecs : Spec
mySpecs =
    combineSpecs
        [ ( "legend1", legend1 )
        , ( "legend2", legend2 )
        , ( "legend3", legend3 )
        , ( "legend4", legend4 )
        , ( "legend5", legend5 )
        , ( "legend6", legend6 )
        , ( "legend7", legend7 )
        , ( "legend8", legend8 )
        , ( "legend9", legend9 )
        , ( "legend10", legend10 )
        , ( "legend11", legend11 )
        , ( "legend12", legend12 )
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
