-- Input a user name and password. Make sure the password matches.
--
-- Read how it works:
--   https://guide.elm-lang.org/architecture/forms.html
--


module Main exposing
    ( Model
    , Msg(..)
    , init
    , main
    , ores
    , refinedProducts
    , reprocessingPercentage
    , update
    , view
    , viewInput
    , yieldPriceM3
    , yieldPriceUnit
    , yield_price
    )

import Basics exposing (..)
import Browser
import Dict exposing (Dict)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


type alias ProductQuantity =
    { product : String
    , quantity : Int
    }


type alias Ore =
    { name : String
    , refineQuantity : Int
    , volume : Float
    , products : List ProductQuantity
    , skill : String
    }


ores : Dict String Ore
ores =
    Dict.fromList
        [ ( "Arkonor"
          , { name = "Arkonor"
            , refineQuantity = 100
            , volume = 16.0
            , products =
                [ { product = "Tritanium", quantity = 22000 }
                , { product = "Mexallon", quantity = 2500 }
                , { product = "Megacyte", quantity = 320 }
                ]
            , skill = "Arkonor Reprocessing"
            }
          )
        , ( "Crimson Arkonor"
          , { name = "Crimson Arkonor"
            , refineQuantity = 100
            , volume = 16.0
            , products =
                [ { product = "Tritanium", quantity = 23100 }
                , { product = "Mexallon", quantity = 2625 }
                , { product = "Megacyte", quantity = 336 }
                ]
            , skill = "Arkonor Reprocessing"
            }
          )
        , ( "Prime Arkonor"
          , { name = "Prime Arkonor"
            , refineQuantity = 100
            , volume = 16.0
            , products =
                [ { product = "Tritanium", quantity = 24200 }
                , { product = "Mexallon", quantity = 2750 }
                , { product = "Megacyte", quantity = 352 }
                ]
            , skill = "Arkonor Reprocessing"
            }
          )
        , ( "Flawless Arkonor"
          , { name = "Flawless Arkonor"
            , refineQuantity = 100
            , volume = 16.0
            , products =
                [ { product = "Tritanium", quantity = 25300 }
                , { product = "Mexallon", quantity = 2875 }
                , { product = "Megacyte", quantity = 368 }
                ]
            , skill = "Arkonor Reprocessing"
            }
          )
        , ( "Bezdnacine"
          , { name = "Bezdnacine"
            , refineQuantity = 100
            , volume = 16.0
            , products =
                [ { product = "Tritanium", quantity = 13200 }
                , { product = "Pyerite", quantity = 2200 }
                , { product = "Mexallon", quantity = 3780 }
                , { product = "Isogen", quantity = 1100 }
                , { product = "Megacyte", quantity = 185 }
                , { product = "Morphite", quantity = 10 }
                ]
            , skill = "Scordite Reprocessing"
            }
          )
        , ( "Bistot"
          , { name = "Bistot"
            , refineQuantity = 100
            , volume = 16.0
            , products =
                [ { product = "Pyerite", quantity = 12000 }
                , { product = "Zydrine", quantity = 450 }
                , { product = "Megacyte", quantity = 100 }
                ]
            , skill = "Bistot Reprocessing"
            }
          )
        , ( "Triclinic Bistot"
          , { name = "Triclinic Bistot"
            , refineQuantity = 100
            , volume = 16.0
            , products =
                [ { product = "Pyerite", quantity = 12600 }
                , { product = "Zydrine", quantity = 473 }
                , { product = "Megacyte", quantity = 105 }
                ]
            , skill = "Bistot Reprocessing"
            }
          )
        , ( "Monoclinic Bistot"
          , { name = "Monoclinic Bistot"
            , refineQuantity = 100
            , volume = 16.0
            , products =
                [ { product = "Pyerite", quantity = 13200 }
                , { product = "Zydrine", quantity = 495 }
                , { product = "Megacyte", quantity = 110 }
                ]
            , skill = "Bistot Reprocessing"
            }
          )
        , ( "Cubic Bistot"
          , { name = "Cubic Bistot"
            , refineQuantity = 100
            , volume = 16.0
            , products =
                [ { product = "Pyerite", quantity = 13800 }
                , { product = "Zydrine", quantity = 518 }
                , { product = "Megacyte", quantity = 115 }
                ]
            , skill = "Bistot Reprocessing"
            }
          )
        , ( "Crokite"
          , { name = "Crokite"
            , refineQuantity = 100
            , volume = 16.0
            , products =
                [ { product = "Tritanium", quantity = 21000 }
                , { product = "Nocxium", quantity = 760 }
                , { product = "Zydrine", quantity = 135 }
                ]
            , skill = "Crokite Reprocessing"
            }
          )
        , ( "Sharp Crokite"
          , { name = "Sharp Crokite"
            , refineQuantity = 100
            , volume = 16.0
            , products =
                [ { product = "Tritanium", quantity = 22050 }
                , { product = "Nocxium", quantity = 798 }
                , { product = "Zydrine", quantity = 142 }
                ]
            , skill = "Crokite Reprocessing"
            }
          )
        , ( "Crystalline Crokite"
          , { name = "Crystalline Crokite"
            , refineQuantity = 100
            , volume = 16.0
            , products =
                [ { product = "Tritanium", quantity = 23100 }
                , { product = "Nocxium", quantity = 836 }
                , { product = "Zydrine", quantity = 149 }
                ]
            , skill = "Crokite Reprocessing"
            }
          )
        , ( "Pellucid Crokite"
          , { name = "Pellucid Crokite"
            , refineQuantity = 100
            , volume = 16.0
            , products =
                [ { product = "Tritanium", quantity = 24150 }
                , { product = "Nocxium", quantity = 874 }
                , { product = "Zydrine", quantity = 155 }
                ]
            , skill = "Crokite Reprocessing"
            }
          )
        , ( "Spodumain"
          , { name = "Spodumain"
            , refineQuantity = 100
            , volume = 16.0
            , products =
                [ { product = "Tritanium", quantity = 56000 }
                , { product = "Pyerite", quantity = 12050 }
                , { product = "Mexallon", quantity = 2100 }
                , { product = "Isogen", quantity = 450 }
                ]
            , skill = "Spodumain Reprocessing"
            }
          )
        , ( "Bright Spodumain"
          , { name = "Bright Spodumain"
            , refineQuantity = 100
            , volume = 16.0
            , products =
                [ { product = "Tritanium", quantity = 58800 }
                , { product = "Pyerite", quantity = 12653 }
                , { product = "Mexallon", quantity = 2205 }
                , { product = "Isogen", quantity = 473 }
                ]
            , skill = "Spodumain Reprocessing"
            }
          )
        , ( "Gleaming Spodumain"
          , { name = "Gleaming Spodumain"
            , refineQuantity = 100
            , volume = 16.0
            , products =
                [ { product = "Tritanium", quantity = 61600 }
                , { product = "Pyerite", quantity = 13255 }
                , { product = "Mexallon", quantity = 2310 }
                , { product = "Isogen", quantity = 495 }
                ]
            , skill = "Spodumain Reprocessing"
            }
          )
        , ( "Dazzling Spodumain"
          , { name = "Dazzling Spodumain"
            , refineQuantity = 100
            , volume = 16.0
            , products =
                [ { product = "Tritanium", quantity = 64400 }
                , { product = "Pyerite", quantity = 13858 }
                , { product = "Mexallon", quantity = 2415 }
                , { product = "Isogen", quantity = 518 }
                ]
            , skill = "Spodumain Reprocessing"
            }
          )
        , ( "Talassonite"
          , { name = "Talassonite"
            , refineQuantity = 100
            , volume = 16.0
            , products =
                [ { product = "Tritanium", quantity = 12600 }
                , { product = "Nocxium", quantity = 456 }
                , { product = "Zydrine", quantity = 81 }
                , { product = "Megacyte", quantity = 13 }
                ]
            , skill = "Scordite Reprocessing"
            }
          )
        , ( "Veldspar"
          , { name = "Veldspar"
            , refineQuantity = 100
            , volume = 0.1
            , products = [ { product = "Tritanium", quantity = 415 } ]
            , skill = "Veldspar Reprocessing"
            }
          )
        , ( "Concentrated Veldspar"
          , { name = "Concentrated Veldspar"
            , refineQuantity = 100
            , volume = 0.1
            , products = [ { product = "Tritanium", quantity = 436 } ]
            , skill = "Veldspar Reprocessing"
            }
          )
        , ( "Dense Veldspar"
          , { name = "Dense Veldspar"
            , refineQuantity = 100
            , volume = 0.1
            , products = [ { product = "Tritanium", quantity = 457 } ]
            , skill = "Veldspar Reprocessing"
            }
          )
        , ( "Stable Veldspar"
          , { name = "Stable Veldspar"
            , refineQuantity = 100
            , volume = 0.1
            , products = [ { product = "Tritanium", quantity = 477 } ]
            , skill = "Veldspar Reprocessing"
            }
          )
        ]


