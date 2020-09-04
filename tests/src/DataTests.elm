port module DataTests exposing (Msg, elmToJS)

import Browser
import Dict
import Html exposing (Html)
import Html.Attributes
import Html.Events
import Json.Encode
import VegaLite exposing (..)


path : String
path =
    "https://cdn.jsdelivr.net/npm/vega-datasets@2.1/data/"


showData : Data -> Spec
showData data =
    let
        enc =
            encoding
                << position X [ pName "cat" ]
                << position Y [ pName "val", pQuant ]
    in
    toVegaLite [ data, enc [], bar [] ]


data1 : Spec
data1 =
    let
        data =
            dataFromColumns []
                << dataColumn "cat" (strs [ "a", "b", "c" ])
                << dataColumn "val" (nums [ 10, 18, 12 ])
    in
    showData (data [])


data2 : Spec
data2 =
    let
        data =
            dataFromRows []
                << dataRow [ ( "cat", str "a" ), ( "val", num 10 ) ]
                << dataRow [ ( "cat", str "b" ), ( "val", num 18 ) ]
                << dataRow [ ( "cat", str "c" ), ( "val", num 12 ) ]
    in
    showData (data [])


data3 : Spec
data3 =
    let
        json =
            Json.Encode.list Json.Encode.object
                [ [ ( "cat", Json.Encode.string "a" ), ( "val", Json.Encode.float 10 ) ]
                , [ ( "cat", Json.Encode.string "b" ), ( "val", Json.Encode.float 18 ) ]
                , [ ( "cat", Json.Encode.string "c" ), ( "val", Json.Encode.float 12 ) ]
                ]
    in
    showData (dataFromJson json [])


data4 : Spec
data4 =
    showData (dataFromUrl "data/dataTest.csv" [])


data5 : Spec
data5 =
    showData (dataFromUrl "data/dataTest.tsv" [])


data6 : Spec
data6 =
    showData (dataFromUrl "data/dataTest.csv" [ dsv ',' ])


data7 : Spec
data7 =
    showData (dataFromUrl "data/dataTest.json" [])


dataSource : String -> Spec
dataSource name =
    let
        dataColumns =
            dataFromColumns []
                << dataColumn "cat" (strs [ "a", "b", "c" ])
                << dataColumn "val" (nums [ 10, 18, 12 ])

        dataRows =
            dataFromRows []
                << dataRow [ ( "cat", str "a" ), ( "val", num 10 ) ]
                << dataRow [ ( "cat", str "b" ), ( "val", num 18 ) ]
                << dataRow [ ( "cat", str "c" ), ( "val", num 12 ) ]

        json =
            Json.Encode.list Json.Encode.object
                [ [ ( "cat", Json.Encode.string "a" ), ( "val", Json.Encode.float 10 ) ]
                , [ ( "cat", Json.Encode.string "b" ), ( "val", Json.Encode.float 18 ) ]
                , [ ( "cat", Json.Encode.string "c" ), ( "val", Json.Encode.float 12 ) ]
                ]

        enc =
            encoding
                << position X [ pName "cat" ]
                << position Y [ pName "val", pQuant ]
    in
    toVegaLite
        [ datasets
            [ ( "myData1", dataRows [] )
            , ( "myData2", dataColumns [] )
            , ( "myData3", dataFromJson json [] )
            ]
        , dataFromSource name []
        , enc []
        , bar []
        ]


data8 : Spec
data8 =
    dataSource "myData1"


data9 : Spec
data9 =
    dataSource "myData2"


data10 : Spec
data10 =
    dataSource "myData3"


data11 : Spec
data11 =
    let
        pollData =
            dataFromUrl "https://gicentre.github.io/data/euPolls.arrow" [ arrow ]

        enc =
            encoding
                << position X [ pName "Answer" ]
                << position Y [ pName "Percent", pAggregate opMean ]
                << color [ mName "Pollster" ]
                << column [ fName "Pollster" ]
    in
    toVegaLite [ pollData, enc [], bar [] ]


namedData1 : Spec
namedData1 =
    let
        data =
            dataFromColumns []
                << dataColumn "a" (strs [ "A", "B", "C", "D", "E", "F", "G", "H", "I" ])
                << dataColumn "b" (nums [ 28, 55, 43, 91, 81, 53, 19, 87, 52 ])

        enc =
            encoding
                << position X [ pName "a", pOrdinal ]
                << position Y [ pName "b", pQuant ]
    in
    toVegaLite [ data [] |> dataName "source", enc [], bar [] ]


