port module GalleryInteraction exposing (elmToJS)

import Platform
import VegaLite exposing (..)



-- NOTE: All data sources in these examples originally provided at
-- https://github.com/vega/vega-datasets
-- The examples themselves reproduce those at https://vega.github.io/vega-lite/examples/


interaction1 : Spec
interaction1 =
    let
        des =
            description "A bar chart with highlighting on hover and selecting on click. Inspired by Tableau's interaction style."

        config =
            configure
                << configuration (coScale [ sacoBandPaddingInner 0.2 ])

        data =
            dataFromColumns []
                << dataColumn "a" (strs [ "A", "B", "C", "D", "E", "F", "G", "H", "I" ])
                << dataColumn "b" (nums [ 28, 55, 43, 91, 81, 53, 19, 87, 52 ])

        sel =
            selection
                << select "highlight" seSingle [ seOn "mouseover", seEmpty ]
                << select "select" seMulti []

        enc =
            encoding
                << position X [ pName "a", pOrdinal ]
                << position Y [ pName "b", pQuant ]
                << fillOpacity [ mSelectionCondition (selectionName "select") [ mNum 1 ] [ mNum 0.3 ] ]
                << strokeWidth
                    [ mDataCondition
                        [ ( and (selected "select") (expr "length(data(\"select_store\"))"), [ mNum 2 ] )
                        , ( selected "highlight", [ mNum 1 ] )
                        ]
                        [ mNum 0 ]
                    ]
    in
    toVegaLite
        [ des
        , config []
        , data []
        , sel []
        , bar [ maFill "#4C78A8", maStroke "black", maCursor cuPointer ]
        , enc []
        ]


interaction2 : Spec
interaction2 =
    let
        des =
            description "Scatterplot with external links and tooltips"

        trans =
            transform
                << calculateAs "'https://www.google.com/search?q=' + datum.Name" "url"

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]
                << color [ mName "Origin" ]
                << tooltip [ tName "Name" ]
                << hyperlink [ hName "url" ]
    in
    toVegaLite
        [ des
        , dataFromUrl "https://vega.github.io/vega-lite/data/cars.json" []
        , trans []
        , point []
        , enc []
        ]


interaction3 : Spec
interaction3 =
    let
        des =
            description "Drag out a rectangular brush to highlight points"

        sel =
            selection << select "myBrush" seInterval []

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]
                << color
                    [ mSelectionCondition (selectionName "myBrush")
                        [ mName "Cylinders", mOrdinal ]
                        [ mStr "grey" ]
                    ]
    in
    toVegaLite
        [ des
        , dataFromUrl "https://vega.github.io/vega-lite/data/cars.json" []
        , point []
        , sel []
        , enc []
        ]


interaction4 : Spec
interaction4 =
    let
        des =
            description "Area chart with rectangular brush"

        trans =
            transform
                << filter (fiSelection "myBrush")

        sel =
            selection << select "myBrush" seInterval [ seEncodings [ chX ] ]

        enc =
            encoding
                << position X [ pName "date", pTemporal, pTimeUnit yearMonth ]
                << position Y [ pName "count", pQuant, pAggregate opSum ]

        specBackground =
            asSpec [ area [], sel [] ]

        specHighlight =
            asSpec [ area [ maColor "goldenrod" ], trans [] ]
    in
    toVegaLite
        [ des
        , dataFromUrl "https://vega.github.io/vega-lite/data/unemployment-across-industries.json" []
        , enc []
        , layer [ specBackground, specHighlight ]
        ]


interaction5 : Spec
interaction5 =
    let
        des =
            description "Mouse over individual points or select multiple points with the shift key"

        sel =
            selection << select "myPaintbrush" seMulti [ seOn "mouseover", seNearest True ]

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]
                << size
                    [ mSelectionCondition (selectionName "myPaintbrush")
                        [ mNum 300 ]
                        [ mNum 50 ]
                    ]
    in
    toVegaLite
        [ des
        , dataFromUrl "https://vega.github.io/vega-lite/data/cars.json" []
        , point []
        , sel []
        , enc []
        ]


