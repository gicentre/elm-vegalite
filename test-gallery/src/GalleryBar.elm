port module GalleryBar exposing (elmToJS)

import Dict exposing (Dict)
import Platform
import VegaLite exposing (..)



-- NOTE: All data sources in these examples originally provided at
-- https://github.com/vega/vega-datasets
-- The examples themselves reproduce those at https://vega.github.io/vega-lite/examples/


path : String
path =
    "https://cdn.jsdelivr.net/npm/vega-datasets@2.1/data/"


bar1 : Spec
bar1 =
    let
        desc =
            description "A simple bar chart with embedded data."

        data =
            dataFromColumns []
                << dataColumn "a" (strs [ "A", "B", "C", "D", "E", "F", "G", "H", "I" ])
                << dataColumn "b" (nums [ 28, 55, 43, 91, 81, 53, 19, 87, 52 ])

        enc =
            encoding
                << position X [ pName "a", pOrdinal ]
                << position Y [ pName "b", pQuant ]
    in
    toVegaLite [ desc, data [], enc [], bar [] ]


bar2 : Spec
bar2 =
    let
        desc =
            description "A bar chart showing the US population distribution of age groups in 2000."

        data =
            dataFromUrl (path ++ "population.json") []

        trans =
            transform << filter (fiExpr "datum.year == 2000")

        enc =
            encoding
                << position X [ pName "people", pAggregate opSum, pTitle "population" ]
                << position Y [ pName "age", pOrdinal ]
    in
    toVegaLite [ desc, heightStep 17, data, trans [], enc [], bar [] ]


bar3 : Spec
bar3 =
    let
        desc =
            description "A bar chart showing the US population distribution of age groups in 2000, sorted by population"

        data =
            dataFromUrl (path ++ "population.json") []

        trans =
            transform << filter (fiExpr "datum.year == 2000")

        enc =
            encoding
                << position X [ pName "people", pAggregate opSum, pTitle "population" ]
                << position Y [ pName "age", pOrdinal, pSort [ soByChannel chX, soDescending ] ]
    in
    toVegaLite [ desc, heightStep 17, data, trans [], enc [], bar [] ]


bar4 : Spec
bar4 =
    let
        desc =
            description "Simple histogram of IMDB ratings."

        data =
            dataFromUrl (path ++ "movies.json") []

        enc =
            encoding
                << position X [ pName "IMDB Rating", pQuant, pBin [] ]
                << position Y [ pAggregate opCount ]
    in
    toVegaLite
        [ desc, data, enc [], bar [] ]


bar5 : Spec
bar5 =
    let
        data =
            dataFromColumns []
                << dataColumn "binStart" (nums [ 8, 10, 12, 14, 16, 18, 20, 22 ])
                << dataColumn "binEnd" (nums [ 10, 12, 14, 16, 18, 20, 22, 24 ])
                << dataColumn "count" (nums [ 7, 29, 71, 127, 94, 54, 17, 5 ])

        enc =
            encoding
                << position X [ pName "binStart", pQuant, pBin [ biStep 2 ] ]
                << position X2 [ pName "binEnd" ]
                << position Y [ pName "count", pQuant ]
    in
    toVegaLite [ data [], enc [], bar [] ]


bar6 : Spec
bar6 =
    let
        desc =
            description "Log-scaled Histogram"

        data =
            dataFromColumns []
                << dataColumn "x" (nums [ 0.01, 0.1, 1, 1, 1, 1, 10, 10, 100, 500, 800 ])

        trans =
            transform
                << calculateAs "log(datum.x)/log(10)" "logX"
                << binAs [] "logX" "binLogX"
                << calculateAs "pow(10,datum.binLogX)" "x1"
                << calculateAs "pow(10,datum.binLogX_end)" "x2"

        enc =
            encoding
                << position X
                    [ pName "x1"
                    , pQuant
                    , pScale [ scType scLog, scBase 10 ]
                    , pAxis [ axTickCount (niTickCount 5) ]
                    ]
                << position X2 [ pName "x2" ]
                << position Y [ pAggregate opCount ]
    in
    toVegaLite [ desc, data [], trans [], enc [], bar [] ]


