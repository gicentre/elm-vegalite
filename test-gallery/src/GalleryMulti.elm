port module GalleryMulti exposing (elmToJS)

import Platform
import VegaLite exposing (..)



-- NOTE: All data sources in these examples originally provided at
-- https://github.com/vega/vega-datasets
-- The examples themselves reproduce those at https://vega.github.io/vega-lite/examples/


path : String
path =
    "https://cdn.jsdelivr.net/npm/vega-datasets@2.1/data/"


multi1 : Spec
multi1 =
    let
        desc =
            description "Overview and detail."

        data =
            dataFromUrl (path ++ "sp500.csv") []

        sel =
            selection << select "myBrush" seInterval [ seEncodings [ chX ] ]

        enc1 =
            encoding
                << position X
                    [ pName "date"
                    , pTemporal
                    , pScale [ scDomain (doSelection "myBrush") ]
                    , pTitle ""
                    ]
                << position Y [ pName "price", pQuant ]

        spec1 =
            asSpec [ width 500, area [], enc1 [] ]

        enc2 =
            encoding
                << position X [ pName "date", pTemporal, pAxis [ axTitle "", axFormat "%Y" ] ]
                << position Y
                    [ pName "price"
                    , pQuant
                    , pAxis [ axTickCount (niTickCount 3), axGrid False ]
                    ]

        spec2 =
            asSpec [ width 480, height 60, sel [], area [], enc2 [] ]
    in
    toVegaLite [ desc, data, vConcat [ spec1, spec2 ] ]


multi2 : Spec
multi2 =
    let
        desc =
            description "Cross-filter."

        data =
            dataFromUrl (path ++ "flights-2k.json") [ parse [ ( "date", foDate "" ) ] ]

        trans =
            transform
                << calculateAs "hours(datum.date)" "time"

        encPosition =
            encoding
                << position X [ pRepeat arColumn, pBin [ biMaxBins 20 ] ]
                << position Y [ pAggregate opCount ]

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
        [ desc
        , data
        , trans []
        , repeat [ columnFields [ "distance", "delay", "time" ] ]
        , specification (asSpec [ layer [ specAll, specSelection ] ])
        ]


multi3 : Spec
multi3 =
    let
        desc =
            description "Scatterplot matrix"

        data =
            dataFromUrl (path ++ "cars.json") []

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
                        [ mName "Origin" ]
                        [ mStr "grey" ]
                    ]
    in
    toVegaLite
        [ desc
        , repeat
            [ rowFields [ "Horsepower", "Acceleration", "Miles_per_Gallon" ]
            , columnFields [ "Miles_per_Gallon", "Acceleration", "Horsepower" ]
            ]
        , specification (asSpec [ data, enc [], sel [], point [] ])
        ]


