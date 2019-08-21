port module GalleryFacet exposing (elmToJS)

import Platform
import VegaLite exposing (..)



-- NOTE: All data sources in these examples originally provided at
-- https://github.com/vega/vega-datasets
-- The examples themselves reproduce those at https://vega.github.io/vega-lite/examples/


facet1 : Spec
facet1 =
    let
        des =
            description "A trellis bar chart showing the US population distribution of age groups and gender in 2000"

        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/population.json"

        trans =
            transform
                << filter (fiExpr "datum.year == 2000")
                << calculateAs "datum.sex == 2 ? 'Female' : 'Male'" "gender"

        enc =
            encoding
                << position X [ pName "age", pOrdinal ]
                << position Y
                    [ pName "people"
                    , pQuant
                    , pAggregate opSum
                    , pAxis [ axTitle "Population" ]
                    ]
                << color
                    [ mName "gender"
                    , mNominal
                    , mScale [ scRange (raStrs [ "#EA98D2", "#659CCA" ]) ]
                    ]
                << row [ fName "gender", fNominal ]
    in
    toVegaLite [ des, widthStep 17, data [], trans [], bar [], enc [] ]


facet2 : Spec
facet2 =
    let
        des =
            description "Barley crop yields in 1931 and 1932 shown as stacked bar charts"

        enc =
            encoding
                << position X [ pName "yield", pQuant, pAggregate opSum ]
                << position Y [ pName "variety", pNominal ]
                << color [ mName "site", mNominal ]
                << column [ fName "year", fOrdinal ]
    in
    toVegaLite
        [ des
        , dataFromUrl "https://vega.github.io/vega-lite/data/barley.json" []
        , bar []
        , enc []
        ]


facet3 : Spec
facet3 =
    let
        des =
            description "Scatterplots of movie takings vs profits for different MPAA ratings"

        enc =
            encoding
                << position X [ pName "Worldwide_Gross", pQuant ]
                << position Y [ pName "US_DVD_Sales", pQuant ]
                << column [ fName "MPAA_Rating", fOrdinal ]
    in
    toVegaLite
        [ des
        , dataFromUrl "https://vega.github.io/vega-lite/data/movies.json" []
        , point []
        , enc []
        ]


facet4 : Spec
facet4 =
    let
        des =
            description "Disitributions of car engine power for different countries of origin"

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant, pBin [ biMaxBins 15 ] ]
                << position Y [ pQuant, pAggregate opCount ]
                << row [ fName "Origin", fOrdinal ]
    in
    toVegaLite
        [ des
        , dataFromUrl "https://vega.github.io/vega-lite/data/cars.json" []
        , bar []
        , enc []
        ]


facet5 : Spec
facet5 =
    let
        des =
            description "Anscombe's Quartet"

        enc =
            encoding
                << position X [ pName "X", pQuant, pScale [ scZero False ] ]
                << position Y [ pName "Y", pQuant, pScale [ scZero False ] ]
                << opacity [ mNum 1 ]
                << column [ fName "Series", fOrdinal ]
    in
    toVegaLite [ des, dataFromUrl "https://vega.github.io/vega-lite/data/anscombe.json" [], circle [], enc [] ]


facet6 : Spec
facet6 =
    let
        des =
            description "The Trellis display by Becker et al. helped establish small multiples as a 'powerful mechanism for understanding interactions in studies of how a response depends on explanatory variables'"

        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/barley.json"

        enc =
            encoding
                << position X
                    [ pName "yield"
                    , pQuant
                    , pAggregate opMedian
                    , pScale [ scZero False ]
                    ]
                << position Y
                    [ pName "variety"
                    , pOrdinal
                    , pSort [ soByChannel chX, soDescending ]
                    ]
                << color [ mName "year", mNominal ]
    in
    toVegaLite
        [ data []
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
        des =
            description "Stock prices of five large companies as a small multiples of area charts"

        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/stocks.csv"

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
                    , mNominal
                    , mLegend []
                    ]
                << row
                    [ fName "symbol"
                    , fNominal
                    , fHeader [ hdTitle "Stock price", hdLabelAngle 0 ]
                    ]

        res =
            resolve
                << resolution (reScale [ ( chY, reIndependent ) ])

        cfg =
            configure
                << configuration (coView [ vicoStroke Nothing ])
    in
    toVegaLite [ des, width 300, height 50, cfg [], res [], data [], area [], enc [] ]



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