bar7 : Spec
bar7 =
    let
        desc =
            description "Grouped bar chart showing population structure by age and gender."

        data =
            dataFromUrl (path ++ "population.json") []

        trans =
            transform
                << filter (fiExpr "datum.year == 2000")
                << calculateAs "datum.sex == 2 ? 'Female' : 'Male'" "gender"

        enc =
            encoding
                << position X [ pName "gender", pTitle "" ]
                << position Y
                    [ pName "people"
                    , pAggregate opSum
                    , pAxis [ axTitle "population", axGrid False ]
                    ]
                << column [ fName "age", fOrdinal, fSpacing 10 ]
                << color
                    [ mName "gender"
                    , mScale [ scRange (raStrs [ "#675193", "#ca8861" ]) ]
                    , mTitle ""
                    ]

        cfg =
            configure
                << configuration (coAxis [ axcoDomainWidth 1 ])
                << configuration (coView [ vicoStroke Nothing ])
    in
    toVegaLite [ desc, cfg [], widthStep 12, data, trans [], enc [], bar [] ]


weatherColors : List ScaleProperty
weatherColors =
    categoricalDomainMap
        [ ( "sun", "#e7ba52" )
        , ( "fog", "#c7c7c7" )
        , ( "drizzle", "#aec7ea" )
        , ( "rain", "#1f77b4" )
        , ( "snow", "#9467bd" )
        ]


weatherBars : List MarkProperty -> Spec
weatherBars mProps =
    let
        desc =
            description "Seattle weather stacked bar chart"

        data =
            dataFromUrl (path ++ "seattle-weather.csv") []

        enc =
            encoding
                << position X
                    [ pName "date"
                    , pOrdinal
                    , pTimeUnit month
                    , pAxis [ axTitle "", axLabelAngle 0, axTicks False ]
                    ]
                << position Y
                    [ pAggregate opCount
                    , pAxis [ axGrid False, axTitle "Number of days" ]
                    ]
                << color
                    [ mName "weather"
                    , mScale weatherColors
                    , mTitle ""
                    ]
    in
    toVegaLite [ desc, width 300, data, enc [], bar mProps ]


bar8 : Spec
bar8 =
    weatherBars []


bar9 : Spec
bar9 =
    weatherBars [ maCornerRadiusTopLeft 3, maCornerRadiusTopRight 3 ]


bar10 : Spec
bar10 =
    let
        desc =
            description "Seattle precipitation bar chart with abbreviated labels"

        data =
            dataFromUrl (path ++ "seattle-weather.csv") []

        enc =
            encoding
                << position X
                    [ pName "date"
                    , pOrdinal
                    , pTimeUnit month
                    , pAxis
                        [ axTitle ""
                        , axGrid False
                        , axLabelAngle 0
                        , axLabelExpr "datum.label[0]"
                        , axTicks False
                        ]
                    ]
                << position Y
                    [ pName "precipitation"
                    , pAggregate opMean
                    , pAxis [ axGrid False, axTitle "Average number of days with rain" ]
                    ]
    in
    toVegaLite [ desc, width 300, data, enc [], bar [] ]


bar11 : Spec
bar11 =
    let
        desc =
            description "A bar chart with negative values. We can hide the axis domain line, and instead use a conditional grid colour to draw a zero baseline."

        data =
            dataFromColumns []
                << dataColumn "a" (strs [ "A", "B", "C", "D", "E", "F", "G", "H", "I" ])
                << dataColumn "b" (nums [ -28, 55, -33, 91, 81, 53, -19, 87, 52 ])

        enc =
            encoding
                << position X
                    [ pName "a"
                    , pOrdinal
                    , pAxis [ axDomain False, axTicks False, axLabelAngle 0, axLabelPadding 4 ]
                    ]
                << position Y
                    [ pName "b"
                    , pQuant
                    , pAxis [ axDataCondition (expr "datum.value == 0") (cAxGridColor "black" "#ddd") ]
                    ]
    in
    toVegaLite [ desc, data [], enc [], bar [] ]


