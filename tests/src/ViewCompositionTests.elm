port module ViewCompositionTests exposing (elmToJS)

import Browser
import Dict
import Html exposing (Html)
import Html.Attributes
import Html.Events
import Json.Encode
import VegaLite exposing (..)


path : String
path =
    "https://cdn.jsdelivr.net/npm/vega-datasets@2.2/data/"


genderChart : List HeaderProperty -> List HeaderProperty -> Spec
genderChart hdProps cProps =
    let
        cfg2 =
            configure
                << configuration (coHeader cProps)
                << configuration (coFacet [ facoSpacing 80 ])

        popData =
            dataFromUrl (path ++ "population.json") []

        trans =
            transform
                << filter (fiExpr "datum.year == 2000")
                << calculateAs "datum.sex == 2 ? 'Female' : 'Male'" "gender"

        enc =
            encoding
                << column [ fName "gender", fHeader hdProps ]
                << position X [ pName "age", pOrdinal ]
                << position Y [ pName "people", pAggregate opSum, pTitle "Population" ]
                << color [ mName "gender", mScale [ scRange (raStrs [ "#675193", "#ca8861" ]) ] ]
    in
    toVegaLite [ widthStep 17, cfg2 [], popData, trans [], enc [], bar [] ]


columns1 : Spec
columns1 =
    genderChart [] []


columns2 : Spec
columns2 =
    genderChart [ hdTitleFontSize 20, hdLabelFontSize 15 ] []


columns3 : Spec
columns3 =
    genderChart [] [ hdTitleFontSize 20, hdLabelFontSize 15 ]


columns4 : Spec
columns4 =
    genderChart
        [ hdTitleFontSize 20
        , hdLabelFontSize 15
        , hdTitlePadding -27
        , hdLabelPadding 40
        ]
        []


columns5 : Spec
columns5 =
    genderChart []
        [ hdLabelBaseline vaLineTop
        , hdLabelLineHeight 60
        , hdLabelFontStyle "italic"
        , hdLabelFontWeight fwBold
        ]


columns6 : Spec
columns6 =
    genderChart
        [ hdTitleFontStyle "italic"
        , hdTitleFontWeight (fwValue 300)
        , hdTitleBaseline vaLineTop
        , hdTitleLineHeight 60
        , hdLabels False
        ]
        [ hdTitleFontStyle "italic"
        , hdTitleFontWeight (fwValue 300)
        , hdTitleBaseline vaLineTop
        , hdTitleLineHeight 60
        , hdLabels False
        ]


data : List DataColumn -> Data
data =
    let
        rows =
            List.concatMap (\x -> List.repeat (3 * 5) x) [ 1, 2, 3, 4 ] |> nums

        cols =
            List.concatMap (\x -> List.repeat 3 x) [ 1, 2, 3, 4, 5 ]
                |> List.repeat 4
                |> List.concat
                |> nums

        cats =
            List.repeat (4 * 5) [ 1, 2, 3 ] |> List.concat |> nums

        vals =
            [ 30, 15, 12, 25, 30, 25, 10, 28, 11, 18, 24, 16, 10, 10, 10, 8, 8, 29, 11, 24, 12, 26, 32, 9, 8, 18, 28, 8, 20, 24, 21, 15, 20, 4, 13, 12, 27, 21, 14, 5, 1, 2, 11, 2, 5, 14, 20, 24, 20, 2, 9, 15, 14, 13, 22, 30, 30, 10, 8, 12 ]
                |> nums
    in
    dataFromColumns []
        << dataColumn "row" rows
        << dataColumn "col" cols
        << dataColumn "cat" cats
        << dataColumn "val" vals


cfg : List LabelledSpec -> ( VLProperty, Spec )
cfg =
    -- Styling to remove axis gridlines and labels
    configure
        << configuration (coHeader [ hdLabelFontSize 0.1 ])
        << configuration (coView [ vicoStroke Nothing, vicoContinuousHeight 120 ])
        << configuration (coFacet [ facoSpacing 80, facoColumns 5 ])


grid1 : Spec
grid1 =
    let
        encByCatVal =
            encoding
                << position X [ pName "cat", pOrdinal, pAxis [] ]
                << position Y [ pName "val", pQuant, pAxis [] ]
                << color [ mName "cat", mLegend [] ]

        specByCatVal =
            asSpec [ width 120, height 120, bar [], encByCatVal [] ]
    in
    toVegaLite
        [ cfg []
        , data []
        , spacingRC 20 80
        , specification specByCatVal
        , facet
            [ rowBy [ fName "row", fOrdinal, fHeader [ hdTitle "" ] ]
            , columnBy [ fName "col", fOrdinal, fHeader [ hdTitle "" ] ]
            ]
        ]