interaction6 : Spec
interaction6 =
    let
        des =
            description "Drag to pan. Zoom in or out with mousewheel/zoom gesture."

        sel =
            selection << select "myGrid" seInterval [ seBindScales ]

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant, pScale [ scDomain (doNums [ 75, 150 ]) ] ]
                << position Y [ pName "Miles_per_Gallon", pQuant, pScale [ scDomain (doNums [ 20, 40 ]) ] ]
                << size [ mName "Cylinders", mQuant ]
    in
    toVegaLite
        [ des
        , dataFromUrl "https://vega.github.io/vega-lite/data/cars.json" []
        , circle []
        , sel []
        , enc []
        ]


interaction7 : Spec
interaction7 =
    let
        des =
            description "Drag the sliders to highlight points"

        trans =
            transform
                << calculateAs "year(datum.Year)" "Year"

        sel1 =
            selection
                << select "CylYr"
                    seSingle
                    [ seFields [ "Cylinders", "Year" ]
                    , seInit [ ( "Cylinders", num 4 ), ( "Year", num 1977 ) ]
                    , seBind
                        [ iRange "Cylinders" [ inName "Cylinders ", inMin 3, inMax 8, inStep 1 ]
                        , iRange "Year" [ inName "Year ", inMin 1969, inMax 1981, inStep 1 ]
                        ]
                    ]

        encPosition =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]

        enc1 =
            encoding
                << color
                    [ mSelectionCondition (selectionName "CylYr")
                        [ mName "Origin" ]
                        [ mStr "grey" ]
                    ]

        spec1 =
            asSpec [ sel1 [], circle [], enc1 [] ]

        trans2 =
            transform
                << filter (fiSelection "CylYr")

        enc2 =
            encoding
                << color [ mName "Origin" ]
                << size [ mNum 100 ]

        spec2 =
            asSpec [ trans2 [], circle [], enc2 [] ]
    in
    toVegaLite
        [ des
        , dataFromUrl "https://vega.github.io/vega-lite/data/cars.json" []
        , trans []
        , encPosition []
        , layer [ spec1, spec2 ]
        ]


interaction8 : Spec
interaction8 =
    let
        des =
            description "Drag over bars to update selection average"

        sel =
            selection << select "myBrush" seInterval [ seEncodings [ chX ] ]

        encPosition =
            encoding << position Y [ pName "precipitation", pQuant, pAggregate opMean ]

        enc1 =
            encoding
                << position X [ pName "date", pOrdinal, pTimeUnit month ]
                << opacity
                    [ mSelectionCondition (selectionName "myBrush")
                        [ mNum 1 ]
                        [ mNum 0.7 ]
                    ]

        spec1 =
            asSpec [ sel [], bar [], enc1 [] ]

        trans =
            transform
                << filter (fiSelection "myBrush")

        enc2 =
            encoding
                << color [ mStr "firebrick" ]
                << size [ mNum 3 ]

        spec2 =
            asSpec [ des, trans [], rule [], enc2 [] ]
    in
    toVegaLite
        [ dataFromUrl "https://vega.github.io/vega-lite/data/seattle-weather.csv" []
        , encPosition []
        , layer [ spec1, spec2 ]
        ]


