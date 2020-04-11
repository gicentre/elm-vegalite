port module TimeTests exposing (elmToJS)

import Browser
import Dict exposing (Dict)
import Html exposing (Html)
import Html.Attributes
import Html.Events
import Json.Encode
import VegaLite exposing (..)


timeByUnit : TimeUnit -> Spec
timeByUnit tu =
    let
        data =
            dataFromUrl "https://gicentre.github.io/data/tests/timeTest.tsv" []

        enc =
            encoding
                << position X [ pName "date", pTemporal, pTimeUnit tu ]
                << position Y [ pName "temperature", pQuant, pAggregate opMean, pScale [ scZero False ] ]
    in
    toVegaLite [ width 800, data, enc [], line [ maStrokeWidth 0.2 ] ]


timeYear : Spec
timeYear =
    timeByUnit year


timeQuarter : Spec
timeQuarter =
    timeByUnit quarter


timeQuarterMonth : Spec
timeQuarterMonth =
    timeByUnit quarterMonth


timeMonth : Spec
timeMonth =
    timeByUnit month


timeMonthDate : Spec
timeMonthDate =
    timeByUnit monthDate


timeDate : Spec
timeDate =
    timeByUnit date


timeYearMonthDateHours : Spec
timeYearMonthDateHours =
    timeByUnit yearMonthDateHours


timeYearMonthDateHoursMinutes : Spec
timeYearMonthDateHoursMinutes =
    timeByUnit yearMonthDateHoursMinutes


timeYearMonthDateHoursMinutesSeconds : Spec
timeYearMonthDateHoursMinutesSeconds =
    timeByUnit yearMonthDateHoursMinutesSeconds


timeDay : Spec
timeDay =
    timeByUnit day


timeHours : Spec
timeHours =
    timeByUnit hours


timeHoursMinutes : Spec
timeHoursMinutes =
    timeByUnit hoursMinutes


timeHoursMinutesSeconds : Spec
timeHoursMinutesSeconds =
    timeByUnit hoursMinutesSeconds


timeMinutes : Spec
timeMinutes =
    timeByUnit minutes


timeMinutesSeconds : Spec
timeMinutesSeconds =
    timeByUnit minutesSeconds



-- TODO: Add milliseconds example
-- | SecondsMilliseconds
-- | Milliseconds


type Date
    = Local
    | UTC


parseTime : Date -> Spec
parseTime dType =
    let
        format =
            case dType of
                Local ->
                    foDate "%d %b %Y %H:%M"

                UTC ->
                    foUtc "%d %b %Y %H:%M"

        tu =
            case dType of
                Local ->
                    pTimeUnit yearMonthDateHours

                UTC ->
                    pTimeUnit (utc yearMonthDateHours)

        timeScale =
            case dType of
                Local ->
                    pScale [ scType scTime ]

                UTC ->
                    pScale [ scType scUtc ]

        data =
            dataFromColumns [ parse [ ( "date", format ) ] ]
                << dataColumn "date" (strs [ "28 Oct 2017 22:00", "28 Oct 2017 23:00", "29 Oct 2017 00:00", "29 Oct 2017 01:00", "29 Oct 2017 02:00", "29 Oct 2017 03:00", "29 Oct 2017 04:00" ])
                << dataColumn "value" (nums [ 1, 2, 3, 4, 5, 6, 7 ])

        enc =
            encoding
                << position X [ pName "date", pTemporal, tu, timeScale, pAxis [ axFormat "%d %b %H:%M" ] ]
                << position Y [ pName "value", pQuant ]
                << size [ mNum 500 ]
    in
    toVegaLite [ width 800, data [], enc [], circle [] ]


localTime : Spec
localTime =
    parseTime Local


utcTime : Spec
utcTime =
    parseTime UTC


timeBand : Spec
timeBand =
    let
        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/seattle-temps.csv" []

        enc =
            encoding
                << position X [ pName "date", pTimeUnit month, pTemporal, pBand 0.5 ]
                << position Y [ pName "temp", pAggregate opMean, pQuant ]
    in
    toVegaLite
        [ width 400
        , data
        , enc []
        , line [ maPoint (pmMarker [ maFill "black" ]) ]
        ]



{- Ids and specifications to be provided to the Vega-Lite runtime. -}


specs : List ( String, Spec )
specs =
    [ ( "timeYear", timeYear )
    , ( "timeQuarter", timeQuarter )
    , ( "timeQuarterMonth", timeQuarterMonth )
    , ( "timeMonth", timeMonth )
    , ( "timeMonthDate", timeMonthDate )
    , ( "timeDate", timeDate )
    , ( "timeYearMonthDateHours", timeYearMonthDateHours )
    , ( "timeYearMonthDateHoursMinutes", timeYearMonthDateHoursMinutes )
    , ( "timeYearMonthDateHoursMinutesSeconds", timeYearMonthDateHoursMinutesSeconds )
    , ( "timeDay", timeDay )
    , ( "timeHours", timeHours )
    , ( "timeHoursMinutes", timeHoursMinutes )
    , ( "timeHoursMinutesSeconds", timeHoursMinutesSeconds )
    , ( "timeMinutes", timeMinutes )
    , ( "timeMinutesSeconds", timeMinutesSeconds )
    , ( "localTime", localTime )
    , ( "utcTime", utcTime )
    , ( "timeBand", timeBand )
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
