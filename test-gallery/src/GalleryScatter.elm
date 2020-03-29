port module GalleryScatter exposing (elmToJS)

import Platform
import VegaLite exposing (..)



-- NOTE: All data sources in these examples originally provided at
-- https://github.com/vega/vega-datasets
-- The examples themselves reproduce those at https://vega.github.io/vega-lite/examples/


base : String
base =
    "https://vega.github.io/vega-lite/data/"


scatter1 : Spec
scatter1 =
    let
        des =
            description "A scatterplot showing horsepower and miles per gallon for various cars (via point marks)."

        data =
            dataFromUrl (base ++ "cars.json") []

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]
    in
    toVegaLite
        [ des, data, enc [], point [ maTooltip ttData ] ]


scatter2 : Spec
scatter2 =
    let
        des =
            description "Shows the distribution of a single variable (precipitation) using tick marks."

        data =
            dataFromUrl (base ++ "seattle-weather.csv") []

        enc =
            encoding
                << position X [ pName "precipitation", pQuant ]
    in
    toVegaLite
        [ des, data, enc [], tick [] ]


scatter3 : Spec
scatter3 =
    let
        des =
            description "Shows the relationship between horsepower and the number of cylinders using tick marks."

        data =
            dataFromUrl (base ++ "cars.json") []

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Cylinders", pOrdinal ]
    in
    toVegaLite
        [ des, data, enc [], tick [] ]


scatter4 : Spec
scatter4 =
    let
        des =
            description "A scatterplot showing horsepower and miles per gallon with country of origin double encoded by colour and shape."

        data =
            dataFromUrl (base ++ "cars.json") []

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]
                << color [ mName "Origin", mNominal ]
                << shape [ mName "Origin", mNominal ]
    in
    toVegaLite
        [ des, data, enc [], point [] ]


scatter5 : Spec
scatter5 =
    let
        des =
            description "A binned scatterplot comparing IMDB and Rotten Tomatoes rating with marks sized by number of reviews."

        data =
            dataFromUrl (base ++ "movies.json") []

        enc =
            encoding
                << position X [ pName "IMDB_Rating", pQuant, pBin [ biMaxBins 10 ] ]
                << position Y [ pName "Rotten_Tomatoes_Rating", pQuant, pBin [ biMaxBins 10 ] ]
                << size [ mAggregate opCount, mQuant ]
    in
    toVegaLite
        [ des, data, enc [], circle [] ]


scatter6 : Spec
scatter6 =
    let
        des =
            description "A bubbleplot showing horsepower on x, miles per gallons on y, and acceleration on size."

        data =
            dataFromUrl (base ++ "cars.json") []

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]
                << size [ mName "Acceleration", mQuant ]
    in
    toVegaLite
        [ des, data, enc [], point [] ]


scatter7 : Spec
scatter7 =
    let
        des =
            description "Scatterplot with Null values in grey"

        cfg =
            configure
                << configuration (coMark [ maRemoveInvalid False ])

        data =
            dataFromUrl (base ++ "movies.json") []

        enc =
            encoding
                << position X [ pName "IMDB_Rating", pQuant ]
                << position Y [ pName "Rotten_Tomatoes_Rating", pQuant ]
                << color
                    [ mDataCondition
                        [ ( expr "datum.IMDB_Rating === null || datum.Rotten_Tomatoes_Rating === null"
                          , [ mStr "#ddd" ]
                          )
                        ]
                        [ mStr "rgb(76,120,168)" ]
                    ]
    in
    toVegaLite
        [ des, cfg [], data, enc [], point [] ]


scatter8 : Spec
scatter8 =
    let
        des =
            description "A scatterplot showing horsepower and miles per gallon for various cars (via circle marks)."

        data =
            dataFromUrl (base ++ "cars.json") []

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]
    in
    toVegaLite
        [ des, data, enc [], circle [] ]


scatter9 : Spec
scatter9 =
    let
        des =
            description "A bubble plot showing the correlation between health and income for 187 countries in the world (modified from an example in Lisa Charlotte Rost's blog post 'One Chart, Twelve Charting Libraries' --http://lisacharlotterost.github.io/2016/05/17/one-chart-code/)."

        data =
            dataFromUrl (base ++ "gapminder-health-income.csv") []

        enc =
            encoding
                << position X [ pName "income", pQuant, pScale [ scType scLog ] ]
                << position Y [ pName "health", pQuant, pScale [ scZero False ] ]
                << size [ mName "population", mQuant ]
                << color [ mStr "#000" ]

        sel =
            selection << select "view" seInterval [ seBindScales ]
    in
    toVegaLite [ des, width 500, height 300, data, enc [], sel [], circle [] ]


