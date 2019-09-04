port module ProjectionTests exposing (elmToJS)

import Browser
import Html exposing (Html, div, pre)
import Html.Attributes exposing (id)
import Json.Encode
import VegaLite exposing (..)



{- Some relevant data sources:

   https://github.com/deldersveld/topojson
   https://github.com/topojson/world-atlas

   graticule.json produced with mapshaper.org:
     open console and type -graticule then export as topojson.
-}


worldMapTemplate : String -> List ProjectionProperty -> ( String, Spec )
worldMapTemplate tText projProps =
    ( tText
    , toVegaLite
        [ width 500
        , height 300
        , title tText []
        , background "#c1e7f5"
        , projection projProps

        --, dataFromUrl "https://vega.github.io/vega-lite/data/world-110m.json" [ topojsonFeature "countries" ]
        , dataFromUrl "https://vega.github.io/vega-lite/data/graticule.json" [ topojsonFeature "graticule" ]
        , geoshape [ maFillOpacity 0.01, maStroke "#411", maStrokeWidth 0.5 ]
        ]
    )


standardProjs : List ( String, Spec )
standardProjs =
    [ worldMapTemplate "Albers" [ prType albers ]
    , worldMapTemplate "AzimuthalEqualArea" [ prType azimuthalEqualArea ]
    , worldMapTemplate "AzimuthalEquidistant" [ prType azimuthalEquidistant ]
    , worldMapTemplate "ConicConformal" [ prType conicConformal, prClipAngle (Just 65) ]
    , worldMapTemplate "ConicEqualArea" [ prType conicEqualArea ]
    , worldMapTemplate "ConicEquidistant" [ prType conicEquidistant ]
    , worldMapTemplate "EqualEarth" [ prType equalEarth ]
    , worldMapTemplate "Equirectangular" [ prType equirectangular ]
    , worldMapTemplate "Gnomonic" [ prType gnomonic ]
    , worldMapTemplate "Identity" [ prType identityProjection ]
    , worldMapTemplate "Mercator" [ prType mercator ]
    , worldMapTemplate "Orthographic" [ prType orthographic ]
    , worldMapTemplate "Stereographic" [ prType stereographic ]
    , worldMapTemplate "TransverseMercator" [ prType transverseMercator ]
    ]


d3Projections : List ( String, Spec )
d3Projections =
    -- Note these require registering via JavaScript in the hosting page.
    let
        customSpec pText =
            worldMapTemplate pText [ prType (customProjection pText), prClipAngle (Just 179.999), prRotate 20 -90 0, prPrecision 0.1 ]
    in
    List.map customSpec [ "airy", "aitoff", "armadillo", "august", "baker", "berghaus", "bertin1953", "boggs", "bonne", "bottomley", "collignon", "craig", "craster", "cylindricalequalarea", "cylindricalstereographic", "eckert1", "eckert2", "eckert3", "eckert4", "eckert5", "eckert6", "eisenlohr", "fahey", "foucaut", "gingery", "winkel3" ]


configExample : ( String, Spec )
configExample =
    let
        cfg =
            configure
                << configuration (coBackground "rgb(251,247,238)")
                << configuration (coTitle [ ticoFont "Roboto", ticoFontWeight W600, ticoFontSize 18 ])
                << configuration (coView [ vicoWidth 500, vicoHeight 300, vicoStroke Nothing ])
                << configuration (coAutosize [ asFit ])
                << configuration (coProjection [ prType orthographic, prRotate 0 0 0 ])

        globeSpec =
            asSpec
                [ dataFromUrl "data/globe.json" [ topojsonFeature "globe" ]
                , geoshape [ maColor "#c1e7f5" ]
                ]

        graticuleSpec =
            asSpec
                [ dataFromUrl "https://vega.github.io/vega-lite/data/graticule.json" [ topojsonFeature "graticule" ]
                , geoshape [ maFillOpacity 0.01, maStroke "#411", maStrokeWidth 0.1 ]
                ]

        countrySpec =
            asSpec
                [ dataFromUrl "https://vega.github.io/vega-lite/data/world-110m.json" [ topojsonFeature "countries" ]
                , geoshape [ maColor "#708E71" ]
                ]
    in
    ( "configExample"
    , toVegaLite [ title "Hello, World!" [], cfg [], layer [ globeSpec, graticuleSpec, countrySpec ] ]
    )


reflectExample : Bool -> Bool -> ( String, Spec )
reflectExample rx ry =
    let
        name =
            if Basics.not rx && Basics.not ry then
                "identityExample"

            else
                "reflect"
                    ++ (if rx then
                            "X"

                        else
                            ""
                       )
                    ++ (if ry then
                            "Y"

                        else
                            ""
                       )
                    ++ "Example"

        globeSpec =
            asSpec
                [ dataFromUrl "data/globe.json" [ topojsonFeature "globe" ]
                , geoshape [ maColor "#c1e7f5" ]
                , projection [ prType identityProjection, prReflectX rx, prReflectY ry ]
                ]

        graticuleSpec =
            asSpec
                [ dataFromUrl "https://vega.github.io/vega-lite/data/graticule.json" [ topojsonFeature "graticule" ]
                , geoshape [ maFillOpacity 0.01, maStroke "#411", maStrokeWidth 0.1 ]
                , projection [ prType identityProjection, prReflectX rx, prReflectY ry ]
                ]

        countrySpec =
            asSpec
                [ dataFromUrl "https://vega.github.io/vega-lite/data/world-110m.json" [ topojsonFeature "countries" ]
                , geoshape [ maColor "#708E71" ]
                , projection [ prType identityProjection, prReflectX rx, prReflectY ry ]
                ]
    in
    ( name, toVegaLite [ width 500, height 250, layer [ globeSpec, graticuleSpec, countrySpec ] ] )


sourceExample : Spec
sourceExample =
    Tuple.second (reflectExample True True)



{- This list comprises the specifications to be provided to the Vega-Lite runtime. -}


mySpecs : Spec
mySpecs =
    combineSpecs
        (standardProjs
            ++ [ configExample
               , reflectExample False False
               , reflectExample True False
               , reflectExample False True
               , reflectExample True True
               ]
            ++ d3Projections
        )



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