bar12 : Spec
bar12 =
    let
        desc =
            description "Barley crop yields as a horizontal stacked bar chart"

        data =
            dataFromUrl (path ++ "barley.json") []

        enc =
            encoding
                << position X [ pName "yield", pAggregate opSum ]
                << position Y [ pName "variety" ]
                << color [ mName "site" ]
    in
    toVegaLite [ desc, data, enc [], bar [] ]


bar13 : Spec
bar13 =
    let
        desc =
            description "Population structure as a normalised stacked bar chart."

        data =
            dataFromUrl (path ++ "population.json") []

        trans =
            transform
                << filter (fiExpr "datum.year == 2000")
                << calculateAs "datum.sex == 2 ? 'Female' : 'Male'" "gender"

        enc =
            encoding
                << position X [ pName "age", pOrdinal ]
                << position Y [ pName "people", pAggregate opSum, pTitle "Population", pStack stNormalize ]
                << color [ mName "gender", mScale [ scRange (raStrs [ "#675193", "#ca8861" ]) ] ]
    in
    toVegaLite [ desc, widthStep 17, data, trans [], enc [], bar [] ]


bar14 : Spec
bar14 =
    let
        desc =
            description "A simple bar chart with ranged data (aka Gantt Chart)."

        data =
            dataFromColumns []
                << dataColumn "task" (strs [ "A", "B", "C" ])
                << dataColumn "start" (nums [ 1, 3, 8 ])
                << dataColumn "end" (nums [ 3, 8, 10 ])

        enc =
            encoding
                << position Y [ pName "task", pOrdinal ]
                << position X [ pName "start", pQuant ]
                << position X2 [ pName "end" ]
    in
    toVegaLite [ desc, data [], enc [], bar [] ]


bar15 : Spec
bar15 =
    let
        desc =
            description "A bar chart that directly encodes color names in the data."

        data =
            dataFromColumns []
                << dataColumn "color" (strs [ "red", "green", "blue" ])
                << dataColumn "b" (nums [ 28, 55, 43 ])

        enc =
            encoding
                << position X [ pName "color" ]
                << position Y [ pName "b", pQuant ]
                << color [ mName "color", mScale [] ]
    in
    toVegaLite [ desc, data [], enc [], bar [] ]


bar16 : Spec
bar16 =
    let
        desc =
            description "Layered bar chart showing the US population distribution of age groups and gender in 2000."

        data =
            dataFromUrl (path ++ "population.json") []

        trans =
            transform
                << filter (fiExpr "datum.year == 2000")
                << calculateAs "datum.sex == 2 ? 'Female' : 'Male'" "gender"

        enc =
            encoding
                << position X [ pName "age", pOrdinal ]
                << position Y [ pName "people", pAggregate opSum, pTitle "Population", pStack stNone ]
                << color
                    [ mName "gender"
                    , mScale [ scRange (raStrs [ "#675193", "#ca8861" ]) ]
                    ]
                << opacity [ mNum 0.7 ]
    in
    toVegaLite [ desc, widthStep 17, data, trans [], enc [], bar [] ]


bar17 : Spec
bar17 =
    let
        data =
            dataFromUrl (path ++ "population.json") []

        trans =
            transform
                << filter (fiExpr "datum.year == 2000")
                << calculateAs "datum.sex == 2 ? 'Female' : 'Male'" "gender"
                << calculateAs "datum.sex == 2 ? -datum.people : datum.people" "signedPeople"

        enc =
            encoding
                << position Y
                    [ pName "age"
                    , pOrdinal
                    , pAxis []
                    , pSort [ soDescending ]
                    ]
                << position X
                    [ pName "signedPeople"
                    , pAggregate opSum
                    , pAxis [ axTitle "Population", axFormat "s" ]
                    ]
                << color
                    [ mName "gender"
                    , mScale [ scRange (raStrs [ "#675193", "#ca8861" ]) ]
                    , mLegend [ leOrient loTop, leTitle "" ]
                    ]

        cfg =
            configure
                << configuration (coView [ vicoStroke Nothing ])
                << configuration (coAxis [ axcoGrid False ])
    in
    toVegaLite [ width 300, height 200, cfg [], data, trans [], enc [], bar [] ]


