port module WindowTransformTests exposing (elmToJS)

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


window1 : Spec
window1 =
    let
        data =
            dataFromColumns []
                << dataColumn "Activity" (strs [ "Sleeping", "Eating", "TV", "Work", "Exercise" ])
                << dataColumn "Time" (nums [ 8, 2, 4, 8, 2 ])

        trans =
            transform
                << window [ ( [ wiAggregateOp opSum, wiField "Time" ], "TotalTime" ) ]
                    [ wiFrame Nothing Nothing ]
                << calculateAs "datum.Time/datum.TotalTime * 100" "PercentOfTotal"

        enc =
            encoding
                << position X [ pName "PercentOfTotal", pQuant, pTitle "% of total time" ]
                << position Y [ pName "Activity" ]
    in
    toVegaLite
        [ heightStep 12
        , data []
        , trans []
        , bar []
        , enc []
        ]


window2 : Spec
window2 =
    let
        data =
            dataFromUrl (path ++ "movies.json") []

        trans =
            transform
                << filter (fiExpr "datum['IMDB Rating'] != null")
                << window [ ( [ wiAggregateOp opMean, wiField "IMDB Rating" ], "AverageRating" ) ]
                    [ wiFrame Nothing Nothing ]
                << filter (fiExpr "(datum['IMDB Rating'] - datum.AverageRating) > 2.5")

        barEnc =
            encoding
                << position X [ pName "IMDB Rating", pQuant ]
                << position Y [ pName "Title", pOrdinal ]

        barSpec =
            asSpec [ bar [], barEnc [] ]

        ruleEnc =
            encoding
                << position X [ pName "AverageRating", pAggregate opMean ]

        ruleSpec =
            asSpec [ rule [ maColor "red" ], ruleEnc [] ]
    in
    toVegaLite [ data, trans [], layer [ barSpec, ruleSpec ] ]


window3 : Spec
window3 =
    let
        data =
            dataFromUrl (path ++ "movies.json") [ parse [ ( "Release_Date", foDate "%b %d %Y" ) ] ]

        trans =
            transform
                << filter (fiExpr "datum['IMDB Rating'] != null")
                << timeUnitAs year "Release Date" "year"
                << window [ ( [ wiAggregateOp opMean, wiField "IMDB Rating" ], "AverageYearRating" ) ]
                    [ wiGroupBy [ "year" ], wiFrame Nothing Nothing ]
                << filter (fiExpr "(datum['IMDB Rating'] - datum.AverageYearRating) > 2.5")

        barEnc =
            encoding
                << position X [ pName "IMDB Rating", pQuant ]
                << position Y [ pName "Title", pOrdinal ]

        barSpec =
            asSpec [ bar [ maClip True ], barEnc [] ]

        tickEnc =
            encoding
                << position X [ pName "AverageYearRating", pQuant ]
                << position Y [ pName "Title", pOrdinal ]
                << color [ mStr "red" ]

        tickSpec =
            asSpec [ tick [], tickEnc [] ]
    in
    toVegaLite [ data, trans [], layer [ barSpec, tickSpec ] ]


window4 : Spec
window4 =
    let
        data =
            dataFromUrl (path ++ "movies.json") [ parse [ ( "Release_Date", foDate "%b %d %Y" ) ] ]

        trans =
            transform
                << filter (fiExpr "datum['IMDB Rating'] != null")
                << filter (fiRange "Release Date" (dtRange [] [ dtYear 2019 ]))
                << window [ ( [ wiAggregateOp opMean, wiField "IMDB Rating" ], "AverageRating" ) ]
                    [ wiFrame Nothing Nothing ]
                << calculateAs "datum['IMDB Rating'] - datum.AverageRating" "RatingDelta"

        enc =
            encoding
                << position X [ pName "Release Date", pTemporal ]
                << position Y [ pName "RatingDelta", pQuant, pTitle "Residual" ]
    in
    toVegaLite [ data, trans [], enc [], point [ maStrokeWidth 0.3, maOpacity 0.3 ] ]


window5 : Spec
window5 =
    let
        data =
            dataFromColumns []
                << dataColumn "team" (strs [ "Man Utd", "Chelsea", "Man City", "Spurs", "Man Utd", "Chelsea", "Man City", "Spurs", "Man Utd", "Chelsea", "Man City", "Spurs" ])
                << dataColumn "matchday" (nums [ 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3 ])
                << dataColumn "point" (nums [ 3, 1, 1, 0, 6, 1, 0, 3, 9, 1, 0, 6 ])

        trans =
            transform
                << window
                    [ ( [ wiOp woRank ], "rank" ) ]
                    [ wiSort [ wiDescending "point" ], wiGroupBy [ "matchday" ] ]

        enc =
            encoding
                << position X [ pName "matchday", pOrdinal ]
                << position Y [ pName "rank", pOrdinal ]
                << color [ mName "team", mScale teamColours ]

        teamColours =
            categoricalDomainMap
                [ ( "Man Utd", "#cc2613" )
                , ( "Chelsea", "#125dc7" )
                , ( "Man City", "#8bcdfc" )
                , ( "Spurs", "#d1d1d1" )
                ]
    in
    toVegaLite [ data [], trans [], enc [], line [ maOrient moVertical ] ]


