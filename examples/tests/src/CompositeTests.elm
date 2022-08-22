port module CompositeTests exposing (elmToJS)

import Browser
import Dict
import Html exposing (Html)
import Html.Attributes
import Html.Events
import Json.Encode
import VegaLite exposing (..)


path : String
path =
    "https://cdn.jsdelivr.net/npm/vega-datasets@2.3/data/"


bPlot : SummaryExtent -> Spec
bPlot ext =
    let
        data =
            dataFromUrl (path ++ "population.json") []

        enc =
            encoding
                << position X [ pName "age", pOrdinal ]
                << position Y [ pName "people", pQuant, pTitle "Population" ]
    in
    toVegaLite [ data, boxplot [ maExtent ext ], enc [] ]


boxplot1 : Spec
boxplot1 =
    bPlot exRange


boxplot2 : Spec
boxplot2 =
    bPlot (exIqrScale 2)


boxplot3 : Spec
boxplot3 =
    let
        data =
            dataFromUrl (path ++ "population.json") []

        enc =
            encoding
                << position X [ pName "age", pOrdinal ]
                << position Y [ pName "people", pQuant, pTitle "Population" ]
    in
    toVegaLite
        [ data
        , boxplot
            [ maExtent (exIqrScale 0.5)
            , maBox [ maColor "firebrick" ]
            , maOutliers [ maColor "black", maStrokeWidth 0.3, maSize 10 ]
            , maMedian [ maSize 18, maFill "black", maStrokeWidth 0 ]
            , maRule [ maStrokeWidth 0.4 ]
            , maTicks [ maSize 8 ]
            ]
        , enc []
        ]


boxplot4 : Spec
boxplot4 =
    let
        data =
            dataFromUrl (path ++ "population.json") []

        enc =
            encoding
                << position X [ pName "age", pOrdinal ]
                << position Y [ pName "people", pQuant, pTitle "Population" ]
    in
    toVegaLite
        [ data
        , boxplot
            [ maExtent (exIqrScale 0.5)

            -- Box, outliers, median and rule appear by default so empty list removes them.
            , maBox []
            , maOutliers []
            , maMedian []
            , maRule []

            -- Default for ticks is absent unless added, so empty list displays them with default properties.
            , maTicks []
            ]
        , enc []
        ]


eBand : String -> Spec
eBand ext =
    let
        data =
            dataFromUrl (path ++ "cars.json") []

        label =
            case ext of
                "ci" ->
                    "(95% CI)"

                "stdev" ->
                    "(1 stdev)"

                "stderr" ->
                    "(1 std Error)"

                "range" ->
                    "(min to max)"

                _ ->
                    "(IQR)"

        summary =
            case ext of
                "ci" ->
                    exCi

                "stdev" ->
                    exStdev

                "stderr" ->
                    exStderr

                "range" ->
                    exRange

                _ ->
                    exIqr

        enc =
            encoding
                << position X [ pName "Year", pTimeUnit year ]
                << position Y
                    [ pName "Miles_per_Gallon"
                    , pQuant
                    , pScale [ scZero False ]
                    , pTitle ("Miles per Gallon " ++ label)
                    ]
    in
    toVegaLite [ data, errorband [ maExtent summary, maInterpolate miMonotone, maBorders [] ], enc [] ]


errorband1 : Spec
errorband1 =
    eBand "ci"


errorband2 : Spec
errorband2 =
    eBand "stdev"


eBar : SummaryExtent -> Spec
eBar ext =
    let
        data =
            dataFromUrl (path ++ "barley.json") []

        enc =
            encoding
                << position X [ pName "yield", pQuant, pScale [ scZero False ] ]
                << position Y
                    [ pName "variety"
                    , pOrdinal
                    ]
    in
    toVegaLite [ data, errorbar [ maExtent ext, maTicks [ maStroke "blue" ] ], enc [] ]


errorbar1 : Spec
errorbar1 =
    eBar exCi


errorbar2 : Spec
errorbar2 =
    eBar exStdev


errorbar3 : Spec
errorbar3 =
    let
        desc =
            description "Error bars with color encoding"

        data =
            dataFromUrl (path ++ "barley.json") []

        specErrorBars =
            asSpec [ errorbar [ maTicks [] ], encErrorBars [] ]

        encErrorBars =
            encoding
                << position X [ pName "yield", pQuant, pScale [ scZero False ] ]
                << position Y [ pName "variety", pOrdinal ]
                << color [ mStr "#4682b4" ]

        specPoints =
            asSpec [ point [ maFilled True, maColor "black" ], encPoints [] ]

        encPoints =
            encoding
                << position X [ pName "yield", pAggregate opMean ]
                << position Y [ pName "variety", pOrdinal ]
    in
    toVegaLite [ desc, data, layer [ specErrorBars, specPoints ] ]


