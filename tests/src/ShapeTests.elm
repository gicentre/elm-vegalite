port module ShapeTests exposing (elmToJS)

import Browser
import Dict exposing (Dict)
import Html exposing (Html)
import Html.Attributes
import Html.Events
import Json.Encode
import VegaLite exposing (..)


path : String
path =
    "https://cdn.jsdelivr.net/npm/vega-datasets@2.1/data/"


chart : String -> (List a -> List ( String, Spec )) -> Spec
chart des enc =
    toVegaLite
        [ description des
        , dataFromUrl (path ++ "cars.json") []
        , (transform
            << calculateAs "year(datum.Year)" "YearOfManufacture"
            << filter (fiExpr "datum.YearOfManufacture == 1970")
          )
            []
        , point [ maFilled True ]
        , (encoding
            << position X [ pName "Horsepower", pQuant ]
            << position Y [ pName "Miles_per_Gallon", pQuant ]
            << opacity [ mNum 0.6 ]
            << enc
          )
            []
        ]


rectTest : List MarkProperty -> Spec
rectTest mps =
    let
        data =
            dataFromUrl (path ++ "cars.json") []

        enc =
            encoding
                << position X [ pName "Origin" ]
                << position Y [ pName "Cylinders", pOrdinal ]
    in
    toVegaLite [ width 200, height 200, data, enc [], rect (maSize 30 :: maOpacity 0.6 :: mps) ]


rounded1 : Spec
rounded1 =
    rectTest [ maCornerRadius 8 ]


rounded2 : Spec
rounded2 =
    rectTest [ maCornerRadiusTopLeft 8 ]


rounded3 : Spec
rounded3 =
    rectTest [ maCornerRadiusTopRight 8 ]


rounded4 : Spec
rounded4 =
    rectTest [ maCornerRadiusBottomLeft 8 ]


rounded5 : Spec
rounded5 =
    rectTest [ maCornerRadiusBottomRight 8 ]


rounded6 : Spec
rounded6 =
    rectTest [ maCornerRadius 16, maCornerRadiusBottomLeft 0, maCornerRadiusTopRight 0 ]


unitSquare : String
unitSquare =
    "M -0.5 -0.5 h 1 v 1 h -1z"


largeSquare : String
largeSquare =
    "M -5 -5 h 10 v 10 h -10z"


square : String
square =
    "M -1.5 -1.5 h 3 v 3 h -3z"


tri : String
tri =
    "M -1.5 -1.5 h 3 l -1.5 3z"


cross : String
cross =
    "M -1.5 -1.5 m1 0 h 1 v 1 h 1 v 1 h -1 v 1 h -1  v -1 h -1 v -1 h 1z"


horizLine : String
horizLine =
    "M -1 0 h 2"


scatter1 : Spec
scatter1 =
    chart "Default nominal shapes."
        (shape [ mName "Origin" ])


scatter2 : Spec
scatter2 =
    chart "Default ordinal shapes."
        (shape [ mName "Cylinders", mOrdinal ])


scatter3 : Spec
scatter3 =
    chart "Enlarged shapes (but legend shapes should remain same size)"
        (shape [ mName "Origin" ] << size [ mNum 200 ])


scatter4 : Spec
scatter4 =
    chart "Reduced shapes (but legend shapes should remain same size)"
        (shape [ mName "Origin" ] << size [ mNum 20 ])


scatter5 : Spec
scatter5 =
    chart "Fixed shape, sized by number of cylinder category"
        (size [ mName "Cylinders", mOrdinal ])


scatter6 : Spec
scatter6 =
    chart "Sized by number of cylinders, shape by origin"
        (shape [ mName "Origin" ] << size [ mName "Cylinders", mOrdinal ])


scatter7 : Spec
scatter7 =
    chart "Sized and shaped by number of cylinders (should only have a single set of legend items)"
        (shape [ mName "Cylinders", mOrdinal ] << size [ mName "Cylinders", mOrdinal ])


scatter8 : Spec
scatter8 =
    chart "Sized, shaped and coloured by number of cylinders (should only have a single set of legend items)"
        (shape [ mName "Cylinders", mOrdinal ]
            << size [ mName "Cylinders", mOrdinal ]
            << color [ mName "Cylinders", mOrdinal ]
        )


scatter9 : Spec
scatter9 =
    chart "Custom-shaped and coloured by origin (should only have a single set of legend items)"
        (shape [ mName "Origin" ] << color [ mName "Origin" ])