type UpwellType
    = Other
    | Athanor
    | Tatara


type SecurityStatus
    = High
    | Low
    | Null


type alias StationAttributes =
    { npc : Bool
    , upwellType : UpwellType
    , securityStatus : SecurityStatus
    , rig : Int
    }



-- MAIN


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { name : String
    , product : String
    , productPrices : Dict String Float
    , skillSelection : String
    , skills : Dict String Int
    , stationAttributes : StationAttributes
    , implant : Int
    }


reprocessingPercentage : Model -> String -> Float
reprocessingPercentage model ore =
    let
        reprocessing =
            toFloat << Maybe.withDefault 0 <| Dict.get "Reprocessing" model.skills

        reprocessing_efficiency =
            toFloat << Maybe.withDefault 0 <| Dict.get "Reprocessing Efficiency" model.skills

        ore_skill_level =
            toFloat
                << Maybe.withDefault 0
                << Maybe.andThen ((\f b a -> f a b) Dict.get model.skills << (\x -> x.skill))
            <|
                Dict.get ore ores

        implant =
            0.01 * toFloat model.implant

        structure_mod =
            case model.stationAttributes.upwellType of
                Other ->
                    0.0

                Athanor ->
                    0.02

                Tatara ->
                    0.04

        security_mod =
            case model.stationAttributes.securityStatus of
                High ->
                    0.0

                Low ->
                    0.06

                Null ->
                    0.12
    in
    (1 + (0.03 * reprocessing))
        * (1 + (0.02 * reprocessing_efficiency))
        * (1 + (0.02 * ore_skill_level))
        * (1 + implant)
        * (if model.stationAttributes.npc then
            50

           else
            (50 + toFloat model.stationAttributes.rig) * (1 + structure_mod) * (1 + security_mod)
          )
        / 100


