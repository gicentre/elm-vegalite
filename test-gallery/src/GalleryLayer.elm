port module GalleryLayer exposing (elmToJS)

import Json.Encode as JE
import Platform
import VegaLite exposing (..)



-- NOTE: All data sources in these examples originally provided at
-- https://github.com/vega/vega-datasets
-- The examples themselves reproduce those at https://vega.github.io/vega-lite/examples/


layer1 : Spec
layer1 =
    let
        des =
            description "A candlestick chart inspired by Protovis (http://mbostock.github.io/protovis/ex/candlestick.html)"

        data =
            dataFromColumns []
                << dataColumn "date" (strs [ "01-Jun-2009", "02-Jun-2009", "03-Jun-2009", "04-Jun-2009", "05-Jun-2009", "08-Jun-2009", "09-Jun-2009", "10-Jun-2009", "11-Jun-2009", "12-Jun-2009", "15-Jun-2009", "16-Jun-2009", "17-Jun-2009", "18-Jun-2009", "19-Jun-2009", "22-Jun-2009", "23-Jun-2009", "24-Jun-2009", "25-Jun-2009", "26-Jun-2009", "29-Jun-2009", "30-Jun-2009" ])
                << dataColumn "open" (nums [ 28.7, 30.04, 29.62, 31.02, 29.39, 30.84, 29.77, 26.9, 27.36, 28.08, 29.7, 30.81, 31.19, 31.54, 29.16, 30.4, 31.3, 30.58, 29.45, 27.09, 25.93, 25.36 ])
                << dataColumn "high" (nums [ 30.05, 30.13, 31.79, 31.02, 30.81, 31.82, 29.77, 29.74, 28.11, 28.5, 31.09, 32.75, 32.77, 31.54, 29.32, 32.05, 31.54, 30.58, 29.56, 27.22, 27.18, 27.38 ])
                << dataColumn "low" (nums [ 28.45, 28.3, 29.62, 29.92, 28.85, 26.41, 27.79, 26.9, 26.81, 27.73, 29.64, 30.07, 30.64, 29.6, 27.56, 30.3, 27.83, 28.79, 26.3, 25.76, 25.29, 25.02 ])
                << dataColumn "close" (nums [ 30.04, 29.63, 31.02, 30.18, 29.62, 29.77, 28.27, 28.46, 28.11, 28.15, 30.81, 32.68, 31.54, 30.03, 27.99, 31.17, 30.58, 29.05, 26.36, 25.93, 25.35, 26.35 ])
                << dataColumn "signal" (strs [ "short", "short", "short", "short", "short", "short", "short", "short", "short", "short", "long", "short", "short", "short", "short", "short", "short", "long", "long", "long", "long", "long" ])
                << dataColumn "ret" (nums [ -4.89396411092985, -0.322580645161295, 3.68663594470045, 4.51010886469673, 6.08424336973478, 1.2539184952978, -5.02431118314424, -5.46623794212217, -8.3743842364532, -5.52763819095477, 3.4920634920635, 0.155038759689914, 5.82822085889571, 8.17610062893082, 8.59872611464968, 15.4907975460123, 11.7370892018779, -10.4234527687296, 0, 0, 5.26315789473684, 6.73758865248228 ])

        trans =
            transform << calculateAs "datum.open > datum.close" "isIncrease"

        encLine =
            encoding
                << position X
                    [ pName "date"
                    , pTemporal
                    , pTimeUnit yearMonthDate
                    , pScale
                        [ scDomain
                            (doDts
                                [ [ dtMonth May, dtDate 31, dtYear 2009 ]
                                , [ dtMonth Jul, dtDate 1, dtYear 2009 ]
                                ]
                            )
                        ]
                    , pAxis [ axTitle "Date in 2009", axFormat "%m/%d" ]
                    ]
                << position Y [ pName "low", pQuant, pScale [ scZero False ] ]
                << position Y2 [ pName "high", pQuant ]
                << color
                    [ mName "isIncrease"
                    , mNominal
                    , mLegend []
                    , mScale [ scRange (raStrs [ "#ae1325", "#06982d" ]) ]
                    ]

        specLine =
            asSpec [ encLine [], rule [] ]

        encBar =
            encoding
                << position X [ pName "date", pTemporal, pTimeUnit yearMonthDate ]
                << position Y [ pName "open", pQuant ]
                << position Y2 [ pName "close", pQuant ]
                << size [ mNum 5 ]
                << color [ mName "isIncrease", mNominal, mLegend [] ]

        specBar =
            asSpec [ encBar [], bar [] ]
    in
    toVegaLite [ des, width 320, data [], trans [], layer [ specLine, specBar ] ]