interaction9 : Spec
interaction9 =
    let
        desc =
            description "Multi-series line chart with positioned labels and interactive highlight on hover."

        cfg =
            configure
                << configuration (coView [ vicoStroke Nothing ])

        stockData =
            dataFromUrl "https://vega.github.io/vega-lite/data/stocks.csv"
                [ parse [ ( "date", foDate "" ) ] ]

        trans =
            transform
                << filter (fiExpr "datum.symbol !== 'IBM'")

        enc =
            encoding
                << color
                    [ mSelectionCondition (selectionName "myHover")
                        [ mName "symbol", mLegend [] ]
                        [ mStr "grey" ]
                    ]
                << opacity
                    [ mSelectionCondition (selectionName "myHover")
                        [ mNum 1 ]
                        [ mNum 0.2 ]
                    ]

        enc1 =
            encoding
                << position X [ pName "date", pTemporal, pTitle "" ]
                << position Y [ pName "price", pQuant, pTitle "Price" ]

        sel1 =
            selection
                << select "myHover"
                    seSingle
                    [ seOn "mouseover"
                    , seEmpty
                    , seFields [ "symbol" ]
                    , seInit [ ( "symbol", str "AAPL" ) ]
                    ]

        spec1 =
            asSpec
                [ enc1 []
                , layer
                    [ asSpec
                        [ description "Transparent layer to make it easier to trigger selection"
                        , sel1 []
                        , line [ maStrokeWidth 8, maStroke "transparent" ]
                        ]
                    , asSpec [ line [] ]
                    ]
                ]

        enc2 =
            encoding
                << position X [ pName "date", pTemporal, pAggregate opMax ]
                << position Y [ pName "price", pQuant, pAggregate (opArgMax (Just "date")) ]

        enc2_1 =
            encoding
                << text [ tName "symbol" ]

        spec2 =
            asSpec
                [ enc2 []
                , layer
                    [ asSpec [ circle [] ]
                    , asSpec [ enc2_1 [], textMark [ maAlign haLeft, maDx 4 ] ]
                    ]
                ]
    in
    toVegaLite [ cfg [], stockData, trans [], enc [], layer [ spec1, spec2 ] ]


interaction10 : Spec
interaction10 =
    let
        desc =
            description "Displays labels for all stock prices of the hovered time"

        stockData =
            dataFromUrl "https://vega.github.io/vega-lite/data/stocks.csv"
                [ parse [ ( "date", foDate "" ) ] ]

        enc1 =
            encoding
                << position X [ pName "date", pTemporal ]
                << position Y [ pName "price", pQuant ]
                << color [ mName "symbol" ]

        spec1 =
            asSpec
                [ enc1 []
                , layer
                    [ asSpec [ line [] ]
                    , asSpec [ point [], sel1_2 [], enc1_2 [] ]
                    ]
                ]

        enc1_2 =
            encoding
                << opacity [ mSelectionCondition (expr "myTooltip") [ mNum 1 ] [ mNum 0 ] ]

        sel1_2 =
            selection
                << select "myTooltip"
                    seSingle
                    [ seNearest True
                    , seOn "mouseover"
                    , seEncodings [ chX ]
                    , seEmpty
                    ]

        spec2 =
            asSpec [ trans2 [], layer [ spec2_1, spec2_2 ] ]

        trans2 =
            transform << filter (fiSelection "myTooltip")

        spec2_1 =
            asSpec [ rule [ maColor "gray" ], enc2_1 [] ]

        enc2_1 =
            encoding << position X [ pName "date", pTemporal ]

        spec2_2 =
            asSpec [ textMark [ maAlign haLeft, maDx 5, maDy -5 ], enc2_2 [] ]

        enc2_2 =
            encoding
                << position X [ pName "date", pTemporal ]
                << position Y [ pName "price", pQuant ]
                << text [ tName "price", tQuant ]
                << color [ mName "symbol" ]
    in
    toVegaLite [ width 400, height 300, stockData, layer [ spec1, spec2 ] ]