window6 : Spec
window6 =
    let
        data =
            dataFromColumns []
                << dataColumn "student" (strs [ "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V" ])
                << dataColumn "score" (nums [ 100, 56, 88, 65, 45, 23, 66, 67, 13, 12, 50, 78, 66, 30, 97, 75, 24, 42, 76, 78, 21, 46 ])

        trans =
            transform
                << window [ ( [ wiOp woRank ], "rank" ) ] [ wiSort [ wiDescending "score" ] ]
                << filter (fiExpr "datum.rank <= 5")

        enc =
            encoding
                << position X [ pName "score", pQuant ]
                << position Y
                    [ pName "student"
                    , pSort [ soByField "score" opMean, soDescending ]
                    ]
    in
    toVegaLite [ data [], trans [], enc [], bar [] ]


window7 : Spec
window7 =
    let
        data =
            dataFromUrl (path ++ "cars.json") []

        trans =
            transform
                << filter (fiExpr "datum.Miles_per_Gallon !== null")
                << timeUnitAs year "Year" "year"
                << window [ ( [ wiAggregateOp opMean, wiField "Miles_per_Gallon" ], "Average_MPG" ) ]
                    [ wiSort [ wiAscending "year" ], wiIgnorePeers False, wiFrame Nothing (Just 0) ]

        circleEnc =
            encoding
                << position X [ pName "Year", pTimeUnit year ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]

        circleSpec =
            asSpec [ circle [], circleEnc [] ]

        lineEnc =
            encoding
                << position X [ pName "Year", pTimeUnit year ]
                << position Y [ pName "Average_MPG", pQuant, pTitle "Miles per gallon" ]

        lineSpec =
            asSpec [ line [ maColor "red" ], lineEnc [] ]
    in
    toVegaLite [ data, trans [], layer [ circleSpec, lineSpec ] ]


joinAggregate1 : Spec
joinAggregate1 =
    let
        data =
            dataFromColumns []
                << dataColumn "Activity" (strs [ "Sleeping", "Eating", "TV", "Work", "Exercise" ])
                << dataColumn "Time" (nums [ 8, 2, 4, 8, 2 ])

        trans =
            transform
                << joinAggregate [ opAs opSum "Time" "TotalTime" ] []
                << calculateAs "datum.Time/datum.TotalTime * 100" "PercentOfTotal"

        enc =
            encoding
                << position X [ pName "PercentOfTotal", pQuant, pTitle "% of total Time" ]
                << position Y [ pName "Activity" ]
    in
    toVegaLite [ heightStep 12, data [], trans [], enc [], bar [] ]


joinAggregate2 : Spec
joinAggregate2 =
    let
        data =
            dataFromUrl (path ++ "movies.json") []

        trans =
            transform
                << filter (fiExpr "datum['IMDB Rating'] != null")
                << joinAggregate [ opAs opMean "IMDB Rating" "AverageRating" ] []
                << filter (fiExpr "(datum['IMDB Rating'] - datum.AverageRating) > 2.5")

        enc =
            encoding
                << position X [ pName "IMDB Rating", pQuant ]
                << position Y [ pName "Title", pTitle "", pSort [ soByChannel chX, soDescending ] ]
    in
    toVegaLite [ data, trans [], enc [], bar [] ]


joinAggregate3 : Spec
joinAggregate3 =
    let
        data =
            dataFromUrl (path ++ "movies.json") []

        trans =
            transform
                << filter (fiExpr "datum['IMDB Rating'] != null")
                << timeUnitAs year "Release Date" "year"
                << joinAggregate [ opAs opMean "IMDB Rating" "AverageYearRating" ]
                    [ wiGroupBy [ "year" ] ]
                << filter (fiExpr "(datum['IMDB Rating'] - datum.AverageYearRating) > 2.5")

        enc =
            encoding
                << position X [ pName "IMDB Rating", pQuant ]
                << position Y [ pName "Title", pTitle "", pSort [ soByChannel chX, soDescending ] ]
    in
    toVegaLite [ data, trans [], enc [], bar [] ]



{- Ids and specifications to be provided to the Vega-Lite runtime. -}


specs : List ( String, Spec )
specs =
    [ ( "window1", window1 )
    , ( "window2", window2 )
    , ( "window3", window3 )
    , ( "window4", window4 )
    , ( "window5", window5 )
    , ( "window6", window6 )
    , ( "window7", window7 )
    , ( "joinAggregate1", joinAggregate1 )
    , ( "joinAggregate2", joinAggregate2 )
    , ( "joinAggregate3", joinAggregate3 )
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
