port module NullTests exposing (elmToJS)

import Browser
import Dict
import Html exposing (Html)
import Html.Attributes
import Html.Events
import Json.Encode
import VegaLite exposing (..)


path : String
path =
    "https://cdn.jsdelivr.net/npm/vega-datasets@2.3/data/"


axis1 : Spec
axis1 =
    let
        data =
            dataFromColumns []
                << dataColumn "x" (nums [ 0, 1000, 1000, 0, 0, 1000 ])
                << dataColumn "y" (nums [ 1000, 1000, 0, 0, 1000, 0 ])
                << dataColumn "order" (List.range 1 6 |> List.map toFloat |> nums)

        enc =
            encoding
                << position X [ pName "x", pQuant, pAxis [] ]
                << position Y [ pName "y", pQuant, pAxis [] ]
                << order [ oName "order" ]
    in
    toVegaLite [ data [], enc [], line [] ]


scaleEncode : ( VLProperty, Spec ) -> Spec
scaleEncode enc =
    let
        data =
            dataFromColumns []
                << dataColumn "x" (nums [ 10, 20, 30, 40, 50, 60, 70, 80, 90, 100 ])
                << dataColumn "y" (nums [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ])
                << dataColumn "val" (nums [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ])
                << dataColumn "cat" (strs [ "a", "b", "c", "d", "e", "f", "g", "h", "i", "j" ])
    in
    toVegaLite [ width 400, height 400, data [], enc, point [] ]


scale0 : Spec
scale0 =
    (encoding
        << position X [ pName "x", pQuant ]
        << position Y [ pName "y", pQuant ]
        << color [ mName "val", mOrdinal ]
        << size [ mName "val", mQuant ]
        << shape [ mName "cat" ]
    )
        []
        |> scaleEncode


scale1 : Spec
scale1 =
    (encoding
        << position X [ pName "x", pQuant, pScale [] ]
        << position Y [ pName "y", pQuant ]
        << color [ mName "val", mOrdinal ]
        << size [ mName "val", mQuant ]
        << shape [ mName "cat" ]
    )
        []
        |> scaleEncode


scale2 : Spec
scale2 =
    (encoding
        << position X [ pName "x", pQuant ]
        << position Y [ pName "y", pQuant, pScale [] ]
        << color [ mName "val", mOrdinal ]
        << size [ mName "val", mQuant ]
        << shape [ mName "cat" ]
    )
        []
        |> scaleEncode


scale3 : Spec
scale3 =
    (encoding
        << position X [ pName "x", pQuant ]
        << position Y [ pName "y", pQuant ]
        << color [ mName "val", mOrdinal, mScale [] ]
        << size [ mName "val", mQuant ]
        << shape [ mName "cat" ]
    )
        []
        |> scaleEncode


scale4 : Spec
scale4 =
    (encoding
        << position X [ pName "x", pQuant ]
        << position Y [ pName "y", pQuant ]
        << color [ mName "val", mOrdinal ]
        << size [ mName "val", mQuant, mScale [] ]
        << shape [ mName "cat" ]
    )
        []
        |> scaleEncode


scale5 : Spec
scale5 =
    (encoding
        << position X [ pName "x", pQuant ]
        << position Y [ pName "y", pQuant ]
        << color [ mName "val", mOrdinal ]
        << size [ mName "val", mQuant ]
        << shape [ mName "cat", mScale [] ]
    )
        []
        |> scaleEncode


filter1 : Spec
filter1 =
    let
        cfg =
            configure
                << configuration (coMark [ maRemoveInvalid False ])

        data =
            dataFromUrl (path ++ "movies.json") []

        enc =
            encoding
                << position X [ pName "IMDB Rating", pQuant ]
                << position Y [ pName "Rotten Tomatoes Rating", pQuant ]
                << color
                    [ mCondition (prTest (expr "datum['IMDB Rating'] === null || datum['Rotten Tomatoes Rating'] === null"))
                        [ mStr "#ddd" ]
                        [ mStr "rgb(76,120,168)" ]
                    ]
    in
    toVegaLite
        [ cfg [], data, enc [], point [] ]


