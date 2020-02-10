port module GeoTests exposing (elmToJS)

import Browser
import Html exposing (Html, div, pre)
import Html.Attributes exposing (id)
import Json.Encode
import VegaLite exposing (..)



{- Some relevant data sources:

   https://github.com/deldersveld/topojson
   https://github.com/topojson/world-atlas
-}


defaultSize1 : Spec
defaultSize1 =
    toVegaLite
        [ description "Default map size"
        , projection [ prType albersUsa ]
        , dataFromUrl "https://vega.github.io/vega-lite/data/us-10m.json" [ topojsonFeature "counties" ]
        , geoshape []
        , encoding <| color [ mStr "black" ] []
        ]


defaultSize2 : Spec
defaultSize2 =
    toVegaLite
        [ description "Default map size with view width and height specified in config."
        , configure <| configuration (coView [ vicoContinuousWidth 500, vicoContinuousHeight 300 ]) <| []
        , projection [ prType albersUsa ]
        , dataFromUrl "https://vega.github.io/vega-lite/data/us-10m.json" [ topojsonFeature "counties" ]
        , geoshape []
        , encoding <| color [ mStr "black" ] []
        ]


choropleth1 : Spec
choropleth1 =
    toVegaLite
        [ width 900
        , height 500
        , configure <| configuration (coView [ vicoStroke Nothing ]) []
        , dataFromUrl "https://vega.github.io/vega-lite/data/londonBoroughs.json" [ topojsonFeature "boroughs" ]
        , geoshape [ maStrokeOpacity 0 ]
        , encoding <| color [ mName "id", mNominal ] []
        ]


choropleth2 : Spec
choropleth2 =
    let
        trans =
            transform
                << calculateAs "indexof (datum.name,' ') > 0  ? substring(datum.name,0,indexof(datum.name, ' ')) : datum.name" "bLabel"

        polyEnc =
            encoding
                << color [ mName "id", mNominal, mScale boroughColors, mLegend [] ]
                << opacity [ mNum 1 ]

        polySpec =
            asSpec
                [ dataFromUrl "https://vega.github.io/vega-lite/data/londonBoroughs.json" [ topojsonFeature "boroughs" ]
                , geoshape [ maStroke "rgb(251,247,238)", maStrokeWidth 2 ]
                , polyEnc []
                ]

        labelEnc =
            encoding
                << position Longitude [ pName "cx", pQuant ]
                << position Latitude [ pName "cy", pQuant ]
                << text [ tName "bLabel", tNominal ]

        labelSpec =
            asSpec [ dataFromUrl "https://vega.github.io/vega-lite/data/londonCentroids.json" [], trans [], textMark [], labelEnc [] ]
    in
    toVegaLite
        [ width 1200
        , height 700
        , configure <| configuration (coView [ vicoStroke Nothing ]) []
        , layer [ polySpec, labelSpec ]
        ]


tubeLines1 : Spec
tubeLines1 =
    toVegaLite
        [ width 700
        , height 500
        , dataFromUrl "https://vega.github.io/vega-lite/data/londonTubeLines.json" [ topojsonFeature "line" ]
        , geoshape [ maFilled False ]
        , encoding <| color [ mName "id", mNominal ] []
        ]


tubeLines2 : Spec
tubeLines2 =
    let
        enc =
            encoding
                << color
                    [ mName "id"
                    , mNominal
                    , mLegend [ leTitle "", leOrient loBottomRight ]
                    , mScale tubeLineColors
                    ]
    in
    toVegaLite
        [ width 700
        , height 500
        , configure <| configuration (coView [ vicoStroke Nothing ]) []
        , dataFromUrl "https://vega.github.io/vega-lite/data/londonTubeLines.json" [ topojsonFeature "line" ]
        , geoshape [ maFilled False, maStrokeWidth 2 ]
        , enc []
        ]


