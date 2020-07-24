port module TextFormatTests exposing (elmToJS)

import Browser
import Dict exposing (Dict)
import Html exposing (Html)
import Html.Attributes
import Html.Events
import Json.Encode
import VegaLite exposing (..)


textFormat1 : Spec
textFormat1 =
    let
        data =
            dataFromColumns []
                << dataColumn "a" (strs (List.range 1981 2001 |> List.map String.fromInt))
                << dataColumn "b" (nums (List.range 1991 2011 |> List.map (\n -> toFloat (2011 + (1991 - n)))))

        encSym =
            encoding
                << position X [ pName "a", pTemporal ]
                << position Y [ pName "b", pQuant ]

        specSym =
            asSpec [ circle [], encSym [] ]

        encLabel =
            encoding
                << position X
                    [ pName "a"
                    , pTemporal
                    , pAxis [ axFormatAsTemporal, axFormat "%y" ]
                    ]
                << position Y
                    [ pName "b"
                    , pQuant
                    , pScale [ scZero False ]
                    , pAxis [ axFormatAsNum, axFormat ".2f" ]
                    ]
                << text
                    [ tName "a"
                    , tTemporal
                    , tFormatAsTemporal
                    , tFormat "%b `%y"
                    ]
                << color
                    [ mName "a"
                    , mTemporal
                    , mLegend [ leFormatAsTemporal, leFormat "%b %Y" ]
                    ]

        specLabel =
            asSpec
                [ encLabel []
                , textMark [ maDy 4, maDx 22, maBaseline vaMiddle, maLimit 30, maEllipsis "~ ", maDir tdRightToLeft ]
                ]
    in
    toVegaLite
        [ width 600
        , height 400
        , title "A title over\ntwo lines with an \\n escaped new line on the second line." []
        , data []
        , layer [ specSym, specLabel ]
        ]


textFormat2 : Spec
textFormat2 =
    let
        data =
            dataFromUrl "https://gicentre.github.io/data/westMidlands/westMidsCrimesAggregated.tsv"

        trans =
            transform
                << filter (fiExpr "datum.month >= '2016'")

        enc =
            encoding
                << position X [ pName "crimeType", pTitle "" ]
                << position Y [ pName "reportedCrimes", pQuant, pAggregate opSum ]
                << color [ mName "crimeType", mLegend [] ]
                << column [ fName "month", fTemporal, fHeader [ hdFormatAsTemporal, hdFormat "%b %y" ] ]
    in
    toVegaLite [ width 100, data [], trans [], bar [], enc [] ]


textAlign1 : Spec
textAlign1 =
    let
        cfg =
            configure
                << configuration (coMark [ maFontSize 20 ])
                << configuration (coText [ maLineHeight 40 ])

        data =
            dataFromColumns []
                << dataColumn "x" (nums [ 10, 20 ])
                << dataColumn "y" (nums [ 10, 20 ])

        enc =
            encoding
                << position X
                    [ pName "x"
                    , pQuant
                    , pTitle ""
                    , pScale [ scDomain (doNums [ 5, 25 ]), scNice niFalse ]
                    , pAxis [ axLabelLineHeight 40, axLabelBaseline vaLineTop ]
                    ]
                << position Y
                    [ pName "y"
                    , pQuant
                    , pTitle ""
                    , pScale [ scDomain (doNums [ 5, 25 ]), scNice niFalse ]
                    ]
                << text [ tStr "Xxgqh" ]

        mk va =
            case va of
                "top" ->
                    asSpec [ title va [], data [], enc [], textMark [ maBaseline vaTop ] ]

                "lineTop" ->
                    asSpec [ title va [], data [], enc [], textMark [ maBaseline vaLineTop ] ]

                "middle" ->
                    asSpec [ title va [], data [], enc [], textMark [ maBaseline vaMiddle ] ]

                "alphabetic" ->
                    asSpec [ title va [], data [], enc [], textMark [ maBaseline vaAlphabetic ] ]

                "bottom" ->
                    asSpec [ title va [], data [], enc [], textMark [ maBaseline vaBottom ] ]

                "lineBottom" ->
                    asSpec [ title va [], data [], enc [], textMark [ maBaseline vaLineBottom ] ]

                _ ->
                    asSpec []
    in
    toVegaLite
        [ cfg []
        , columns 2
        , concat (List.map mk [ "top", "lineTop", "middle", "alphabetic", "bottom", "lineBottom" ])
        ]


multiline1 : Spec
multiline1 =
    let
        cfg =
            configure
                << configuration (coTitle [ ticoSubtitleLineHeight 24 ])
                << configuration (coAxis [ axcoTitleLineHeight 24 ])
                << configuration (coLegend [ lecoTitleLineHeight 24 ])
                << configuration (coMark [ maLineHeight 16 ])

        data1 =
            dataFromColumns []
                << dataColumn "x" (nums [ 8, 12 ])
                << dataColumn "y" (nums [ 5, 15 ])
                << dataColumn "label" (strs [ "data on\ntwo lines", "data on\nthree\nlines" ])
                << dataColumn "cat" (strs [ "A", "B" ])

        data2 =
            dataFromColumns []
                << dataColumn "x" (nums [ 15 ])
                << dataColumn "y" (nums [ 10 ])
                << dataColumn "cat" (strs [ "C" ])

        encBase =
            encoding
                << position X
                    [ pName "x"
                    , pQuant
                    , pScale [ scDomain (doNums [ 0, 20 ]) ]
                    , pTitle "Axis title on\ntwo lines"
                    ]
                << position Y
                    [ pName "y"
                    , pQuant
                    , pScale [ scDomain (doNums [ 0, 20 ]) ]
                    , pAxis [ axTitle "Axis title on\ntwo lines" ]
                    ]
                << color [ mName "cat", mTitle "Legend title on\ntwo lines" ]

        enc1 =
            encBase
                << text [ tName "label" ]

        spec1 =
            asSpec [ data1 [], enc1 [], textMark [] ]

        enc2 =
            encBase
                << text [ tStr "literal\non\nthree lines" ]

        spec2 =
            asSpec [ data2 [], enc2 [], textMark [] ]
    in
    toVegaLite
        [ cfg []
        , title "Main title on\ntwo lines" [ tiLineHeight 24, tiSubtitle "Subtitle on\ntwo lines" ]
        , layer [ spec1, spec2 ]
        ]


customFormatter1 : Spec
customFormatter1 =
    let
        data =
            dataFromUrl "https://gicentre.github.io/data/westMidlands/westMidsCrimesAggregated.tsv"

        trans =
            transform
                << filter (fiExpr "datum.month >= '2016'")

        enc =
            encoding
                << position X [ pName "crimeType", pAxis [ axFormatAsCustom "axTest" ] ]
                << position Y [ pName "reportedCrimes", pQuant, pAggregate opSum ]
                << color [ mName "crimeType", mLegend [ leFormatAsCustom "leTest" ] ]
                << column [ fName "month", fTemporal, fHeader [ hdFormatAsCustom "hdTest" ] ]
    in
    toVegaLite [ width 100, data [], trans [], bar [], enc [] ]



{- Ids and specifications to be provided to the Vega-Lite runtime. -}


specs : List ( String, Spec )
specs =
    [ ( "textFormat1", textFormat1 )
    , ( "textFormat2", textFormat2 )
    , ( "textAlign1", textAlign1 )
    , ( "multiline1", multiline1 )
    , ( "customFormatter1", customFormatter1 )
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
