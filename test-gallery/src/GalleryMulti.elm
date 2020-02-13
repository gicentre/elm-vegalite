port module GalleryMulti exposing (elmToJS)

import Platform
import VegaLite exposing (..)



-- NOTE: All data sources in these examples originally provided at
-- https://github.com/vega/vega-datasets
-- The examples themselves reproduce those at https://vega.github.io/vega-lite/examples/


multi1 : Spec
multi1 =
    let
        des =
            description "Overview and detail."

        sel =
            selection << select "myBrush" seInterval [ seEncodings [ chX ] ]

        enc1 =
            encoding
                << position X
                    [ pName "date"
                    , pTemporal
                    , pScale [ scDomain (doSelection "myBrush") ]
                    , pAxis [ axTitle "" ]
                    ]
                << position Y [ pName "price", pQuant ]

        spec1 =
            asSpec [ width 500, area [], enc1 [] ]

        enc2 =
            encoding
                << position X [ pName "date", pTemporal, pAxis [ axFormat "%Y" ] ]
                << position Y
                    [ pName "price"
                    , pQuant
                    , pAxis [ axTickCount 3, axGrid False ]
                    ]

        spec2 =
            asSpec [ width 480, height 60, sel [], area [], enc2 [] ]
    in
    toVegaLite
        [ des
        , dataFromUrl "https://vega.github.io/vega-lite/data/sp500.csv" []
        , vConcat [ spec1, spec2 ]
        ]


multi2 : Spec
multi2 =
    let
        des =
            description "Cross-filter."

        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/flights-2k.json"
                [ parse [ ( "date", foDate "" ) ] ]

        trans =
            transform
                << calculateAs "hours(datum.date)" "time"

        encPosition =
            encoding
                << position X [ pRepeat arColumn, pQuant, pBin [ biMaxBins 20 ] ]
                << position Y [ pAggregate opCount, pQuant ]

        encAll =
            encPosition
                << color [ mStr "#ddd" ]

        specAll =
            asSpec [ encAll [], bar [] ]

        sel =
            selection
                << select "myBrush" seInterval [ seEncodings [ chX ], seSelectionMark [ smFill "steelblue" ] ]

        selTrans =
            transform
                << filter (fiSelection "myBrush")

        specSelection =
            asSpec [ sel [], selTrans [], encPosition [], bar [] ]
    in
    toVegaLite
        [ des
        , data
        , trans []
        , repeat [ columnFields [ "distance", "delay", "time" ] ]
        , specification (asSpec [ layer [ specAll, specSelection ] ])
        ]


multi3 : Spec
multi3 =
    let
        des =
            description "Scatterplot matrix"

        sel =
            selection
                << select "myBrush"
                    seInterval
                    [ seOn "[mousedown[event.shiftKey], window:mouseup] > window:mousemove!"
                    , seTranslate "[mousedown[event.shiftKey], window:mouseup] > window:mousemove!"
                    , seZoom "wheel![event.shiftKey]"
                    , seResolve seUnion
                    ]
                << select "grid"
                    seInterval
                    [ seBindScales
                    , seTranslate "[mousedown[!event.shiftKey], window:mouseup] > window:mousemove!"
                    , seZoom "wheel![event.shiftKey]"
                    , seResolve seGlobal
                    ]

        enc =
            encoding
                << position X [ pRepeat arColumn, pQuant ]
                << position Y [ pRepeat arRow, pQuant ]
                << color
                    [ mSelectionCondition (selectionName "myBrush")
                        [ mName "Origin", mNominal ]
                        [ mStr "grey" ]
                    ]

        spec =
            asSpec
                [ dataFromUrl "https://vega.github.io/vega-lite/data/cars.json" []
                , point []
                , sel []
                , enc []
                ]
    in
    toVegaLite
        [ des
        , repeat
            [ rowFields [ "Horsepower", "Acceleration", "Miles_per_Gallon" ]
            , columnFields [ "Miles_per_Gallon", "Acceleration", "Horsepower" ]
            ]
        , specification spec
        ]