layer2 : Spec
layer2 =
    let
        des =
            description "A ranged dot plot that uses 'layer' to convey changing life expectancy for the five most populous countries (between 1955 and 2000)."

        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/countries.json" []

        trans =
            transform
                << filter (fiOneOf "country" (strs [ "China", "India", "United States", "Indonesia", "Brazil" ]))
                << filter (fiOneOf "year" (nums [ 1955, 2000 ]))

        encCountry =
            encoding
                << position Y
                    [ pName "country"
                    , pNominal
                    , pAxis
                        [ axTitle "Country"
                        , axOffset 5
                        , axTicks False
                        , axMinExtent 70
                        , axDomain False
                        ]
                    ]

        encLine =
            encoding
                << position X [ pName "life_expect", pQuant ]
                << detail [ dName "country", dNominal ]
                << color [ mStr "#db646f" ]

        specLine =
            asSpec [ encLine [], line [] ]

        encPoints =
            encoding
                << position X
                    [ pName "life_expect"
                    , pQuant
                    , pAxis [ axTitle "Life Expectancy (years)" ]
                    ]
                << color
                    [ mName "year"
                    , mOrdinal
                    , mScale (domainRangeMap ( 1955, "#e6959c" ) ( 2000, "#911a24" ))
                    , mLegend [ leTitle "Year" ]
                    ]
                << size [ mNum 100 ]
                << opacity [ mNum 1 ]

        specPoints =
            asSpec [ encPoints [], point [ maFilled True ] ]
    in
    toVegaLite [ des, data, trans [], encCountry [], layer [ specLine, specPoints ] ]


layer3 : Spec
layer3 =
    let
        des =
            description "Bullet chart"

        cfg =
            configure << configuration (coTick [ maThickness 2 ])

        row title ranges measures marker =
            JE.object
                [ ( "title", JE.string title )
                , ( "ranges", JE.list JE.float ranges )
                , ( "measures", JE.list JE.float measures )
                , ( "markers", JE.list JE.float [ marker ] )
                ]

        data =
            dataFromJson
                (JE.list identity
                    [ row "Revenue" [ 150, 225, 300 ] [ 220, 270 ] 250
                    , row "Profit" [ 20, 25, 30 ] [ 21, 23 ] 26
                    , row "Order size" [ 350, 500, 600 ] [ 100, 320 ] 550
                    , row "New customers" [ 1400, 2000, 2500 ] [ 1000, 1650 ] 2100
                    , row "Satisfaction" [ 3.5, 4.25, 5 ] [ 3.2, 4.7 ] 4.4
                    ]
                )

        res =
            resolve << resolution (reScale [ ( chX, reIndependent ) ])

        encLine =
            encoding
                << position X [ pName "life_expect", pQuant ]
                << detail [ dName "country", dNominal ]
                << color [ mStr "#db646f" ]

        enc1 =
            encoding
                << position X
                    [ pName "ranges[2]"
                    , pQuant
                    , pScale [ scNice niFalse ]
                    , pAxis [ axTitle "" ]
                    ]

        spec1 =
            asSpec [ enc1 [], bar [ maColor "#eee" ] ]

        enc2 =
            encoding << position X [ pName "ranges[1]", pQuant ]

        spec2 =
            asSpec [ enc2 [], bar [ maColor "#ddd" ] ]

        enc3 =
            encoding << position X [ pName "ranges[0]", pQuant ]

        spec3 =
            asSpec [ enc3 [], bar [ maColor "#ccc" ] ]

        enc4 =
            encoding << position X [ pName "measures[1]", pQuant ]

        spec4 =
            asSpec [ enc4 [], bar [ maColor "lightsteelblue", maSize 10 ] ]

        enc5 =
            encoding << position X [ pName "measures[0]", pQuant ]

        spec5 =
            asSpec [ enc5 [], bar [ maColor "steelblue", maSize 10 ], enc5 [] ]

        enc6 =
            encoding << position X [ pName "markers[0]", pQuant ]

        spec6 =
            asSpec [ enc6 [], tick [ maColor "black" ] ]
    in
    toVegaLite
        [ des
        , cfg []
        , data []
        , res []
        , facet [ rowBy [ fName "title", fOrdinal, fHeader [ hdLabelAngle 30, hdTitle "" ] ] ]
        , specification (asSpec [ layer [ spec1, spec2, spec3, spec4, spec5, spec6 ] ])
        ]