multi4 : Spec
multi4 =
    let
        desc =
            description "A dashboard with cross-highlighting"

        cfg =
            configure
                << configuration (coRange [ racoHeatmap "greenblue" ])
                << configuration (coView [ vicoStroke Nothing ])

        data =
            dataFromUrl (path ++ "movies.json") []

        trans =
            transform
                << filter (fiExpr "isValid(datum['Major Genre'])")

        selTrans =
            transform
                << filter (fiSelection "myPts")

        encPosition =
            encoding
                << position X
                    [ pName "IMDB Rating"
                    , pTitle "IMDB Rating"
                    , pBin [ biMaxBins 10 ]
                    ]
                << position Y
                    [ pName "Rotten Tomatoes Rating"
                    , pTitle "Rotten Tomatoes Rating"
                    , pBin [ biMaxBins 10 ]
                    ]

        enc1 =
            encoding
                << color
                    [ mAggregate opCount
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
                << size [ mAggregate opCount, mTitle "in selected genre" ]
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
                << position X [ pName "Major Genre", pAxis [ axTitle "", axLabelAngle -40 ] ]
                << position Y [ pAggregate opCount, pTitle "Number of films" ]
                << color
                    [ mSelectionCondition (selectionName "myPts")
                        [ mStr "steelblue" ]
                        [ mStr "grey" ]
                    ]

        res =
            resolve
                << resolution
                    (reLegend
                        [ ( chColor, reIndependent )
                        , ( chSize, reIndependent )
                        ]
                    )
    in
    toVegaLite [ desc, cfg [], data, trans [], res [], vConcat [ heatSpec, barSpec ] ]


multi5 : Spec
multi5 =
    let
        desc =
            description "A dashboard with cross-highlighting"

        data =
            dataFromUrl (path ++ "seattle-weather.csv") []

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
                    , pTitle "Maximum Daily Temperature (C)"
                    ]
                << color
                    [ mSelectionCondition (selectionName "myBrush")
                        [ mName "weather"
                        , mTitle "Weather"
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
                << position X [ pAggregate opCount ]
                << position Y [ pName "weather" ]
                << color
                    [ mSelectionCondition (selectionName "myClick")
                        [ mName "weather", mScale weatherColors ]
                        [ mStr "#acbf98" ]
                    ]
    in
    toVegaLite
        [ title "Seattle Weather, 2012-2015" []
        , desc
        , data
        , vConcat [ spec1, spec2 ]
        ]


multi6 : Spec
multi6 =
    let
        desc =
            description "Drag a rectangular brush to show (first 20) selected points in a table."

        data =
            dataFromUrl (path ++ "cars.json") []

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
                << text [ tName "Horsepower" ]

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
                << text [ tName "Miles_per_Gallon" ]

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
                << text [ tName "Origin" ]

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
        [ desc
        , cfg []
        , data
        , trans []
        , res []
        , hConcat [ specPoint, specHPText, specMPGText, specOriginText ]
        ]


multi7 : Spec
multi7 =
    let
        desc =
            description "One dot per airport in the US overlayed on geoshape"

        dataBoundaries =
            dataFromUrl (path ++ "us-10m.json") [ topojsonFeature "states" ]

        dataAirports =
            dataFromUrl (path ++ "airports.csv") []

        dataFlights =
            dataFromUrl (path ++ "flights-airport.csv") []

        cfg =
            configure
                << configuration (coView [ vicoStroke Nothing ])

        backdropSpec =
            asSpec
                [ dataBoundaries
                , geoshape [ maFill "#ddd", maStroke "#fff" ]
                ]

        lineTrans =
            transform
                << filter (fiSelection "mySelection")
                << lookup "origin" dataAirports "iata" (luAs "o")
                << lookup "destination" dataAirports "iata" (luAs "d")

        lineEnc =
            encoding
                << position Longitude [ pName "o.longitude" ]
                << position Latitude [ pName "o.latitude" ]
                << position Longitude2 [ pName "d.longitude" ]
                << position Latitude2 [ pName "d.latitude" ]

        lineSpec =
            asSpec
                [ dataFlights
                , lineTrans []
                , lineEnc []
                , rule [ maColor "black", maOpacity 0.35 ]
                ]

        airportTrans =
            transform
                << aggregate [ opAs opCount "" "routes" ] [ "origin" ]
                << lookup "origin"
                    dataAirports
                    "iata"
                    (luFields [ "state", "latitude", "longitude" ])
                << filter (fiExpr "datum.state !== 'PR' && datum.state !== 'VI'")

        airportEnc =
            encoding
                << position Longitude [ pName "longitude" ]
                << position Latitude [ pName "latitude" ]
                << size [ mName "routes", mQuant, mScale [ scRange (raNums [ 0, 1000 ]) ], mLegend [] ]
                << order [ oName "routes", oQuant, oSort [ soDescending ] ]

        sel =
            selection
                << select "mySelection" seSingle [ seOn "mouseover", seNearest True, seEmpty, seFields [ "origin" ] ]

        airportSpec =
            asSpec [ dataFlights, airportTrans [], sel [], airportEnc [], circle [] ]
    in
    toVegaLite
        [ desc
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
            dataFromUrl (path ++ "flights-5k.json") [ parse [ ( "date", foDate "" ) ] ]

        trans =
            transform
                << calculateAs "hours(datum.date) + minutes(datum.date) / 60" "time"

        sel =
            selection
                << select "brush" seInterval [ seEncodings [ chX ] ]

        enc1 =
            encoding
                << position X [ pName "time", pBin [ biMaxBins 30 ] ]
                << position Y [ pAggregate opCount ]

        spec1 =
            asSpec [ width 963, height 100, sel [], enc1 [], bar [] ]

        enc2 =
            encoding
                << position X
                    [ pName "time"
                    , pBin [ biMaxBins 30, biSelectionExtent "brush" ]
                    ]
                << position Y [ pAggregate opCount ]

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