tubeLines3 : Spec
tubeLines3 =
    let
        polySpec =
            asSpec
                [ dataFromUrl "https://vega.github.io/vega-lite/data/londonBoroughs.json" [ topojsonFeature "boroughs" ]
                , geoshape [ maStroke "rgb(251,247,238)", maStrokeWidth 2 ]
                , encoding <| color [ mStr "#ddc" ] []
                ]

        labelEnc =
            encoding
                << position Longitude [ pName "cx", pQuant ]
                << position Latitude [ pName "cy", pQuant ]
                << text [ tName "bLabel", tNominal ]
                << size [ mNum 8 ]
                << opacity [ mNum 0.6 ]

        trans =
            transform
                << calculateAs "indexof (datum.name,' ') > 0  ? substring(datum.name,0,indexof(datum.name, ' ')) : datum.name" "bLabel"

        labelSpec =
            asSpec [ dataFromUrl "https://vega.github.io/vega-lite/data/londonCentroids.json" [], trans [], textMark [], labelEnc [] ]

        tubeEnc =
            encoding
                << color
                    [ mName "id"
                    , mNominal
                    , mLegend [ leTitle "", leOrient loBottomRight, leOffset 0 ]
                    , mScale tubeLineColors
                    ]

        routeSpec =
            asSpec
                [ dataFromUrl "https://vega.github.io/vega-lite/data/londonTubeLines.json" [ topojsonFeature "line" ]
                , geoshape [ maFilled False, maStrokeWidth 2 ]
                , tubeEnc []
                ]
    in
    toVegaLite
        [ width 700
        , height 500
        , configure <| configuration (coView [ vicoStroke Nothing ]) []
        , layer [ polySpec, labelSpec, routeSpec ]
        ]


boroughColors : List ScaleProperty
boroughColors =
    categoricalDomainMap
        [ ( "Kingston upon Thames", "#9db7b1" )
        , ( "Croydon", "#d4b4e5" )
        , ( "Bromley", "#afb9cb" )
        , ( "Hounslow", "#b2add6" )
        , ( "Ealing", "#e2f8ca" )
        , ( "Havering", "#a1bde6" )
        , ( "Hillingdon", "#e8aa95" )
        , ( "Harrow", "#8bd0eb" )
        , ( "Brent", "#dfb89b" )
        , ( "Barnet", "#a2e7ed" )
        , ( "Lambeth", "#e3aba7" )
        , ( "Southwark", "#86cbd1" )
        , ( "Lewisham", "#ecb1c2" )
        , ( "Greenwich", "#acd8ba" )
        , ( "Bexley", "#e4bad9" )
        , ( "Enfield", "#9bd6ca" )
        , ( "Waltham Forest", "#cec9f3" )
        , ( "Redbridge", "#c9d2a8" )
        , ( "Sutton", "#d1c1d9" )
        , ( "Richmond upon Thames", "#ddcba2" )
        , ( "Merton", "#a2acbd" )
        , ( "Wandsworth", "#deefd6" )
        , ( "Hammersmith and Fulham", "#b5d7a7" )
        , ( "Kensington and Chelsea", "#f6d4c9" )
        , ( "Westminster", "#add4e0" )
        , ( "Camden", "#d9b9ad" )
        , ( "Tower Hamlets", "#c6e1db" )
        , ( "Islington", "#e0c7ce" )
        , ( "Hackney", "#a6b79f" )
        , ( "Haringey", "#cbd5e7" )
        , ( "Newham", "#c2d2ba" )
        , ( "Barking and Dagenham", "#ebe2cf" )
        , ( "City of London", "#c7bfad" )
        ]


tubeLineColors : List ScaleProperty
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


sphere1 : Spec
sphere1 =
    let
        data =
            dataFromUrl "https://gicentre.github.io/data/geoTutorials/world-110m.json"
                [ topojsonFeature "countries1" ]

        proj =
            projection [ prType orthographic ]
    in
    toVegaLite [ width 300, height 300, data, proj, geoshape [ maFill "rgb(149,181,146)" ] ]


sphere2 : Spec
sphere2 =
    let
        countryData =
            dataFromUrl "https://gicentre.github.io/data/geoTutorials/world-110m.json"
                [ topojsonFeature "countries1" ]

        proj =
            projection [ prType orthographic ]

        sphereSpec =
            asSpec [ sphere, geoshape [ maFill "aliceblue" ] ]

        countrySpec =
            asSpec [ countryData, geoshape [ maFill "rgb(149,181,146)" ] ]
    in
    toVegaLite [ width 300, height 300, proj, layer [ sphereSpec, countrySpec ] ]


graticule1 : Spec
graticule1 =
    let
        proj =
            projection [ prType orthographic, prRotate -42 -30 0 ]

        sphereSpec =
            asSpec [ sphere, geoshape [ maFill "aliceblue" ] ]

        gratSpec =
            asSpec [ graticule [], geoshape [ maFilled False, maStrokeWidth 0.3 ] ]
    in
    toVegaLite [ width 300, height 300, proj, layer [ sphereSpec, gratSpec ] ]


