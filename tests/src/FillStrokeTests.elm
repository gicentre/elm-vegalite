port module FillStrokeTests exposing (elmToJS)

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


encChart : (List a -> List LabelledSpec) -> Spec
encChart extraEnc =
    let
        data =
            dataFromColumns []
                << dataColumn "x" (nums [ 10, 20, 30, 36 ])
                << dataColumn "y" (nums [ 1, 2, 3, 4 ])
                << dataColumn "val" (nums [ 1, 2, 3, 4 ])
                << dataColumn "cat" (strs [ "a", "b", "c", "d" ])

        enc =
            encoding
                << position X [ pName "x", pQuant ]
                << position Y [ pName "y", pQuant ]
                << color [ mName "cat" ]
                << size [ mNum 2000 ]
                << extraEnc
    in
    toVegaLite [ width 200, height 200, data [], enc [], circle [ maStroke "black" ] ]


defChart : Spec
defChart =
    encChart (always [])


fill1 : Spec
fill1 =
    encChart (fill [])


fill2 : Spec
fill2 =
    encChart (fill [ mName "y", mOrdinal ])


fill3 : Spec
fill3 =
    encChart (fill [ mStr "red" ])


stroke1 : Spec
stroke1 =
    encChart (stroke [])


stroke2 : Spec
stroke2 =
    encChart (stroke [ mName "y", mOrdinal ])


stroke3 : Spec
stroke3 =
    encChart (stroke [ mStr "red" ])


combined1 : Spec
combined1 =
    encChart (stroke [] << fill [])


combined2 : Spec
combined2 =
    encChart (stroke [ mName "y", mOrdinal ] << fill [ mStr "red" ])


combined3 : Spec
combined3 =
    encChart (stroke [ mStr "red" ] << fill [ mName "y", mOrdinal ])


geo1 : Spec
geo1 =
    let
        geojson =
            geoFeatureCollection
                [ geometry (geoPolygon [ [ ( -2, 58 ), ( 3, 58 ), ( 3, 53 ), ( -2, 53 ), ( -2, 58 ) ] ]) []
                , geometry (geoLine [ ( 4, 52 ), ( 4, 59 ), ( -3, 59 ) ]) []
                , geometry (geoPoint 4 55) []
                ]
    in
    toVegaLite
        [ width 300
        , height 300
        , dataFromJson geojson [ jsonProperty "features" ]
        , geoshape []
        ]


geo2 : Spec
geo2 =
    let
        geojson =
            geoFeatureCollection
                [ geometry (geoPolygon [ [ ( -2, 58 ), ( 3, 58 ), ( 3, 53 ), ( -2, 53 ), ( -2, 58 ) ] ]) []
                , geometry (geoLine [ ( 4, 52 ), ( 4, 59 ), ( -3, 59 ) ]) []
                , geometry (geoPoint 4 55) []
                ]

        enc =
            encoding
                << stroke [ mName "geometry.type" ]
                << fill
                    [ mDataCondition [ ( expr "datum.geometry.type === 'Polygon'", [ mName "geometry.type" ] ) ]
                        [ mStr "rgb(0,0,0,0)" ]
                    ]
    in
    toVegaLite
        [ width 300
        , height 300
        , enc []
        , dataFromJson geojson [ jsonProperty "features" ]
        , geoshape [ maStrokeWidth 2 ]
        ]


gradient1 : Spec
gradient1 =
    let
        data =
            dataFromColumns []
                << dataColumn "cat" (strs [ "a", "b", "c", "d" ])
                << dataColumn "value" (nums [ 10, 5, 20, 8 ])

        enc =
            encoding
                << position X [ pName "cat" ]
                << position Y [ pName "value", pQuant ]
    in
    toVegaLite
        [ width 200
        , data []
        , enc []
        , bar
            [ maColorGradient grLinear
                [ grX1 1
                , grX2 1
                , grY1 0
                , grY2 1
                , grStops
                    [ ( 0, "red" )
                    , ( 1, "blue" )
                    ]
                ]
            ]
        ]


gradient2 : Spec
gradient2 =
    let
        data =
            dataFromColumns []
                << dataColumn "cat" (strs [ "a", "b", "c", "d" ])
                << dataColumn "value" (nums [ 10, 5, 20, 8 ])

        enc =
            encoding
                << position X [ pName "cat" ]
                << position Y [ pName "value", pQuant ]
    in
    toVegaLite
        [ width 300
        , data []
        , enc []
        , area
            [ maColorGradient grLinear
                [ grX1 0
                , grX2 1
                , grY1 1
                , grY2 1
                , grStops [ ( 0, "red" ), ( 1, "blue" ) ]
                ]
            ]
        ]