scatter10 : Spec
scatter10 =
    chart "Custom-shaped and coloured by origin (should only have a single set of legend items)"
        (shape
            [ mName "Origin"
            , mScale <|
                categoricalDomainMap
                    [ ( "Europe", square )
                    , ( "Japan", cross )
                    , ( "USA", tri )
                    ]
            ]
            << color [ mName "Origin" ]
        )


scatter11 : Spec
scatter11 =
    chart "Sized, shaped and coloured by number of cylinders (should have two sets of legend items)"
        (shape [ mName "Cylinders", mOrdinal ]
            << size [ mName "Cylinders", mOrdinal ]
            << color [ mName "Origin" ]
        )


scatter12 : Spec
scatter12 =
    chart "Custom nominal shape with unit area."
        (shape [ mPath unitSquare ])


scatter13 : Spec
scatter13 =
    chart "Custom nominal shape with unit area sized by Cylinders."
        (shape [ mPath unitSquare ]
            << size [ mName "Cylinders", mOrdinal ]
        )


scatter14 : Spec
scatter14 =
    chart "Custom nominal shape with area of 10x10 pixel units."
        (shape [ mPath largeSquare ] << color [ mName "Origin" ])


scatter15 : Spec
scatter15 =
    chart "Custom shape sets encoding origin."
        (shape
            [ mName "Origin"
            , mScale <|
                categoricalDomainMap
                    [ ( "Europe", square )
                    , ( "Japan", cross )
                    , ( "USA", tri )
                    ]
            ]
        )