bar18 : Spec
bar18 =
    let
        desc =
            description "A diverging stacked bar chart for sentiments towards a set of eight questions, displayed as percentages with neutral responses straddling the 0% mark."

        data =
            dataFromColumns []
                << dataColumn "question" (strs [ "Q1", "Q1", "Q1", "Q1", "Q1", "Q2", "Q2", "Q2", "Q2", "Q2", "Q3", "Q3", "Q3", "Q3", "Q3", "Q4", "Q4", "Q4", "Q4", "Q4", "Q5", "Q5", "Q5", "Q5", "Q5", "Q6", "Q6", "Q6", "Q6", "Q6", "Q7", "Q7", "Q7", "Q7", "Q7", "Q8", "Q8", "Q8", "Q8", "Q8" ])
                << dataColumn "type" (strs [ "Strongly disagree", "Disagree", "Neither agree nor disagree", "Agree", "Strongly agree", "Strongly disagree", "Disagree", "Neither agree nor disagree", "Agree", "Strongly agree", "Strongly disagree", "Disagree", "Neither agree nor disagree", "Agree", "Strongly agree", "Strongly disagree", "Disagree", "Neither agree nor disagree", "Agree", "Strongly agree", "Strongly disagree", "Disagree", "Neither agree nor disagree", "Agree", "Strongly agree", "Strongly disagree", "Disagree", "Neither agree nor disagree", "Agree", "Strongly agree", "Strongly disagree", "Disagree", "Neither agree nor disagree", "Agree", "Strongly agree", "Strongly disagree", "Disagree", "Neither agree nor disagree", "Agree", "Strongly agree" ])
                << dataColumn "value" (nums [ 24, 294, 594, 1927, 376, 2, 2, 0, 7, 11, 2, 0, 2, 4, 2, 0, 2, 1, 7, 6, 0, 1, 3, 16, 4, 1, 1, 2, 9, 3, 0, 0, 1, 4, 0, 0, 0, 0, 0, 2 ])
                << dataColumn "percentage" (nums [ 0.7, 9.1, 18.5, 59.9, 11.7, 18.2, 18.2, 0, 63.6, 0, 20, 0, 20, 40, 20, 0, 12.5, 6.3, 43.8, 37.5, 0, 4.2, 12.5, 66.7, 16.7, 6.3, 6.3, 12.5, 56.3, 18.8, 0, 0, 20, 80, 0, 0, 0, 0, 0, 100 ])
                << dataColumn "percentage_start" (nums [ -19.1, -18.4, -9.2, 9.2, 69.2, -36.4, -18.2, 0, 0, 63.6, -30, -10, -10, 10, 50, -15.6, -15.6, -3.1, 3.1, 46.9, -10.4, -10.4, -6.3, 6.3, 72.9, -18.8, -12.5, -6.3, 6.3, 62.5, -10, -10, -10, 10, 90, 0, 0, 0, 0, 0 ])
                << dataColumn "percentage_end" (nums [ -18.4, -9.2, 9.2, 69.2, 80.9, -18.2, 0, 0, 63.6, 63.6, -10, -10, 10, 50, 70, -15.6, -3.1, 3.1, 46.9, 84.4, -10.4, -6.3, 6.3, 72.9, 89.6, -12.5, -6.3, 6.3, 62.5, 81.3, -10, -10, 10, 90, 90, 0, 0, 0, 0, 100 ])

        enc =
            encoding
                << position X [ pName "percentage_start", pQuant, pTitle "Percentage" ]
                << position X2 [ pName "percentage_end" ]
                << position Y
                    [ pName "question"
                    , pAxis [ axTitle "Question", axOffset 5, axTicks False, axMinExtent 60, axDomain False ]
                    ]
                << color
                    [ mName "type"
                    , mLegend [ leTitle "Response" ]
                    , mScale <|
                        scType scOrdinal
                            :: categoricalDomainMap
                                [ ( "Strongly disagree", "#c30d24" )
                                , ( "Disagree", "#f3a583" )
                                , ( "Neither agree nor disagree", "#cccccc" )
                                , ( "Agree", "#94c6da" )
                                , ( "Strongly agree", "#1770ab" )
                                ]
                    ]
    in
    toVegaLite [ desc, data [], enc [], bar [] ]