gradient3 : Spec
gradient3 =
    let
        data =
            dataFromColumns []
                << dataColumn "cat" (strs [ "a", "b", "c", "d" ])
                << dataColumn "value" (nums [ 10, 5, 20, 8 ])

        enc =
            encoding
                << position X [ pName "cat" ]
                << position Y [ pName "value", pQuant ]
    in
    toVegaLite
        [ width 300
        , data []
        , enc []
        , area
            [ maColorGradient grLinear
                [ grX1 0
                , grX2 1
                , grY1 1
                , grY2 1
                , grStops [ ( 1, "blue" ), ( 0, "red" ) ]
                ]
            ]
        ]


rounded1 : Spec
rounded1 =
    let
        data =
            dataFromColumns []
                << dataColumn "cat" (strs [ "a", "b", "c", "d", "e", "f", "g", "h", "i" ])
                << dataColumn "value" (nums [ 28, 55, 43, 91, 81, 53, 19, 87, 52 ])

        enc =
            encoding
                << position X [ pName "cat" ]
                << position Y [ pName "value", pQuant ]
    in
    toVegaLite [ data [], enc [], bar [ maCornerRadiusEnd 4 ] ]


rounded2 : Spec
rounded2 =
    let
        data =
            dataFromColumns []
                << dataColumn "cat" (strs [ "a", "b", "c", "d", "e", "f", "g", "h", "i" ])
                << dataColumn "value" (nums [ 28, 55, 43, 91, 81, 53, 19, 87, 52 ])

        enc =
            encoding
                << position X [ pName "value", pQuant ]
                << position Y [ pName "cat" ]
    in
    toVegaLite [ data [], enc [], bar [ maCornerRadiusEnd 4 ] ]


strokeDash1 : Spec
strokeDash1 =
    let
        data =
            dataFromUrl (path ++ "stocks.csv") []

        enc =
            encoding
                << position X [ pName "date", pTemporal ]
                << position Y [ pName "price", pQuant ]
                << strokeDash [ mName "symbol" ]
    in
    toVegaLite [ data, enc [], line [] ]


strokeDash2 : Spec
strokeDash2 =
    let
        data =
            dataFromUrl (path ++ "stocks.csv") []

        enc =
            encoding
                << position X [ pName "date", pTemporal ]
                << position Y [ pName "price", pQuant ]
                << strokeDash
                    [ mName "symbol"
                    , mScale
                        [ scDomain (doStrs [ "AAPL", "AMZN", "GOOG", "IBM", "MSFT" ])
                        , scRange (raNumLists [ [ 1, 0 ], [ 3, 1 ], [ 2, 3 ], [ 4, 4 ], [ 5, 6 ] ])
                        ]
                    ]
    in
    toVegaLite [ data, enc [], line [] ]


strokeDash3 : Spec
strokeDash3 =
    let
        data =
            dataFromColumns []
                << dataColumn "x" (nums [ 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1 ])
                << dataColumn "y" (nums [ 100, 100, 90, 90, 80, 80, 70, 70, 60, 60, 50, 50, 40, 40, 30, 30, 20, 20, 10, 10 ])
                << dataColumn "cat" (nums [ 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10 ])

        encBase =
            encoding
                << position X [ pName "x", pQuant, pAxis [ axTitle "", axGrid False ] ]
                << position Y [ pName "y", pQuant, pAxis [ axTitle "", axGrid False ] ]

        enc1 =
            encBase
                << strokeDash [ mName "cat" ]

        spec1 =
            asSpec [ title "Nominal" [], width 200, enc1 [], line [] ]

        enc2 =
            encBase
                << strokeDash [ mName "cat", mOrdinal ]

        spec2 =
            asSpec [ title "Ordinal" [], width 200, enc2 [], line [] ]

        res =
            resolve
                << resolution (reScale [ ( chStrokeDash, reIndependent ) ])
    in
    toVegaLite [ data [], res [], concat [ spec1, spec2 ] ]


d0 : List Float
d0 =
    [ 1, 0 ]


d1 : List Float
d1 =
    [ 16, 4 ]


d2 : List Float
d2 =
    [ 10, 4 ]


d3 : List Float
d3 =
    [ 8, 4 ]


d4 : List Float
d4 =
    [ 8, 4, 4, 4 ]


d5 : List Float
d5 =
    [ 6, 4 ]


d6 : List Float
d6 =
    [ 5, 4 ]


d7 : List Float
d7 =
    [ 4, 6 ]


d8 : List Float
d8 =
    [ 2, 4 ]


