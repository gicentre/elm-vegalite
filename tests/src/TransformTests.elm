port module TransformTests exposing (elmToJS)

import Browser
import Dict
import Html exposing (Html)
import Html.Attributes
import Html.Events
import Json.Encode
import VegaLite exposing (..)


path : String
path =
    "https://cdn.jsdelivr.net/npm/vega-datasets@2.2/data/"


transform1 : Spec
transform1 =
    let
        data =
            dataFromUrl (path ++ "cars.json") []

        trans =
            transform
                -- calculateAs transform first to test that order of transforms is preserved.
                << calculateAs "datum.Acceleration" "myAcceleration"
                << aggregate [ opAs opMean "myAcceleration" "mean_acceleration" ]
                    [ "Cylinders" ]

        enc =
            encoding
                << position X [ pName "Cylinders", pOrdinal ]
                << position Y [ pName "mean_acceleration", pQuant ]
    in
    toVegaLite [ data, trans [], enc [], bar [] ]


binTransform : List BinProperty -> Spec
binTransform bProps =
    let
        data =
            dataFromUrl (path ++ "movies.json") []

        trans =
            transform
                -- calculateAs transform first to test that order of transforms is preserved.
                << calculateAs "datum['IMDB Rating']" "rating"
                << filter (fiExpr "datum.rating != null")
                << binAs bProps "rating" "ratingGroup"

        enc =
            encoding
                << position X [ pName "ratingGroup", pOrdinal ]
                << position Y [ pAggregate opCount, pTitle "Number of movies" ]
    in
    toVegaLite [ width 400, data, trans [], enc [], bar [] ]


transform2 : Spec
transform2 =
    binTransform []


transform3 : Spec
transform3 =
    binTransform [ biStep 0.25 ]


transform4 : Spec
transform4 =
    let
        imputeData =
            dataFromColumns []
                << dataColumn "A" (nums [ 0, 0, 1, 1, 2, 2, 3 ])
                << dataColumn "B" (nums [ 28, 91, 43, 55, 81, 53, 19 ])
                << dataColumn "C" (nums [ 0, 1, 0, 1, 0, 1, 0 ])

        trans =
            transform
                -- calculateAs transform first to test that order of transforms is preserved.
                << calculateAs "datum.A" "a"
                << calculateAs "datum.B" "b"
                << calculateAs "datum.C" "c"
                << impute "b" "a" [ imMethod imMean, imGroupBy [ "c" ], imFrame (Just -2) (Just 2) ]

        enc =
            encoding
                << position X [ pName "a", pQuant ]
                << position Y [ pName "b", pQuant ]
                << color [ mName "c" ]
    in
    toVegaLite [ imputeData [], trans [], enc [], line [] ]


transform5 : Spec
transform5 =
    let
        data =
            dataFromUrl (path ++ "movies.json") []

        trans =
            transform
                -- calculateAs transform first to test that order of transforms is preserved.
                << calculateAs "datum['IMDB Rating']" "rating"
                << filter (fiExpr "datum.rating != null")
                << density "rating" [ dnBandwidth 0.3 ]

        enc =
            encoding
                << position X [ pName "value", pQuant, pTitle "IMDB Rating" ]
                << position Y [ pName "density", pQuant ]
    in
    toVegaLite [ width 400, height 100, data, trans [], enc [], area [] ]


transform6 : Spec
transform6 =
    let
        data =
            dataFromUrl (path ++ "movies.json") []

        trans =
            transform
                -- calculateAs transform first to test that order of transforms is preserved.
                << calculateAs "datum['IMDB Rating']" "imdbRating"
                << calculateAs "datum['Rotten Tomatoes Rating']" "rtRating"
                << loess "imdbRating" "rtRating" [ lsBandwidth 0.1, lsAs "tx" "ty" ]

        enc1 =
            encoding
                << position X [ pName "Rotten Tomatoes Rating", pQuant ]
                << position Y [ pName "IMDB Rating", pQuant ]

        enc2 =
            encoding
                << position X [ pName "tx", pQuant ]
                << position Y [ pName "ty", pQuant ]

        pointSpec =
            asSpec [ enc1 [], point [ maFilled True, maOpacity 0.3 ] ]

        trendSpec =
            asSpec [ trans [], enc2 [], line [ maColor "firebrick" ] ]
    in
    toVegaLite [ width 300, height 300, data, layer [ pointSpec, trendSpec ] ]


