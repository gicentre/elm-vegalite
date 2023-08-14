port module TimeTests exposing (elmToJS)

import Browser
import Dict
import Html exposing (Html)
import Html.Attributes
import Html.Events
import Json.Encode
import Time
import VegaLite exposing (..)


path : String
path =
    "https://cdn.jsdelivr.net/npm/vega-datasets@2.3/data/"


timeByUnit : TimeUnit -> Spec
timeByUnit tu =
    let
        data =
            dataFromUrl "https://gicentre.github.io/data/tests/timeTest.tsv" []

        enc =
            encoding
                << position X [ pName "date", pTimeUnit tu ]
                << position Y [ pName "temperature", pAggregate opMean, pScale [ scZero False ] ]
    in
    toVegaLite [ width 800, data, enc [], line [ maStrokeWidth 0.2 ] ]


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
            dataFromUrl (path ++ "seattle-weather.csv") []

        enc =
            encoding
                << position X [ pName "date", pTimeUnit month, pBandPosition 0.5 ]
                << position Y [ pName "temp_max", pAggregate opMean ]
    in
    toVegaLite
        [ width 400
        , data
        , enc []
        , line [ maPoint (pmMarker [ maFill "black" ]) ]
        ]


timePosix : Spec
timePosix =
    let
        data =
            dataFromUrl (path ++ "seattle-weather.csv") []

        myTime =
            -- July 1st 2014 in milliseconds
            Time.millisToPosix 1404172800000

        enc =
            encoding
                << position X
                    [ pName "date"
                    , pTemporal
                    , pScale [ scDomain <| doMinDt <| fromPosixTime <| myTime ]
                    ]
                << position Y [ pName "temp_max", pAggregate opMean ]
    in
    toVegaLite
        [ width 800
        , data
        , enc []
        , line [ maClip True ]
        ]


preBinned : Spec
preBinned =
    let
        --     {
        --   "data": {"url": "data/stocks.csv"},
        --   "transform": [
        --     {"filter": "datum.symbol==='GOOG'"}
        --   ],
        --   "mark": "bar",
        --   "encoding": {
        --     "x": {"timeUnit": "binnedyearmonth", "field": "date", "type": "temporal"},
        --     "y": {"field": "price", "type": "quantitative"}
        --   }
        -- }
        data =
            dataFromUrl (path ++ "stocks.csv") []

        trans =
            transform
                << filter (fiExpr "datum.symbol === 'GOOG'")

        enc =
            encoding
                << position X
                    [ pName "date"
                    , pTemporal
                    , pTimeUnit (binnedTimeUnit yearMonth)
                    ]
                << position Y [ pName "price", pQuant ]
    in
    toVegaLite [ data, trans [], enc [], bar [] ]



{- Ids and specifications to be provided to the Vega-Lite runtime. -}


specs : List ( String, Spec )
specs =
    [ ( "timeYear", timeByUnit year )
    , ( "timeYearQuarter", timeByUnit yearQuarter )
    , ( "timeYearQuarterMonth", timeByUnit yearQuarterMonth )
    , ( "timeYearMonth", timeByUnit yearMonth )
    , ( "timeYearMonthDate", timeByUnit yearMonthDate )
    , ( "timeYearMonthDateHours", timeByUnit yearMonthDateHours )
    , ( "timeYearMonthDateHoursMinutes", timeByUnit yearMonthDateHoursMinutes )
    , ( "timeYearMonthDateHoursMinutesSeconds", timeByUnit yearMonthDateHoursMinutesSeconds )
    , ( "timeQuarter", timeByUnit quarter )
    , ( "timeQuarterMonth", timeByUnit quarterMonth )
    , ( "timeMonth", timeByUnit month )
    , ( "timeMonthDate", timeByUnit monthDate )
    , ( "timeMonthDateHours", timeByUnit monthDateHours )
    , ( "timeMonthDateHoursMinutes", timeByUnit monthDateHoursMinutes )
    , ( "timeMonthDateHoursMinutesSeconds", timeByUnit monthDateHoursMinutesSeconds )
    , ( "timeDay", timeByUnit day )
    , ( "timeDayHours", timeByUnit dayHours )
    , ( "timeDayHoursMinutes", timeByUnit dayHoursMinutes )
    , ( "timeDayHoursMinutesSeconds", timeByUnit dayHoursMinutesSeconds )
    , ( "timeDate", timeByUnit date )
    , ( "timeHours", timeByUnit hours )
    , ( "timeHoursMinutes", timeByUnit hoursMinutes )
    , ( "timeHoursMinutesSeconds", timeByUnit hoursMinutesSeconds )
    , ( "timeMinutes", timeByUnit minutes )
    , ( "timeMinutesSeconds", timeByUnit minutesSeconds )
    , ( "timeSeconds", timeByUnit seconds )
    , ( "timeSecondsMilliseconds", timeByUnit secondsMilliseconds )
    , ( "timeMilliseconds", timeByUnit milliseconds )
    , ( "localTime", localTime )
    , ( "utcTime", utcTime )
    , ( "timeBand", timeBand )
    , ( "timePosix", timePosix )
    , ( "preBinned", preBinned )
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