filter2 : Spec
filter2 =
    let
        cfg =
            configure
                << configuration (coMark [ maRemoveInvalid False ])

        data =
            dataFromUrl (path ++ "movies.json") []

        trans =
            transform
                << filter (fiValid "IMDB Rating")
                << filter (fiValid "Rotten Tomatoes Rating")

        enc =
            encoding
                << position X [ pName "IMDB Rating", pQuant ]
                << position Y [ pName "Rotten Tomatoes Rating", pQuant ]
                << color
                    [ mCondition (prTest (expr "datum['IMDB Rating'] === null || datum['Rotten Tomatoes Rating'] === null"))
                        [ mStr "#ddd" ]
                        [ mStr "rgb(76,120,168)" ]
                    ]
    in
    toVegaLite [ cfg [], data, trans [], enc [], point [] ]

invalidModes :List MarkProperty-> Spec
invalidModes markProps =
    let
        cfg =
            configure
                << configuration (coMark markProps )

        data =
            dataFromRows []
                << dataRow [ ( "a", nullValue ), ( "b", num 100 ) ]
                << dataRow [ ( "a", num -10 ), ( "b", nullValue) ]
                << dataRow [ ( "a", num -5 ), ( "b", num -25 ) ]
                << dataRow [ ( "a", num -1 ), ( "b", num -20 ) ]
                << dataRow [ ( "a", num 0 ), ( "b", nullValue ) ]
                << dataRow [ ( "a", num 1), ( "b", num 30 ) ]
                << dataRow [ ( "a", num 5), ( "b", num 40 ) ]
                << dataRow [ ( "a", num 10), ( "b", nullValue ) ]
        
        encQuant =
            encoding
                << position X [ pName "a", pQuant]
                << position Y [ pName "b", pQuant]
        spec1 =
            asSpec [width 100, height 100, encQuant[], point []]
        
        spec2 =
            asSpec [width 100, height 100, encQuant[], bar []]

        spec3 =
            asSpec [width 100, height 100, encQuant[], line [ maPoint (pmMarker []) ]]

        spec4 =
            asSpec [width 100, height 100, encQuant[], area []]

        quantSpec = 
            asSpec [title "Quantitative X" [], hConcat [spec1, spec2, spec3, spec4]]


        encOrd =
            encoding
                << position X [ pName "a", pOrdinal]
                << position Y [ pName "b", pQuant]

        spec5 =
            asSpec [width 100, height 100, encOrd[], point []]
        
        spec6 =
            asSpec [width 100, height 100, encOrd[], bar []]

        spec7 =
            asSpec [width 100, height 100, encOrd[], line [ maPoint (pmMarker []) ]]

        spec8 =
            asSpec [width 100, height 100, encOrd[], area []]

        ordSpec = 
            asSpec [ title "Ordinal X" [], hConcat [spec5, spec6, spec7, spec8] ]
                
    in
    toVegaLite [ cfg[], data [], vConcat [quantSpec, ordSpec] ]

