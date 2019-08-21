port module FillStrokeTests exposing (elmToJS)

import Browser
import Html exposing (Html, div, pre)
import Html.Attributes exposing (id)
import Json.Encode
import VegaLite exposing (..)


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
                << color [ mName "cat", mNominal ]
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
                ]
    in
    toVegaLite
        [ width 300
        , height 300
        , dataFromJson geojson []
        , geoshape []
        ]


geo2 : Spec
geo2 =
    let
        geojson =
            geoFeatureCollection
                [ geometry (geoPolygon [ [ ( -2, 58 ), ( 3, 58 ), ( 3, 53 ), ( -2, 53 ), ( -2, 58 ) ] ]) []
                , geometry (geoLine [ ( 4, 52 ), ( 4, 59 ), ( -3, 59 ) ]) []
                ]

        -- NOTE: There is a bug in Vega-Lite that prevents nested geometry from being read correctly.
        enc =
            encoding << color [ mName "features.geometry.type", mNominal ]
    in
    toVegaLite
        [ width 300
        , height 300
        , enc []
        , dataFromJson geojson []
        , geoshape []
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
                << position X [ pName "cat", pMType Nominal ]
                << position Y [ pName "value", pMType Quantitative ]
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
                << position X [ pName "cat", pMType Nominal ]
                << position Y [ pName "value", pMType Quantitative ]
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
                << position X [ pName "cat", pMType Nominal ]
                << position Y [ pName "value", pMType Quantitative ]
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


sourceExample : Spec
sourceExample =
    gradient1



{- This list comprises the specifications to be provided to the Vega-Lite runtime. -}


mySpecs : Spec
mySpecs =
    combineSpecs
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
