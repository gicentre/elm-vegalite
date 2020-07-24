port module ColorTests exposing (elmToJS)

import Browser
import Dict exposing (Dict)
import Html exposing (Html)
import Html.Attributes
import Html.Events
import Json.Encode
import VegaLite exposing (..)


chart : String -> (List a -> List ( String, Spec )) -> Spec
chart desText enc =
    let
        des =
            description desText

        data =
            dataFromUrl "https://vega.github.io/vega-lite/data/cars.json"

        trans =
            transform
                << calculateAs "(datum.Acceleration - 15.52)/2.80" "accelerationZScore"

        fullEnc =
            encoding
                << position X [ pName "Horsepower", pQuant ]
                << position Y [ pName "Miles_per_Gallon", pQuant ]
                << size [ mNum 60 ]
                << opacity [ mNum 1 ]
                << enc
    in
    toVegaLite [ des, data [], trans [], circle [], fullEnc [] ]


defContinuous : Spec
defContinuous =
    chart "Default continuous colour scales."
        (color [ mName "Acceleration", mQuant ])


defOrdinal : Spec
defOrdinal =
    chart "Default ordinal colour scales."
        (color [ mName "Cylinders", mOrdinal ])


defNominal : Spec
defNominal =
    chart "Default nominal colour scales."
        (color [ mName "Origin", mNominal ])


namedContinuous1 : Spec
namedContinuous1 =
    chart "Continuous colour scale based on named vega schame. Should use the entire plasma colour scheme."
        (color [ mName "Acceleration", mQuant, mScale [ scScheme "plasma" [] ] ])


namedContinuous2 : Spec
namedContinuous2 =
    chart "Continuous colour scale based on named vega schame. Should use the upper half of the plasma colour scheme."
        (color [ mName "Acceleration", mQuant, mScale [ scScheme "plasma" [ 0.5, 1 ] ] ])


namedContinuous3 : Spec
namedContinuous3 =
    chart "Continuous colour scale based on named vega schame. Should use the flipped plasma colour scheme (i.e. red to orange)."
        (color [ mName "Acceleration", mQuant, mScale [ scScheme "plasma" [], scReverse True ] ])


namedContinuous4 : Spec
namedContinuous4 =
    chart "Continuous colour scale based on named vega schame. Should use the first half of the flipped plasma colour scheme (i.e. red to orange)."
        (color [ mName "Acceleration", mQuant, mScale [ scScheme "plasma" [ 0, 0.5 ], scReverse True ] ])


customContinuous : Spec
customContinuous =
    chart "Custom continuous colour scheme (red to blue ramp)."
        (color [ mName "Acceleration", mQuant, mScale [ scRange (raStrs [ "#f33", "#33f" ]) ] ])


customDiscrete : Spec
customDiscrete =
    chart "Custom discrete colours (red, green, blue)."
        (color [ mName "Origin", mNominal, mScale [ scRange (raStrs [ "#e33", "#3a3", "#33d" ]) ] ])


scale1 : Spec
scale1 =
    chart "Linear (default) colour scale."
        (color [ mName "Acceleration", mQuant, mScale [ scType scLinear, scRange (raStrs [ "yellow", "red" ]) ] ])


scale3 : Spec
scale3 =
    chart "Power colour scale with default (1) exponent."
        (color [ mName "Acceleration", mQuant, mScale [ scType scPow, scRange (raStrs [ "yellow", "red" ]) ] ])


scale4 : Spec
scale4 =
    chart "Cubic Power colour scale."
        (color [ mName "Acceleration", mQuant, mScale [ scType scPow, scExponent 3, scRange (raStrs [ "yellow", "red" ]) ] ])


scale5 : Spec
scale5 =
    chart "Square root colour scale."
        (color [ mName "Acceleration", mQuant, mScale [ scType scSqrt, scRange (raStrs [ "yellow", "red" ]) ] ])


scale6 : Spec
scale6 =
    chart "Log colour scale."
        (color [ mName "Acceleration", mQuant, mScale [ scType scLog, scRange (raStrs [ "yellow", "red" ]) ] ])


scale7 : Spec
scale7 =
    chart "SymLog colour scale with default slope constant (1)."
        (color [ mName "accelerationZScore", mQuant, mScale [ scType scSymLog, scRange (raStrs [ "yellow", "red" ]) ] ])