namedData2 : Spec
namedData2 =
    let
        data =
            dataFromUrl "data/dataTest.tsv" [] |> dataName "myName"

        enc =
            encoding
                << position X [ pName "cat" ]
                << position Y [ pName "val", pQuant ]
    in
    toVegaLite [ data, enc [], bar [] ]


namedData3 : Spec
namedData3 =
    let
        data =
            dataFromColumns [] [] |> dataName "source"

        enc =
            encoding
                << position X [ pName "cat" ]
                << position Y [ pName "val", pQuant ]
    in
    toVegaLite [ data, enc [], bar [] ]


geodata1 : Spec
geodata1 =
    let
        cfg =
            configure
                << configuration (coView [ vicoStroke Nothing ])

        data =
            dataFromUrl (path ++ "londonBoroughs.json") [ topojsonFeature "boroughs" ]

        enc =
            encoding
                << color [ mName "id" ]
    in
    toVegaLite [ width 700, height 500, cfg [], data, enc [], geoshape [] ]


geodata2 : Spec
geodata2 =
    let
        geojson =
            geoFeatureCollection
                [ geometry (geoPolygon [ [ ( -3, 52 ), ( 4, 52 ), ( 4, 45 ), ( -3, 45 ), ( -3, 52 ) ] ]) [ ( "Region", str "Southsville" ) ]
                , geometry (geoPolygon [ [ ( -3, 59 ), ( 4, 59 ), ( 4, 52 ), ( -3, 52 ), ( -3, 59 ) ] ]) [ ( "Region", str "Northerton" ) ]
                ]

        cfg =
            configure
                << configuration (coView [ vicoStroke Nothing ])

        data =
            dataFromJson geojson [ jsonProperty "features" ]

        proj =
            projection [ prType orthographic ]

        enc =
            encoding
                << color [ mName "properties.Region", mLegend [ leTitle "" ] ]
    in
    toVegaLite [ width 300, height 400, cfg [], data, proj, enc [], geoshape [] ]


flatten1 : Spec
flatten1 =
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
    toVegaLite [ data [], trans [], enc [], circle [] ]


fold1 : Spec
fold1 =
    let
        data =
            dataFromColumns []
                << dataColumn "city" (strs [ "Bristol", "Bristol", "Sheffield", "Sheffield", "Glasgow", "Glasgow" ])
                << dataColumn "temperature" (nums [ 12, 14, 11, 13, 7, 10 ])
                << dataColumn "year" (nums [ 2017, 2018, 2017, 2018, 2017, 2018 ])

        trans =
            transform
                << pivot "year" "temperature" [ piGroupBy [ "city" ] ]

        enc =
            encoding
                -- 2017 temperatures for the Bristol, Sheffield and Glasgow
                << position X [ pName "2017", pQuant ]
                << position Y [ pName "city" ]
    in
    toVegaLite [ data [], trans [], enc [], circle [] ]


pivot1 : Spec
pivot1 =
    let
        data =
            dataFromColumns []
                << dataColumn "country" (strs [ "USA", "USA", "Canada", "Canada" ])
                << dataColumn "medalType" (strs [ "gold", "silver", "gold", "silver" ])
                << dataColumn "count" (nums [ 10, 20, 7, 26 ])

        trans =
            transform
                << pivot "medalType" "count" [ piGroupBy [ "country" ] ]

        enc =
            encoding
                << position X [ pName "country" ]
                << position Y [ pRepeat arFlow, pQuant ]
                << color [ mName "country" ]

        spec =
            asSpec [ data [], trans [], enc [], bar [] ]
    in
    toVegaLite [ repeatFlow [ "gold", "silver" ], specification spec ]


doData : List DataColumn -> Data
doData =
    dataFromColumns []
        << dataColumn "x" (nums [ 1, 2, 3, 4 ])
        << dataColumn "y" (nums [ 95, 97, 100, 105 ])


domain1 : Spec
domain1 =
    let
        enc =
            encoding
                << position X [ pName "x", pQuant ]
                << position Y [ pName "y", pQuant, pScale [ scZero False ] ]
    in
    toVegaLite [ doData [], enc [], line [ maPoint (pmMarker []) ] ]


