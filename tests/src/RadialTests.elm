port module RadialTests exposing (elmToJS)

import Browser
import Dict exposing (Dict)
import Html exposing (Html)
import Html.Attributes
import Html.Events
import Json.Encode
import VegaLite exposing (..)


radial : Float -> Spec
radial innerR =
    let
        data =
            dataFromColumns []
                << dataColumn "category" (strs [ "A", "B", "C", "D", "E", "F" ])
                << dataColumn "value" (nums [ 4, 6, 10, 3, 7, 8 ])

        enc =
            encoding
                << position Theta [ pName "value", pQuant ]
                << color [ mName "category", mNominal ]
    in
    toVegaLite [ data [], enc [], arc [ maTooltip ttEncoding, maInnerRadius innerR ] ]


radial1 : Spec
radial1 =
    radial 0


radial2 : Spec
radial2 =
    radial 50


radial3 : Spec
radial3 =
    let
        data =
            dataFromColumns []
                << dataColumn "category" (strs [ "A", "B", "C", "D", "E", "F" ])
                << dataColumn "value" (nums [ 4, 6, 10, 3, 7, 8 ])

        enc =
            encoding
                << position Theta [ pName "value", pQuant, pStack stZero ]
                << color [ mName "category", mNominal, mLegend [] ]

        pieSpec =
            asSpec [ arc [ maOuterRadius 80 ] ]

        labelEnc =
            encoding
                << text [ tName "category", tNominal ]

        labelSpec =
            asSpec [ labelEnc [], textMark [ maRadius 90 ] ]
    in
    toVegaLite [ data [], enc [], layer [ pieSpec, labelSpec ] ]


radial4 : Spec
radial4 =
    let
        data =
            dataFromColumns []
                << dataColumn "x" (nums [ 0 ])
    in
    toVegaLite
        [ data []
        , arc
            [ maTheta 0.3
            , maTheta2 1.3
            , maInnerRadius 30
            , maOuterRadius 100
            , maX 0
            , maY 200
            ]
        ]


radial5 : Spec
radial5 =
    let
        data =
            dataFromColumns []
                << dataColumn "dir" (strs [ "1N", "2NE", "3E", "4SE", "5S", "6SW", "7W", "8NW" ])
                << dataColumn "strength" (nums [ 1, 2, 3, 4, 5, 6, 7, 8 ])

        enc =
            encoding
                << position Theta [ pName "dir", pOrdinal ]
                << position R [ pName "strength", pQuant ]
                << color [ mName "dir", mNominal ]
    in
    toVegaLite [ data [], enc [], arc [] ]


radial6 : Spec
radial6 =
    let
        thetas =
            List.range 0 8 |> List.map (\n -> toFloat n * 45 |> degrees)

        data =
            dataFromColumns []
                << dataColumn "dir" (strs [ "1N", "2NE", "3E", "4SE", "5S", "6SW", "7W", "8NW" ])
                << dataColumn "t" (thetas |> List.take 8 |> nums)
                << dataColumn "t2" (thetas |> List.drop 1 |> nums)

        enc =
            encoding
                << position Theta [ pName "t", pQuant ]
                << position Theta2 [ pName "t2" ]
                << color [ mName "dir", mNominal ]
    in
    toVegaLite [ data [], enc [], arc [] ]


radial7 : Spec
radial7 =
    let
        thetas =
            List.range 0 8 |> List.map (\n -> toFloat n * 45 |> degrees)

        data =
            dataFromColumns []
                << dataColumn "dir" (strs [ "1N", "2NE", "3E", "4SE", "5S", "6SW", "7W", "8NW" ])
                << dataColumn "strength" (nums [ 1, 2, 3, 4, 5, 6, 7, 8 ])
                << dataColumn "t" (thetas |> List.take 8 |> nums)
                << dataColumn "t2" (thetas |> List.drop 1 |> nums)

        enc =
            encoding
                << position R [ pName "strength", pQuant, pScale [ scZero True ] ]
                << position Theta [ pName "t", pQuant ]
                << position Theta2 [ pName "t2" ]
                << position R2 [ pNum 10 ]
                << color [ mName "dir", mNominal ]
    in
    toVegaLite [ data [], enc [], arc [] ]