layer4 : Spec
layer4 =
    let
        des =
            description "A dual axis chart, created by setting y's scale resolution to independent."

        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/weather.csv" []

        trans =
            transform
                << filter (fiExpr "datum.location == \"Seattle\"")
                << calculateAs "datum.precipitation * 25.4" "precipitationmm"

        encTime =
            encoding
                << position X
                    [ pName "date"
                    , pTemporal
                    , pTimeUnit month
                    , pAxis [ axFormat "%b", axTitle "" ]
                    ]

        encArea =
            encoding
                << position Y
                    [ pName "temp_max"
                    , pQuant
                    , pAggregate opMean
                    , pScale [ scDomain (doNums [ 0, 30 ]) ]
                    , pAxis [ axTitle "Avgerage Temperature (°C)", axTitleColor "#85C5A6" ]
                    ]
                << position Y2 [ pName "temp_min", pAggregate opMean ]

        specArea =
            asSpec [ encArea [], area [ maOpacity 0.3, maColor "#85C5A6" ] ]

        encLine =
            encoding
                << position Y
                    [ pName "precipitationmm"
                    , pQuant
                    , pAggregate opMean
                    , pAxis [ axTitle "Precipitation (mm)", axTitleColor "#85A9C5" ]
                    ]

        specLine =
            asSpec [ encLine [], line [ maStroke "#85A9C5", maInterpolate miMonotone ] ]

        res =
            resolve
                << resolution (reScale [ ( chY, reIndependent ) ])
    in
    toVegaLite
        [ des
        , width 400
        , height 300
        , data
        , trans []
        , encTime []
        , res []
        , layer [ specArea, specLine ]
        ]


layer5 : Spec
layer5 =
    let
        des =
            description "Horizon chart with 2 layers. (See https://idl.cs.washington.edu/papers/horizon/ for more details on horizon charts.)"

        cfg =
            configure
                << configuration (coArea [ maInterpolate miMonotone, maOrient moVertical ])

        data =
            dataFromColumns []
                << dataColumn "x" (nums (List.map toFloat <| List.range 1 20))
                << dataColumn "y" (nums [ 28, 55, 43, 91, 81, 53, 19, 87, 52, 48, 24, 49, 87, 66, 17, 27, 68, 16, 49, 15 ])

        trans =
            transform << calculateAs "datum.y - 50" "ny"

        encX =
            encoding << position X [ pName "x", pQuant, pScale [ scZero False, scNice niFalse ] ]

        encLower =
            encoding
                << position Y [ pName "y", pQuant, pScale [ scDomain (doNums [ 0, 50 ]) ] ]
                << opacity [ mNum 0.6 ]

        specLower =
            asSpec [ encLower [], area [ maClip True ] ]

        encUpper =
            encoding
                << position Y [ pName "ny", pQuant, pScale [ scDomain (doNums [ 0, 50 ]) ], pAxis [ axTitle "y" ] ]
                << opacity [ mNum 0.3 ]

        specUpper =
            asSpec [ encUpper [], trans [], area [ maClip True ] ]
    in
    toVegaLite
        [ des
        , width 300
        , height 50
        , cfg []
        , data []
        , encX []
        , layer [ specLower, specUpper ]
        ]