domain2 : Spec
domain2 =
    let
        enc =
            encoding
                << position X [ pName "x", pQuant ]
                << position Y
                    [ pName "y"
                    , pQuant
                    , pScale [ scZero False, scDomain (doNums [ 90, 100 ]) ]
                    ]
    in
    toVegaLite [ doData [], enc [], line [ maPoint (pmMarker []) ] ]


domain3 : Spec
domain3 =
    let
        enc =
            encoding
                << position X [ pName "x", pQuant ]
                << position Y
                    [ pName "y"
                    , pQuant
                    , pScale [ scZero False, scDomain (doNums [ 90, 100 ] |> doUnionWith) ]
                    ]
    in
    toVegaLite [ doData [], enc [], line [ maPoint (pmMarker []) ] ]


imputeData : List DataColumn -> Data
imputeData =
    dataFromColumns []
        << dataColumn "a" (nums [ 0, 0, 1, 1, 2, 2, 3 ])
        << dataColumn "b" (nums [ 28, 91, 43, 55, 81, 53, 19 ])
        << dataColumn "c" (nums [ 0, 1, 0, 1, 0, 1, 0 ])


impute1 : Spec
impute1 =
    let
        trans =
            transform
                << impute "b" "a" [ imNewValue (num 0), imGroupBy [ "c" ] ]

        enc =
            encoding
                << position X [ pName "a", pQuant, pScale [ scNice (niTickCount 1) ] ]
                << position Y [ pName "b", pQuant ]
                << color [ mName "c" ]
    in
    toVegaLite [ imputeData [], trans [], enc [], line [] ]


impute2 : Spec
impute2 =
    let
        trans =
            transform
                << impute "b" "a" [ imMethod imMean, imGroupBy [ "c" ], imFrame (Just -2) (Just 2) ]

        enc =
            encoding
                << position X [ pName "a", pQuant, pScale [ scNice (niTickCount 1) ] ]
                << position Y [ pName "b", pQuant ]
                << color [ mName "c" ]
    in
    toVegaLite [ imputeData [], trans [], enc [], line [] ]


impute3 : Spec
impute3 =
    let
        trans =
            transform
                << impute "b" "a" [ imNewValue (num 100), imGroupBy [ "c" ], imKeyValSequence 1 4 1 ]

        enc =
            encoding
                << position X [ pName "a", pQuant, pScale [ scNice (niTickCount 1) ] ]
                << position Y [ pName "b", pQuant ]
                << color [ mName "c" ]
    in
    toVegaLite [ imputeData [], trans [], enc [], line [] ]


impute4 : Spec
impute4 =
    let
        enc =
            encoding
                << position X [ pName "a", pQuant, pScale [ scNice (niTickCount 1) ] ]
                << position Y [ pName "b", pQuant, pImpute [ imNewValue (num 0) ] ]
                << color [ mName "c" ]
    in
    toVegaLite [ imputeData [], enc [], line [] ]


impute5 : Spec
impute5 =
    let
        enc =
            encoding
                << position X [ pName "a", pQuant, pScale [ scNice (niTickCount 1) ] ]
                << position Y [ pName "b", pQuant, pImpute [ imMethod imMean ] ]
                << color [ mName "c" ]
    in
    toVegaLite [ imputeData [], enc [], line [] ]


impute6 : Spec
impute6 =
    let
        enc =
            encoding
                << position X [ pName "a", pQuant, pScale [ scNice (niTickCount 1) ] ]
                << position Y [ pName "b", pQuant, pImpute [ imMethod imMean, imFrame (Just -2) (Just 2) ] ]
                << color [ mName "c" ]
    in
    toVegaLite [ imputeData [], enc [], line [] ]


impute7 : Spec
impute7 =
    let
        enc =
            encoding
                << position X [ pName "a", pQuant, pScale [ scNice (niTickCount 1) ] ]
                << position Y [ pName "b", pQuant, pImpute [ imNewValue (num 100), imKeyVals (nums [ 4 ]) ] ]
                << color [ mName "c" ]
    in
    toVegaLite [ imputeData [], enc [], line [] ]


impute8 : Spec
impute8 =
    let
        enc =
            encoding
                << position X [ pName "a", pQuant, pScale [ scNice (niTickCount 1) ] ]
                << position Y [ pName "b", pQuant, pImpute [ imNewValue (num 100), imKeyValSequence 4 6 1 ] ]
                << color [ mName "c" ]
    in
    toVegaLite [ imputeData [], enc [], line [] ]