bar19 : Spec
bar19 =
    let
        desc =
            description "A simple bar chart with embedded data labels."

        data =
            dataFromColumns []
                << dataColumn "a" (strs [ "A", "B", "C" ])
                << dataColumn "b" (nums [ 28, 55, 43 ])

        enc =
            encoding
                << position X [ pName "b", pQuant ]
                << position Y [ pName "a", pOrdinal ]

        specBar =
            asSpec [ bar [] ]

        specText =
            asSpec
                [ textMark [ maStyle [ "label" ] ]
                , encoding (text [ tName "b", tQuant ] [])
                ]

        cfg =
            configure
                << configuration (coMarkStyles [ ( "label", [ maAlign haLeft, maBaseline vaMiddle, maDx 3 ] ) ])
    in
    toVegaLite [ desc, cfg [], data [], enc [], layer [ specBar, specText ] ]


bar20 : Spec
bar20 =
    let
        desc =
            description "Bar chart with label overlay"

        data =
            dataFromUrl (path ++ "movies.json") []

        trans =
            transform
                << calculateAs "isValid(datum['Major Genre'])? datum['Major Genre'] : 'unclassified'" "genre"

        enc =
            encoding
                << position Y
                    [ pName "genre"
                    , pSort
                        [ soCustom
                            (strs
                                [ "Action"
                                , "Adventure"
                                , "Comedy"
                                , "Black Comedy"
                                , "Romantic Comedy"
                                , "Concert/Performance"
                                , "Documentary"
                                , "Drama"
                                , "Horror"
                                , "Musical"
                                , "Thriller/Suspense"
                                , "Western"
                                , "unclassified"
                                ]
                            )
                        ]
                    , pAxis []
                    ]

        encBar =
            encoding
                << position X
                    [ pName "IMDB Rating"
                    , pAggregate opMean
                    , pScale [ scDomain (doNums [ 0, 10 ]) ]
                    , pTitle "Mean IMDB Ratings"
                    ]

        specBar =
            asSpec [ encBar [], bar [ maColor "#ddd" ] ]

        encText =
            encoding
                << text [ tName "genre" ]
                << detail [ dAggregate opCount ]

        specText =
            asSpec [ encText [], textMark [ maAlign haLeft, maX 5 ] ]
    in
    toVegaLite
        [ desc
        , width 200
        , heightStep 16
        , data
        , trans []
        , enc []
        , layer [ specBar, specText ]
        ]


bar21 : Spec
bar21 =
    let
        desc =
            description "Bar Chart with a spacing-saving y-axis"

        cfg =
            configure
                << configuration (coView [ vicoStroke Nothing ])

        data =
            dataFromUrl (path ++ "cars.json") []

        enc =
            encoding
                << position X [ pAggregate opCount, pAxis [ axGrid False ] ]
                << position Y
                    [ pName "Origin"
                    , pScale [ scPaddingInner 0.2 ]
                    , pAxis
                        [ axTitle ""
                        , axDomain False
                        , axTicks False
                        , axLabelAlign haLeft
                        , axLabelBaseline vaTop
                        , axLabelPadding -5
                        , axLabelColor "white"
                        , axZIndex 1
                        ]
                    ]
    in
    toVegaLite
        [ desc
        , cfg []
        , heightStep 30
        , data
        , enc []
        , bar [ maYOffset 5, maCornerRadiusEnd 2 ]
        ]


bar22 : Spec
bar22 =
    let
        desc =
            description "A Wilkinson dot plot"

        cfg =
            configure
                << configuration (coView [ vicoStroke Nothing ])

        data =
            dataFromColumns []
                << dataColumn "data" (nums [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 3, 3, 4, 4, 4, 4, 4, 4 ])

        trans =
            transform
                << window [ ( [ wiOp woRank, wiField "rank" ], "id" ) ] [ wiGroupBy [ "data" ] ]

        enc =
            encoding
                << position X [ pName "data", pOrdinal ]
                << position Y
                    [ pName "id"
                    , pOrdinal
                    , pAxis []
                    , pSort [ soDescending ]
                    ]
    in
    toVegaLite
        [ desc
        , cfg []
        , height 100
        , data []
        , trans []
        , enc []
        , circle [ maOpacity 1 ]
        ]