yield_price : Model -> String -> Float -> Result String Float
yield_price model ore_name quantity =
    let
        refinedQuantities =
            refinedProducts model ore_name quantity
    in
    Result.andThen
        (\products ->
            List.foldr
                (\x acc ->
                    case acc of
                        Err e ->
                            Err e

                        Ok o ->
                            case Dict.get x.product model.productPrices of
                                Just price ->
                                    Ok <| o + (toFloat x.quantity * price)

                                Nothing ->
                                    Err ("Unable to look up product key \"" ++ x.product ++ "\".")
                )
                (Ok 0.0)
                products
        )
        refinedQuantities


yieldPriceUnit : Model -> String -> Float -> Result String Float
yieldPriceUnit model ore_name total_ore_quantity =
    Result.map (\x -> x / total_ore_quantity) <| yield_price model ore_name total_ore_quantity


yieldPriceM3 : Model -> String -> Float -> Result String Float
yieldPriceM3 model ore_name total_ore_quantity =
    let
        ore_volume =
            case Dict.get ore_name ores of
                Just x ->
                    Ok x.volume

                Nothing ->
                    Err ("Unable to look up ore key \"" ++ ore_name ++ "\".")
    in
    Result.map2 (\volume price -> price / volume) ore_volume <| yieldPriceUnit model ore_name total_ore_quantity


refinedProducts : Model -> String -> Float -> Result String (List ProductQuantity)
refinedProducts model ore_name total_ore_quantity =
    let
        ore =
            case Dict.get ore_name ores of
                Just x ->
                    Ok x

                Nothing ->
                    Err ("Unable to look up key \"" ++ ore_name ++ "\".")

        refines : Float -> Ore -> Int
        refines quantity ore_attributes =
            floor (quantity / toFloat ore_attributes.refineQuantity)
    in
    Result.map2
        (\products n_refines ->
            List.map
                (\x -> { x | quantity = floor (toFloat x.quantity * reprocessingPercentage model ore_name) })
            <|
                List.map (\x -> { x | quantity = x.quantity * n_refines }) products
        )
        (Result.map .products ore)
        (Result.map (refines total_ore_quantity) ore)