multi4 : Spec
multi4 =
    let
        des =
            description "A dashboard with cross-highlighting"

        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/movies.json" []

        trans =
            transform
                << filter (fiExpr "isValid(datum.Major_Genre)")

        selTrans =
            transform
                << filter (fiSelection "myPts")

        encPosition =
            encoding
                << position X
                    [ pName "IMDB_Rating"
                    , pQuant
                    , pTitle "IMDB Rating"
                    , pBin [ biMaxBins 10 ]
                    ]
                << position Y
                    [ pName "Rotten_Tomatoes_Rating"
                    , pQuant
                    , pTitle "Rotten Tomatoes Rating"
                    , pBin [ biMaxBins 10 ]
                    ]

        enc1 =
            encoding
                << color
                    [ mAggregate opCount
                    , mQuant
                    , mLegend
                        [ leTitle "Number of films"
                        , leDirection moHorizontal
                        , leGradientLength 120
                        ]
                    ]

        spec1 =
            asSpec [ enc1 [], rect [] ]

        enc2 =
            encoding
                << size [ mAggregate opCount, mQuant, mTitle "in selected genre" ]
                << color [ mStr "#666" ]

        spec2 =
            asSpec [ selTrans [], enc2 [], point [] ]

        heatSpec =
            asSpec [ encPosition [], layer [ spec1, spec2 ] ]

        sel =
            selection << select "myPts" seSingle [ seEncodings [ chX ] ]

        barSpec =
            asSpec [ width 420, height 120, sel [], encBar [], bar [] ]

        encBar =
            encoding
                << position X
                    [ pName "Major_Genre"
                    , pNominal
                    , pAxis [ axTitle "", axLabelAngle -40 ]
                    ]
                << position Y [ pAggregate opCount, pQuant, pTitle "Number of films" ]
                << color
                    [ mSelectionCondition (selectionName "myPts")
                        [ mStr "steelblue" ]
                        [ mStr "grey" ]
                    ]

        config =
            configure
                << configuration (coRange [ racoHeatmap "greenblue" ])
                << configuration (coView [ vicoStroke Nothing ])

        res =
            resolve
                << resolution
                    (reLegend
                        [ ( chColor, reIndependent )
                        , ( chSize, reIndependent )
                        ]
                    )
    in
    toVegaLite
        [ des
        , data
        , trans []
        , vConcat [ heatSpec, barSpec ]
        , res []
        , config []
        ]


multi5 : Spec
multi5 =
    let
        des =
            description "A dashboard with cross-highlighting"

        spec1 =
            asSpec
                [ width 600, height 300, point [], sel1 [], trans1 [], enc1 [] ]

        sel1 =
            selection << select "myBrush" seInterval [ seEncodings [ chX ] ]

        trans1 =
            transform << filter (fiSelection "myClick")

        weatherColors =
            categoricalDomainMap
                [ ( "sun", "#e7ba52" )
                , ( "fog", "#c7c7c7" )
                , ( "drizzle", "#aec7ea" )
                , ( "rain", "#1f77b4" )
                , ( "snow", "#9467bd" )
                ]

        enc1 =
            encoding
                << position X
                    [ pName "date"
                    , pTemporal
                    , pTimeUnit monthDate
                    , pAxis [ axTitle "Date", axFormat "%b" ]
                    ]
                << position Y
                    [ pName "temp_max"
                    , pQuant
                    , pScale [ scDomain (doNums [ -5, 40 ]) ]
                    , pAxis [ axTitle "Maximum Daily Temperature (C)" ]
                    ]
                << color
                    [ mSelectionCondition (selectionName "myBrush")
                        [ mName "weather"
                        , mTitle "Weather"
                        , mNominal
                        , mScale weatherColors
                        ]
                        [ mStr "#cfdebe" ]
                    ]
                << size
                    [ mName "precipitation"
                    , mQuant
                    , mScale [ scDomain (doNums [ -1, 50 ]) ]
                    ]

        spec2 =
            asSpec [ width 600, bar [], sel2 [], trans2 [], enc2 [] ]

        sel2 =
            selection << select "myClick" seMulti [ seEncodings [ chColor ] ]

        trans2 =
            transform << filter (fiSelection "myBrush")

        enc2 =
            encoding
                << position X [ pAggregate opCount, pQuant ]
                << position Y [ pName "weather", pNominal ]
                << color
                    [ mSelectionCondition (selectionName "myClick")
                        [ mName "weather"
                        , mNominal
                        , mScale weatherColors
                        ]
                        [ mStr "#acbf98" ]
                    ]
    in
    toVegaLite
        [ title "Seattle Weather, 2012-2015" []
        , des
        , dataFromUrl "https://vega.github.io/vega-lite/data/seattle-weather.csv" []
        , vConcat [ spec1, spec2 ]
        ]


multi6 : Spec
multi6 =
    let
        desc =
            description "Drag a rectangular brush to show (first 20) selected points in a table."

        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/cars.json"

        trans =
            transform
                << window [ ( [ wiOp woRowNumber ], "rowNumber" ) ] []

        sel =
            selection
                << select "brush" seInterval []

        encPoint =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]
                << color
                    [ mSelectionCondition (selectionName "brush")
                        [ mName "Cylinders", mOrdinal ]
                        [ mStr "grey" ]
                    ]

        specPoint =
            asSpec [ sel [], point [], encPoint [] ]

        tableTrans =
            transform
                << filter (fiSelection "brush")
                << window [ ( [ wiOp woRank ], "rank" ) ] []
                << filter (fiLessThan "rank" (num 20))

        encHPText =
            encoding
                << position Y [ pName "rowNumber", pOrdinal, pAxis [] ]
                << text [ tName "Horsepower", tNominal ]

        specHPText =
            asSpec
                [ title "Engine power" []
                , tableTrans []
                , textMark []
                , encHPText []
                ]

        encMPGText =
            encoding
                << position Y [ pName "rowNumber", pOrdinal, pAxis [] ]
                << text [ tName "Miles_per_Gallon", tNominal ]

        specMPGText =
            asSpec
                [ title "Efficiency (mpg)" []
                , tableTrans []
                , textMark []
                , encMPGText []
                ]

        encOriginText =
            encoding
                << position Y [ pName "rowNumber", pOrdinal, pAxis [] ]
                << text [ tName "Origin", tNominal ]

        specOriginText =
            asSpec
                [ title "Country of origin" []
                , tableTrans []
                , textMark []
                , encOriginText []
                ]

        res =
            resolve
                << resolution (reLegend [ ( chColor, reIndependent ) ])

        cfg =
            configure
                << configuration (coView [ vicoStroke Nothing ])
    in
    toVegaLite
        [ cfg []
        , data []
        , trans []
        , res []
        , hConcat [ specPoint, specHPText, specMPGText, specOriginText ]
        ]