transform7 : Spec
transform7 =
    let
        countyData =
            dataFromUrl (path ++ "us-10m.json") [ topojsonFeature "counties" ]

        unemploymentData =
            dataFromUrl (path ++ "unemployment.tsv") []

        trans =
            transform
                -- calculateAs transform first to test that order of transforms is preserved.
                << calculateAs "datum.id" "countyID"
                << lookup "countyID" unemploymentData "id" (luFields [ "rate" ])

        proj =
            projection [ prType albersUsa ]

        enc =
            encoding
                << color [ mName "rate", mQuant ]
    in
    toVegaLite [ width 500, height 300, countyData, proj, trans [], enc [], geoshape [] ]


transform8 : Spec
transform8 =
    let
        data =
            dataFromColumns []
                << dataColumn "city" (strs [ "Bristol", "Bristol", "Sheffield", "Sheffield", "Glasgow", "Glasgow" ])
                << dataColumn "temp" (nums [ 12, 14, 11, 13, 7, 10 ])
                << dataColumn "year" (nums [ 2017, 2018, 2017, 2018, 2017, 2018 ])

        trans =
            transform
                -- calculateAs transform first to test that order of transforms is preserved.
                << calculateAs "datum.year" "Year"
                << calculateAs "datum.city" "City"
                << calculateAs "datum.temp" "Temperature"
                << pivot "Year" "Temperature" [ piGroupBy [ "City" ] ]

        enc =
            encoding
                -- 2017 temperatures for the Bristol, Sheffield and Glasgow
                << position X [ pName "2017", pQuant ]
                << position Y [ pName "City" ]
    in
    toVegaLite [ data [], trans [], enc [], circle [] ]


transform9 : Spec
transform9 =
    let
        data =
            dataFromUrl (path ++ "normal-2d.json") []

        trans =
            transform
                << quantile "u" [ qtStep 0.01, qtAs "p" "v" ]
                << calculateAs "quantileUniform(datum.p)" "unif"
                << calculateAs "quantileNormal(datum.p)" "norm"

        enc1 =
            encoding
                << position X [ pName "unif", pQuant ]
                << position Y [ pName "v", pQuant ]

        enc2 =
            encoding
                << position X [ pName "norm", pQuant ]
                << position Y [ pName "v", pQuant ]
    in
    toVegaLite
        [ data
        , trans []
        , hConcat
            [ asSpec [ enc1 [], point [] ]
            , asSpec [ enc2 [], point [] ]
            ]
        ]


transform10 : Spec
transform10 =
    let
        data =
            dataFromUrl (path ++ "movies.json") []

        trans =
            transform
                -- calculateAs transform first to test that order of transforms is preserved.
                << calculateAs "datum['IMDB Rating']" "imdbRating"
                << calculateAs "datum['Rotten Tomatoes Rating']" "rtRating"
                << regression "imdbRating" "rtRating" [ rgMethod rgPoly, rgOrder 3, rgExtent 10 90 ]

        enc1 =
            encoding
                << position X [ pName "Rotten Tomatoes Rating", pQuant ]
                << position Y [ pName "IMDB Rating", pQuant ]

        enc2 =
            encoding
                << position X [ pName "rtRating", pQuant ]
                << position Y [ pName "imdbRating", pQuant ]

        pointSpec =
            asSpec [ enc1 [], point [ maFilled True, maOpacity 0.3 ] ]

        regSpec =
            asSpec [ trans [], enc2 [], line [ maColor "firebrick" ] ]
    in
    toVegaLite [ width 300, height 300, data, layer [ pointSpec, regSpec ] ]