toRows : String -> List ( String, Int ) -> List DataRow -> List DataRow
toRows country animalFreqs =
    let
        toRow animal n =
            dataRow
                [ ( "country", str country ), ( "animal", str animal ), ( "col", num <| toFloat n ) ]

        fToCol ( animal, f ) =
            List.foldl (\n -> toRow animal n) [] (List.range 1 f)
    in
    (++) (List.concatMap fToCol animalFreqs)


bar23 : Spec
bar23 =
    let
        isotypes =
            let
                cow =
                    "M4 -2c0 0 0.9 -0.7 1.1 -0.8c0.1 -0.1 -0.1 0.5 -0.3 0.7c-0.2 0.2 1.1 1.1 1.1 1.2c0 0.2 -0.2 0.8 -0.4 0.7c-0.1 0 -0.8 -0.3 -1.3 -0.2c-0.5 0.1 -1.3 1.6 -1.5 2c-0.3 0.4 -0.6 0.4 -0.6 0.4c0 0.1 0.3 1.7 0.4 1.8c0.1 0.1 -0.4 0.1 -0.5 0c0 0 -0.6 -1.9 -0.6 -1.9c-0.1 0 -0.3 -0.1 -0.3 -0.1c0 0.1 -0.5 1.4 -0.4 1.6c0.1 0.2 0.1 0.3 0.1 0.3c0 0 -0.4 0 -0.4 0c0 0 -0.2 -0.1 -0.1 -0.3c0 -0.2 0.3 -1.7 0.3 -1.7c0 0 -2.8 -0.9 -2.9 -0.8c-0.2 0.1 -0.4 0.6 -0.4 1c0 0.4 0.5 1.9 0.5 1.9l-0.5 0l-0.6 -2l0 -0.6c0 0 -1 0.8 -1 1c0 0.2 -0.2 1.3 -0.2 1.3c0 0 0.3 0.3 0.2 0.3c0 0 -0.5 0 -0.5 0c0 0 -0.2 -0.2 -0.1 -0.4c0 -0.1 0.2 -1.6 0.2 -1.6c0 0 0.5 -0.4 0.5 -0.5c0 -0.1 0 -2.7 -0.2 -2.7c-0.1 0 -0.4 2 -0.4 2c0 0 0 0.2 -0.2 0.5c-0.1 0.4 -0.2 1.1 -0.2 1.1c0 0 -0.2 -0.1 -0.2 -0.2c0 -0.1 -0.1 -0.7 0 -0.7c0.1 -0.1 0.3 -0.8 0.4 -1.4c0 -0.6 0.2 -1.3 0.4 -1.5c0.1 -0.2 0.6 -0.4 0.6 -0.4z"

                pig =
                    "M1.2 -2c0 0 0.7 0 1.2 0.5c0.5 0.5 0.4 0.6 0.5 0.6c0.1 0 0.7 0 0.8 0.1c0.1 0 0.2 0.2 0.2 0.2c0 0 -0.6 0.2 -0.6 0.3c0 0.1 0.4 0.9 0.6 0.9c0.1 0 0.6 0 0.6 0.1c0 0.1 0 0.7 -0.1 0.7c-0.1 0 -1.2 0.4 -1.5 0.5c-0.3 0.1 -1.1 0.5 -1.1 0.7c-0.1 0.2 0.4 1.2 0.4 1.2l-0.4 0c0 0 -0.4 -0.8 -0.4 -0.9c0 -0.1 -0.1 -0.3 -0.1 -0.3l-0.2 0l-0.5 1.3l-0.4 0c0 0 -0.1 -0.4 0 -0.6c0.1 -0.1 0.3 -0.6 0.3 -0.7c0 0 -0.8 0 -1.5 -0.1c-0.7 -0.1 -1.2 -0.3 -1.2 -0.2c0 0.1 -0.4 0.6 -0.5 0.6c0 0 0.3 0.9 0.3 0.9l-0.4 0c0 0 -0.4 -0.5 -0.4 -0.6c0 -0.1 -0.2 -0.6 -0.2 -0.5c0 0 -0.4 0.4 -0.6 0.4c-0.2 0.1 -0.4 0.1 -0.4 0.1c0 0 -0.1 0.6 -0.1 0.6l-0.5 0l0 -1c0 0 0.5 -0.4 0.5 -0.5c0 -0.1 -0.7 -1.2 -0.6 -1.4c0.1 -0.1 0.1 -1.1 0.1 -1.1c0 0 -0.2 0.1 -0.2 0.1c0 0 0 0.9 0 1c0 0.1 -0.2 0.3 -0.3 0.3c-0.1 0 0 -0.5 0 -0.9c0 -0.4 0 -0.4 0.2 -0.6c0.2 -0.2 0.6 -0.3 0.8 -0.8c0.3 -0.5 1 -0.6 1 -0.6z"

                sheep =
                    "M-4.1 -0.5c0.2 0 0.2 0.2 0.5 0.2c0.3 0 0.3 -0.2 0.5 -0.2c0.2 0 0.2 0.2 0.4 0.2c0.2 0 0.2 -0.2 0.5 -0.2c0.2 0 0.2 0.2 0.4 0.2c0.2 0 0.2 -0.2 0.4 -0.2c0.1 0 0.2 0.2 0.4 0.1c0.2 0 0.2 -0.2 0.4 -0.3c0.1 0 0.1 -0.1 0.4 0c0.3 0 0.3 -0.4 0.6 -0.4c0.3 0 0.6 -0.3 0.7 -0.2c0.1 0.1 1.4 1 1.3 1.4c-0.1 0.4 -0.3 0.3 -0.4 0.3c-0.1 0 -0.5 -0.4 -0.7 -0.2c-0.3 0.2 -0.1 0.4 -0.2 0.6c-0.1 0.1 -0.2 0.2 -0.3 0.4c0 0.2 0.1 0.3 0 0.5c-0.1 0.2 -0.3 0.2 -0.3 0.5c0 0.3 -0.2 0.3 -0.3 0.6c-0.1 0.2 0 0.3 -0.1 0.5c-0.1 0.2 -0.1 0.2 -0.2 0.3c-0.1 0.1 0.3 1.1 0.3 1.1l-0.3 0c0 0 -0.3 -0.9 -0.3 -1c0 -0.1 -0.1 -0.2 -0.3 -0.2c-0.2 0 -0.3 0.1 -0.4 0.4c0 0.3 -0.2 0.8 -0.2 0.8l-0.3 0l0.3 -1c0 0 0.1 -0.6 -0.2 -0.5c-0.3 0.1 -0.2 -0.1 -0.4 -0.1c-0.2 -0.1 -0.3 0.1 -0.4 0c-0.2 -0.1 -0.3 0.1 -0.5 0c-0.2 -0.1 -0.1 0 -0.3 0.3c-0.2 0.3 -0.4 0.3 -0.4 0.3l0.2 1.1l-0.3 0l-0.2 -1.1c0 0 -0.4 -0.6 -0.5 -0.4c-0.1 0.3 -0.1 0.4 -0.3 0.4c-0.1 -0.1 -0.2 1.1 -0.2 1.1l-0.3 0l0.2 -1.1c0 0 -0.3 -0.1 -0.3 -0.5c0 -0.3 0.1 -0.5 0.1 -0.7c0.1 -0.2 -0.1 -1 -0.2 -1.1c-0.1 -0.2 -0.2 -0.8 -0.2 -0.8c0 0 -0.1 -0.5 0.4 -0.8z"
            in
            Dict.fromList [ ( "cow", cow ), ( "pig", pig ), ( "sheep", sheep ) ]

        desc =
            description "Isotype bar chart inspired by this Only An Ocean Between, 1943. Population Live Stock, p.13."

        cfg =
            configure
                << configuration (coView [ vicoStroke Nothing ])

        data =
            dataFromRows []
                << toRows "Great Britain" [ ( "cattle", 3 ), ( "pigs", 2 ), ( "sheep", 10 ) ]
                << toRows "United States" [ ( "cattle", 9 ), ( "pigs", 6 ), ( "sheep", 7 ) ]

        enc =
            encoding
                << position X [ pName "col", pOrdinal, pAxis [] ]
                << position Y [ pName "animal", pOrdinal, pAxis [] ]
                << row [ fName "country", fHeader [ hdTitle "" ] ]
                << shape
                    [ mName "animal"
                    , mScale <|
                        categoricalDomainMap
                            [ ( "person", Dict.get "person" isotypes |> Maybe.withDefault "circle" )
                            , ( "cattle", Dict.get "cow" isotypes |> Maybe.withDefault "circle" )
                            , ( "pigs", Dict.get "pig" isotypes |> Maybe.withDefault "circle" )
                            , ( "sheep", Dict.get "sheep" isotypes |> Maybe.withDefault "circle" )
                            ]
                    , mLegend []
                    ]
                << color
                    [ mName "animal"
                    , mLegend []
                    , mScale <|
                        categoricalDomainMap
                            [ ( "person", "rgb(162,160,152)" )
                            , ( "cattle", "rgb(194,81,64)" )
                            , ( "pigs", "rgb(93,93,93)" )
                            , ( "sheep", "rgb(91,131,149)" )
                            ]
                    ]
                << opacity [ mNum 1 ]
                << size [ mNum 200 ]
    in
    toVegaLite
        [ desc
        , cfg []
        , width 800
        , height 200
        , data []
        , enc []
        , point [ maFilled True ]
        ]