sample1 : Spec
sample1 =
    let
        data =
            dataFromUrl (path ++ "cars.json") []

        trans =
            transform
                << sample 200

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]

        spec1 =
            asSpec [ enc [], point [] ]

        spec2 =
            asSpec [ trans [], enc [], point [] ]
    in
    toVegaLite [ data, hConcat [ spec1, spec2 ] ]


bin1 : Spec
bin1 =
    let
        data =
            dataFromColumns []
                << dataColumn "bin_start" (nums [ 8, 10, 12, 14, 16, 18, 20, 22 ])
                << dataColumn "bin_end" (nums [ 10, 12, 14, 16, 18, 20, 22, 24 ])
                << dataColumn "count" (nums [ 7, 29, 71, 127, 94, 54, 17, 5 ])

        enc =
            encoding
                << position X [ pName "bin_start", pBinned, pAxis [ axTickMinStep 2 ] ]
                << position X2 [ pName "bin_end" ]
                << position Y [ pName "count", pQuant ]
    in
    toVegaLite [ data [], enc [], bar [] ]


bin2 : Spec
bin2 =
    let
        data =
            dataFromColumns []
                << dataColumn "x" (nums [ 10.6, 12.1, 9.4, 11.5, 12.6, 10.7, 11.6, 7.7, 12, 10.6, 16.5, 8.7, 7.6, 10.2, 10, 9.8, 11, 9, 10.4, 11.6, 11.2, 11.1, 11.7, 12.1, 9.9, 8.9, 10.9, 14.6, 11.4, 12.1 ])

        enc =
            encoding
                << position X [ pName "x", pBin [] ]
                << position Y [ pAggregate opCount ]
    in
    toVegaLite [ width 300, data [], enc [], bar [] ]


bin3 : Spec
bin3 =
    let
        data =
            dataFromColumns []
                << dataColumn "x" (nums [ 10.6, 12.1, 9.4, 11.5, 12.6, 10.7, 11.6, 7.7, 12, 10.6, 16.5, 8.7, 7.6, 10.2, 10, 9.8, 11, 9, 10.4, 11.6, 11.2, 11.1, 11.7, 12.1, 9.9, 8.9, 10.9, 14.6, 11.4, 12.1, 12.2, 11.3, 13.1, 14.3, 9.8, 12.7, 9.2, 8.7, 11.3, 6.5, 11.1, 8.9, 11.8, 10.5, 12.8, 11.1, 11.2, 7, 12.4, 11.3, 8.3, 12.4, 12.1, 9.4, 8.6, 11.1, 8.9, 8.4, 10.5, 9.9, 6.5, 8.2, 12.7, 7.7, 11.1, 8.1, 8.1, 10.7, 9.8, 11.2, 11.2 ])

        enc =
            encoding
                << position X [ pName "x", pBin [ biAnchor 0.5 ] ]
                << position Y [ pAggregate opCount ]
    in
    toVegaLite [ width 300, data [], enc [], bar [] ]


sequence1 : Spec
sequence1 =
    let
        data =
            dataSequence 0 12.7 0.1

        trans =
            transform
                << calculateAs "sin(datum.data)" "v"

        enc =
            encoding
                << position X [ pName "data", pQuant ]
                << position Y [ pName "v", pQuant ]
    in
    toVegaLite [ data, trans [], enc [], line [] ]


sequence2 : Spec
sequence2 =
    let
        data =
            dataSequenceAs 0 12.7 0.1 "u"

        trans =
            transform
                << calculateAs "sin(datum.u)" "v"

        enc =
            encoding
                << position X [ pName "u", pQuant ]
                << position Y [ pName "v", pQuant ]
    in
    toVegaLite [ data, trans [], enc [], line [] ]


filter1 : Spec
filter1 =
    let
        data =
            dataFromColumns []
                << dataColumn "a" (strs [ "A", "B", "C", "D", "E", "F", "G", "H", "I" ])
                << dataColumn "b" (nums [ 28, 55, 43, 91, 81, 53, 19, 87, 52 ])

        trans =
            transform
                << filter (fiExpr "datum.a == 'A' || datum.a == 'C' || datum.a == 'E'")

        enc =
            encoding
                << position X [ pName "a", pOrdinal ]
                << position Y [ pName "b", pQuant ]
    in
    toVegaLite [ data [], trans [], enc [], bar [] ]