transform11 : Spec
transform11 =
    let
        data =
            dataFromUrl (path ++ "movies.json") []

        transReg =
            transform
                << regression "IMDB Rating" "Rotten Tomatoes Rating" [ rgMethod rgLinear ]

        transCoeff =
            transform
                << regression "IMDB Rating" "Rotten Tomatoes Rating" [ rgMethod rgLinear, rgParams True ]
                << calculateAs "'y = '+format(datum.coef[0],'.2f')+' + '+format(datum.coef[1],'.2f')+'x'+'   R²: '+format(datum.rSquared, '.2f')" "coef"

        encScatter =
            encoding
                << position X [ pName "Rotten Tomatoes Rating", pQuant ]
                << position Y [ pName "IMDB Rating", pQuant ]

        encCoeff =
            encoding
                << text [ tName "coef" ]

        specScatter =
            asSpec [ encScatter [], point [ maFilled True, maOpacity 0.3 ] ]

        specReg =
            asSpec [ transReg [], encScatter [], line [ maColor "firebrick" ] ]

        specCoeff =
            asSpec
                [ transCoeff []
                , encCoeff []
                , textMark
                    [ maX 4
                    , maY 4
                    , maAlign haLeft
                    , maBaseline vaTop
                    , maColor "firebrick"
                    ]
                ]
    in
    toVegaLite [ width 300, height 300, data, layer [ specScatter, specReg, specCoeff ] ]


transform12 : Spec
transform12 =
    let
        data =
            dataFromJson
                (Json.Encode.list Json.Encode.object
                    [ [ ( "key", Json.Encode.string "alpha" )
                      , ( "foo", Json.Encode.list Json.Encode.float [ 1, 2 ] )
                      , ( "bar", Json.Encode.list Json.Encode.string [ "A", "B" ] )
                      ]
                    , [ ( "key", Json.Encode.string "beta" )
                      , ( "foo", Json.Encode.list Json.Encode.float [ 3, 4, 5 ] )
                      , ( "bar", Json.Encode.list Json.Encode.string [ "C", "D" ] )
                      ]
                    ]
                )

        trans =
            transform
                << flattenAs [ "foo", "bar" ] [ "quant", "cat" ]

        enc =
            encoding
                << position X [ pName "quant", pQuant ]
                << position Y [ pName "cat" ]
                << color [ mName "key" ]
    in
    toVegaLite [ data [], trans [], circle [], enc [] ]


transform13 : Spec
transform13 =
    let
        data =
            dataFromColumns []
                << dataColumn "country" (strs [ "USA", "Canada" ])
                << dataColumn "gold" (nums [ 10, 7 ])
                << dataColumn "silver" (nums [ 20, 26 ])

        trans =
            transform
                -- calculateAs transforms to test that order of transforms is preserved.
                << calculateAs "datum.gold" "goldMedals"
                << calculateAs "datum.silver" "silverMedals"
                << foldAs [ "goldMedals", "silverMedals" ] "k" "v"
                << calculateAs "datum.k" "year"
                << calculateAs "datum.v" "numberOfMedals"

        enc =
            encoding
                << column [ fName "year" ]
                << position X [ pName "country" ]
                << position Y [ pName "numberOfMedals", pQuant ]
                << color [ mName "country", mLegend [] ]
    in
    toVegaLite [ data [], trans [], bar [], enc [] ]


transform14 : Spec
transform14 =
    let
        data =
            dataFromUrl (path ++ "cars.json") []

        trans =
            transform
                << aggregate [ opAs opCount "" "count_*" ] [ "Origin", "Cylinders" ]
                << stack "count_*"
                    []
                    "stack_count_Origin1"
                    "stack_count_Origin2"
                    [ stOffset stNormalize, stSort [ stAscending "Origin" ] ]
                << window
                    [ ( [ wiAggregateOp opMin, wiField "stack_count_Origin1" ], "x" )
                    , ( [ wiAggregateOp opMax, wiField "stack_count_Origin2" ], "x2" )
                    ]
                    [ wiFrame Nothing Nothing, wiGroupBy [ "Origin" ] ]
                << stack "count_*"
                    [ "Origin" ]
                    "y"
                    "y2"
                    [ stOffset stNormalize, stSort [ stAscending "Cylinders" ] ]

        enc =
            encoding
                << position X [ pName "x", pQuant, pAxis [] ]
                << position X2 [ pName "x2" ]
                << position Y [ pName "y", pQuant, pAxis [] ]
                << position Y2 [ pName "y2" ]
                << color [ mName "Origin" ]
                << opacity [ mName "Cylinders", mQuant, mLegend [] ]
                << tooltips
                    [ [ tName "Origin" ]
                    , [ tName "Cylinders", tQuant ]
                    ]
    in
    toVegaLite [ data, trans [], enc [], rect [] ]