grid2 : Spec
grid2 =
    let
        encByCatVal =
            encoding
                << position X [ pName "cat", pOrdinal, pAxis [] ]
                << position Y [ pName "val", pQuant, pAxis [] ]
                << color [ mName "cat", mLegend [] ]

        specByCatVal =
            asSpec [ width 120, height 120, bar [], encByCatVal [] ]

        trans =
            transform
                << calculateAs "datum.row * 1000 + datum.col" "index"
    in
    toVegaLite
        [ cfg []
        , data []
        , trans []
        , columns 5
        , specification specByCatVal
        , facetFlow [ fName "index", fOrdinal, fHeader [ hdTitle "" ] ]
        ]


grid3 : Spec
grid3 =
    let
        encByCatVal =
            encoding
                << position X [ pName "cat", pOrdinal, pAxis [] ]
                << position Y [ pName "val", pQuant, pAxis [] ]
                << color [ mName "cat", mLegend [] ]

        specByCatVal =
            asSpec [ width 120, height 120, bar [], encByCatVal [] ]

        trans =
            transform
                << calculateAs "datum.row * 1000 + datum.col" "index"
    in
    toVegaLite
        [ cfg []
        , data []
        , trans []
        , columns 0
        , specification specByCatVal
        , facetFlow [ fName "index", fOrdinal, fHeader [ hdTitle "" ] ]
        ]


grid4 : Spec
grid4 =
    let
        carData =
            dataFromUrl (path ++ "cars.json") []

        enc =
            encoding
                << position X [ pRepeat arFlow, pBin [] ]
                << position Y [ pAggregate opCount ]
                << color [ mName "Origin" ]
    in
    toVegaLite
        [ columns 3
        , repeatFlow [ "Horsepower", "Miles_per_Gallon", "Acceleration", "Displacement", "Weight_in_lbs" ]
        , specification (asSpec [ carData, enc [], bar [] ])
        ]


grid5 : Spec
grid5 =
    let
        carData =
            dataFromUrl (path ++ "cars.json") []

        enc =
            encoding
                << position X [ pRepeat arRow, pBin [] ]
                << position Y [ pAggregate opCount ]
                << color [ mName "Origin" ]
    in
    toVegaLite
        [ repeat [ rowFields [ "Horsepower", "Miles_per_Gallon", "Acceleration", "Displacement", "Weight_in_lbs" ] ]
        , specification (asSpec [ carData, enc [], bar [] ])
        ]


concat1 : Spec
concat1 =
    let
        cfgBorder =
            configure
                << configuration (coView [ vicoStrokeWidth 2, vicoStroke (Just "black") ])

        geojson =
            geometry (geoPolygon [ [ ( -3, 60 ), ( 4, 60 ), ( 4, 40 ), ( -3, 40 ), ( -3, 60 ) ] ]) []

        chartData =
            dataFromColumns []
                << dataColumn "x" (nums [ 1, 2 ])
                << dataColumn "y" (nums [ 30, 20 ])

        enc =
            encoding
                << position X [ pName "x", pQuant ]
                << position Y [ pName "y", pQuant ]

        chart1Spec =
            asSpec [ width 300, chartData [], enc [], circle [] ]

        chartSpec =
            asSpec [ vConcat [ chart1Spec ] ]

        mapSpec =
            asSpec [ width 100, height 400, dataFromJson geojson [], geoshape [] ]
    in
    toVegaLite
        [ cfgBorder []
        , hConcat [ chartSpec, mapSpec ]
        ]


concat2 : Spec
concat2 =
    let
        geoData =
            dataFromUrl (path ++ "us-10m.json") [ topojsonFeature "counties" ]

        attData =
            dataFromColumns []
                << dataColumn "id" (nums [ 1001, 1003, 1005 ])
                << dataColumn "rate" (nums [ 0.9, 0.7, 0.5 ])

        trans =
            transform
                << lookup "id" (attData []) "id" (luFields [ "rate" ])

        geoEnc =
            encoding
                << color [ mName "rate", mQuant ]

        mapSpec =
            asSpec [ geoData, trans [], geoEnc [], geoshape [] ]

        enc =
            encoding
                << position X [ pName "rate", pBin [] ]
                << position Y [ pAggregate opCount ]

        chartSpec =
            asSpec [ attData [], enc [], bar [] ]
    in
    toVegaLite [ hConcat [ mapSpec, chartSpec ] ]