imputeScatter : List (Channel, DataValue) -> Spec
imputeScatter ivs =
    let
        cfg =
            configure
                << configuration (coMark [maInvalid [], maTooltip ttEncoding] )
                << configuration (coScale [ sacoInvalid ivs])

        data =
            dataFromRows []
                << dataRow [ ( "a", num 1 ), ( "b", num 15 ), ("c", num 1) ]
                << dataRow [ ( "a", num 2 ), ( "b", num 25), ("c", num 1) ]
                << dataRow [ ( "a", num 3 ), ( "b", num 20 ), ("c", num 1) ]
                << dataRow [ ( "a", num 1 ), ( "b", num 12 ), ("c", num 2) ]
                << dataRow [ ( "a", num 2 ), ( "b", num 21), ("c", num 2) ]
                << dataRow [ ( "a", num 3 ), ( "b", num 29 ), ("c", num 2) ]
                << dataRow [ ( "a", num 1 ), ( "b", num 8 ), ("c", nullValue) ]
                << dataRow [ ( "a", num 2 ), ( "b", num 31), ("c", nullValue) ]
                << dataRow [ ( "a", num 3 ), ( "b", num 49 ), ("c", nullValue) ]

        encClr = 
            encoding
                << position X [ pName "a", pQuant ]
                << position Y [ pName "b", pQuant ]
                << color [mName "c", mQuant ]

        encSze = 
            encoding
                << position X [ pName "a", pQuant ]
                << position Y [ pName "b", pQuant ]
                << size [mName "c", mQuant ]

        clrSpec =
            asSpec [title "Colour" [], width 100, height 100, encClr[], point[] ]

        szeSpec =
            asSpec [title "Size" [], width 100, height 100, encSze[], point[] ]
                
    in
        toVegaLite [cfg[], data[], concat [clrSpec, szeSpec] ]


imputeBar : List (Channel, DataValue) -> Spec
imputeBar ivs =
    let
        cfg =
            configure
                << configuration (coMark [maInvalid [ ivImputeMark ], maTooltip ttEncoding] )
                << configuration (coScale [ sacoInvalid ivs])

        data =
            dataFromRows []
                << dataRow [ ( "a", num 1 ), ( "b", num 15 ), ("c", num 1) ]
                << dataRow [ ( "a", num 2 ), ( "b", num 25), ("c", num 1) ]
                << dataRow [ ( "a", num 3 ), ( "b", num 20 ), ("c", num 1) ]
                << dataRow [ ( "a", num 1 ), ( "b", num 12 ), ("c", num 2) ]
                << dataRow [ ( "a", num 2 ), ( "b", num 21), ("c", num 2) ]
                << dataRow [ ( "a", num 3 ), ( "b", num 29 ), ("c", num 2) ]
                << dataRow [ ( "a", num 1 ), ( "b", num 8 ), ("c", nullValue) ]
                << dataRow [ ( "a", num 2 ), ( "b", num 31), ("c", nullValue) ]
                << dataRow [ ( "a", num 3 ), ( "b", num 49 ), ("c", nullValue) ]

        enc = 
            encoding
                << position X [ pName "a", pQuant ]
                << position Y [ pName "b", pQuant ]
                << color [mName "c", mQuant ]

    in
        toVegaLite [ cfg[], data[], enc[], bar[] ]



{- Ids and specifications to be provided to the Vega-Lite runtime. -}


specs : List ( String, Spec )
specs =
    [ ( "axis1", axis1 )
    , ( "scale0", scale0 )
    , ( "scale1", scale1 )
    , ( "scale2", scale2 )
    , ( "scale3", scale3 )
    , ( "scale4", scale4 )
    , ( "scale5", scale5 )
    , ( "filter1", filter1 )
    , ( "filter2", filter2 )
    , ( "modes1", invalidModes [ maInvalid [] ] )
    , ( "modes2", invalidModes [ maInvalid [ivImputeMark] ] )
    , ( "modes3", invalidModes [ maInvalid [ivBreakPaths] ] )
    , ( "modes4", invalidModes [ maInvalid [ivImputeDomain, ivImputePathDomain, ivBreakPaths] ] )
    , ( "modes5", invalidModes [ maInvalid [ivImputePathDomain, ivBreakPaths] ] )
    , ( "impute1", imputeScatter [ ] )
    , ( "impute2", imputeScatter[ (chColor, str "#aaa"), (chSize, num 4) ] )
    , ( "impute3", imputeBar[ ] )
    , ( "impute4", imputeBar[ (chColor, str "red") ] )
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
