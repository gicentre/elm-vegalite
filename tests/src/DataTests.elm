port module DataTests exposing (elmToJS)

import Browser
import Html exposing (Html, div, pre)
import Html.Attributes exposing (id)
import Json.Encode as JE
import VegaLite exposing (..)


showData : Data -> Spec
showData data =
    let
        enc =
            encoding
                << position X [ pName "cat", pNominal ]
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
            JE.list JE.object
                [ [ ( "cat", JE.string "a" ), ( "val", JE.float 10 ) ]
                , [ ( "cat", JE.string "b" ), ( "val", JE.float 18 ) ]
                , [ ( "cat", JE.string "c" ), ( "val", JE.float 12 ) ]
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
            JE.list JE.object
                [ [ ( "cat", JE.string "a" ), ( "val", JE.float 10 ) ]
                , [ ( "cat", JE.string "b" ), ( "val", JE.float 18 ) ]
                , [ ( "cat", JE.string "c" ), ( "val", JE.float 12 ) ]
                ]

        enc =
            encoding
                << position X [ pName "cat", pNominal ]
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
                << position X [ pName "Answer", pNominal ]
                << position Y [ pName "Percent", pQuant, pAggregate opMean ]
                << color [ mName "Pollster", mMType Nominal ]
                << column [ fName "Pollster", fMType Nominal ]
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
                << position X [ pName "cat", pNominal ]
                << position Y [ pName "val", pQuant ]
    in
    toVegaLite [ data, enc [], bar [] ]


namedData3 : Spec
namedData3 =
    let
        enc =
            encoding
                << position X [ pName "cat", pNominal ]
                << position Y [ pName "val", pQuant ]
    in
    toVegaLite [ dataFromColumns [] [] |> dataName "source", enc [], bar [] ]


geodata1 : Spec
geodata1 =
    toVegaLite
        [ width 700
        , height 500
        , configure <| configuration (coView [ vicoStroke Nothing ]) []
        , dataFromUrl "https://vega.github.io/vega-lite/data/londonBoroughs.json" [ topojsonFeature "boroughs" ]
        , geoshape []
        , encoding <| color [ mName "id", mMType Nominal ] []
        ]


geodata2 : Spec
geodata2 =
    let
        geojson =
            geoFeatureCollection
                [ geometry (geoPolygon [ [ ( -3, 52 ), ( 4, 52 ), ( 4, 45 ), ( -3, 45 ), ( -3, 52 ) ] ]) [ ( "Region", str "Southsville" ) ]
                , geometry (geoPolygon [ [ ( -3, 59 ), ( 4, 59 ), ( 4, 52 ), ( -3, 52 ), ( -3, 59 ) ] ]) [ ( "Region", str "Northerton" ) ]
                ]
    in
    toVegaLite
        [ width 300
        , height 400
        , configure <| configuration (coView [ vicoStroke Nothing ]) []
        , dataFromJson geojson [ jsonProperty "features" ]
        , projection [ prType orthographic ]
        , encoding (color [ mName "properties.Region", mMType Nominal, mLegend [ leTitle "" ] ] [])
        , geoshape []
        ]


flatten1 : Spec
flatten1 =
    let
        data =
            dataFromJson
                (JE.list JE.object
                    [ [ ( "key", JE.string "alpha" )
                      , ( "foo", JE.list JE.float [ 1, 2 ] )
                      , ( "bar", JE.list JE.string [ "A", "B" ] )
                      ]
                    , [ ( "key", JE.string "beta" )
                      , ( "foo", JE.list JE.float [ 3, 4, 5 ] )
                      , ( "bar", JE.list JE.string [ "C", "D" ] )
                      ]
                    ]
                )

        trans =
            transform
                << flattenAs [ "foo", "bar" ] [ "quant", "cat" ]

        enc =
            encoding
                << position X [ pName "quant", pQuant ]
                << position Y [ pName "cat", pNominal ]
                << color [ mName "key", mMType Nominal ]
    in
    toVegaLite [ data [], trans [], circle [], enc [] ]


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
                << position Y [ pName "city", pNominal ]
    in
    toVegaLite [ data [], trans [], enc [], circle [] ]


fold2 : Spec
fold2 =
    let
        data =
            dataFromColumns []
                << dataColumn "country" (strs [ "USA", "Canada" ])
                << dataColumn "gold" (nums [ 10, 7 ])
                << dataColumn "silver" (nums [ 20, 26 ])

        trans =
            transform
                << foldAs [ "gold", "silver" ] "k" "v"

        enc =
            encoding
                << column [ fName "k", fMType Nominal ]
                << position X [ pName "country", pNominal ]
                << position Y [ pName "v", pQuant ]
                << color [ mName "country", mMType Nominal ]
    in
    toVegaLite [ data [], trans [], bar [], enc [] ]


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
                << position X [ pName "country", pNominal ]
                << position Y [ pRepeat arFlow, pQuant ]
                << color [ mName "country", mMType Nominal ]

        spec =
            asSpec [ data [], trans [], enc [], bar [] ]
    in
    toVegaLite [ repeatFlow [ "gold", "silver" ], specification spec ]


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
                << color [ mName "c", mMType Nominal ]
    in
    toVegaLite [ imputeData [], trans [], line [], enc [] ]


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
                << color [ mName "c", mMType Nominal ]
    in
    toVegaLite [ imputeData [], trans [], line [], enc [] ]


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
                << color [ mName "c", mMType Nominal ]
    in
    toVegaLite [ imputeData [], trans [], line [], enc [] ]


impute4 : Spec
impute4 =
    let
        enc =
            encoding
                << position X [ pName "a", pQuant, pScale [ scNice (niTickCount 1) ] ]
                << position Y [ pName "b", pQuant, pImpute [ imNewValue (num 0) ] ]
                << color [ mName "c", mMType Nominal ]
    in
    toVegaLite [ imputeData [], line [], enc [] ]


impute5 : Spec
impute5 =
    let
        enc =
            encoding
                << position X [ pName "a", pQuant, pScale [ scNice (niTickCount 1) ] ]
                << position Y [ pName "b", pQuant, pImpute [ imMethod imMean ] ]
                << color [ mName "c", mMType Nominal ]
    in
    toVegaLite [ imputeData [], line [], enc [] ]


impute6 : Spec
impute6 =
    let
        enc =
            encoding
                << position X [ pName "a", pQuant, pScale [ scNice (niTickCount 1) ] ]
                << position Y [ pName "b", pQuant, pImpute [ imMethod imMean, imFrame (Just -2) (Just 2) ] ]
                << color [ mName "c", mMType Nominal ]
    in
    toVegaLite [ imputeData [], line [], enc [] ]


impute7 : Spec
impute7 =
    let
        enc =
            encoding
                << position X [ pName "a", pQuant, pScale [ scNice (niTickCount 1) ] ]
                << position Y [ pName "b", pQuant, pImpute [ imNewValue (num 100), imKeyVals (nums [ 4 ]) ] ]
                << color [ mName "c", mMType Nominal ]
    in
    toVegaLite [ imputeData [], line [], enc [] ]


impute8 : Spec
impute8 =
    let
        enc =
            encoding
                << position X [ pName "a", pQuant, pScale [ scNice (niTickCount 1) ] ]
                << position Y [ pName "b", pQuant, pImpute [ imNewValue (num 100), imKeyValSequence 4 6 1 ] ]
                << color [ mName "c", mMType Nominal ]
    in
    toVegaLite [ imputeData [], line [], enc [] ]


sample1 : Spec
sample1 =
    let
        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/cars.json" []

        trans =
            transform
                << sample 200

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]

        spec1 =
            asSpec [ point [], enc [] ]

        spec2 =
            asSpec [ point [], trans [], enc [] ]
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
                << position X [ pName "bin_start", pQuant, pBinned, pAxis [ axTickStep 2 ] ]
                << position X2 [ pName "bin_end", pQuant ]
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
                << position X [ pName "x", pQuant, pBin [] ]
                << position Y [ pAggregate opCount, pQuant ]
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
                << position X [ pName "x", pQuant, pBin [ biAnchor 0.5 ] ]
                << position Y [ pAggregate opCount, pQuant ]
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


sourceExample : Spec
sourceExample =
    annotate1



{- This list comprises the specifications to be provided to the Vega-Lite runtime. -}


mySpecs : Spec
mySpecs =
    combineSpecs
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
            [ Html.text (JE.encode 2 sourceExample) ]
        ]


port elmToJS : Spec -> Cmd msg
