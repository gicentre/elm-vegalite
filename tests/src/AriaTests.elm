port module AriaTests exposing (elmToJS)

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


defaultVis : List MarkProperty -> List AxisProperty -> List LegendProperty -> (List a -> ( VLProperty, Spec )) -> Spec
defaultVis mProps axProps leProps cfg =
    let
        data =
            dataFromUrl (path ++ "cars.json") []

        axp =
            if axProps == [] then
                [ axDomain True ]

            else
                axProps

        lep =
            if leProps == [] then
                [ leColumns 1 ]

            else
                leProps

        enc =
            encoding
                << position X [ pName "Horsepower", pQuant, pAxis axp ]
                << position Y [ pName "Miles_per_Gallon", pQuant, pAxis axp ]
                << color [ mName "Cylinders", mOrdinal, mLegend lep ]
                << shape [ mName "Origin" ]
    in
    toVegaLite
        [ title "Car Scatter" []
        , cfg []
        , width 200
        , height 200
        , data
        , enc []
        , point (maSize 100 :: mProps)
        ]


aria1 : Spec
aria1 =
    configure
        << configuration (coAria False)
        |> defaultVis [] [] []


aria2 : Spec
aria2 =
    configure |> defaultVis [ maAria [] ] [] []


aria3 : Spec
aria3 =
    configure |> defaultVis [ maAria [ arDescription "Point mark description here" ] ] [] []


aria4 : Spec
aria4 =
    configure
        |> defaultVis [ maAria [ arEnable, arDescription "Point mark description here" ] ]
            []
            []


aria5 : Spec
aria5 =
    configure
        |> defaultVis [ maAria [ arEnable, arDescription "Point mark description here" ] ]
            [ axAria [] ]
            []


aria6 : Spec
aria6 =
    configure
        |> defaultVis [ maAria [ arEnable, arDescription "Point mark description here" ] ]
            [ axAria [ arDescription "Axis description here" ] ]
            []


aria7 : Spec
aria7 =
    configure
        |> defaultVis [ maAria [ arEnable, arDescription "Point mark description here" ] ]
            [ axAria [ arEnable, arDescription "Axis description here" ] ]
            []


aria8 : Spec
aria8 =
    configure
        << configuration (coAria False)
        << configuration (coAxis [ axcoAria [ arEnable, arDescription "Axis description here" ] ])
        |> defaultVis [] [] []


aria9 : Spec
aria9 =
    configure
        |> defaultVis [ maAria [ arEnable, arDescription "Point mark description here" ] ]
            []
            [ leAria [] ]


aria10 : Spec
aria10 =
    configure
        |> defaultVis [ maAria [ arEnable, arDescription "Point mark description here" ] ]
            []
            [ leAria [ arDescription "Legend description here" ] ]


aria11 : Spec
aria11 =
    configure
        |> defaultVis [ maAria [ arEnable, arDescription "Point mark description here" ] ]
            []
            [ leAria [ arEnable, arDescription "Legend description here" ] ]


aria12 : Spec
aria12 =
    configure
        << configuration (coAria False)
        << configuration (coLegend [ lecoAria [ arEnable, arDescription "Legend description here" ] ])
        |> defaultVis [] [] []



{- Ids and specifications to be provided to the Vega-Lite runtime. -}


specs : List ( String, Spec )
specs =
    [ ( "aria1", aria1 )
    , ( "aria2", aria2 )
    , ( "aria3", aria3 )
    , ( "aria4", aria4 )
    , ( "aria5", aria5 )
    , ( "aria6", aria6 )
    , ( "aria7", aria7 )
    , ( "aria8", aria8 )
    , ( "aria9", aria9 )
    , ( "aria10", aria10 )
    , ( "aria11", aria11 )
    , ( "aria12", aria12 )
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