scale8 : Spec
scale8 =
    chart "SymLog colour scale with slope constant of 0.01."
        (color [ mName "accelerationZScore", mQuant, mScale [ scType scSymLog, scConstant 0.01, scRange (raStrs [ "yellow", "red" ]) ] ])


interp1 : Spec
interp1 =
    chart "HSL interpolation."
        (color [ mName "Acceleration", mQuant, mScale [ scInterpolate hsl, scType scLinear, scRange (raStrs [ "yellow", "red" ]) ] ])


interp2 : Spec
interp2 =
    chart "HSL-long interpolation."
        (color [ mName "Acceleration", mQuant, mScale [ scInterpolate hslLong, scType scLinear, scRange (raStrs [ "yellow", "red" ]) ] ])


interp3 : Spec
interp3 =
    chart "Lab interpolation."
        (color [ mName "Acceleration", mQuant, mScale [ scInterpolate lab, scType scLinear, scRange (raStrs [ "yellow", "red" ]) ] ])


interp4 : Spec
interp4 =
    chart "HCL interpolation."
        (color [ mName "Acceleration", mQuant, mScale [ scInterpolate hcl, scType scLinear, scRange (raStrs [ "yellow", "red" ]) ] ])


interp5 : Spec
interp5 =
    chart "HCL-long interpolation."
        (color [ mName "Acceleration", mQuant, mScale [ scInterpolate hclLong, scType scLinear, scRange (raStrs [ "yellow", "red" ]) ] ])


interp6 : Spec
interp6 =
    chart "cube-helix interpolation."
        (color [ mName "Acceleration", mQuant, mScale [ scInterpolate (cubeHelix 1), scType scLinear, scRange (raStrs [ "yellow", "red" ]) ] ])


interp7 : Spec
interp7 =
    chart "cube-helix-long interpolation."
        (color [ mName "Acceleration", mQuant, mScale [ scInterpolate (cubeHelixLong 1), scType scLinear, scRange (raStrs [ "yellow", "red" ]) ] ])


gamma1 : Spec
gamma1 =
    chart "cube-helix-long interpolation, gamma of -0.1"
        (color [ mName "Acceleration", mQuant, mScale [ scInterpolate (cubeHelixLong -0.1), scType scLinear, scRange (raStrs [ "yellow", "red" ]) ] ])


gamma2 : Spec
gamma2 =
    chart "cube-helix-long interpolation, gamma of 0"
        (color [ mName "Acceleration", mQuant, mScale [ scInterpolate (cubeHelixLong 0), scType scLinear, scRange (raStrs [ "yellow", "red" ]) ] ])


gamma3 : Spec
gamma3 =
    chart "cube-helix-long interpolation with default gamma value of 1"
        (color [ mName "Acceleration", mQuant, mScale [ scInterpolate (cubeHelixLong 1), scType scLinear, scRange (raStrs [ "yellow", "red" ]) ] ])


gamma4 : Spec
gamma4 =
    chart "cube-helix-long interpolation, gamma of 2"
        (color [ mName "Acceleration", mQuant, mScale [ scInterpolate (cubeHelixLong 2), scType scLinear, scRange (raStrs [ "yellow", "red" ]) ] ])


gamma5 : Spec
gamma5 =
    chart "cube-helix-long interpolation, gamma of 10"
        (color [ mName "Acceleration", mQuant, mScale [ scInterpolate (cubeHelixLong 10), scType scLinear, scRange (raStrs [ "yellow", "red" ]) ] ])