interaction11 : Spec
interaction11 =
    let
        desc =
            description "Displays tooltips for all stock prices of the hovered time"

        stockData =
            dataFromUrl "https://vega.github.io/vega-lite/data/stocks.csv"
                [ parse [ ( "date", foDate "" ) ] ]

        enc =
            encoding
                << position X [ pName "date", pTemporal ]

        transSelFilter =
            transform
                << filter (fiSelection "hover")

        enc1 =
            encoding
                << position Y [ pName "price", pQuant ]
                << color [ mName "symbol" ]

        spec1 =
            asSpec
                [ enc1 []
                , layer
                    [ asSpec [ line [] ]
                    , asSpec [ transSelFilter [], point [] ]
                    ]
                ]

        sel =
            selection
                << select "hover"
                    seSingle
                    [ seFields [ "date" ]
                    , seEmpty
                    , seOn "mouseover"
                    , seClear "mouseout"
                    , seNearest True
                    ]

        transPivot =
            transform
                << pivot "symbol" "price" [ piGroupBy [ "date" ] ]

        enc2 =
            encoding
                << opacity [ mSelectionCondition (expr "hover") [ mNum 0.3 ] [ mNum 0 ] ]
                << tooltips
                    [ [ tName "AAPL", tQuant ]
                    , [ tName "AMZN", tQuant ]
                    , [ tName "GOOG", tQuant ]
                    , [ tName "IBM", tQuant ]
                    , [ tName "MSFT", tQuant ]
                    ]

        spec2 =
            asSpec [ sel [], transPivot [], enc2 [], rule [] ]
    in
    toVegaLite [ width 400, height 300, stockData, enc [], layer [ spec1, spec2 ] ]


interaction12 : Spec
interaction12 =
    let
        stockData =
            dataFromUrl "https://vega.github.io/vega-lite/data/stocks.csv"
                [ csv, parse [ ( "date", foDate "" ) ] ]

        sel =
            selection
                << select "index"
                    seSingle
                    [ seOn "mouseover"
                    , seEncodings [ chX ]
                    , seNearest True
                    , seInit [ ( "x", dt [ dtYear 2005, dtMonthNum Jan, dtDate 1 ] ) ]
                    ]

        trans =
            transform
                << lookupSelection "symbol" "index" "symbol"
                << calculateAs "datum.index && datum.index.price > 0 ? (datum.price - datum.index.price)/datum.index.price : 0"
                    "indexed_price"

        pointEnc =
            encoding
                << position X [ pName "date", pTemporal, pAxis [] ]

        pointSpec =
            asSpec [ sel [], pointEnc [], point [ maOpacity 0 ] ]

        lineEnc =
            encoding
                << position X [ pName "date", pTemporal, pAxis [] ]
                << position Y [ pName "indexed_price", pQuant, pAxis [ axFormat "%" ] ]
                << color [ mName "symbol" ]

        lineSpec =
            asSpec [ trans [], lineEnc [], line [] ]

        ruleTrans =
            transform
                << filter (fiSelection "index")

        ruleEnc =
            encoding
                << position X [ pName "date", pTemporal, pAxis [] ]
                << color [ mStr "firebrick" ]

        textEnc =
            encoding
                << position Y [ pNum 310 ]
                << text [ tName "date", tTemporal, tTimeUnit yearMonth ]

        labelledRuleSpec =
            asSpec
                [ ruleTrans []
                , ruleEnc []
                , layer
                    [ asSpec [ rule [ maStrokeWidth 0.5 ] ]
                    , asSpec [ textEnc [], textMark [ maAlign haCenter, maFontWeight W100 ] ]
                    ]
                ]
    in
    toVegaLite [ width 650, height 300, stockData, layer [ pointSpec, lineSpec, labelledRuleSpec ] ]


interaction13 : Spec
interaction13 =
    let
        desc =
            description "Multi Series Line Chart with Tooltip"

        config =
            configure
                << configuration (coAxis [ axcoMinExtent 30 ] |> coAxisYFilter)

        enc =
            encoding
                << position X [ pName "date", pTemporal, pTimeUnit yearMonthDate ]
                << tooltips
                    [ [ tName "date", tTemporal, tTimeUnit yearMonthDate ]
                    , [ tName "temp_max", tQuant ]
                    , [ tName "temp_min", tQuant ]
                    ]

        enc1 =
            encoding
                << position Y [ pName "temp_max", pQuant ]

        spec1 =
            asSpec [ line [ maColor "orange" ], enc1 [] ]

        enc2 =
            encoding
                << position Y [ pName "temp_min", pQuant ]

        spec2 =
            asSpec [ line [ maColor "red" ], enc2 [] ]

        sel =
            selection
                << select "hover" seSingle [ seOn "mouseover", seEmpty ]

        enc3 =
            encoding
                << color
                    [ mSelectionCondition (VegaLite.not (selectionName "hover"))
                        [ mStr "transparent" ]
                        []
                    ]

        spec3 =
            asSpec [ sel [], rule [], enc3 [] ]
    in
    toVegaLite
        [ config []
        , dataFromUrl "https://vega.github.io/vega-lite/data/seattle-weather.csv" []
        , enc []
        , layer [ spec1, spec2, spec3 ]
        ]