init : Model
init =
    Model ""
        "Tritanium"
        (Dict.fromList
            [ ( "Tritanium", 5.5 )
            , ( "Pyerite", 4.8 )
            , ( "Mexallon", 45.0 )
            , ( "Isogen", 13.5 )
            , ( "Nocxium", 220.0 )
            , ( "Zydrine", 475.0 )
            , ( "Megacyte", 325.0 )
            , ( "Morphite", 3000.0 )
            ]
        )
        "Reprocessing"
        (Dict.fromList
            [ ( "Reprocessing", 0 )
            , ( "Reprocessing Efficiency", 0 )
            , ( "Arkonor Reprocessing", 0 )
            , ( "Bistot Reprocessing", 0 )
            , ( "Crokite Reprocessing", 0 )
            , ( "Dark Ochre Reprocessing", 0 )
            , ( "Gneiss Reprocessing", 0 )
            , ( "Hedbergite Reprocessing", 0 )
            , ( "Hemorphite Reprocessing", 0 )
            , ( "Jaspet Reprocessing", 0 )
            , ( "Kernite Reprocessing", 0 )
            , ( "Mercoxit Reprocessing", 0 )
            , ( "Omber Reprocessing", 0 )
            , ( "Plagioclase Reprocessing", 0 )
            , ( "Pyroxeres Reprocessing", 0 )
            , ( "Scordite Reprocessing", 0 )
            , ( "Spodumain Reprocessing", 0 )
            , ( "Veldspar Reprocessing", 0 )
            ]
        )
        (StationAttributes True Other High 0)
        0



-- UPDATE


type Msg
    = ProductSelection String
    | SkillSelection String
    | UpdatePrice Float
    | UpdateSkill Int
    | SetNPC
    | SetUpwell UpwellType
    | SetSecurityStatus SecurityStatus
    | SetRig Int
    | SetImplant Int
    | Failure


update : Msg -> Model -> Model
update msg model =
    case msg of
        ProductSelection product ->
            { model | product = product }

        UpdatePrice new_price ->
            { model | productPrices = Dict.insert model.product new_price model.productPrices }

        SkillSelection skill ->
            { model | skillSelection = skill }

        UpdateSkill level ->
            { model | skills = Dict.insert model.skillSelection level model.skills }

        SetNPC ->
            let
                currentAttributes =
                    model.stationAttributes
            in
            { model | stationAttributes = { currentAttributes | npc = True } }

        SetUpwell upwell ->
            let
                currentAttributes =
                    model.stationAttributes
            in
            { model | stationAttributes = { currentAttributes | npc = False, upwellType = upwell } }

        SetSecurityStatus security ->
            let
                currentAttributes =
                    model.stationAttributes
            in
            { model | stationAttributes = { currentAttributes | securityStatus = security } }

        SetRig rig ->
            let
                currentAttributes =
                    model.stationAttributes
            in
            { model | stationAttributes = { currentAttributes | rig = rig } }

        SetImplant implant ->
            { model | implant = implant }

        Failure ->
            model



-- VIEW