d9 : List Float
d9 =
    [ 1, 3 ]


strokeDash4 : Spec
strokeDash4 =
    let
        data =
            dataFromColumns []
                << dataColumn "x" (nums [ 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1 ])
                << dataColumn "y" (nums [ 100, 100, 90, 90, 80, 80, 70, 70, 60, 60, 50, 50, 40, 40, 30, 30, 20, 20, 10, 10 ])
                << dataColumn "cat" (nums [ 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10 ])

        encBase =
            encoding
                << position X [ pName "x", pQuant, pAxis [ axTitle "", axGrid False ] ]
                << position Y [ pName "y", pQuant, pAxis [ axTitle "", axGrid False ] ]

        enc1 =
            encBase
                << strokeDash
                    [ mName "cat"
                    , mScale
                        [ scDomain (doNums [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ])
                        , scRange (raNumLists [ d0, d6, d8, d4, d9, d1, d5, d3, d7, d2 ])
                        ]
                    ]

        spec1 =
            asSpec [ title "Nominal" [], width 200, height 100, enc1 [], line [] ]

        enc2 =
            encBase
                << strokeDash
                    [ mName "cat"
                    , mOrdinal
                    , mScale
                        [ scDomain (doNums [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ])
                        , scRange (raNumLists [ d0, d1, d2, d3, d4, d5, d6, d7, d8, d9 ])
                        ]
                    ]

        spec2 =
            asSpec [ title "Ordinal" [], width 200, height 100, enc2 [], line [] ]

        res =
            resolve
                << resolution (reScale [ ( chStrokeDash, reIndependent ) ])
    in
    toVegaLite [ data [], res [], concat [ spec1, spec2 ] ]


scaledStrokeDash : Float -> Spec
scaledStrokeDash dashScale =
    let
        scaleDash sc =
            List.map (List.map ((*) sc))

        data =
            dataSequenceAs 0 100 0.1 "x0"

        trans =
            transform
                << calculateAs "abs(sin(datum.x0+random()))" "y0"
                << calculateAs "datum.x0 %10" "x"
                << calculateAs "floor(datum.x0 / 10)" "cat"
                << calculateAs "datum.y0 + datum.cat" "y"

        enc =
            encoding
                << position X [ pName "x", pQuant, pAxis [ axGrid False ] ]
                << position Y [ pName "y", pQuant, pAxis [ axGrid False ] ]
                << strokeDash
                    [ mName "cat"
                    , mOrdinal
                    , mScale
                        [ scDomain (doNums [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ])
                        , scRange (raNumLists (scaleDash dashScale [ d0, d1, d2, d3, d4, d5, d6, d7, d8, d9 ]))
                        ]
                    ]
    in
    toVegaLite
        [ title ("Dash scale " ++ String.fromFloat dashScale) []
        , width 300
        , height 300
        , data
        , trans []
        , enc []
        , line []
        ]


strokeDash5 : Spec
strokeDash5 =
    scaledStrokeDash 0.2


strokeDash6 : Spec
strokeDash6 =
    scaledStrokeDash 0.5


strokeDash7 : Spec
strokeDash7 =
    scaledStrokeDash 1


strokeDash8 : Spec
strokeDash8 =
    scaledStrokeDash 2


strokeDash9 : Spec
strokeDash9 =
    scaledStrokeDash 4



{- Ids and specifications to be provided to the Vega-Lite runtime. -}


specs : List ( String, Spec )
specs =
    [ ( "default", defChart )
    , ( "fill1", fill1 )
    , ( "fill2", fill2 )
    , ( "fill3", fill3 )
    , ( "stroke1", stroke1 )
    , ( "stroke2", stroke2 )
    , ( "stroke3", stroke3 )
    , ( "combined1", combined1 )
    , ( "combined2", combined2 )
    , ( "combined3", combined3 )
    , ( "geo1", geo1 )
    , ( "geo2", geo2 )
    , ( "gradient1", gradient1 )
    , ( "gradient2", gradient2 )
    , ( "gradient3", gradient3 )
    , ( "rounded1", rounded1 )
    , ( "rounded2", rounded2 )
    , ( "strokeDash1", strokeDash1 )
    , ( "strokeDash2", strokeDash2 )
    , ( "strokeDash3", strokeDash3 )
    , ( "strokeDash4", strokeDash4 )
    , ( "strokeDash5", strokeDash5 )
    , ( "strokeDash6", strokeDash6 )
    , ( "strokeDash7", strokeDash7 )
    , ( "strokeDash8", strokeDash8 )
    , ( "strokeDash9", strokeDash9 )
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