errorbar4 : Spec
errorbar4 =
    let
        desc =
            description "Symmetric error bars encoded with xError channel"

        data =
            dataFromColumns []
                << dataColumn "yieldError" (nums [ 7.55, 6.98, 3.92, 11.97 ])
                << dataColumn "yield" (nums [ 32.4, 30.97, 33.96, 30.45 ])
                << dataColumn "variety" (strs [ "Glabron", "Manchuria", "No. 457", "No. 462" ])

        specErrorBars =
            asSpec [ errorbar [ maTicks [] ], encErrorBars [] ]

        encErrorBars =
            encoding
                << position X [ pName "yield", pQuant, pScale [ scZero False ] ]
                << position Y [ pName "variety", pOrdinal ]
                << position XError [ pName "yieldError" ]

        specPoints =
            asSpec [ point [ maFilled True, maColor "black" ], encPoints [] ]

        encPoints =
            encoding
                << position X [ pName "yield", pQuant ]
                << position Y [ pName "variety", pOrdinal ]
    in
    toVegaLite [ desc, data [], layer [ specErrorBars, specPoints ] ]


errorbar5 : Spec
errorbar5 =
    let
        desc =
            description "Asymmetric error bars encoded with xError and xError2 channels"

        data =
            dataFromColumns []
                << dataColumn "yieldError" (nums [ 7.55, 6.98, 3.92, 11.97 ])
                << dataColumn "yieldError2" (nums [ -10.55, -3.98, -0.92, -15.97 ])
                << dataColumn "yield" (nums [ 32.4, 30.97, 33.96, 30.45 ])
                << dataColumn "variety" (strs [ "Glabron", "Manchuria", "No. 457", "No. 462" ])

        specErrorBars =
            asSpec [ errorbar [ maTicks [] ], encErrorBars [] ]

        encErrorBars =
            encoding
                << position X [ pName "yield", pQuant, pScale [ scZero False ] ]
                << position Y [ pName "variety", pOrdinal ]
                << position XError [ pName "yieldError" ]
                << position XError2 [ pName "yieldError2" ]

        specPoints =
            asSpec [ point [ maFilled True, maColor "black" ], encPoints [] ]

        encPoints =
            encoding
                << position X [ pName "yield", pQuant ]
                << position Y [ pName "variety", pOrdinal ]
    in
    toVegaLite [ desc, data [], layer [ specErrorBars, specPoints ] ]


errorbar6 : Spec
errorbar6 =
    let
        desc =
            description "Symmetric error bars encoded with yError channel"

        data =
            dataFromColumns []
                << dataColumn "yieldError" (nums [ 7.55, 6.98, 3.92, 11.97 ])
                << dataColumn "yield" (nums [ 32.4, 30.97, 33.96, 30.45 ])
                << dataColumn "variety" (strs [ "Glabron", "Manchuria", "No. 457", "No. 462" ])

        specErrorBars =
            asSpec [ errorbar [ maTicks [] ], encErrorBars [] ]

        encErrorBars =
            encoding
                << position Y [ pName "yield", pQuant, pScale [ scZero False ] ]
                << position X [ pName "variety", pOrdinal ]
                << position YError [ pName "yieldError" ]

        specPoints =
            asSpec [ point [ maFilled True, maColor "black" ], encPoints [] ]

        encPoints =
            encoding
                << position Y [ pName "yield", pQuant ]
                << position X [ pName "variety", pOrdinal ]
    in
    toVegaLite [ desc, data [], layer [ specErrorBars, specPoints ] ]


errorbar7 : Spec
errorbar7 =
    let
        desc =
            description "Asymmetric error bars encoded with yError and yError2 channels"

        data =
            dataFromColumns []
                << dataColumn "yieldError" (nums [ 7.55, 6.98, 3.92, 11.97 ])
                << dataColumn "yieldError2" (nums [ -10.55, -3.98, -0.92, -15.97 ])
                << dataColumn "yield" (nums [ 32.4, 30.97, 33.96, 30.45 ])
                << dataColumn "variety" (strs [ "Glabron", "Manchuria", "No. 457", "No. 462" ])

        specErrorBars =
            asSpec [ errorbar [ maTicks [] ], encErrorBars [] ]

        encErrorBars =
            encoding
                << position Y [ pName "yield", pQuant, pScale [ scZero False ] ]
                << position X [ pName "variety", pOrdinal ]
                << position YError [ pName "yieldError" ]
                << position YError2 [ pName "yieldError2" ]

        specPoints =
            asSpec [ point [ maFilled True, maColor "black" ], encPoints [] ]

        encPoints =
            encoding
                << position Y [ pName "yield", pQuant ]
                << position X [ pName "variety", pOrdinal ]
    in
    toVegaLite [ desc, data [], layer [ specErrorBars, specPoints ] ]



{- Ids and specifications to be provided to the Vega-Lite runtime. -}


specs : List ( String, Spec )
specs =
    [ ( "boxplot1", boxplot1 )
    , ( "boxplot2", boxplot2 )
    , ( "boxplot3", boxplot3 )
    , ( "boxplot4", boxplot4 )
    , ( "errorband1", errorband1 )
    , ( "errorband2", errorband2 )
    , ( "errorbar1", errorbar1 )
    , ( "errorbar2", errorbar2 )
    , ( "errorbar3", errorbar3 )
    , ( "errorbar4", errorbar4 )
    , ( "errorbar5", errorbar5 )
    , ( "errorbar6", errorbar6 )
    , ( "errorbar7", errorbar7 )
    ]



{- ---------------------------------------------------------------------------
   BOILERPLATE: NO NEED TO EDIT

   The code below creates an Elm module that opens an outgoing port to Javascript
   and sends both the specs and DOM node to it.
   It allows the source code of any of the generated specs to be selected from
   a drop-down list. Useful for viewing specs that might generate invalid Vega-Lite.
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