graticule2 : Spec
graticule2 =
    let
        proj =
            projection [ prType orthographic, prRotate -42 -30 0 ]

        sphereSpec =
            asSpec [ sphere, geoshape [ maFill "aliceblue" ] ]

        gratSpec =
            asSpec
                [ graticule [ grExtent ( 0, 0 ) ( 90, 90 ), grStep ( 2, 2 ), grPrecision 2 ]
                , geoshape [ maFilled False, maStrokeWidth 0.3 ]
                ]
    in
    toVegaLite [ width 300, height 300, proj, layer [ sphereSpec, gratSpec ] ]


graticule3 : Spec
graticule3 =
    let
        proj =
            projection [ prType orthographic, prRotate -42 -30 0 ]

        sphereSpec =
            asSpec [ sphere, geoshape [ maFill "aliceblue" ] ]

        gratSpec =
            asSpec
                [ graticule
                    [ grExtentMajor ( 0, 0 ) ( 90, 90 )
                    , grExtentMinor ( 0, 0 ) ( 90, 75.01 )
                    , grStepMinor ( 2, 2 )
                    ]
                , geoshape [ maFilled False, maStrokeWidth 0.3 ]
                ]
    in
    toVegaLite [ width 300, height 300, proj, layer [ sphereSpec, gratSpec ] ]


graticule4 : Spec
graticule4 =
    let
        proj =
            projection [ prType orthographic, prRotate -42 -30 0 ]

        sphereSpec =
            asSpec [ sphere, geoshape [ maFill "aliceblue" ] ]

        gratSpec =
            asSpec
                [ graticule [ grStepMinor ( 15, 30 ) ]
                , geoshape [ maFilled False, maStrokeWidth 0.3 ]
                ]
    in
    toVegaLite [ width 300, height 300, proj, layer [ sphereSpec, gratSpec ] ]


scale1 : Spec
scale1 =
    let
        data =
            dataFromUrl "https://gicentre.github.io/data/geoTutorials/world-110m.json"
                [ topojsonFeature "countries1" ]

        proj =
            projection [ prType orthographic, prScale 470 ]

        countrySpec =
            asSpec [ data, geoshape [ maFill "rgb(149,181,146)" ] ]

        gratSpec =
            asSpec
                [ graticule [ grStepMinor ( 5, 5 ) ]
                , geoshape [ maFilled False, maStrokeWidth 0.3 ]
                ]
    in
    toVegaLite [ width 300, height 300, proj, layer [ countrySpec, gratSpec ] ]


translate1 : Spec
translate1 =
    let
        data =
            dataFromUrl "https://gicentre.github.io/data/geoTutorials/world-110m.json"
                [ topojsonFeature "countries1" ]

        proj =
            projection [ prType orthographic, prTranslate 0 100 ]

        countrySpec =
            asSpec [ data, geoshape [ maFill "rgb(149,181,146)" ] ]

        gratSpec =
            asSpec
                [ graticule [ grStepMinor ( 5, 5 ) ]
                , geoshape [ maFilled False, maStrokeWidth 0.3 ]
                ]
    in
    toVegaLite [ width 300, height 300, proj, layer [ countrySpec, gratSpec ] ]


mapComp1 : Spec
mapComp1 =
    let
        globe =
            asSpec
                [ width 300
                , height 300
                , dataFromUrl "https://vega.github.io/vega-lite/data/graticule.json" [ topojsonFeature "graticule" ]
                , projection [ prType orthographic ]
                , geoshape [ maFilled False ]
                ]
    in
    toVegaLite [ hConcat [ globe, globe, globe ] ]


mapComp2 : Spec
mapComp2 =
    let
        globe =
            let
                graticuleSpec =
                    asSpec
                        [ dataFromUrl "https://vega.github.io/vega-lite/data/graticule.json" [ topojsonFeature "graticule" ]
                        , geoshape [ maFilled False, maStroke "#411", maStrokeWidth 0.1 ]
                        ]

                countrySpec =
                    asSpec
                        [ dataFromUrl "https://vega.github.io/vega-lite/data/world-110m.json" [ topojsonFeature "land" ]
                        , geoshape [ maFill "black", maFillOpacity 0.7 ]
                        ]
            in
            asSpec [ width 300, height 300, projection [ prType orthographic ], layer [ graticuleSpec, countrySpec ] ]
    in
    toVegaLite
        [ configure <| configuration (coView [ vicoStroke Nothing ]) <| []
        , hConcat [ globe, globe, globe ]
        ]