blend1 : Spec
blend1 =
    -- Thanks to @dougburke for this blend mode test.
    let
        blendData =
            dataFromColumns []
                << dataColumn "x" (nums [ 0 ])
                << dataColumn "y" (nums [ 0 ])

        ellipse ang =
            let
                rad =
                    ang * pi / 180

                cosRot =
                    cos rad

                sinRot =
                    sin rad

                rmajor =
                    1.0

                rminor =
                    0.3

                pair t =
                    let
                        x =
                            rmajor * cos t * cosRot - rminor * sin t * sinRot

                        y =
                            rmajor * cos t * sinRot + rminor * sin t * cosRot
                    in
                    "L " ++ String.fromFloat x ++ " " ++ String.fromFloat y

                thetas =
                    List.range 0 25 |> List.map (\n -> (2 * pi / 25) * toFloat n)
            in
            List.intersperse " " (List.map pair thetas) |> String.concat |> symPath

        ax t f =
            position t [ pName f, pQuant, pScale [ scDomain (doNums [ -5, 5 ]) ], pTitle "" ]

        props p =
            case p of
                0 ->
                    [ grX1 0.5, grX2 0.5, grY1 1, grY2 0 ]

                1 ->
                    [ grX1 0.7, grX2 0.3, grY1 0.1, grY2 1 ]

                _ ->
                    [ grX1 1, grX2 0, grY1 1, grY2 0 ]

        gradient f =
            let
                c =
                    case f of
                        0 ->
                            "rgb(0,255,0)"

                        1 ->
                            "rgb(255,0,0)"

                        _ ->
                            "rgb(0,0,255)"
            in
            maFillGradient grLinear (grStops [ ( 0, "white" ), ( 1, c ) ] :: props f)

        lyr bm f =
            let
                a =
                    case f of
                        0 ->
                            0

                        1 ->
                            45

                        _ ->
                            -45
            in
            asSpec [ point [ maShape (ellipse a), maBlend bm, gradient f ] ]

        createLayer ( bm, ttl ) =
            let
                enc =
                    encoding
                        << ax X "x"
                        << ax Y "y"
            in
            asSpec
                [ enc []
                , layer (List.map (lyr bm) [ 1, 0, 2 ])
                , title ttl []
                ]

        layers =
            List.map createLayer
                [ ( bmNormal, "Normal" )
                , ( bmMultiply, "Multiply" )
                , ( bmScreen, "Screen" )
                , ( bmOverlay, "Overlay" )
                , ( bmDarken, "Darken" )
                , ( bmLighten, "Lighten" )
                , ( bmColorDodge, "Color-Dodge" )
                , ( bmColorBurn, "Color-Burn" )
                , ( bmHardLight, "Hard-Light" )
                , ( bmSoftLight, "Soft-Light" )
                , ( bmDifference, "Difference" )
                , ( bmExclusion, "Exclusion" )
                , ( bmHue, "Hue" )
                , ( bmSaturation, "Saturation" )
                , ( bmColor, "Color" )
                , ( bmLuminosity, "Luminosity" )
                ]

        cfg =
            configure
                << configuration (coAxis [ axcoDomain False, axcoLabels False, axcoTicks False ])
                << configuration (coPoint [ maOpacity 1, maSize 40000, maStroke "" ])
                << configuration (coBackground "rgba(255,255,255,0)")
    in
    toVegaLite
        [ cfg []
        , blendData []
        , columns 4
        , vConcat layers
        ]



{- Ids and specifications to be provided to the Vega-Lite runtime. -}


specs : List ( String, Spec )
specs =
    [ ( "defContinuous", defContinuous )
    , ( "defOrdinal", defOrdinal )
    , ( "defNominal", defNominal )
    , ( "namedContinuous1", namedContinuous1 )
    , ( "namedContinuous2", namedContinuous2 )
    , ( "namedContinuous3", namedContinuous3 )
    , ( "namedContinuous4", namedContinuous4 )
    , ( "customContinuous", customContinuous )
    , ( "customDiscrete", customDiscrete )
    , ( "scale1", scale1 )
    , ( "scale3", scale3 )
    , ( "scale4", scale4 )
    , ( "scale5", scale5 )
    , ( "scale6", scale6 )
    , ( "scale7", scale7 )
    , ( "scale8", scale8 )
    , ( "interp1", interp1 )
    , ( "interp2", interp2 )
    , ( "interp3", interp3 )
    , ( "interp4", interp4 )
    , ( "interp5", interp5 )
    , ( "interp6", interp6 )
    , ( "interp7", interp7 )
    , ( "gamma1", gamma1 )
    , ( "gamma2", gamma2 )
    , ( "gamma3", gamma3 )
    , ( "gamma4", gamma4 )
    , ( "gamma5", gamma5 )
    , ( "blend1", blend1 )
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