multi7 : Spec
multi7 =
    let
        des =
            description "One dot per airport in the US overlayed on geoshape"

        cfg =
            configure
                << configuration (coView [ vicoStroke Nothing ])

        backdropSpec =
            asSpec
                [ dataFromUrl "https://vega.github.io/vega-lite/data/us-10m.json" [ topojsonFeature "states" ]
                , geoshape [ maFill "#ddd", maStroke "#fff" ]
                ]

        lineTrans =
            transform
                << filter (fiSelection "mySelection")
                << lookup "origin"
                    (dataFromUrl "https://vega.github.io/vega-lite/data/airports.csv" [])
                    "iata"
                    (luAs "o")
                << lookup "destination"
                    (dataFromUrl "https://vega.github.io/vega-lite/data/airports.csv" [])
                    "iata"
                    (luAs "d")

        lineEnc =
            encoding
                << position Longitude [ pName "o.longitude", pQuant ]
                << position Latitude [ pName "o.latitude", pQuant ]
                << position Longitude2 [ pName "d.longitude" ]
                << position Latitude2 [ pName "d.latitude" ]

        lineSpec =
            asSpec
                [ dataFromUrl "https://vega.github.io/vega-lite/data/flights-airport.csv" []
                , lineTrans []
                , lineEnc []
                , rule [ maColor "black", maOpacity 0.35 ]
                ]

        airportTrans =
            transform
                << aggregate [ opAs opCount "" "routes" ] [ "origin" ]
                << lookup "origin"
                    (dataFromUrl "https://vega.github.io/vega-lite/data/airports.csv" [])
                    "iata"
                    (luFields [ "state", "latitude", "longitude" ])
                << filter (fiExpr "datum.state !== 'PR' && datum.state !== 'VI'")

        airportEnc =
            encoding
                << position Longitude [ pName "longitude", pQuant ]
                << position Latitude [ pName "latitude", pQuant ]
                << size [ mName "routes", mQuant, mScale [ scRange (raNums [ 0, 1000 ]) ], mLegend [] ]
                << order [ oName "routes", oQuant, oSort [ soDescending ] ]

        sel =
            selection
                << select "mySelection" seSingle [ seOn "mouseover", seNearest True, seEmpty, seFields [ "origin" ] ]

        airportSpec =
            asSpec
                [ dataFromUrl "https://vega.github.io/vega-lite/data/flights-airport.csv" []
                , airportTrans []
                , sel []
                , circle []
                , airportEnc []
                ]
    in
    toVegaLite
        [ des
        , cfg []
        , width 900
        , height 500
        , projection [ prType albersUsa ]
        , layer [ backdropSpec, lineSpec, airportSpec ]
        ]


multi8 : Spec
multi8 =
    let
        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/flights-5k.json"
                [ parse [ ( "date", foDate "" ) ] ]

        trans =
            transform
                << calculateAs "hours(datum.date) + minutes(datum.date) / 60" "time"

        sel =
            selection
                << select "brush" seInterval [ seEncodings [ chX ] ]

        enc1 =
            encoding
                << position X [ pName "time", pBin [ biMaxBins 30 ], pQuant ]
                << position Y [ pAggregate opCount, pQuant ]

        spec1 =
            asSpec [ width 963, height 100, sel [], enc1 [], bar [] ]

        enc2 =
            encoding
                << position X
                    [ pName "time"
                    , pBin [ biMaxBins 30, biSelectionExtent "brush" ]
                    , pQuant
                    ]
                << position Y [ pAggregate opCount, pQuant ]

        spec2 =
            asSpec [ width 963, height 100, enc2 [], bar [] ]
    in
    toVegaLite [ data, trans [], vConcat [ spec1, spec2 ] ]



{- This list comprises the specifications to be provided to the Vega-Lite runtime. -}


mySpecs : Spec
mySpecs =
    combineSpecs
        [ ( "multi1", multi1 )
        , ( "multi2", multi2 )
        , ( "multi3", multi3 )
        , ( "multi4", multi4 )
        , ( "multi5", multi5 )
        , ( "multi6", multi6 )
        , ( "multi7", multi7 )
        , ( "multi8", multi8 )
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
