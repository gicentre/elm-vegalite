port module GalleryFacet exposing (elmToJS)

import Platform
import VegaLite exposing (..)



-- NOTE: All data sources in these examples originally provided at
-- https://github.com/vega/vega-datasets
-- The examples themselves reproduce those at https://vega.github.io/vega-lite/examples/


path : String
path =
    "https://cdn.jsdelivr.net/npm/vega-datasets@2.1/data/"


facet1 : Spec
facet1 =
    let
        desc =
            description "A trellis bar chart showing the US population distribution of age groups and gender in 2000"

        data =
            dataFromUrl (path ++ "population.json") []

        trans =
            transform
                << filter (fiExpr "datum.year == 2000")
                << calculateAs "datum.sex == 2 ? 'Female' : 'Male'" "gender"

        enc =
            encoding
                << position X [ pName "age", pOrdinal, pAxis [ axLabelAngle 0 ] ]
                << position Y [ pName "people", pAggregate opSum, pTitle "population" ]
                << color
                    [ mName "gender"
                    , mScale [ scRange (raStrs [ "#675193", "#ca8861" ]) ]
                    , mLegend []
                    ]
                << row [ fName "gender", fHeader [ hdTitle "" ] ]
    in
    toVegaLite [ desc, widthStep 17, data, trans [], enc [], bar [] ]


facet2 : Spec
facet2 =
    let
        desc =
            description "Barley crop yields in 1931 and 1932 shown as stacked bar charts"

        data =
            dataFromUrl (path ++ "barley.json") []

        enc =
            encoding
                << position X [ pName "yield", pAggregate opSum ]
                << position Y [ pName "variety" ]
                << color [ mName "site" ]
                << column [ fName "year", fOrdinal ]
    in
    toVegaLite [ desc, data, enc [], bar [] ]


facet3 : Spec
facet3 =
    let
        desc =
            description "Scatterplots of movie takings vs profits for different MPAA ratings"

        data =
            dataFromUrl (path ++ "movies.json") []

        enc =
            encoding
                << position X [ pName "Worldwide Gross", pQuant ]
                << position Y [ pName "US DVD Sales", pQuant ]
                << column [ fName "MPAA Rating", fOrdinal ]
    in
    toVegaLite [ desc, data, enc [], point [] ]


facet4 : Spec
facet4 =
    let
        desc =
            description "Disitributions of car engine power for different countries of origin"

        data =
            dataFromUrl (path ++ "cars.json") []

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant, pBin [ biMaxBins 15 ] ]
                << position Y [ pAggregate opCount ]
                << row [ fName "Origin", fOrdinal ]
    in
    toVegaLite [ desc, data, enc [], bar [] ]


facet5 : Spec
facet5 =
    let
        desc =
            description "Anscombe's Quartet"

        data =
            dataFromUrl (path ++ "anscombe.json") []

        trans =
            transform
                << regression "Y" "X" [ rgExtent 0 20, rgAs "rx" "ry" ]

        encScatter =
            encoding
                << position X [ pName "X", pQuant, pAxis [ axTitle "", axGrid False ] ]
                << position Y [ pName "Y", pQuant, pAxis [ axTitle "", axGrid False ] ]

        encLine =
            encoding
                << position X [ pName "rx", pQuant ]
                << position Y [ pName "ry", pQuant ]

        scatter =
            asSpec [ encScatter [], circle [ maOpacity 1, maColor "black" ] ]

        rLine =
            asSpec [ trans [], encLine [], line [ maStrokeWidth 1 ] ]
    in
    toVegaLite
        [ desc
        , data
        , columns 2
        , facetFlow [ fName "Series", fOrdinal, fHeader [ hdTitle "" ] ]
        , specification (asSpec [ layer [ scatter, rLine ] ])
        ]