mapComp3 : Spec
mapComp3 =
    let
        rotatedSpec rot =
            let
                graticuleSpec =
                    asSpec
                        [ projection [ prType orthographic, prRotate rot 0 0 ]
                        , dataFromUrl "https://vega.github.io/vega-lite/data/graticule.json" [ topojsonFeature "graticule" ]
                        , geoshape [ maFilled False, maStroke "#411", maStrokeWidth 0.1 ]
                        ]

                countrySpec =
                    asSpec
                        [ projection [ prType orthographic, prRotate rot 0 0 ]
                        , dataFromUrl "https://vega.github.io/vega-lite/data/world-110m.json" [ topojsonFeature "countries" ]
                        , geoshape [ maStroke "white", maFill "black", maStrokeWidth 0.5 ]
                        ]
            in
            asSpec [ width 300, height 300, layer [ graticuleSpec, countrySpec ] ]
    in
    toVegaLite
        [ configure <| configuration (coView [ vicoStroke Nothing ]) <| [], hConcat [ rotatedSpec -65, rotatedSpec 115, rotatedSpec -65 ] ]


mapComp4 : Spec
mapComp4 =
    let
        rotatedSpec rot =
            let
                seaSpec =
                    asSpec
                        [ projection [ prType orthographic, prRotate 0 0 0 ]
                        , dataFromUrl "data/globe.json" [ topojsonFeature "globe" ]
                        , geoshape [ maFill "#c1e7f5", maStrokeOpacity 0 ]
                        ]

                graticuleSpec =
                    asSpec
                        [ projection [ prType orthographic, prRotate rot 0 0 ]
                        , dataFromUrl "https://vega.github.io/vega-lite/data/graticule.json" [ topojsonFeature "graticule" ]
                        , geoshape [ maFilled False, maStroke "#411", maStrokeWidth 0.1 ]
                        ]

                countrySpec =
                    asSpec
                        [ projection [ prType orthographic, prRotate rot 0 0 ]
                        , dataFromUrl "https://vega.github.io/vega-lite/data/world-110m.json" [ topojsonFeature "countries" ]
                        , geoshape [ maStroke "white", maFill "#242", maStrokeWidth 0.1 ]
                        ]
            in
            asSpec [ width 300, height 300, layer [ seaSpec, graticuleSpec, countrySpec ] ]
    in
    toVegaLite
        [ configure <| configuration (coView [ vicoStroke Nothing ]) <| [], hConcat [ rotatedSpec 0, rotatedSpec -40 ] ]


dotMap1 : Spec
dotMap1 =
    let
        enc =
            encoding
                << position Longitude [ pName "longitude", pQuant ]
                << position Latitude [ pName "latitude", pQuant ]
                << size [ mNum 1 ]
                << color [ mName "digit", mNominal ]
    in
    toVegaLite
        [ description "US zip codes: One dot per zipcode colored by first digit"
        , width 500
        , height 300
        , projection [ prType albersUsa ]
        , dataFromUrl "https://vega.github.io/vega-lite/data/zipcodes.csv" []
        , transform <| calculateAs "substring(datum.zip_code, 0, 1)" "digit" <| []
        , circle []
        , enc []
        ]


scribbleMap1 : Spec
scribbleMap1 =
    let
        stateCondition =
            List.map (\s -> "&& datum.state !='" ++ s ++ "'") [ "AS", "FM", "PW", "MH", "GU", "MP", "VI", "PR" ]
                |> String.concat

        config =
            configure
                << configuration (coTitle [ ticoFont "Roboto", ticoFontWeight W300, ticoFontSize 28 ])
                << configuration (coView [ vicoStroke Nothing ])

        trans =
            transform
                << filter ("datum.latitude != '' && datum.county != 'Honolulu' " ++ stateCondition |> fiExpr)
                << calculateAs "datum.state == 'HI' ? 'hi' : (datum.state == 'AK' ? 'ak' : 'continent')" "conterminous"

        enc =
            encoding
                << position Longitude [ pName "longitude", pQuant ]
                << position Latitude [ pName "latitude", pQuant ]
                << order [ oName "zip_code", oQuant ]
                << color [ mStr "#666" ]
                << detail [ dName "conterminous", dNominal ]
    in
    toVegaLite
        [ title "US connected zip codes" []
        , config []
        , width 1000
        , height 600
        , projection [ prType albersUsa ]
        , dataFromUrl "https://vega.github.io/vega-lite/data/zipcodes.csv" []
        , trans []
        , line [ maStrokeWidth 0.2, maInterpolate miMonotone ]
        , enc []
        ]