isotypes : Dict String String
isotypes =
    let
        cow =
            "M4 -2c0 0 0.9 -0.7 1.1 -0.8c0.1 -0.1 -0.1 0.5 -0.3 0.7c-0.2 0.2 1.1 1.1 1.1 1.2c0 0.2 -0.2 0.8 -0.4 0.7c-0.1 0 -0.8 -0.3 -1.3 -0.2c-0.5 0.1 -1.3 1.6 -1.5 2c-0.3 0.4 -0.6 0.4 -0.6 0.4c0 0.1 0.3 1.7 0.4 1.8c0.1 0.1 -0.4 0.1 -0.5 0c0 0 -0.6 -1.9 -0.6 -1.9c-0.1 0 -0.3 -0.1 -0.3 -0.1c0 0.1 -0.5 1.4 -0.4 1.6c0.1 0.2 0.1 0.3 0.1 0.3c0 0 -0.4 0 -0.4 0c0 0 -0.2 -0.1 -0.1 -0.3c0 -0.2 0.3 -1.7 0.3 -1.7c0 0 -2.8 -0.9 -2.9 -0.8c-0.2 0.1 -0.4 0.6 -0.4 1c0 0.4 0.5 1.9 0.5 1.9l-0.5 0l-0.6 -2l0 -0.6c0 0 -1 0.8 -1 1c0 0.2 -0.2 1.3 -0.2 1.3c0 0 0.3 0.3 0.2 0.3c0 0 -0.5 0 -0.5 0c0 0 -0.2 -0.2 -0.1 -0.4c0 -0.1 0.2 -1.6 0.2 -1.6c0 0 0.5 -0.4 0.5 -0.5c0 -0.1 0 -2.7 -0.2 -2.7c-0.1 0 -0.4 2 -0.4 2c0 0 0 0.2 -0.2 0.5c-0.1 0.4 -0.2 1.1 -0.2 1.1c0 0 -0.2 -0.1 -0.2 -0.2c0 -0.1 -0.1 -0.7 0 -0.7c0.1 -0.1 0.3 -0.8 0.4 -1.4c0 -0.6 0.2 -1.3 0.4 -1.5c0.1 -0.2 0.6 -0.4 0.6 -0.4z"

        pig =
            "M1.2 -2c0 0 0.7 0 1.2 0.5c0.5 0.5 0.4 0.6 0.5 0.6c0.1 0 0.7 0 0.8 0.1c0.1 0 0.2 0.2 0.2 0.2c0 0 -0.6 0.2 -0.6 0.3c0 0.1 0.4 0.9 0.6 0.9c0.1 0 0.6 0 0.6 0.1c0 0.1 0 0.7 -0.1 0.7c-0.1 0 -1.2 0.4 -1.5 0.5c-0.3 0.1 -1.1 0.5 -1.1 0.7c-0.1 0.2 0.4 1.2 0.4 1.2l-0.4 0c0 0 -0.4 -0.8 -0.4 -0.9c0 -0.1 -0.1 -0.3 -0.1 -0.3l-0.2 0l-0.5 1.3l-0.4 0c0 0 -0.1 -0.4 0 -0.6c0.1 -0.1 0.3 -0.6 0.3 -0.7c0 0 -0.8 0 -1.5 -0.1c-0.7 -0.1 -1.2 -0.3 -1.2 -0.2c0 0.1 -0.4 0.6 -0.5 0.6c0 0 0.3 0.9 0.3 0.9l-0.4 0c0 0 -0.4 -0.5 -0.4 -0.6c0 -0.1 -0.2 -0.6 -0.2 -0.5c0 0 -0.4 0.4 -0.6 0.4c-0.2 0.1 -0.4 0.1 -0.4 0.1c0 0 -0.1 0.6 -0.1 0.6l-0.5 0l0 -1c0 0 0.5 -0.4 0.5 -0.5c0 -0.1 -0.7 -1.2 -0.6 -1.4c0.1 -0.1 0.1 -1.1 0.1 -1.1c0 0 -0.2 0.1 -0.2 0.1c0 0 0 0.9 0 1c0 0.1 -0.2 0.3 -0.3 0.3c-0.1 0 0 -0.5 0 -0.9c0 -0.4 0 -0.4 0.2 -0.6c0.2 -0.2 0.6 -0.3 0.8 -0.8c0.3 -0.5 1 -0.6 1 -0.6z"

        sheep =
            "M-4.1 -0.5c0.2 0 0.2 0.2 0.5 0.2c0.3 0 0.3 -0.2 0.5 -0.2c0.2 0 0.2 0.2 0.4 0.2c0.2 0 0.2 -0.2 0.5 -0.2c0.2 0 0.2 0.2 0.4 0.2c0.2 0 0.2 -0.2 0.4 -0.2c0.1 0 0.2 0.2 0.4 0.1c0.2 0 0.2 -0.2 0.4 -0.3c0.1 0 0.1 -0.1 0.4 0c0.3 0 0.3 -0.4 0.6 -0.4c0.3 0 0.6 -0.3 0.7 -0.2c0.1 0.1 1.4 1 1.3 1.4c-0.1 0.4 -0.3 0.3 -0.4 0.3c-0.1 0 -0.5 -0.4 -0.7 -0.2c-0.3 0.2 -0.1 0.4 -0.2 0.6c-0.1 0.1 -0.2 0.2 -0.3 0.4c0 0.2 0.1 0.3 0 0.5c-0.1 0.2 -0.3 0.2 -0.3 0.5c0 0.3 -0.2 0.3 -0.3 0.6c-0.1 0.2 0 0.3 -0.1 0.5c-0.1 0.2 -0.1 0.2 -0.2 0.3c-0.1 0.1 0.3 1.1 0.3 1.1l-0.3 0c0 0 -0.3 -0.9 -0.3 -1c0 -0.1 -0.1 -0.2 -0.3 -0.2c-0.2 0 -0.3 0.1 -0.4 0.4c0 0.3 -0.2 0.8 -0.2 0.8l-0.3 0l0.3 -1c0 0 0.1 -0.6 -0.2 -0.5c-0.3 0.1 -0.2 -0.1 -0.4 -0.1c-0.2 -0.1 -0.3 0.1 -0.4 0c-0.2 -0.1 -0.3 0.1 -0.5 0c-0.2 -0.1 -0.1 0 -0.3 0.3c-0.2 0.3 -0.4 0.3 -0.4 0.3l0.2 1.1l-0.3 0l-0.2 -1.1c0 0 -0.4 -0.6 -0.5 -0.4c-0.1 0.3 -0.1 0.4 -0.3 0.4c-0.1 -0.1 -0.2 1.1 -0.2 1.1l-0.3 0l0.2 -1.1c0 0 -0.3 -0.1 -0.3 -0.5c0 -0.3 0.1 -0.5 0.1 -0.7c0.1 -0.2 -0.1 -1 -0.2 -1.1c-0.1 -0.2 -0.2 -0.8 -0.2 -0.8c0 0 -0.1 -0.5 0.4 -0.8z"

        person =
            "M1.7 -1.7h-0.8c0.3 -0.2 0.6 -0.5 0.6 -0.9c0 -0.6 -0.4 -1 -1 -1c-0.6 0 -1 0.4 -1 1c0 0.4 0.2 0.7 0.6 0.9h-0.8c-0.4 0 -0.7 0.3 -0.7 0.6v1.9c0 0.3 0.3 0.6 0.6 0.6h0.2c0 0 0 0.1 0 0.1v1.9c0 0.3 0.2 0.6 0.3 0.6h1.3c0.2 0 0.3 -0.3 0.3 -0.6v-1.8c0 0 0 -0.1 0 -0.1h0.2c0.3 0 0.6 -0.3 0.6 -0.6v-2c0.2 -0.3 -0.1 -0.6 -0.4 -0.6z"
    in
    Dict.fromList [ ( "cow", cow ), ( "pig", pig ), ( "sheep", sheep ), ( "person", person ) ]