transform15 : Spec
transform15 =
    let
        data =
            dataFromUrl (path ++ "seattle-weather.csv") [ parse [ ( "date", foDate "%Y-%m-%d" ) ] ]

        trans =
            transform
                -- calculateAs transforms to test that order of transforms is preserved.
                << calculateAs "datum.date" "sampleDate"
                << calculateAs "datum.temp_max" "maxTemp"
                << timeUnitAs month "sampleDate" "month"

        enc =
            encoding
                << position X [ pName "month", pTemporal, pAxis [ axFormat "%b" ] ]
                << position Y [ pName "maxTemp", pAggregate opMax ]
    in
    toVegaLite [ width 400, data, trans [], enc [], line [ maPoint (pmMarker [ maFill "black" ]) ] ]


transform16 : Spec
transform16 =
    let
        data =
            dataFromUrl (path ++ "seattle-weather.csv") [ parse [ ( "date", foDate "%Y-%m-%d" ) ] ]

        trans =
            transform
                -- calculateAs transforms to test that order of transforms is preserved.
                << calculateAs "datum.date" "sampleDate"
                << calculateAs "datum.temp_max" "maxTemp"
                << timeUnitAs (tuStep 2 month) "sampleDate" "bimonth"

        enc =
            encoding
                << position X [ pName "bimonth", pTemporal, pAxis [ axFormat "%b" ] ]
                << position Y [ pName "maxTemp", pAggregate opMax ]
    in
    toVegaLite [ width 400, data, trans [], enc [], line [ maPoint (pmMarker [ maFill "black" ]) ] ]


transform17 : Spec
transform17 =
    let
        data =
            dataFromUrl (path ++ "seattle-weather.csv") [ parse [ ( "date", foDate "%Y-%m-%d" ) ] ]

        trans =
            transform
                << calculateAs "datum.temp_max" "maxTemp"
                << timeUnitAs (tuMaxBins 3) "date" "tBin"

        enc =
            encoding
                << position X [ pName "tBin", pTemporal, pAxis [ axFormat "%b" ] ]
                << position Y [ pName "maxTemp", pAggregate opMax ]
    in
    toVegaLite [ width 400, data, trans [], enc [], line [ maPoint (pmMarker [ maFill "black" ]) ] ]


transform18 : Spec
transform18 =
    let
        dateTime mnt =
            "Sun, 01 Jan 2012 00:0" ++ String.fromInt mnt ++ ":00"

        data =
            dataFromColumns []
                << dataColumn "date" (List.map dateTime (List.range 1 15) |> strs)
                << dataColumn "distance" (nums [ 1, 1, 2, 1, 4, 2, 5, 2, 6, 4, 1, 1, 3, 0, 2, 3 ])

        enc =
            encoding
                << position X [ pName "date", pTimeUnit (utc minutes |> tuStep 5) ]
                << position Y [ pName "distance", pAggregate opSum ]
    in
    toVegaLite [ data [], enc [], bar [] ]


transform19 : Spec
transform19 =
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


transform20 : Spec
transform20 =
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



{- Ids and specifications to be provided to the Vega-Lite runtime. -}


specs : List ( String, Spec )
specs =
    [ ( "transform1", transform1 )
    , ( "transform2", transform2 )
    , ( "transform3", transform3 )
    , ( "transform4", transform4 )
    , ( "transform5", transform5 )
    , ( "transform6", transform6 )
    , ( "transform7", transform7 )
    , ( "transform8", transform8 )
    , ( "transform9", transform9 )
    , ( "transform10", transform10 )
    , ( "transform11", transform11 )
    , ( "transform12", transform12 )
    , ( "transform13", transform13 )
    , ( "transform14", transform14 )
    , ( "transform15", transform15 )
    , ( "transform16", transform16 )
    , ( "transform17", transform17 )
    , ( "transform18", transform18 )
    , ( "transform19", transform19 )
    , ( "transform20", transform20 )
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