filter2 : Spec
filter2 =
    let
        data =
            dataFromColumns []
                << dataColumn "a" (strs [ "A", "B", "C", "D", "E", "F", "G", "H", "I" ])
                << dataColumn "b" (nums [ 28, 55, 43, 91, 81, 53, 19, 87, 52 ])

        trans =
            transform
                << filter
                    (or
                        (or (fiEqual "a" (str "A") |> fiOp)
                            (fiEqual "a" (str "C") |> fiOp)
                        )
                        (fiEqual "a" (str "E") |> fiOp)
                        |> fiCompose
                    )

        enc =
            encoding
                << position X [ pName "a", pOrdinal ]
                << position Y [ pName "b", pQuant ]
    in
    toVegaLite [ data [], trans [], enc [], bar [] ]


annotate1 : Spec
annotate1 =
    let
        data =
            dataFromColumns []
                << dataColumn "a" (strs [ "A", "B", "C", "D", "E" ])
                << dataColumn "b" (nums [ 28, 55, 43, 91, 81 ])

        enc =
            encoding
                << position X [ pName "a", pOrdinal ]
                << position Y [ pName "b", pQuant ]

        specBars =
            asSpec [ enc [], bar [] ]

        specText =
            asSpec [ noData, textMark [ maText "Test" ] ]
    in
    toVegaLite [ data [], layer [ specBars, specText ] ]


datum1 : Spec
datum1 =
    let
        data =
            dataFromUrl (path ++ "stocks.csv") []

        enc1 =
            encoding
                << position X [ pName "date", pTemporal, pAxis [ axGrid False ] ]
                << position Y [ pName "price", pQuant, pAxis [ axGrid False ] ]
                << color [ mName "symbol" ]

        spec1 =
            asSpec [ data, enc1 [], line [] ]

        emptyData =
            dataFromColumns []

        enc2 =
            encoding
                << position Y [ pDatum (num 200) ]

        spec2 =
            asSpec [ emptyData [], enc2 [], rule [ maStrokeDash [ 2, 2 ] ] ]
    in
    toVegaLite [ layer [ spec1, spec2 ] ]


datum2 : Spec
datum2 =
    let
        data =
            dataFromUrl (path ++ "stocks.csv") []

        enc1 =
            encoding
                << position X [ pName "date", pTemporal, pAxis [ axGrid False ] ]
                << position Y [ pName "price", pQuant, pAxis [ axGrid False ] ]
                << color [ mName "symbol" ]

        spec1 =
            asSpec [ data, enc1 [], line [] ]

        emptyData =
            dataFromColumns []

        enc2 =
            encoding
                << position X [ pDatum (dt [ dtYear 2006 ]) ]

        spec2 =
            asSpec [ emptyData [], enc2 [], rule [ maStrokeDash [ 2, 2 ] ] ]
    in
    toVegaLite [ layer [ spec1, spec2 ] ]


datum3 : Spec
datum3 =
    let
        cfg =
            configure
                << configuration (coAxis [ axcoDomain False ])

        data =
            dataSequenceAs -10 11 0.1 "x"

        trans =
            transform
                << calculateAs "-1 + pow((datum.x-1),2)/4" "y"

        enc1 =
            encoding
                << position X [ pName "x", pQuant, pTitle "x" ]
                << position Y [ pName "y", pQuant, pTitle "y" ]

        spec1 =
            asSpec [ enc1 [], line [] ]

        emptyData =
            dataFromColumns []

        enc2 =
            encoding
                << position X [ pDatum (num 0) ]

        spec2 =
            asSpec [ emptyData [], enc2 [], rule [] ]

        enc3 =
            encoding
                << position Y [ pDatum (num 0) ]

        spec3 =
            asSpec [ emptyData [], enc3 [], rule [] ]
    in
    toVegaLite
        [ cfg []
        , width 300
        , height 400
        , data
        , trans []
        , layer [ spec1, spec2, spec3 ]
        ]


