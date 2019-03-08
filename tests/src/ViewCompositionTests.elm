port module ViewCompositionTests exposing (elmToJS)

import Browser
import Html exposing (Html, div, pre)
import Html.Attributes exposing (id)
import Json.Encode
import VegaLite exposing (..)


genderChart : List HeaderProperty -> List HeaderProperty -> Spec
genderChart hdProps cProps =
    let
        conf =
            configure << configuration (coHeader cProps)

        pop =
            dataFromUrl "https://vega.github.io/vega-lite/data/population.json" []

        trans =
            transform
                << filter (fiExpr "datum.year == 2000")
                << calculateAs "datum.sex == 2 ? 'Female' : 'Male'" "gender"

        enc =
            encoding
                << column
                    [ fName "gender"
                    , fMType Nominal
                    , fHeader hdProps
                    ]
                << position X
                    [ pName "age"
                    , pMType Ordinal
                    , pScale [ scRangeStep (Just 17) ]
                    ]
                << position Y
                    [ pName "people"
                    , pMType Quantitative
                    , pAggregate opSum
                    , pAxis [ axTitle "Population" ]
                    ]
                << color
                    [ mName "gender"
                    , mMType Nominal
                    , mScale [ scRange (raStrs [ "#EA98D2", "#659CCA" ]) ]
                    ]
    in
    toVegaLite [ conf [], pop, trans [], enc [], bar [] ]


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
            [ 30, 15, 12, 25, 30, 25, 10, 28, 11, 18, 24, 16, 10, 10, 10 ]
                ++ [ 8, 8, 29, 11, 24, 12, 26, 32, 9, 8, 18, 28, 8, 20, 24 ]
                ++ [ 21, 15, 20, 4, 13, 12, 27, 21, 14, 5, 1, 2, 11, 2, 5 ]
                ++ [ 14, 20, 24, 20, 2, 9, 15, 14, 13, 22, 30, 30, 10, 8, 12 ]
                |> nums
    in
    dataFromColumns []
        << dataColumn "row" rows
        << dataColumn "col" cols
        << dataColumn "cat" cats
        << dataColumn "val" vals


cfg =
    -- Styling to remove axis gridlines and labels
    configure
        << configuration (coHeader [ hdLabelFontSize 0.1 ])
        << configuration (coView [ vicoStroke Nothing, vicoHeight 120 ])
        << configuration (coFacet [ facoSpacing 80, facoColumns 5 ])


grid1 : Spec
grid1 =
    let
        encByCatVal =
            encoding
                << position X [ pName "cat", pMType Ordinal, pAxis [] ]
                << position Y [ pName "val", pMType Quantitative, pAxis [] ]
                << color [ mName "cat", mMType Nominal, mLegend [] ]

        specByCatVal =
            asSpec [ width 120, height 120, bar [], encByCatVal [] ]
    in
    toVegaLite
        [ cfg []
        , data []
        , spacingRC 20 80
        , specification specByCatVal
        , facet
            [ rowBy [ fName "row", fMType Ordinal, fHeader [ hdTitle "" ] ]
            , columnBy [ fName "col", fMType Ordinal, fHeader [ hdTitle "" ] ]
            ]
        ]


grid2 : Spec
grid2 =
    let
        encByCatVal =
            encoding
                << position X [ pName "cat", pMType Ordinal, pAxis [] ]
                << position Y [ pName "val", pMType Quantitative, pAxis [] ]
                << color [ mName "cat", mMType Nominal, mLegend [] ]

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
        , columns (Just 5)
        , specification specByCatVal
        , facetFlow [ fName "index", fMType Ordinal, fHeader [ hdTitle "" ] ]
        ]


grid3 : Spec
grid3 =
    let
        encByCatVal =
            encoding
                << position X [ pName "cat", pMType Ordinal, pAxis [] ]
                << position Y [ pName "val", pMType Quantitative, pAxis [] ]
                << color [ mName "cat", mMType Nominal, mLegend [] ]

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
        , columns Nothing
        , specification specByCatVal
        , facetFlow [ fName "index", fMType Ordinal, fHeader [ hdTitle "" ] ]
        ]


sourceExample : Spec
sourceExample =
    grid3



{- This list comprises the specifications to be provided to the Vega-Lite runtime. -}


mySpecs : Spec
mySpecs =
    combineSpecs
        [ ( "columns1", columns1 )
        , ( "columns2", columns2 )
        , ( "columns3", columns3 )
        , ( "columns4", columns4 )
        , ( "grid1", grid1 )
        , ( "grid2", grid2 )
        , ( "grid3", grid3 )
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
