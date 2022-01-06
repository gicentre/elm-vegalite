port module GalleryScatter exposing (elmToJS)

import Platform
import VegaLite exposing (..)



-- NOTE: All data sources in these examples originally provided at
-- https://github.com/vega/vega-datasets
-- The examples themselves reproduce those at https://vega.github.io/vega-lite/examples/


path : String
path =
    "https://cdn.jsdelivr.net/npm/vega-datasets@2.2/data/"


scatter1 : Spec
scatter1 =
    let
        desc =
            description "A scatterplot showing horsepower and miles per gallon for various cars (via point marks)."

        data =
            dataFromUrl (path ++ "cars.json") []

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]
    in
    toVegaLite
        [ desc, data, enc [], point [ maTooltip ttData ] ]


scatter2 : Spec
scatter2 =
    let
        desc =
            description "Shows the distribution of a single variable (precipitation) using tick marks."

        data =
            dataFromUrl (path ++ "seattle-weather.csv") []

        enc =
            encoding
                << position X [ pName "precipitation", pQuant ]
    in
    toVegaLite
        [ desc, data, enc [], tick [] ]


scatter3 : Spec
scatter3 =
    let
        desc =
            description "Shows the relationship between horsepower and the number of cylinders using tick marks."

        data =
            dataFromUrl (path ++ "cars.json") []

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Cylinders", pOrdinal ]
    in
    toVegaLite
        [ desc, data, enc [], tick [] ]


scatter4 : Spec
scatter4 =
    let
        desc =
            description "A scatterplot showing penguin morphology with species double encoded by colour and shape."

        data =
            dataFromUrl (path ++ "penguins.json") []

        enc =
            encoding
                << position X [ pName "Flipper Length (mm)", pQuant, pScale [ scZero False ] ]
                << position Y [ pName "Body Mass (g)", pQuant, pScale [ scZero False ] ]
                << color [ mName "Species" ]
                << shape [ mName "Species" ]
    in
    toVegaLite
        [ desc, data, enc [], point [] ]


scatter5 : Spec
scatter5 =
    let
        desc =
            description "A binned scatterplot comparing IMDB and Rotten Tomatoes rating with marks sized by number of reviews."

        data =
            dataFromUrl (path ++ "movies.json") []

        enc =
            encoding
                << position X [ pName "IMDB Rating", pBin [ biMaxBins 10 ] ]
                << position Y [ pName "Rotten Tomatoes Rating", pBin [ biMaxBins 10 ] ]
                << size [ mAggregate opCount ]
    in
    toVegaLite
        [ desc, data, enc [], circle [] ]


scatter6 : Spec
scatter6 =
    let
        desc =
            description "A bubbleplot showing horsepower on x, miles per gallons on y, and acceleration on size."

        data =
            dataFromUrl (path ++ "cars.json") []

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]
                << size [ mName "Acceleration", mQuant ]
    in
    toVegaLite
        [ desc, data, enc [], point [] ]


scatter7 : Spec
scatter7 =
    let
        desc =
            description "Scatterplot with Null values in grey"

        cfg =
            configure
                << configuration (coMark [ maRemoveInvalid False ])

        data =
            dataFromUrl (path ++ "movies.json") []

        enc =
            encoding
                << position X [ pName "IMDB Rating", pQuant ]
                << position Y [ pName "Rotten Tomatoes Rating", pQuant ]
                << color
                    [ mCondition (prTest (expr "datum['IMDB Rating'] === null || datum['Rotten Tomatoes Rating'] === null"))
                        [ mStr "#ddd" ]
                        [ mStr "rgb(76,120,168)" ]
                    ]
    in
    toVegaLite
        [ desc, cfg [], data, enc [], point [] ]


scatter8 : Spec
scatter8 =
    let
        desc =
            description "A scatterplot showing horsepower and miles per gallon for various cars (via circle marks)."

        data =
            dataFromUrl (path ++ "cars.json") []

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]
    in
    toVegaLite
        [ desc, data, enc [], circle [] ]


scatter9 : Spec
scatter9 =
    let
        desc =
            description "A bubble plot showing the correlation between health and income for 187 countries in the world (modified from an example in Lisa Charlotte Rost's blog post 'One Chart, Twelve Charting Libraries' --http://lisacharlotterost.github.io/2016/05/17/one-chart-code/)."

        data =
            dataFromUrl (path ++ "gapminder-health-income.csv") []

        enc =
            encoding
                << position X [ pName "income", pScale [ scType scLog ] ]
                << position Y [ pName "health", pQuant, pScale [ scZero False ] ]
                << size [ mName "population", mQuant ]
                << color [ mStr "#000" ]

        ps =
            params << param "view" [ paSelect seInterval [], paBindScales ]
    in
    toVegaLite [ desc, width 500, height 300, data, ps [], enc [], circle [] ]