scribbleMap2 : Spec
scribbleMap2 =
    let
        stateCondition =
            List.map (\s -> "&& datum.state !='" ++ s ++ "'") [ "AS", "FM", "PW", "MH", "GU", "MP", "VI", "PR" ]
                |> String.concat

        config =
            configure
                << configuration (coTitle [ ticoFont "Roboto", ticoFontWeight W300, ticoFontSize 28 ])
                << configuration (coView [ vicoStroke Nothing ])

        trans =
            transform
                << filter ("datum.latitude != '' && datum.county != 'Honolulu' " ++ stateCondition |> fiExpr)
                << calculateAs "substring(datum.zip_code, 0, 3)" "digit3"
                << calculateAs "length(datum.zip_code+' ')" "ziplen"

        enc =
            encoding
                << position Longitude [ pName "longitude", pQuant ]
                << position Latitude [ pName "latitude", pQuant ]
                << order [ oName "zip_code", oQuant ]
                << color [ mName "digit3", mNominal, mLegend [] ]
                << detail [ dName "ziplen", dNominal ]
    in
    toVegaLite
        [ title "US connected zip codes, coloured by first three digits" []
        , config []
        , width 1000
        , height 600
        , projection [ prType albersUsa ]
        , dataFromUrl "https://vega.github.io/vega-lite/data/zipcodes.csv" []
        , trans []
        , line [ maStrokeWidth 0.2, maInterpolate miMonotone ]
        , enc []
        ]


map1d : Spec
map1d =
    let
        geoData =
            dataFromUrl "https://gicentre.github.io/data/geoTutorials/londonBoroughs.json"
                [ topojsonFeature "boroughs" ]

        centroidData =
            dataFromUrl "https://gicentre.github.io/data/geoTutorials/londonCentroids.csv"

        backgroundSpec =
            asSpec [ geoData, geoshape [ maFill "lightgrey", maStroke "white" ] ]

        cEnc =
            encoding
                << position Longitude [ pName "cx", pQuant ]
                << position Latitude [ pName "cy", pQuant ]

        hEnc =
            encoding
                << position Longitude [ pName "cx", pQuant ]
                << position Latitude [ pNum 51.28 ]

        vEnc =
            encoding
                << position Longitude [ pNum -0.52 ]
                << position Latitude [ pName "cy", pQuant ]

        cSpec =
            asSpec [ centroidData [], circle [], cEnc [] ]

        hSpec =
            asSpec [ centroidData [], circle [], hEnc [] ]

        vSpec =
            asSpec [ centroidData [], circle [], vEnc [] ]
    in
    toVegaLite
        [ width 500, height 400, layer [ backgroundSpec, cSpec, hSpec, vSpec ] ]


sourceExample : Spec
sourceExample =
    map1d



{- This list comprises the specifications to be provided to the Vega-Lite runtime. -}


mySpecs : Spec
mySpecs =
    combineSpecs
        [ ( "defaultSize1", defaultSize1 )
        , ( "defaultSize2", defaultSize2 )
        , ( "choropleth1", choropleth1 )
        , ( "choropleth2", choropleth2 )
        , ( "linear1", tubeLines1 )
        , ( "linear2", tubeLines2 )
        , ( "linear3", tubeLines3 )
        , ( "sphere1", sphere1 )
        , ( "sphere2", sphere2 )
        , ( "graticule1", graticule1 )
        , ( "graticule2", graticule2 )
        , ( "graticule3", graticule3 )
        , ( "graticule4", graticule4 )
        , ( "scale1", scale1 )
        , ( "translate1", translate1 )
        , ( "mapComp1", mapComp1 )
        , ( "mapComp2", mapComp2 )
        , ( "mapComp3", mapComp3 )
        , ( "mapComp4", mapComp4 )
        , ( "dotMap1", dotMap1 )
        , ( "scribbleMap1", scribbleMap1 )
        , ( "scribbleMap2", scribbleMap2 )
        , ( "map1d", map1d )
        ]



{- ---------------------------------------------------------------------------
   The code below creates an Elm module that opens an outgoing port to Javascript
   and sends both the specs and DOM node to it.
   This is used to display the generated Vega specs for testing purposes.
-}


main : Program () Spec msg
main =
    Browser.element
        { init = always ( mySpecs, elmToJS mySpecs )
        , view = view
        , update = \_ model -> ( model, Cmd.none )
        , subscriptions = always Sub.none
        }



-- View


view : Spec -> Html msg
view spec =
    div []
        [ div [ id "specSource" ] []
        , pre []
            [ Html.text (Json.Encode.encode 2 sourceExample) ]
        ]


port elmToJS : Spec -> Cmd msg