scatter10 : Spec
scatter10 =
    let
        des =
            description "Visualization of global deaths from natural disasters. Copy of chart from https://ourworldindata.org/natural-catastrophes"

        data =
            dataFromUrl (base ++ "disasters.csv") []

        trans =
            transform
                << filter (fiExpr "datum.Entity !== 'All natural disasters'")

        enc =
            encoding
                << position X [ pName "Year", pOrdinal, pAxis [ axLabelAngle 0 ] ]
                << position Y [ pName "Entity", pNominal, pAxis [ axTitle "" ] ]
                << size
                    [ mName "Deaths"
                    , mQuant
                    , mLegend [ leTitle "Annual Global Deaths" ]
                    , mScale [ scRange (raNums [ 0, 5000 ]) ]
                    ]
                << color [ mName "Entity", mNominal, mLegend [] ]
    in
    toVegaLite
        [ des
        , width 600
        , height 400
        , data
        , trans []
        , enc []
        , circle [ maOpacity 0.8, maStroke "black", maStrokeWidth 1 ]
        ]


scatter11 : Spec
scatter11 =
    let
        des =
            description "A scatterplot showing horsepower and miles per gallon with country of origin double encoded by colour and text symbol."

        data =
            dataFromUrl (base ++ "cars.json") []

        trans =
            transform
                << calculateAs "datum.Origin[0]" "OriginInitial"

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]
                << color [ mName "Origin", mNominal ]
                << text [ tName "OriginInitial", tNominal ]
    in
    toVegaLite [ des, data, trans [], enc [], textMark [] ]


scatter12 : Spec
scatter12 =
    let
        des =
            description "A scatterplot with a loess trendline overlaid."

        data =
            dataFromUrl (base ++ "movies.json") []

        trans =
            transform
                << loess "IMDB_Rating" "Rotten_Tomatoes_Rating" [ lsBandwidth 0.1 ]

        enc =
            encoding
                << position X [ pName "Rotten_Tomatoes_Rating", pQuant ]
                << position Y [ pName "IMDB_Rating", pQuant ]

        pointSpec =
            asSpec [ point [ maFilled True, maOpacity 0.3 ] ]

        trendSpec =
            asSpec [ trans [], line [ maColor "firebrick" ] ]
    in
    toVegaLite [ des, width 300, height 300, data, enc [], layer [ pointSpec, trendSpec ] ]


scatter13 : Spec
scatter13 =
    let
        des =
            description "A scatterplot with a cubic polynomial regression line overlaid limited to the range of 10% to 90% of Rotten Tomatoes ratings"

        data =
            dataFromUrl (base ++ "movies.json") []

        trans =
            transform
                << regression "IMDB_Rating"
                    "Rotten_Tomatoes_Rating"
                    [ rgMethod rgPoly, rgOrder 3, rgExtent (num 10) (num 90) ]

        enc =
            encoding
                << position X [ pName "Rotten_Tomatoes_Rating", pQuant ]
                << position Y [ pName "IMDB_Rating", pQuant ]

        pointSpec =
            asSpec [ point [ maFilled True, maOpacity 0.3 ] ]

        regSpec =
            asSpec [ trans [], line [ maColor "firebrick" ] ]
    in
    toVegaLite [ des, width 300, height 300, data, enc [], layer [ pointSpec, regSpec ] ]


scatter14 : Spec
scatter14 =
    let
        des =
            description "A simple scatterplot using images as point symbols"

        data =
            dataFromColumns []
                << dataColumn "x" (nums [ 0.5, 1.5, 2.5 ])
                << dataColumn "y" (nums [ 0.5, 1.5, 2.5 ])
                << dataColumn "img" (strs [ base ++ "ffox.png", base ++ "gimp.png", base ++ "7zip.png" ])

        enc =
            encoding
                << position X [ pName "x", pQuant ]
                << position Y [ pName "y", pQuant ]
                << url [ hName "img", hNominal ]
    in
    toVegaLite [ des, data [], enc [], image [ maWidth 25, maHeight 25 ] ]



{- This list comprises the specifications to be provided to the Vega-Lite runtime. -}


mySpecs : Spec
mySpecs =
    combineSpecs
        [ ( "scatter1", scatter1 )
        , ( "scatter2", scatter2 )
        , ( "scatter3", scatter3 )
        , ( "scatter4", scatter4 )
        , ( "scatter5", scatter5 )
        , ( "scatter6", scatter6 )
        , ( "scatter7", scatter7 )
        , ( "scatter8", scatter8 )
        , ( "scatter9", scatter9 )
        , ( "scatter10", scatter10 )
        , ( "scatter11", scatter11 )
        , ( "scatter12", scatter12 )
        , ( "scatter13", scatter13 )
        , ( "scatter14", scatter14 )
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