datum4 : Spec
datum4 =
    let
        w =
            300

        minX =
            -10

        maxX =
            12

        minY =
            -5

        maxY =
            30

        yAxisShift =
            w * minX / (maxX - minX)

        xAxisShift =
            h * minY / (maxY - minY)

        h =
            300

        data =
            dataSequenceAs -10 11 0.1 "x"

        trans =
            transform
                << calculateAs "-1 + pow((datum.x-1),2)/4" "y"

        enc =
            encoding
                << position X
                    [ pName "x"
                    , pQuant
                    , pTitle ""
                    , pAxis [ axLabelExpr "datum.value === 0 ? '' : datum.label", axOffset xAxisShift ]
                    , pScale [ scDomain (doNums [ minX, maxX ]) ]
                    ]
                << position Y
                    [ pName "y"
                    , pQuant
                    , pTitle ""
                    , pAxis [ axLabelExpr "datum.value === 0 ? '' : datum.label", axOffset yAxisShift ]
                    , pScale [ scDomain (doNums [ minY, maxY ]) ]
                    ]
    in
    toVegaLite
        [ width w
        , height h
        , padding (paSize 0)
        , data
        , trans []
        , enc []
        , line []
        ]


datum5 : Spec
datum5 =
    let
        data =
            dataFromColumns []

        enc =
            encoding
                << text [ tDatum (num 0.11987), tFormat ".2f" ]
    in
    toVegaLite [ data [], enc [], textMark [] ]


datum6 : Spec
datum6 =
    let
        data =
            dataFromColumns []

        enc =
            encoding
                << text [ tDatum (boo True) ]
    in
    toVegaLite [ data [], enc [], textMark [] ]


datum7 : Spec
datum7 =
    let
        data =
            dataFromColumns []

        enc =
            encoding
                << text [ tDatum (str "Hello, world!") ]
    in
    toVegaLite [ data [], enc [], textMark [] ]


datum8 : Spec
datum8 =
    let
        data =
            dataFromColumns []
                << dataColumn "i" (List.range 1 10 |> List.map toFloat |> nums)

        enc =
            encoding
                << position Y [ pName "i", pOrdinal ]
                << text
                    [ tDataCondition [ ( expr "datum.i %2 == 0", [ tStr "even" ] ) ]
                        [ tStr "odd" ]
                    ]
    in
    toVegaLite [ data [], enc [], textMark [] ]



{- Ids and specifications to be provided to the Vega-Lite runtime. -}


specs : List ( String, Spec )
specs =
    [ ( "data1", data1 )
    , ( "data2", data2 )
    , ( "data3", data3 )
    , ( "data4", data4 )
    , ( "data5", data5 )
    , ( "data6", data6 )
    , ( "data7", data7 )
    , ( "data8", data8 )
    , ( "data9", data9 )
    , ( "data10", data10 )
    , ( "data11", data11 )
    , ( "namedData1", namedData1 )
    , ( "namedData2", namedData2 )
    , ( "namedData3", namedData3 )
    , ( "geodata1", geodata1 )
    , ( "geodata2", geodata2 )
    , ( "flatten1", flatten1 )
    , ( "fold1", fold1 )
    , ( "pivot1", pivot1 )
    , ( "domain1", domain1 )
    , ( "domain2", domain2 )
    , ( "domain3", domain3 )
    , ( "impute1", impute1 )
    , ( "impute2", impute2 )
    , ( "impute3", impute3 )
    , ( "impute4", impute4 )
    , ( "impute5", impute5 )
    , ( "impute6", impute6 )
    , ( "impute7", impute7 )
    , ( "impute8", impute8 )
    , ( "sample1", sample1 )
    , ( "bin1", bin1 )
    , ( "bin2", bin2 )
    , ( "bin3", bin3 )
    , ( "sequence1", sequence1 )
    , ( "sequence2", sequence2 )
    , ( "filter1", filter1 )
    , ( "filter2", filter2 )
    , ( "annotate1", annotate1 )
    , ( "datum1", datum1 )
    , ( "datum2", datum2 )
    , ( "datum3", datum3 )
    , ( "datum4", datum4 )
    , ( "datum5", datum5 )
    , ( "datum6", datum6 )
    , ( "datum7", datum7 )
    , ( "datum8", datum8 )
    ]



{- ---------------------------------------------------------------------------
   BOILERPLATE: NO NEED TO EDIT

   The code below creates an Elm module that opens an outgoing port to Javascript
   and sends both the specs and DOM node to it.
   It allows the source code of any of the generated specs to be selected from
   a drop-down list. Useful for viewin specs that might generate invalid Vega-Lite.
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