facet6 : Spec
facet6 =
    let
        desc =
            description "The Trellis display by Becker et al. helped establish small multiples as a 'powerful mechanism for understanding interactions in studies of how a response depends on explanatory variables'"

        data =
            dataFromUrl (path ++ "barley.json") []

        enc =
            encoding
                << position X [ pName "yield", pAggregate opMedian, pScale [ scZero False ] ]
                << position Y
                    [ pName "variety"
                    , pOrdinal
                    , pSort [ soByChannel chX, soDescending ]
                    ]
                << color [ mName "year" ]
    in
    toVegaLite
        [ data
        , columns 2
        , facetFlow
            [ fName "site"
            , fOrdinal
            , fSort [ soByField "yield" opMedian ]
            , fHeader [ hdTitle "" ]
            ]
        , specification (asSpec [ heightStep 12, enc [], point [] ])
        ]


facet7 : Spec
facet7 =
    let
        desc =
            description "Stock prices of five large companies as a small multiples of area charts"

        data =
            dataFromUrl (path ++ "stocks.csv") []

        trans =
            transform
                << filter (fiExpr "datum.symbol !== 'GOOG'")

        enc =
            encoding
                << position X
                    [ pName "date"
                    , pTemporal
                    , pAxis [ axFormat "%Y", axTitle "", axGrid False ]
                    ]
                << position Y
                    [ pName "price"
                    , pQuant
                    , pAxis [ axTitle "", axGrid False ]
                    ]
                << color
                    [ mName "symbol"
                    , mLegend []
                    ]
                << row
                    [ fName "symbol"
                    , fHeader [ hdTitle "Stock price", hdLabelAngle 0, hdLabelAnchor anStart ]
                    ]

        cfg =
            configure
                << configuration (coView [ vicoStroke Nothing ])
    in
    toVegaLite [ desc, width 300, height 50, cfg [], data, trans [], area [], enc [] ]


facet8 : Spec
facet8 =
    let
        desc =
            description "A simple grid of bar charts to compare performance data."

        data =
            dataFromColumns []
                << dataColumn "a" (List.repeat 9 "a1" ++ List.repeat 9 "a2" ++ List.repeat 9 "a3" |> strs)
                << dataColumn "b" (List.repeat 3 "b1" ++ List.repeat 3 "b2" ++ List.repeat 3 "b3" |> List.repeat 3 |> List.concat |> strs)
                << dataColumn "c" (List.repeat 9 [ "x", "y", "z" ] |> List.concat |> strs)
                << dataColumn "p" (nums [ 0.14, 0.6, 0.03, 0.8, 0.38, 0.55, 0.11, 0.58, 0.79, 0.83, 0.87, 0.67, 0.97, 0.84, 0.9, 0.74, 0.64, 0.19, 0.57, 0.35, 0.49, 0.91, 0.38, 0.91, 0.99, 0.8, 0.37 ])

        enc =
            encoding
                << position X [ pName "p", pQuant, pAxis [ axFormat "%", axTitle "" ] ]
                << position Y [ pName "c", pAxis [] ]
                << color
                    [ mName "c"
                    , mLegend [ leOrient loBottom, leTitleOrient loLeft, leTitle "settings" ]
                    ]
                << row [ fName "a", fHeader [ hdTitle "Factor A", hdLabelAngle 0 ] ]
                << column [ fName "b", fHeader [ hdTitle "Factor B" ] ]

        res =
            resolve
                << resolution (reScale [ ( chY, reIndependent ) ])
    in
    toVegaLite [ desc, width 60, heightStep 8, spacing 5, data [], enc [], bar [] ]



{- This list comprises the specifications to be provided to the Vega-Lite runtime. -}


mySpecs : Spec
mySpecs =
    combineSpecs
        [ ( "facet1", facet1 )
        , ( "facet2", facet2 )
        , ( "facet3", facet3 )
        , ( "facet4", facet4 )
        , ( "facet5", facet5 )
        , ( "facet6", facet6 )
        , ( "facet7", facet7 )
        , ( "facet8", facet8 )
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
