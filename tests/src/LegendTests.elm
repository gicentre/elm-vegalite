port module LegendTests exposing (elmToJS)

import Browser
import Dict exposing (Dict)
import Html exposing (Html)
import Html.Attributes
import Html.Events
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
                << color [ mName "Origin", mLegend legProps ]
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
                << color [ mName "Origin" ]
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
                << color [ mName "Origin", mLegend [ leOrient loNone, leX 232, leY 5 ] ]
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


legend13 : Spec
legend13 =
    legendCore [ leSymbolLimit 4 ]


legend14 : Spec
legend14 =
    legendCoreCfg [ lecoSymbolLimit 4 ]


sourceExample : Spec
sourceExample =
    legend14



{- Ids and specifications to be provided to the Vega-Lite runtime. -}


specs : List ( String, Spec )
specs =
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
    , ( "legend13", legend13 )
    , ( "legend14", legend14 )
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
    | NoSource


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
update msg model =
    case msg of
        NewSource srcName ->
            ( specs |> Dict.fromList |> Dict.get srcName |> Maybe.withDefault Json.Encode.null, Cmd.none )

        NoSource ->
            ( Json.Encode.null, Cmd.none )


port elmToJS : Spec -> Cmd msg