padding1 : Spec
padding1 =
    let
        prm =
            params [ ( "pd", [ paValue (num 0), paBind (ipRange [ inName "padding", inMin 0, inMax 100, inStep 1 ]) ] ) ]

        carData =
            dataFromUrl (path ++ "cars.json") []

        enc =
            encoding
                << position X [ pName "Horsepower", pBin [] ]
                << position Y [ pAggregate opCount ]
                << color [ mName "Origin" ]
    in
    toVegaLite
        [ prm
        , width 300
        , height 300
        , autosize [ asFit ]
        , padding (paSizeExpr "pd")
        , carData
        , enc []
        , bar []
        ]


padding2 : Spec
padding2 =
    let
        prm =
            params
                [ ( "l", [ paValue (num 0), paBind (ipRange [ inName "left padding", inMin 0, inMax 50, inStep 1 ]) ] )
                , ( "t", [ paValue (num 0), paBind (ipRange [ inName "top padding", inMin 0, inMax 50, inStep 1 ]) ] )
                , ( "r", [ paValue (num 0), paBind (ipRange [ inName "right padding", inMin 0, inMax 50, inStep 1 ]) ] )
                , ( "b", [ paValue (num 0), paBind (ipRange [ inName "bottom padding", inMin 0, inMax 50, inStep 1 ]) ] )
                ]

        carData =
            dataFromUrl (path ++ "cars.json") []

        enc =
            encoding
                << position X [ pName "Horsepower", pBin [] ]
                << position Y [ pAggregate opCount ]
                << color [ mName "Origin" ]
    in
    toVegaLite
        [ prm
        , width 300
        , height 300
        , autosize [ asFit ]
        , padding (paEdgesExpr "l" "t" "r" "b")
        , carData
        , enc []
        , bar []
        ]


background1 : Spec
background1 =
    let
        prm =
            params
                [ ( "fc", [ paValue (str "white"), paBind (ipColor []) ] )
                , ( "sc", [ paValue (str "black"), paBind (ipColor []) ] )
                , ( "cr", [ paValue (num 0), paBind (ipRange [ inName "Corner radius", inMin 0, inMax 100, inStep 1 ]) ] )
                , ( "fo", [ paValue (num 1), paBind (ipRange [ inName "Fill opacity", inMin 0, inMax 1 ]) ] )
                , ( "so", [ paValue (num 1), paBind (ipRange [ inName "Stroke opacity", inMin 0, inMax 1 ]) ] )
                , ( "sw", [ paValue (num 1), paBind (ipRange [ inName "Stroke width ", inMin 0, inMax 20 ]) ] )
                ]

        carData =
            dataFromUrl (path ++ "cars.json") []

        enc =
            encoding
                << position X [ pName "Horsepower", pBin [], pAxis [] ]
                << position Y [ pAggregate opCount, pAxis [] ]
                << color [ mName "Origin" ]
    in
    toVegaLite
        [ prm
        , width 300
        , height 300
        , viewBackground
            [ viewFill |> viewBackgroundStrExpr "fc"
            , viewStroke |> viewBackgroundStrExpr "sc"
            , viewCornerRadius |> viewBackgroundNumExpr "cr"
            , viewFillOpacity |> viewBackgroundNumExpr "fo"
            , viewStrokeOpacity |> viewBackgroundNumExpr "so"
            , viewStrokeWidth |> viewBackgroundNumExpr "sw"
            ]
        , carData
        , enc []
        , bar []
        ]



{- Ids and specifications to be provided to the Vega-Lite runtime. -}


specs : List ( String, Spec )
specs =
    [ ( "columns1", columns1 )
    , ( "columns2", columns2 )
    , ( "columns3", columns3 )
    , ( "columns4", columns4 )
    , ( "columns5", columns5 )
    , ( "columns6", columns6 )
    , ( "grid1", grid1 )
    , ( "grid2", grid2 )
    , ( "grid3", grid3 )
    , ( "grid4", grid4 )
    , ( "grid5", grid5 )
    , ( "concat1", concat1 )
    , ( "concat2", concat2 )
    , ( "padding1", padding1 )
    , ( "padding2", padding2 )
    , ( "background1", background1 )
    ]



{- ---------------------------------------------------------------------------
   BOILERPLATE: NO NEED TO EDIT

   The code below creates an Elm module that opens an outgoing port to Javascript
   and sends both the specs and DOM node to it.
   It allows the source code of any of the generated specs to be selected from
   a drop-down list. Useful for viewing specs that might generate invalid Vega-Lite.
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