bar24 : Spec
bar24 =
    let
        desc =
            description "Isotype bar chart using emojis for symbols"

        cfg =
            configure
                << configuration (coView [ vicoStroke Nothing ])

        data =
            dataFromRows []
                << toRows "Great Britain" [ ( "cattle", 3 ), ( "pigs", 2 ), ( "sheep", 10 ) ]
                << toRows "United States" [ ( "cattle", 9 ), ( "pigs", 6 ), ( "sheep", 7 ) ]

        trans =
            transform
                << calculateAs "{'cattle': '🐄', 'pigs': '🐖', 'sheep': '🐏'}[datum.animal]" "emoji"
                << window [ ( [ wiOp woRank ], "rank" ) ] [ wiGroupBy [ "country", "animal" ] ]

        enc =
            encoding
                << position X [ pName "rank", pOrdinal, pAxis [] ]
                << position Y [ pName "animal", pAxis [], pSort [] ]
                << row [ fName "country", fHeader [ hdTitle "" ] ]
                << text [ tName "emoji" ]
                << size [ mNum 65 ]
    in
    toVegaLite
        [ desc
        , cfg []
        , width 800
        , height 200
        , data []
        , trans []
        , enc []
        , textMark [ maBaseline vaMiddle ]
        ]



{- This list comprises the specifications to be provided to the Vega-Lite runtime. -}