scatter10 : Spec
scatter10 =
    let
        desc =
            description "Visualization of global deaths from natural disasters. Copy of chart from https://ourworldindata.org/natural-catastrophes"

        data =
            dataFromUrl (path ++ "disasters.csv") []

        trans =
            transform
                << filter (fiExpr "datum.Entity !== 'All natural disasters'")

        enc =
            encoding
                << position X [ pName "Year", pTemporal, pAxis [ axGrid False ] ]
                << position Y [ pName "Entity", pTitle "" ]
                << size
                    [ mName "Deaths"
                    , mQuant
                    , mLegend [ leTitle "Annual Global Deaths", leClipHeight 30 ]
                    , mScale [ scRange (raMax 5000) ]
                    ]
                << color [ mName "Entity", mLegend [] ]
    in
    toVegaLite
        [ desc
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
        desc =
            description "A scatterplot showing horsepower and miles per gallon with country of origin double encoded by colour and text symbol."

        data =
            dataFromUrl (path ++ "cars.json") []

        trans =
            transform
                << calculateAs "datum.Origin[0]" "OriginInitial"

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]
                << color [ mName "Origin" ]
                << text [ tName "OriginInitial" ]
    in
    toVegaLite [ desc, data, trans [], enc [], textMark [] ]


scatter12 : Spec
scatter12 =
    let
        desc =
            description "A scatterplot with a loess trendline overlaid."

        data =
            dataFromUrl (path ++ "movies.json") []

        trans =
            transform
                << loess "IMDB Rating" "Rotten Tomatoes Rating" [ lsBandwidth 0.1 ]

        enc =
            encoding
                << position X [ pName "Rotten Tomatoes Rating", pQuant ]
                << position Y [ pName "IMDB Rating", pQuant ]

        pointSpec =
            asSpec [ point [ maFilled True, maOpacity 0.3 ] ]

        trendSpec =
            asSpec [ trans [], line [ maColor "firebrick" ] ]
    in
    toVegaLite [ desc, width 300, height 300, data, enc [], layer [ pointSpec, trendSpec ] ]


scatter13 : Spec
scatter13 =
    let
        desc =
            description "A scatterplot with a cubic polynomial regression line overlaid limited to the range of 10% to 90% of Rotten Tomatoes ratings"

        data =
            dataFromUrl (path ++ "movies.json") []

        trans =
            transform
                << regression "IMDB Rating"
                    "Rotten Tomatoes Rating"
                    [ rgMethod rgPoly, rgOrder 3, rgExtent 10 90 ]

        enc =
            encoding
                << position X [ pName "Rotten Tomatoes Rating", pQuant ]
                << position Y [ pName "IMDB Rating", pQuant ]

        pointSpec =
            asSpec [ point [ maFilled True, maOpacity 0.3 ] ]

        regSpec =
            asSpec [ trans [], line [ maColor "firebrick" ] ]
    in
    toVegaLite [ desc, width 300, height 300, data, enc [], layer [ pointSpec, regSpec ] ]


scatter14 : Spec
scatter14 =
    let
        desc =
            description "A simple scatterplot using images as point symbols"

        data =
            dataFromColumns []
                << dataColumn "x" (nums [ 0.5, 1.5, 2.5 ])
                << dataColumn "y" (nums [ 0.5, 1.5, 2.5 ])
                << dataColumn "img" (strs [ path ++ "ffox.png", path ++ "gimp.png", path ++ "7zip.png" ])

        enc =
            encoding
                << position X [ pName "x", pQuant ]
                << position Y [ pName "y", pQuant ]
                << url [ hName "img" ]
    in
    toVegaLite [ desc, data [], enc [], image [ maWidth 25, maHeight 25 ] ]


scatter15 : Spec
scatter15 =
    let
        desc =
            description "A custom axis labels for grouping calculated values."

        data =
            dataFromUrl "https://cdn.jsdelivr.net/npm/vega-datasets@2.2/data/movies.json" []

        enc =
            encoding
                << position X
                    [ pName "IMDB Rating"
                    , pAggregate opMean
                    , pScale [ scDomain (doNums [ 0, 10 ]) ]
                    , pAxis
                        [ axTitle ""
                        , axValues (nums [ 0, 5, 10 ])
                        , axLabelExpr "datum.label == 0 ? 'Poor' : datum.label == 5 ? 'Neutral' : 'Great'"
                        , axLabelFlush Nothing
                        ]
                    ]
                << position Y [ pName "Major Genre", pSort [ soByChannel chX ], pTitle "" ]
    in
    toVegaLite [ desc, data, enc [], circle [ maSize 80 ] ]


scatter16 : Spec
scatter16 =
    let
        data2 =
            dataFromUrl (path ++ "cars.json") []

        trans =
            transform
                << calculateAs "random()" "jitter"

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Cylinders" ]
                << position YOffset [ pName "jitter", pQuant ]
    in
    toVegaLite [ heightStep 50, data2, trans [], enc [], point [] ]



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
        , ( "scatter15", scatter15 )
        , ( "scatter16", scatter16 )
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