view : Model -> Html Msg
view model =
    div
        [ style "float" "left"
        , style "width" "100%"
        ]
        [ div
            [ id "configuration"
            , style "float" "left"
            ]
            [ div []
                [ h1 [] [ text "Refine Product Prices" ]
                , select []
                    (List.map viewProductSelection (Dict.keys model.productPrices))
                , case Dict.get model.product model.productPrices of
                    Just price ->
                        viewNumberInput "number"
                            "Price"
                            (String.fromFloat price)
                            (Maybe.withDefault Failure << Maybe.map UpdatePrice << String.toFloat)

                    Nothing ->
                        p [] [ text "Failed to get selected refine product price." ]
                , div []
                    [ p [] [ text model.product ]
                    , p []
                        [ text
                            (Maybe.withDefault "Error loading refine product price."
                                << Maybe.map String.fromFloat
                             <|
                                Dict.get model.product model.productPrices
                            )
                        ]
                    ]
                ]
            , div []
                [ h1 [] [ text "Reprocessing Skills" ]
                , select []
                    (List.map
                        (\x -> viewOption x (SkillSelection x))
                        (Dict.keys model.skills)
                    )
                , case Dict.get model.skillSelection model.skills of
                    Just level ->
                        input
                            [ type_ "number"
                            , placeholder "Level"
                            , Html.Attributes.min "0"
                            , Html.Attributes.max "5"
                            , value (String.fromInt level)
                            , onInput (Maybe.withDefault Failure << Maybe.map UpdateSkill << String.toInt)
                            ]
                            []

                    Nothing ->
                        p [] [ text "Failed to get selected skill level." ]
                , div []
                    [ p [] [ text model.skillSelection ]
                    , p []
                        [ text
                            (Maybe.withDefault "Error loading skill level."
                                << Maybe.map String.fromInt
                             <|
                                Dict.get model.skillSelection model.skills
                            )
                        ]
                    ]
                ]
            , div []
                [ h1 [] [ text "Station Attributes" ]
                , h2 [] [ text "Station Type" ]
                , div []
                    [ input
                        [ type_ "radio"
                        , id "npc"
                        , name "station_type"
                        , value "npc"
                        , onInput (\_ -> SetNPC)
                        , selected model.stationAttributes.npc
                        ]
                        []
                    , label [ for "npc" ] [ text "NPC" ]
                    ]
                , div []
                    [ input
                        [ type_ "radio"
                        , id "other"
                        , name "station_type"
                        , value "other"
                        , onInput (\_ -> SetUpwell Other)
                        ]
                        []
                    , label [ for "other" ] [ text "Other" ]
                    ]
                , div []
                    [ input
                        [ type_ "radio"
                        , id "athanor"
                        , name "station_type"
                        , value "athanor"
                        , onInput (\_ -> SetUpwell Athanor)
                        ]
                        []
                    , label [ for "athanor" ] [ text "Athanor" ]
                    ]
                , div []
                    [ input
                        [ type_ "radio"
                        , id "tatara"
                        , name "station_type"
                        , value "tatara"
                        , onInput (\_ -> SetUpwell Tatara)
                        ]
                        []
                    , label [ for "tatara" ] [ text "Tatara" ]
                    ]
                , h2 [] [ text "Security Status" ]
                , div []
                    [ input
                        [ type_ "radio"
                        , id "high"
                        , name "security_status"
                        , value "high"
                        , onInput (\_ -> SetSecurityStatus High)
                        ]
                        []
                    , label [ for "high" ] [ text "High" ]
                    ]
                , div []
                    [ input
                        [ type_ "radio"
                        , id "low"
                        , name "security_status"
                        , value "low"
                        , onInput (\_ -> SetSecurityStatus Low)
                        ]
                        []
                    , label [ for "low" ] [ text "Low" ]
                    ]
                , div []
                    [ input
                        [ type_ "radio"
                        , id "null"
                        , name "security_status"
                        , value "null"
                        , onInput (\_ -> SetSecurityStatus Null)
                        ]
                        []
                    , label [ for "null" ] [ text "Null" ]
                    ]
                , h2 [] [ text "Rig" ]
                , div []
                    [ input
                        [ type_ "radio"
                        , id "none"
                        , name "rig"
                        , value "none"
                        , onInput (\_ -> SetRig 0)
                        ]
                        []
                    , label [ for "none" ] [ text "No Rig" ]
                    ]
                , div []
                    [ input
                        [ type_ "radio"
                        , id "t1"
                        , name "rig"
                        , value "t1"
                        , onInput (\_ -> SetRig 1)
                        ]
                        []
                    , label [ for "t1" ] [ text "T1" ]
                    ]
                , div []
                    [ input
                        [ type_ "radio"
                        , id "t2"
                        , name "rig"
                        , value "t2"
                        , onInput (\_ -> SetRig 2)
                        ]
                        []
                    , label [ for "t2" ] [ text "T2" ]
                    ]
                ]
            , div []
                [ h1 [] [ text "Implant" ]
                , div []
                    [ input
                        [ type_ "radio"
                        , id "no_implant"
                        , name "implant"
                        , value "no_implant"
                        , onInput (\_ -> SetImplant 0)
                        ]
                        []
                    , label [ for "no_implant" ] [ text "No implant" ]
                    ]
                , div []
                    [ input
                        [ type_ "radio"
                        , id "one_implant"
                        , name "implant"
                        , value "one_implant"
                        , onInput (\_ -> SetImplant 1)
                        ]
                        []
                    , label [ for "one_implant" ] [ text "1% Implant" ]
                    ]
                , div []
                    [ input
                        [ type_ "radio"
                        , id "two_implant"
                        , name "implant"
                        , value "two_implant"
                        , onInput (\_ -> SetImplant 2)
                        ]
                        []
                    , label [ for "two_implant" ] [ text "2% Implant" ]
                    ]
                , div []
                    [ input
                        [ type_ "radio"
                        , id "four_implant"
                        , name "implant"
                        , value "four_implant"
                        , onInput (\_ -> SetImplant 4)
                        ]
                        []
                    , label [ for "four_implant" ] [ text "4% Implant" ]
                    ]
                ]
            , div []
                [ span [] [ text "Station Type: " ]
                , case model.stationAttributes.npc of
                    True ->
                        span [] [ text "NPC" ]

                    False ->
                        case model.stationAttributes.upwellType of
                            Other ->
                                span [] [ text "Other Upwell" ]

                            Athanor ->
                                span [] [ text "Athanor" ]

                            Tatara ->
                                span [] [ text "Tatara" ]
                , br [] []
                , span [] [ text "Security Status: " ]
                , case model.stationAttributes.securityStatus of
                    High ->
                        span [] [ text "High" ]

                    Low ->
                        span [] [ text "Low" ]

                    Null ->
                        span [] [ text "Null" ]
                , br [] []
                , span [] [ text "Rig: " ]
                , case model.stationAttributes.rig of
                    0 ->
                        span [] [ text "No rig." ]

                    1 ->
                        span [] [ text "T1 Rig." ]

                    2 ->
                        span [] [ text "T2 Rig." ]

                    _ ->
                        span [] [ text "Unexpected rig value." ]
                ]
            , div []
                [ h4 [] [ text "Test Reprocessing Percentage" ]
                , p [] [ text << String.fromFloat <| reprocessingPercentage model "Veldspar" ]
                ]
            ]
        , viewOreData model
        ]


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
    input [ type_ t, placeholder p, value v, onInput toMsg ] []


