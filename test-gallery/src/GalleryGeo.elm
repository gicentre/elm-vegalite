port module GalleryGeo exposing (elmToJS)

import Platform
import VegaLite exposing (..)



-- NOTE: All data sources in these examples originally provided at
-- https://github.com/vega/vega-datasets
-- The examples themselves reproduce those at https://vega.github.io/vega-lite/examples/


path : String
path =
    "https://cdn.jsdelivr.net/npm/vega-datasets@2.1/data/"


{-| No borders around maps
-}
cfg : List LabelledSpec -> ( VLProperty, Spec )
cfg =
    configure
        << configuration (coView [ vicoStroke Nothing ])


proj : ( VLProperty, Spec )
proj =
    projection [ prType albersUsa ]


geo1 : Spec
geo1 =
    let
        countyData =
            dataFromUrl (path ++ "us-10m.json") [ topojsonFeature "counties" ]

        unemploymentData =
            dataFromUrl (path ++ "unemployment.tsv") []

        trans =
            transform
                << lookup "id" unemploymentData "id" (luFields [ "rate" ])

        enc =
            encoding
                << color [ mName "rate", mQuant ]
    in
    toVegaLite [ cfg [], width 500, height 300, countyData, proj, trans [], enc [], geoshape [] ]


geo2 : Spec
geo2 =
    let
        desc =
            description "US zip codes: One dot per zipcode colored by first digit"

        data =
            dataFromUrl (path ++ "zipcodes.csv") []

        trans =
            transform
                << calculateAs "substring(datum.zip_code, 0, 1)" "digit"

        enc =
            encoding
                << position Longitude [ pName "longitude" ]
                << position Latitude [ pName "latitude" ]
                << color [ mName "digit" ]
    in
    toVegaLite [ desc, cfg [], width 500, height 300, data, proj, trans [], enc [], circle [ maSize 1 ] ]


geo3 : Spec
geo3 =
    let
        desc =
            description "One dot per airport in the US overlayed on geoshape"

        mapData =
            dataFromUrl (path ++ "us-10m.json") [ topojsonFeature "states" ]

        airportData =
            dataFromUrl (path ++ "airports.csv") []

        enc =
            encoding
                << color [ mStr "#eee" ]

        backdropSpec =
            asSpec [ mapData, enc [], geoshape [] ]

        overlayEnc =
            encoding
                << position Longitude [ pName "longitude" ]
                << position Latitude [ pName "latitude" ]
                << size [ mNum 5 ]
                << color [ mStr "steelblue" ]

        overlaySpec =
            asSpec [ airportData, overlayEnc [], circle [] ]
    in
    toVegaLite [ desc, cfg [], width 500, height 300, proj, layer [ backdropSpec, overlaySpec ] ]


geo4 : Spec
geo4 =
    let
        desc =
            description "Rules (line segments) connecting SEA to every airport reachable via direct flight"

        mapData =
            dataFromUrl (path ++ "us-10m.json") [ topojsonFeature "states" ]

        airportData =
            dataFromUrl (path ++ "airports.csv") []

        flightData =
            dataFromUrl (path ++ "flights-airport.csv") []

        backdropSpec =
            asSpec [ mapData, geoshape [ maColor "#eee" ] ]

        airportsEnc =
            encoding
                << position Longitude [ pName "longitude" ]
                << position Latitude [ pName "latitude" ]

        airportsSpec =
            asSpec [ airportData, airportsEnc [], circle [ maColor "gray", maSize 5 ] ]

        trans =
            transform
                << filter (fiEqual "origin" (str "SEA"))
                << lookup "origin" airportData "iata" (luAs "o")
                << lookup "destination" airportData "iata" (luAs "d")

        flightsEnc =
            encoding
                << position Longitude [ pName "o.longitude" ]
                << position Latitude [ pName "o.latitude" ]
                << position Longitude2 [ pName "d.longitude" ]
                << position Latitude2 [ pName "d.latitude" ]

        flightsSpec =
            asSpec [ flightData, trans [], flightsEnc [], rule [] ]
    in
    toVegaLite
        [ desc
        , cfg []
        , width 800
        , height 500
        , proj
        , layer [ backdropSpec, airportsSpec, flightsSpec ]
        ]


geo5 : Spec
geo5 =
    let
        desc =
            description "Population per state, engineers per state, and hurricanes per state"

        geoData =
            dataFromUrl (path ++ "us-10m.json") [ topojsonFeature "states" ]

        data =
            dataFromUrl (path ++ "population_engineers_hurricanes.csv") []

        trans =
            transform
                << lookup "id" geoData "id" (luAs "geo")

        enc =
            encoding
                << shape [ mName "geo", mGeo ]
                << color [ mRepeat arRow, mQuant ]

        res =
            resolve
                << resolution (reScale [ ( chColor, reIndependent ) ])
    in
    toVegaLite
        [ cfg []
        , desc
        , repeat [ rowFields [ "population", "engineers", "hurricanes" ] ]
        , res []
        , specification
            (asSpec [ width 500, height 300, data, trans [], proj, enc [], geoshape [] ])
        ]


geo6 : Spec
geo6 =
    let
        desc =
            description "US state capitals overlayed on map of the US"

        mapData =
            dataFromUrl (path ++ "us-10m.json") [ topojsonFeature "states" ]

        capitalData =
            dataFromUrl (path ++ "us-state-capitals.json") []

        backdropSpec =
            asSpec [ mapData, geoshape [ maColor "#ccc" ] ]

        overlayEnc =
            encoding
                << position Longitude [ pName "lon" ]
                << position Latitude [ pName "lat" ]
                << text [ tName "city" ]

        overlaySpec =
            asSpec [ capitalData, overlayEnc [], textMark [] ]
    in
    toVegaLite [ desc, cfg [], width 800, height 500, proj, layer [ backdropSpec, overlaySpec ] ]