interaction14 : Spec
interaction14 =
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
        [ cfg []
        , data []
        , trans []
        , res []
        , hConcat [ specPoint, specHPText, specMPGText, specOriginText ]
        ]


interaction15 : Spec
interaction15 =
    let
        data =
            dataFromColumns []
                << dataColumn "actual" (strs [ "A", "A", "A", "B", "B", "B", "C", "C", "C" ])
                << dataColumn "predicted" (strs [ "A", "B", "C", "A", "B", "C", "A", "B", "C" ])
                << dataColumn "count" (nums [ 13, 0, 0, 0, 10, 6, 0, 0, 9 ])

        sel =
            selection
                << select "highlight" seSingle []

        cfg =
            configure
                << configuration (coScale [ sacoBandPaddingInner 0, sacoBandPaddingOuter 0 ])
                << configuration (coRange [ racoRamp "yellowgreenblue" ])
                << configuration (coView [ vicoStep 40 ])
                << configuration (coAxis [ axcoDomain False ])
                << configuration (coAxis [ axcoLabelAngle 0 ] |> coAxisXFilter)

        enc =
            encoding
                << position X [ pName "predicted" ]
                << position Y [ pName "actual" ]
                << fill [ mName "count", mQuant ]
                << stroke
                    [ mDataCondition
                        [ ( and (selected "highlight")
                                (expr "length(data(\"highlight_store\"))")
                          , [ mStr "black" ]
                          )
                        ]
                        [ mStr "" ]
                    ]
                << opacity
                    [ mSelectionCondition (selectionName "highlight")
                        [ mNum 1 ]
                        [ mNum 0.5 ]
                    ]
    in
    toVegaLite [ cfg [], data [], sel [], enc [], bar [] ]


interaction16 : Spec
interaction16 =
    let
        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/cars.json"

        sel =
            selection
                << select "brush" seInterval [ seEncodings [ chY ] ]

        encMain =
            encoding
                << position Y
                    [ pName "Name"
                    , pScale [ scDomain (doSelection "brush") ]
                    , pAxis [ axMinExtent 200, axTitle "" ]
                    , pSort [ soByChannel chX, soDescending ]
                    ]
                << position X
                    [ pAggregate opCount
                    , pQuant
                    , pScale [ scDomain (doNums [ 0, 6 ]) ]
                    , pAxis [ axOrient siTop ]
                    ]

        specMain =
            asSpec [ encMain [], bar [] ]

        encMini =
            encoding
                << position Y
                    [ pName "Name"
                    , pSort [ soByChannel chX, soDescending ]
                    , pAxis []
                    ]
                << position X [ pAggregate opCount, pQuant, pAxis [] ]

        specMini =
            asSpec [ width 50, height 200, sel [], encMini [], bar [] ]
    in
    toVegaLite [ data [], hConcat [ specMain, specMini ] ]



{- This list comprises the specifications to be provided to the Vega-Lite runtime. -}


mySpecs : Spec
mySpecs =
    combineSpecs
        [ ( "interaction1", interaction1 )
        , ( "interaction2", interaction2 )
        , ( "interaction3", interaction3 )
        , ( "interaction4", interaction4 )
        , ( "interaction5", interaction5 )
        , ( "interaction6", interaction6 )
        , ( "interaction7", interaction7 )
        , ( "interaction8", interaction8 )
        , ( "interaction9", interaction9 )
        , ( "interaction10", interaction10 )
        , ( "interaction11", interaction11 )
        , ( "interaction12", interaction12 )
        , ( "interaction13", interaction13 )
        , ( "interaction14", interaction14 )
        , ( "interaction15", interaction15 )
        , ( "interaction16", interaction16 )
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