viewNumberInput : String -> String -> String -> (String -> msg) -> Html msg
viewNumberInput t p v toMsg =
    input [ type_ t, placeholder p, step "0.01", value v, onInput toMsg ] []


viewOption : String -> msg -> Html msg
viewOption s m =
    option [ value s, onClick m ] [ text s ]


viewProductSelection : String -> Html Msg
viewProductSelection p =
    viewOption p (ProductSelection p)


viewOreData : Model -> Html msg
viewOreData model =
    div
        [ id "ore-data"
        , style "float" "right"
        ]
        [ table []
            [ thead []
                [ tr [] [ text "Ore Data" ]
                , tr []
                    [ td [] [ text "Name" ]
                    , td [] [ text "Price Per Unit (100)" ]
                    , td [] [ text "Price Per Unit (10000)" ]
                    , td [] [ text "Price Per m3 (100)" ]
                    , td [] [ text "Price Per m3 (10000)" ]
                    ]
                ]
            , tbody []
                (List.map
                    (\x ->
                        tr []
                            [ td [] [ text x ]
                            , td []
                                [ text
                                    << String.fromFloat
                                    << roundHundredths
                                    << Result.withDefault 0.0
                                  <|
                                    yieldPriceUnit model x 100
                                ]
                            , td []
                                [ text
                                    << String.fromFloat
                                    << roundHundredths
                                    << Result.withDefault 0.0
                                  <|
                                    yieldPriceUnit model x 10000
                                ]
                            , td []
                                [ text
                                    << String.fromFloat
                                    << roundHundredths
                                    << Result.withDefault 0.0
                                  <|
                                    yieldPriceM3 model x 100
                                ]
                            , td []
                                [ text
                                    << String.fromFloat
                                    << roundHundredths
                                    << Result.withDefault 0.0
                                  <|
                                    yieldPriceM3 model x 10000
                                ]
                            ]
                    )
                    (Dict.keys ores)
                )
            ]
        ]


roundHundredths : Float -> Float
roundHundredths n =
    (\x -> x / 100) << toFloat <| round (n * 100)