layer6 : Spec
layer6 =
    let
        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/weather.json" []

        enc1 =
            encoding
                << position Y [ pName "record.low", pQuant, pScale [ scDomain (doNums [ 10, 70 ]) ], pAxis [ axTitle "Temperature (F)" ] ]
                << position Y2 [ pName "record.high", pQuant ]
                << position X [ pName "id", pOrdinal, pAxis [ axTitle "Day" ] ]
                << size [ mNum 20 ]
                << color [ mStr "#ccc" ]

        spec1 =
            asSpec [ bar [], enc1 [] ]

        enc2 =
            encoding
                << position Y [ pName "normal.low", pQuant ]
                << position Y2 [ pName "normal.high", pQuant ]
                << position X [ pName "id", pOrdinal ]
                << size [ mNum 20 ]
                << color [ mStr "#999" ]

        spec2 =
            asSpec [ bar [], enc2 [] ]

        enc3 =
            encoding
                << position Y [ pName "actual.low", pQuant ]
                << position Y2 [ pName "actual.high", pQuant ]
                << position X [ pName "id", pOrdinal ]
                << size [ mNum 12 ]
                << color [ mStr "#000" ]

        spec3 =
            asSpec [ bar [], enc3 [] ]

        enc4 =
            encoding
                << position Y [ pName "forecast.low.low", pQuant ]
                << position Y2 [ pName "forecast.low.high", pQuant ]
                << position X [ pName "id", pOrdinal ]
                << size [ mNum 12 ]
                << color [ mStr "#000" ]

        spec4 =
            asSpec [ bar [], enc4 [] ]

        enc5 =
            encoding
                << position Y [ pName "forecast.low.high", pQuant ]
                << position Y2 [ pName "forecast.high.low", pQuant ]
                << position X [ pName "id", pOrdinal ]
                << size [ mNum 3 ]
                << color [ mStr "#000" ]

        spec5 =
            asSpec [ bar [], enc5 [] ]

        enc6 =
            encoding
                << position Y [ pName "forecast.high.low", pQuant ]
                << position Y2 [ pName "forecast.high.high", pQuant ]
                << position X [ pName "id", pOrdinal ]
                << size [ mNum 12 ]
                << color [ mStr "#000" ]

        spec6 =
            asSpec [ bar [], enc6 [] ]

        enc7 =
            encoding
                << position X
                    [ pName "id"
                    , pOrdinal
                    , pAxis
                        [ axDomain False
                        , axTicks False
                        , axLabels False
                        , axTitle "Day"
                        , axTitlePadding 25
                        , axOrient siTop
                        ]
                    ]
                << text [ tName "day", tNominal ]

        spec7 =
            asSpec [ textMark [ maAlign haCenter, maDy -105 ], enc7 [] ]
    in
    toVegaLite
        [ description "A layered bar chart with floating bars representing weekly weather data"
        , title "Weekly Weather Observations and Predictions" []
        , width 250
        , height 200
        , data
        , layer [ spec1, spec2, spec3, spec4, spec5, spec6, spec7 ]
        ]