geo7 : Spec
geo7 =
    let
        desc =
            description "Line drawn between airports in the U.S. simulating a flight itinerary"

        airportData =
            dataFromUrl (path ++ "airports.csv") []

        mapData =
            dataFromUrl (path ++ "us-10m.json") [ topojsonFeature "states" ]

        itineraryData =
            dataFromColumns []
                << dataColumn "airport" (strs [ "SEA", "SFO", "LAX", "LAS", "DFW", "DEN", "ORD", "JFK", "ATL" ])
                << dataColumn "order" (nums [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ])

        backdropSpec =
            asSpec [ mapData, geoshape [ maColor "#eee" ] ]

        airportsEnc =
            encoding
                << position Longitude [ pName "longitude" ]
                << position Latitude [ pName "latitude" ]

        airportsSpec =
            asSpec [ airportData, airportsEnc [], circle [ maSize 5, maColor "grey" ] ]

        trans =
            transform
                << lookup "airport" airportData "iata" (luFields [ "latitude", "longitude" ])

        flightsEnc =
            encoding
                << position Longitude [ pName "longitude" ]
                << position Latitude [ pName "latitude" ]
                << order [ oName "order", oOrdinal ]

        flightsSpec =
            asSpec [ itineraryData [], trans [], flightsEnc [], line [] ]
    in
    toVegaLite
        [ desc
        , cfg []
        , width 800
        , height 500
        , proj
        , layer [ backdropSpec, airportsSpec, flightsSpec ]
        ]


geo8 : Spec
geo8 =
    let
        desc =
            description "Income in the U.S. by state, faceted over income brackets"

        geoData =
            dataFromUrl (path ++ "us-10m.json") [ topojsonFeature "states" ]

        incomeData =
            dataFromUrl (path ++ "income.json") []

        trans =
            transform
                << lookup "id" geoData "id" (luAs "geo")

        enc =
            encoding
                << shape [ mName "geo", mGeo ]
                << color [ mName "pct", mQuant, mSort [ soDescending ] ]
                << row [ fName "group" ]
    in
    toVegaLite [ desc, cfg [], width 500, height 300, incomeData, trans [], proj, enc [], geoshape [] ]


geo9 : Spec
geo9 =
    let
        desc =
            description "Geographic position of London underground lines"

        boroughData =
            dataFromUrl (path ++ "londonBoroughs.json") [ topojsonFeature "boroughs" ]

        centroidData =
            dataFromUrl (path ++ "londonCentroids.json") []

        tubeData =
            dataFromUrl (path ++ "londonTubeLines.json") [ topojsonFeature "line" ]

        tubeLineColors =
            categoricalDomainMap
                [ ( "Bakerloo", "rgb(137,78,36)" )
                , ( "Central", "rgb(220,36,30)" )
                , ( "Circle", "rgb(255,206,0)" )
                , ( "District", "rgb(1,114,41)" )
                , ( "DLR", "rgb(0,175,173)" )
                , ( "Hammersmith & City", "rgb(215,153,175)" )
                , ( "Jubilee", "rgb(106,114,120)" )
                , ( "Metropolitan", "rgb(114,17,84)" )
                , ( "Northern", "rgb(0,0,0)" )
                , ( "Piccadilly", "rgb(0,24,168)" )
                , ( "Victoria", "rgb(0,160,226)" )
                , ( "Waterloo & City", "rgb(106,187,170)" )
                ]

        polySpec =
            asSpec
                [ boroughData
                , geoshape [ maColor "#ddc", maStroke "rgb(251,247,238)", maStrokeWidth 2 ]
                ]

        labelEnc =
            encoding
                << position Longitude [ pName "cx" ]
                << position Latitude [ pName "cy" ]
                << text [ tName "bLabel" ]

        trans =
            transform
                << calculateAs "indexof (datum.name,' ') > 0  ? substring(datum.name,0,indexof(datum.name, ' ')) : datum.name" "bLabel"

        labelSpec =
            asSpec
                [ centroidData
                , trans []
                , labelEnc []
                , textMark [ maSize 8, maOpacity 0.6 ]
                ]

        tubeEnc =
            encoding
                << color
                    [ mName "id"
                    , mLegend [ leTitle "", leOrient loBottomRight, leOffset 0 ]
                    , mScale tubeLineColors
                    ]

        routeSpec =
            asSpec
                [ tubeData
                , geoshape [ maFilled False, maStrokeWidth 2 ]
                , tubeEnc []
                ]
    in
    toVegaLite
        [ desc
        , cfg []
        , width 700
        , height 500
        , layer [ polySpec, labelSpec, routeSpec ]
        ]



{- This list comprises the specifications to be provided to the Vega-Lite runtime. -}


mySpecs : Spec
mySpecs =
    combineSpecs
        [ ( "geo1", geo1 )
        , ( "geo2", geo2 )
        , ( "geo3", geo3 )
        , ( "geo4", geo4 )
        , ( "geo5", geo5 )
        , ( "geo6", geo6 )
        , ( "geo7", geo7 )
        , ( "geo8", geo8 )
        , ( "geo9", geo9 )
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