{- Grid of selectable person icons.
   Inspired by Alan Smith's D3 example http://bl.ocks.org/alansmithy/d832fc03f6e6a91e99f4
   and based around Amit Kapoor's unit chart example https://bl.ocks.org/amitkaps/d6648bd8ddb1c1e3706d7530126d1e2b
-}


personGrid : Spec
personGrid =
    let
        config =
            configure
                << configuration (coView [ vicoStroke Nothing ])

        data =
            dataFromColumns []
                << dataColumn "id" (nums <| List.map toFloat (List.range 1 100))

        trans =
            transform
                << calculateAs "ceil (datum.id/10)" "col"
                << calculateAs "datum.id - datum.col*10" "row"

        sel =
            selection
                << select "highlight" seInterval []

        enc =
            encoding
                << position X [ pName "col", pOrdinal, pAxis [] ]
                << position Y [ pName "row", pOrdinal, pAxis [] ]
                << shape [ mPath <| Maybe.withDefault "circle" <| Dict.get "person" isotypes ]
                << color
                    [ mSelectionCondition (selectionName "highlight")
                        [ mStr "rgb(194,81,64)" ]
                        [ mStr "rgb(167,165,156)" ]
                    ]
                << size [ mNum 90 ]
    in
    toVegaLite
        [ config []
        , width 400
        , height 400
        , data []
        , trans []
        , point [ maFilled True ]
        , enc []
        , sel []
        ]


symbols1 : Spec
symbols1 =
    let
        data =
            dataFromColumns [] << dataColumn "x" (nums [ 0 ])

        shapeSpec sym =
            asSpec
                [ point
                    [ maFilled True
                    , maStroke "black"
                    , maSize 400
                    , maShape sym
                    , maStrokeWidth 0.5
                    ]
                ]
    in
    toVegaLite
        [ data []
        , columns 4
        , concat
            [ shapeSpec symCircle
            , shapeSpec symSquare
            , shapeSpec symDiamond
            , shapeSpec symCross
            , shapeSpec symTriangleUp
            , shapeSpec symTriangleDown
            , shapeSpec symTriangleLeft
            , shapeSpec symTriangleRight
            , shapeSpec symTriangle
            , shapeSpec symArrow
            , shapeSpec symWedge
            , shapeSpec symStroke
            , shapeSpec (symPath horizLine)
            ]
        ]


symbols2 : Spec
symbols2 =
    chart "Legend using non-default bordered square symbols)"
        (color
            [ mName "Origin"
            , mLegend
                [ leSymbolType symSquare
                , leSymbolStrokeColor "black"
                , leSymbolStrokeWidth 0.5
                ]
            ]
        )



{- This list comprises the specifications to be provided to the Vega-Lite runtime. -}


specs : List ( String, Spec )
specs =
    [ ( "defNominal", scatter1 )
    , ( "defOrdinal", scatter2 )
    , ( "rounded1", rounded1 )
    , ( "rounded2", rounded2 )
    , ( "rounded3", rounded3 )
    , ( "rounded4", rounded4 )
    , ( "rounded5", rounded5 )
    , ( "rounded6", rounded6 )
    , ( "size1", scatter3 )
    , ( "size2", scatter4 )
    , ( "size3", scatter5 )
    , ( "multi1", scatter6 )
    , ( "multi2", scatter7 )
    , ( "multi3", scatter8 )
    , ( "multi4", scatter9 )
    , ( "multi5", scatter10 )
    , ( "multi6", scatter11 )
    , ( "custom1", scatter12 )
    , ( "custom2", scatter13 )
    , ( "custom3", scatter14 )
    , ( "custom4", scatter15 )
    , ( "isotype1", personGrid )
    , ( "symbols1", symbols1 )
    , ( "symbols2", symbols2 )
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