radial8 : Spec
radial8 =
    let
        data =
            dataFromColumns []
                << dataColumn "month" (strs [ "1854/04", "1854/05", "1854/06", "1854/07", "1854/08", "1854/09", "1854/10", "1854/11", "1854/12", "1855/01", "1855/02", "1855/03" ])
                << dataColumn "disease" (nums [ 1, 12, 11, 359, 828, 788, 503, 844, 1725, 2761, 2120, 1205 ])
                << dataColumn "wounds" (nums [ 0, 0, 0, 0, 1, 81, 132, 287, 114, 83, 42, 32 ])
                << dataColumn "other" (nums [ 5, 9, 6, 23, 30, 70, 128, 106, 131, 324, 361, 172 ])

        colours =
            categoricalDomainMap
                [ ( "disease", "rgb(120,160,180)" )
                , ( "wounds", "rgb(255,190,180)" )
                , ( "other", "rgb(80,80,80)" )
                ]

        enc =
            encoding
                << position Theta [ pName "month", pOrdinal, pScale [ scRange (raNums [ -pi / 2, 3 * pi / 2 ]) ] ]
                << position R [ pRepeat arLayer, pQuant, pScale [ scType scSqrt ] ]
                << color [ mRepeatDatum arLayer, mNominal, mScale colours ]

        encLabels =
            encoding
                << text [ tName "monthLabel", tNominal ]

        spec =
            asSpec
                [ width 500
                , height 500
                , data []
                , enc []
                , arc [ maStroke "black", maStrokeWidth 0.5, maOpacity 0.6 ]
                ]
    in
    toVegaLite
        [ repeat [ layerFields [ "disease", "other", "wounds" ] ]
        , specification spec
        ]


radial9 : Spec
radial9 =
    let
        data =
            dataFromColumns []
                << dataColumn "month" (strs [ "1854/04", "1854/05", "1854/06", "1854/07", "1854/08", "1854/09", "1854/10", "1854/11", "1854/12", "1855/01", "1855/02", "1855/03" ])
                << dataColumn "disease" (nums [ 1, 12, 11, 359, 828, 788, 503, 844, 1725, 2761, 2120, 1205 ])
                << dataColumn "wounds" (nums [ 0, 0, 0, 0, 1, 81, 132, 287, 114, 83, 42, 32 ])
                << dataColumn "other" (nums [ 5, 9, 6, 23, 30, 70, 128, 106, 131, 324, 361, 172 ])

        trans =
            transform
                << foldAs [ "disease", "wounds", "other" ] "cause" "deaths"

        colours =
            categoricalDomainMap
                [ ( "disease", "rgb(120,160,180)" )
                , ( "wounds", "rgb(255,190,180)" )
                , ( "other", "rgb(80,80,80)" )
                ]

        enc =
            encoding
                << position Theta [ pName "month", pOrdinal, pScale [ scRange (raNums [ degrees -90, degrees 270 ]) ] ]
                << position R [ pName "deaths", pQuant, pScale [ scType scSqrt ], pStack stNone ]
                << order [ oName "cause", oOrdinal ]
                << color [ mName "cause", mNominal, mScale colours, mTitle "" ]
    in
    toVegaLite
        [ width 500
        , height 500
        , data []
        , trans []
        , enc []
        , arc [ maStroke "black", maStrokeWidth 0.5, maOpacity 0.6 ]
        ]



{- Ids and specifications to be provided to the Vega-Lite runtime. -}


specs : List ( String, Spec )
specs =
    [ ( "radial1", radial1 )
    , ( "radial2", radial2 )
    , ( "radial3", radial3 )
    , ( "radial4", radial4 )
    , ( "radial5", radial5 )
    , ( "radial6", radial6 )
    , ( "radial7", radial7 )
    , ( "radial8", radial8 )
    , ( "radial9", radial9 )
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
    | NoSource


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
update msg model =
    case msg of
        NewSource srcName ->
            ( specs |> Dict.fromList |> Dict.get srcName |> Maybe.withDefault Json.Encode.null, Cmd.none )

        NoSource ->
            ( Json.Encode.null, Cmd.none )


port elmToJS : Spec -> Cmd msg