mySpecs : Spec
mySpecs =
    combineSpecs
        [ ( "bar1", bar1 )
        , ( "bar2", bar2 )
        , ( "bar3", bar3 )
        , ( "bar4", bar4 )
        , ( "bar5", bar5 )
        , ( "bar6", bar6 )
        , ( "bar7", bar7 )
        , ( "bar8", bar8 )
        , ( "bar9", bar9 )
        , ( "bar10", bar10 )
        , ( "bar11", bar11 )
        , ( "bar12", bar12 )
        , ( "bar13", bar13 )
        , ( "bar14", bar14 )
        , ( "bar15", bar15 )
        , ( "bar16", bar16 )
        , ( "bar17", bar17 )
        , ( "bar18", bar18 )
        , ( "bar19", bar19 )
        , ( "bar20", bar20 )
        , ( "bar21", bar21 )
        , ( "bar22", bar22 )
        , ( "bar23", bar23 )
        , ( "bar24", bar24 )
        ]



{- The code below is boilerplate for creating a headless Elm module that opens
   an outgoing port to Javascript and sends the specs to it.
-}


main : Program () Spec msg
main =
    Platform.worker
        { init = always ( mySpecs, elmToJS mySpecs )
        , update = \_ model -> ( model, Cmd.none )
        , subscriptions = always Sub.none
        }


port elmToJS : Spec -> Cmd msg
