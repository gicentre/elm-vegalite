port module RadialTests exposing (elmToJS)

import Browser
import Dict
import Html exposing (Html)
import Html.Attributes
import Html.Events
import Json.Encode
import VegaLite exposing (..)


vals : List Float
vals =
    [ 4, 6, 10, 3, 7, 8 ]


radial : Float -> Float -> Float -> Spec
radial innerR off1 off2 =
    let
        data =
            dataFromColumns []
                << dataColumn "category" (strs [ "A", "B", "C", "D", "E", "F" ])
                << dataColumn "value" (nums vals)

        enc =
            encoding
                << position Theta [ pName "value", pQuant ]
                << color [ mName "category" ]

        offset1 =
            if off1 /= 0 then
                [ maThetaOffset off1 ]

            else
                []

        offset2 =
            if off2 /= 0 then
                [ maTheta2Offset off2 ]

            else
                []
    in
    toVegaLite [ data [], enc [], arc (maInnerRadius innerR :: offset1 ++ offset2) ]


radial1 : Spec
radial1 =
    radial 0 0 0


radial2 : Spec
radial2 =
    radial 50 0 0


firstCentreOffset : Float
firstCentreOffset =
    degrees (-180 * (List.head vals |> Maybe.withDefault 0) / List.sum vals)


radial3 : Spec
radial3 =
    let
        prm =
            params
                << param "radius" [ paValue (num 0), paBind (ipRange [ inMin 0, inMax 100, inStep 1 ]) ]
                << param "radius2" [ paValue (num 50), paBind (ipRange [ inMin 0, inMax 100, inStep 1 ]) ]
                << param "cornerRadius" [ paValue (num 0), paBind (ipRange [ inMin 0, inMax 50, inStep 1 ]) ]
                << param "padAngle" [ paValue (num 0), paBind (ipRange [ inMin 0, inMax 1.57 ]) ]

        data =
            dataFromColumns []
                << dataColumn "category" (strs [ "A", "B", "C", "D", "E", "F" ])
                << dataColumn "value" (nums vals)

        enc =
            encoding
                << position Theta [ pName "value", pQuant ]
                << color [ mName "category" ]
    in
    toVegaLite
        [ prm []
        , data []
        , enc []
        , arc
            [ maInnerRadius |> maNumExpr "radius"
            , maOuterRadius |> maNumExpr "radius2"
            , maCornerRadius |> maNumExpr "cornerRadius"
            , maPadAngle |> maNumExpr "padAngle"
            ]
        ]


radial4 : Spec
radial4 =
    radial 0 firstCentreOffset 0


radial5 : Spec
radial5 =
    radial 0 firstCentreOffset firstCentreOffset


radial6 : Spec
radial6 =
    let
        data =
            dataFromColumns []
                << dataColumn "category" (strs [ "A", "B", "C", "D", "E", "F" ])
                << dataColumn "value" (nums [ 4, 6, 10, 3, 7, 8 ])

        enc =
            encoding
                << position Theta [ pName "value", pQuant, pStack stZero ]
                << color [ mName "category", mLegend [] ]

        pieSpec =
            asSpec [ arc [ maOuterRadius 80 ] ]

        labelEnc =
            encoding
                << text [ tName "category" ]

        labelSpec =
            asSpec [ labelEnc [], textMark [ maRadius 90 ] ]
    in
    toVegaLite [ data [], enc [], layer [ pieSpec, labelSpec ] ]


radial7 : Spec
radial7 =
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


radial8 : Spec
radial8 =
    let
        data =
            dataFromColumns []
                << dataColumn "dir" (strs [ "1N", "2NE", "3E", "4SE", "5S", "6SW", "7W", "8NW" ])
                << dataColumn "strength" (nums [ 1, 2, 3, 4, 5, 6, 7, 8 ])

        enc =
            encoding
                << position Theta [ pName "dir", pOrdinal ]
                << position R [ pName "strength", pQuant ]
                << color [ mName "dir" ]
    in
    toVegaLite [ data [], enc [], arc [ maThetaOffset (degrees -22.5) ] ]


radial9 : Spec
radial9 =
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
                << color [ mName "dir" ]
    in
    toVegaLite [ data [], enc [], arc [ maThetaOffset (degrees -22.5) ] ]


radial10 : Spec
radial10 =
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
                << color [ mName "dir" ]
    in
    toVegaLite [ data [], enc [], arc [ maThetaOffset (degrees -22.5), maTheta2Offset (degrees -22.5) ] ]


radial11 : Spec
radial11 =
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
                << position R [ pRepeat arLayer, pScale [ scType scSqrt ] ]
                << color [ mRepeatDatum arLayer, mScale colours ]

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


radial12 : Spec
radial12 =
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
                << position Theta [ pName "month", pOrdinal ]
                << position R [ pName "deaths", pScale [ scType scSqrt ], pStack stNone ]
                << order [ oName "cause" ]
                << color [ mName "cause", mScale colours, mTitle "" ]
    in
    toVegaLite
        [ width 500
        , height 500
        , data []
        , trans []
        , enc []
        , arc [ maThetaOffset (degrees -90), maStroke "black", maStrokeWidth 0.5, maOpacity 0.6 ]
        ]


radial13 : Spec
radial13 =
    let
        data =
            dataFromColumns []
                << dataColumn "a" (strs [ "A", "B", "C", "D" ])
                << dataColumn "b" (nums [ 28, 55, 43, 91 ])

        sel =
            selection
                << select "highlight" seSingle [ seOn "mouseover", seEmpty ]
                << select "select" seMulti []

        enc =
            encoding
                << position Theta [ pName "b", pQuant ]
                << color [ mName "a", mLegend [] ]
                << fillOpacity [ mDataCondition [ ( selected "highlight", [ mNum 1 ] ) ] [ mNum 0.6 ] ]
                << strokeWidth [ mDataCondition [ ( selected "highlight", [ mNum 0 ] ) ] [ mNum 8 ] ]
    in
    toVegaLite [ data [], sel [], enc [], arc [ maStroke "white" ] ]



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
    , ( "radial10", radial10 )
    , ( "radial11", radial11 )
    , ( "radial12", radial12 )
    , ( "radial13", radial13 )
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