layer7 : Spec
layer7 =
    let
        minAge age =
            toFloat age / 2 + 7

        maxAge age =
            toFloat ((age - 7) * 2)

        textColour =
            "rgb(143,154,174)"

        dcColour =
            "rgb(223,117,45)"

        partnerColour =
            "rgb(91,198,214)"

        annotationFont =
            maFont "FjallaOne"

        dcData =
            dataFromColumns []
                << dataColumn "year" (List.range 1999 2019 |> List.map toFloat |> nums)
                << dataColumn "dcAge" (List.range 24 44 |> List.map toFloat |> nums)
                << dataColumn "minAge" (List.range 24 44 |> List.map minAge |> nums)
                << dataColumn "maxAge" (List.range 24 44 |> List.map maxAge |> nums)
                << dataColumn "partnerAge" ([ 18, 19, 20, 21, 22, 23, 20, 21, 22, 23, 24, 25, 23, 22, 20, 21, 25, 24, 25, 20, 21 ] |> nums)

        annotationData =
            dataFromRows []
                << dataRow
                    [ ( "name", str "Gisele Bundchen" )
                    , ( "start", num 1999 )
                    , ( "end", num 2004 )
                    ]
                << dataRow
                    [ ( "name", str "Bar Refaeli" )
                    , ( "start", num 2005 )
                    , ( "end", num 2010 )
                    ]
                << dataRow
                    [ ( "name", str "Blake Lively" )
                    , ( "start", num 2011 )
                    , ( "end", num 2011 )
                    ]
                << dataRow
                    [ ( "name", str "Erin Heatherton" )
                    , ( "start", num 2012 )
                    , ( "end", num 2012 )
                    ]
                << dataRow
                    [ ( "name", str "Toni Garrn" )
                    , ( "start", num 2013 )
                    , ( "end", num 2014 )
                    ]
                << dataRow
                    [ ( "name", str "Kelly Rohrbach" )
                    , ( "start", num 2015 )
                    , ( "end", num 2015 )
                    ]
                << dataRow
                    [ ( "name", str "Nina Agdal" )
                    , ( "start", num 2016 )
                    , ( "end", num 2017 )
                    ]
                << dataRow
                    [ ( "name", str "Camilla Morrone" )
                    , ( "start", num 2018 )
                    , ( "end", num 2019 )
                    ]

        dcAnnotationData =
            dataFromRows []
                << dataRow
                    [ ( "dcX", num 2019 )
                    , ( "dcY", num 44 )
                    , ( "dcAnnotation", str "Leo's age" )
                    ]
                << dataRow
                    [ ( "dcX", num 2012 )
                    , ( "dcY", num 32 )
                    , ( "dcAnnotation", str "xkcd non-creepiness range" )
                    ]

        partnerAnnotationData =
            dataFromRows []
                << dataRow
                    [ ( "partnerX", num 2018 )
                    , ( "partnerY", num 25 )
                    , ( "partnerAnnotation", str "partner's age" )
                    ]

        -- XKCD Creepiness range
        encBand =
            encoding
                << position X [ pName "year", pOrdinal, pAxis [ axTitle "" ] ]
                << position Y
                    [ pName "minAge"
                    , pQuant
                    , pScale [ scZero False, scDomain (doNums [ 16, 50 ]) ]
                    , pAxis [ axTitle "" ]
                    ]
                << position Y2 [ pName "maxAge" ]

        specBand =
            asSpec [ encBand [], area [ maClip True, maFill dcColour, maOpacity 0.2 ] ]

        -- Leo's age
        encDiCaprio =
            encoding
                << position X [ pName "year", pOrdinal ]
                << position Y [ pName "dcAge", pQuant ]

        specDiCaprio =
            asSpec
                [ encDiCaprio []
                , line
                    [ maColor dcColour
                    , maStrokeWidth 1
                    , maPoint (pmMarker [ maStroke dcColour, maStrokeWidth 1.5, maFill "rgb(42,24,12)" ])
                    ]
                ]

        encDiCaprioText =
            encoding
                << position X [ pName "year", pOrdinal ]
                << position Y [ pName "dcAge", pQuant ]
                << text [ tName "dcAge", tQuant ]

        specDiCaprioText =
            asSpec [ encDiCaprioText [], textMark [ maColor dcColour, maDy -11 ] ]

        encDiCaprioLabel =
            encoding
                << position X [ pName "dcX", pOrdinal ]
                << position Y [ pName "dcY", pQuant ]
                << text [ tName "dcAnnotation", tNominal ]

        specDiCaprioLabel =
            asSpec
                [ dcAnnotationData []
                , encDiCaprioLabel []
                , textMark [ maColor dcColour, maAlign haLeft, annotationFont, maDx 10, maDy 5, maSize 14 ]
                ]

        -- Partners' ages
        encPartners =
            encoding
                << position X [ pName "year", pOrdinal ]
                << position Y [ pName "partnerAge", pQuant ]

        specPartners =
            asSpec
                [ encPartners []
                , bar
                    [ maColorGradient grLinear
                        [ grX1 1
                        , grX2 1
                        , grY1 1
                        , grY2 0
                        , grStops [ ( 0, "black" ), ( 1, partnerColour ) ]
                        ]
                    ]
                ]

        -- Partners' names
        encPartnerText =
            encoding
                << position X [ pName "year", pOrdinal ]
                << position Y [ pName "partnerAge", pQuant ]
                << text [ tName "partnerAge", tQuant ]

        specPartnerText =
            asSpec [ encPartnerText [], textMark [ maColor partnerColour, maDy -7 ] ]

        encPartnerRange =
            encoding
                << position X [ pName "start", pOrdinal ]
                << position X2 [ pName "end", pOrdinal ]
                << position Y [ pNum 420 ]

        specPartnerRange =
            asSpec [ annotationData [], encPartnerRange [], rule [ maColor partnerColour ] ]

        encPartnerNames =
            encoding
                << position X [ pName "start", pOrdinal ]
                << position Y [ pNum 435 ]
                << text [ tName "name", tNominal ]

        specPartnerNames =
            asSpec
                [ annotationData []
                , encPartnerNames []
                , textMark [ maColor partnerColour, maAlign haLeft, maAngle 30, annotationFont ]
                ]

        encPartnerLabel =
            encoding
                << position X [ pName "partnerX", pOrdinal ]
                << position Y [ pName "partnerY", pQuant ]
                << text [ tName "partnerAnnotation", tNominal ]

        specPartnerLabel =
            asSpec
                [ partnerAnnotationData []
                , encPartnerLabel []
                , textMark [ maColor partnerColour, maAlign haLeft, annotationFont, maDx 17, maDy 5, maSize 14 ]
                ]

        cfg =
            configure
                << configuration (coScale [ sacoBandPaddingInner 0.5 ])
                << configuration
                    (coAxis
                        [ axcoGridOpacity 0.1
                        , axcoTicks False
                        , axcoDomain False
                        , axcoLabelColor textColour
                        , axcoLabelAngle 0
                        ]
                    )
                << configuration (coView [ vicoStroke Nothing ])
                << configuration (coPadding (paSize 60))
                << configuration (coBackground "black")
                << configuration (coText [ maColor textColour ])
                << configuration (coTitle [ ticoColor textColour, ticoFont "FjallaOne", ticoFontSize 22, ticoAnchor anStart ])
    in
    toVegaLite
        [ title "Leonardo DiCaprio has never dated a woman over 25" []
        , width 650
        , height 400
        , cfg []
        , dcData []
        , layer
            [ specBand
            , specDiCaprio
            , specDiCaprioText
            , specDiCaprioLabel
            , specPartners
            , specPartnerText
            , specPartnerRange
            , specPartnerNames
            , specPartnerLabel
            ]
        ]



{- This list comprises the specifications to be provided to the Vega-Lite runtime. -}


mySpecs : Spec
mySpecs =
    combineSpecs
        [ ( "layer1", layer1 )
        , ( "layer2", layer2 )
        , ( "layer3", layer3 )
        , ( "layer4", layer4 )
        , ( "layer5", layer5 )
        , ( "layer6", layer6 )
        , ( "layer7", layer7 )
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
