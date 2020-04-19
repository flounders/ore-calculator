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
    , yieldPriceM3
    , yieldPriceUnit
    , yield_price
    )

import Basics exposing (..)
import Browser exposing (Document)
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
        , ( "Dark Ochre"
          , { name = "Dark Ochre"
            , refineQuantity = 100
            , volume = 8.0
            , products =
                [ { product = "Tritanium", quantity = 10000 }
                , { product = "Isogen", quantity = 1600 }
                , { product = "Nocxium", quantity = 120 }
                ]
            , skill = "Dark Ochre Reprocessing"
            }
          )
        , ( "Onyx Ochre"
          , { name = "Onyx Ochre"
            , refineQuantity = 100
            , volume = 8.0
            , products =
                [ { product = "Tritanium", quantity = 10500 }
                , { product = "Isogen", quantity = 1680 }
                , { product = "Nocxium", quantity = 126 }
                ]
            , skill = "Dark Ochre Reprocessing"
            }
          )
        , ( "Obsidian Ochre"
          , { name = "Obsidian Ochre"
            , refineQuantity = 100
            , volume = 8.0
            , products =
                [ { product = "Tritanium", quantity = 11000 }
                , { product = "Isogen", quantity = 1760 }
                , { product = "Nocxium", quantity = 132 }
                ]
            , skill = "Dark Ochre Reprocessing"
            }
          )
        , ( "Jet Ochre"
          , { name = "Jet Ochre"
            , refineQuantity = 100
            , volume = 8.0
            , products =
                [ { product = "Tritanium", quantity = 11500 }
                , { product = "Isogen", quantity = 1840 }
                , { product = "Nocxium", quantity = 138 }
                ]
            , skill = "Dark Ochre Reprocessing"
            }
          )
        , ( "Gneiss"
          , { name = "Gneiss"
            , refineQuantity = 100
            , volume = 5.0
            , products =
                [ { product = "Pyerite", quantity = 2200 }
                , { product = "Mexallon", quantity = 2400 }
                , { product = "Isogen", quantity = 300 }
                ]
            , skill = "Gneiss Reprocessing"
            }
          )
        , ( "Iridescent Gneiss"
          , { name = "Iridescent Gneiss"
            , refineQuantity = 100
            , volume = 5.0
            , products =
                [ { product = "Pyerite", quantity = 2310 }
                , { product = "Mexallon", quantity = 2520 }
                , { product = "Isogen", quantity = 315 }
                ]
            , skill = "Gneiss Reprocessing"
            }
          )
        , ( "Prismatic Gneiss"
          , { name = "Prismatic Gneiss"
            , refineQuantity = 100
            , volume = 5.0
            , products =
                [ { product = "Pyerite", quantity = 2420 }
                , { product = "Mexallon", quantity = 2640 }
                , { product = "Isogen", quantity = 330 }
                ]
            , skill = "Gneiss Reprocessing"
            }
          )
        , ( "Brilliant Gneiss"
          , { name = "Brilliant Gneiss"
            , refineQuantity = 100
            , volume = 5.0
            , products =
                [ { product = "Pyerite", quantity = 2530 }
                , { product = "Mexallon", quantity = 2760 }
                , { product = "Isogen", quantity = 345 }
                ]
            , skill = "Gneiss Reprocessing"
            }
          )
        , ( "Hedbergite"
          , { name = "Hedbergite"
            , refineQuantity = 100
            , volume = 3.0
            , products =
                [ { product = "Pyerite", quantity = 1000 }
                , { product = "Isogen", quantity = 200 }
                , { product = "Nocxium", quantity = 100 }
                , { product = "Zydrine", quantity = 19 }
                ]
            , skill = "Hedbergite Reprocessing"
            }
          )
        , ( "Vitric Hedbergite"
          , { name = "Vitric Hedbergite"
            , refineQuantity = 100
            , volume = 3.0
            , products =
                [ { product = "Pyerite", quantity = 1050 }
                , { product = "Isogen", quantity = 210 }
                , { product = "Nocxium", quantity = 105 }
                , { product = "Zydrine", quantity = 20 }
                ]
            , skill = "Hedbergite Reprocessing"
            }
          )
        , ( "Glazed Hedbergite"
          , { name = "Glazed Hedbergite"
            , refineQuantity = 100
            , volume = 3.0
            , products =
                [ { product = "Pyerite", quantity = 1100 }
                , { product = "Isogen", quantity = 220 }
                , { product = "Nocxium", quantity = 110 }
                , { product = "Zydrine", quantity = 21 }
                ]
            , skill = "Hedbergite Reprocessing"
            }
          )
        , ( "Lustrous Hedbergite"
          , { name = "Lustrous Hedbergite"
            , refineQuantity = 100
            , volume = 3.0
            , products =
                [ { product = "Pyerite", quantity = 1150 }
                , { product = "Isogen", quantity = 230 }
                , { product = "Nocxium", quantity = 115 }
                , { product = "Zydrine", quantity = 22 }
                ]
            , skill = "Hedbergite Reprocessing"
            }
          )
        , ( "Hemorphite"
          , { name = "Hemorphite"
            , refineQuantity = 100
            , volume = 3.0
            , products =
                [ { product = "Tritanium", quantity = 2200 }
                , { product = "Isogen", quantity = 100 }
                , { product = "Nocxium", quantity = 120 }
                , { product = "Zydrine", quantity = 15 }
                ]
            , skill = "Hemorphite Reprocessing"
            }
          )
        , ( "Vivid Hemorphite"
          , { name = "Vivid Hemorphite"
            , refineQuantity = 100
            , volume = 3.0
            , products =
                [ { product = "Tritanium", quantity = 2310 }
                , { product = "Isogen", quantity = 105 }
                , { product = "Nocxium", quantity = 126 }
                , { product = "Zydrine", quantity = 16 }
                ]
            , skill = "Hemorphite Reprocessing"
            }
          )
        , ( "Radiant Hemorphite"
          , { name = "Radiant Hemorphite"
            , refineQuantity = 100
            , volume = 3.0
            , products =
                [ { product = "Tritanium", quantity = 2420 }
                , { product = "Isogen", quantity = 110 }
                , { product = "Nocxium", quantity = 132 }
                , { product = "Zydrine", quantity = 17 }
                ]
            , skill = "Hemorphite Reprocessing"
            }
          )
        , ( "Scintillating Hemorphite"
          , { name = "Scintillating Hemorphite"
            , refineQuantity = 100
            , volume = 3.0
            , products =
                [ { product = "Tritanium", quantity = 2530 }
                , { product = "Isogen", quantity = 115 }
                , { product = "Nocxium", quantity = 138 }
                , { product = "Zydrine", quantity = 17 }
                ]
            , skill = "Hemorphite Reprocessing"
            }
          )
        , ( "Jaspet"
          , { name = "Jaspet"
            , refineQuantity = 100
            , volume = 2.0
            , products =
                [ { product = "Mexallon", quantity = 350 }
                , { product = "Nocxium", quantity = 75 }
                , { product = "Zydrine", quantity = 8 }
                ]
            , skill = "Jaspet Reprocessing"
            }
          )
        , ( "Pure Jaspet"
          , { name = "Pure Jaspet"
            , refineQuantity = 100
            , volume = 2.0
            , products =
                [ { product = "Mexallon", quantity = 368 }
                , { product = "Nocxium", quantity = 79 }
                , { product = "Zydrine", quantity = 8 }
                ]
            , skill = "Jaspet Reprocessing"
            }
          )
        , ( "Pristine Jaspet"
          , { name = "Pristine Jaspet"
            , refineQuantity = 100
            , volume = 2.0
            , products =
                [ { product = "Mexallon", quantity = 385 }
                , { product = "Nocxium", quantity = 83 }
                , { product = "Zydrine", quantity = 9 }
                ]
            , skill = "Jaspet Reprocessing"
            }
          )
        , ( "Immaculate Jaspet"
          , { name = "Immaculate Jaspet"
            , refineQuantity = 100
            , volume = 2.0
            , products =
                [ { product = "Mexallon", quantity = 403 }
                , { product = "Nocxium", quantity = 86 }
                , { product = "Zydrine", quantity = 9 }
                ]
            , skill = "Jaspet Reprocessing"
            }
          )
        , ( "Kernite"
          , { name = "Kernite"
            , refineQuantity = 100
            , volume = 1.2
            , products =
                [ { product = "Tritanium", quantity = 134 }
                , { product = "Mexallon", quantity = 267 }
                , { product = "Isogen", quantity = 134 }
                ]
            , skill = "Kernite Reprocessing"
            }
          )
        , ( "Luminous Kernite"
          , { name = "Luminous Kernite"
            , refineQuantity = 100
            , volume = 1.2
            , products =
                [ { product = "Tritanium", quantity = 141 }
                , { product = "Mexallon", quantity = 281 }
                , { product = "Isogen", quantity = 141 }
                ]
            , skill = "Kernite Reprocessing"
            }
          )
        , ( "Fiery Kernite"
          , { name = "Fiery Kernite"
            , refineQuantity = 100
            , volume = 1.2
            , products =
                [ { product = "Tritanium", quantity = 148 }
                , { product = "Mexallon", quantity = 294 }
                , { product = "Isogen", quantity = 148 }
                ]
            , skill = "Kernite Reprocessing"
            }
          )
        , ( "Resplendant Kernite"
          , { name = "Resplendant Kernite"
            , refineQuantity = 100
            , volume = 1.2
            , products =
                [ { product = "Tritanium", quantity = 154 }
                , { product = "Mexallon", quantity = 307 }
                , { product = "Isogen", quantity = 154 }
                ]
            , skill = "Kernite Reprocessing"
            }
          )
        , ( "Mercoxit"
          , { name = "Mercoxit"
            , refineQuantity = 100
            , volume = 40.0
            , products =
                [ { product = "Morphite", quantity = 300 } ]
            , skill = "Mercoxit Reprocessing"
            }
          )
        , ( "Magma Mercoxit"
          , { name = "Magma Mercoxit"
            , refineQuantity = 100
            , volume = 40.0
            , products =
                [ { product = "Morphite", quantity = 315 } ]
            , skill = "Mercoxit Reprocessing"
            }
          )
        , ( "Vitreous Mercoxit"
          , { name = "Vitreous Mercoxit"
            , refineQuantity = 100
            , volume = 40.0
            , products =
                [ { product = "Morphite", quantity = 330 } ]
            , skill = "Mercoxit Reprocessing"
            }
          )
        , ( "Omber"
          , { name = "Omber"
            , refineQuantity = 100
            , volume = 0.6
            , products =
                [ { product = "Tritanium", quantity = 800 }
                , { product = "Pyerite", quantity = 100 }
                , { product = "Isogen", quantity = 85 }
                ]
            , skill = "Omber Reprocessing"
            }
          )
        , ( "Silvery Omber"
          , { name = "Silvery Omber"
            , refineQuantity = 100
            , volume = 0.6
            , products =
                [ { product = "Tritanium", quantity = 840 }
                , { product = "Pyerite", quantity = 105 }
                , { product = "Isogen", quantity = 90 }
                ]
            , skill = "Omber Reprocessing"
            }
          )
        , ( "Golden Omber"
          , { name = "Golden Omber"
            , refineQuantity = 100
            , volume = 0.6
            , products =
                [ { product = "Tritanium", quantity = 880 }
                , { product = "Pyerite", quantity = 110 }
                , { product = "Isogen", quantity = 94 }
                ]
            , skill = "Omber Reprocessing"
            }
          )
        , ( "Platinoid Omber"
          , { name = "Platinoid Omber"
            , refineQuantity = 100
            , volume = 0.6
            , products =
                [ { product = "Tritanium", quantity = 920 }
                , { product = "Pyerite", quantity = 115 }
                , { product = "Isogen", quantity = 98 }
                ]
            , skill = "Omber Reprocessing"
            }
          )
        , ( "Plagioclase"
          , { name = "Plagioclase"
            , refineQuantity = 100
            , volume = 0.35
            , products =
                [ { product = "Tritanium", quantity = 107 }
                , { product = "Pyerite", quantity = 213 }
                , { product = "Mexallon", quantity = 107 }
                ]
            , skill = "Plagioclase Reprocessing"
            }
          )
        , ( "Azure Plagioclase"
          , { name = "Azure Plagioclase"
            , refineQuantity = 100
            , volume = 0.35
            , products =
                [ { product = "Tritanium", quantity = 113 }
                , { product = "Pyerite", quantity = 224 }
                , { product = "Mexallon", quantity = 113 }
                ]
            , skill = "Plagioclase Reprocessing"
            }
          )
        , ( "Rich Plagioclase"
          , { name = "Rich Plagioclase"
            , refineQuantity = 100
            , volume = 0.35
            , products =
                [ { product = "Tritanium", quantity = 118 }
                , { product = "Pyerite", quantity = 235 }
                , { product = "Mexallon", quantity = 118 }
                ]
            , skill = "Plagioclase Reprocessing"
            }
          )
        , ( "Sparkling Plagioclase"
          , { name = "Sparkling Plagioclase"
            , refineQuantity = 100
            , volume = 0.35
            , products =
                [ { product = "Tritanium", quantity = 123 }
                , { product = "Pyerite", quantity = 245 }
                , { product = "Mexallon", quantity = 123 }
                ]
            , skill = "Plagioclase Reprocessing"
            }
          )
        , ( "Pyroxeres"
          , { name = "Pyroxeres"
            , refineQuantity = 100
            , volume = 0.3
            , products =
                [ { product = "Tritanium", quantity = 351 }
                , { product = "Pyerite", quantity = 25 }
                , { product = "Mexallon", quantity = 50 }
                , { product = "Nocxium", quantity = 5 }
                ]
            , skill = "Pyroxeres Reprocessing"
            }
          )
        , ( "Solid Pyroxeres"
          , { name = "Solid Pyroxeres"
            , refineQuantity = 100
            , volume = 0.3
            , products =
                [ { product = "Tritanium", quantity = 369 }
                , { product = "Pyerite", quantity = 26 }
                , { product = "Mexallon", quantity = 53 }
                , { product = "Nocxium", quantity = 5 }
                ]
            , skill = "Pyroxeres Reprocessing"
            }
          )
        , ( "Viscous Pyroxeres"
          , { name = "Viscous Pyroxeres"
            , refineQuantity = 100
            , volume = 0.3
            , products =
                [ { product = "Tritanium", quantity = 387 }
                , { product = "Pyerite", quantity = 27 }
                , { product = "Mexallon", quantity = 55 }
                , { product = "Nocxium", quantity = 5 }
                ]
            , skill = "Pyroxeres Reprocessing"
            }
          )
        , ( "Opulent Pyroxeres"
          , { name = "Opulent Pyroxeres"
            , refineQuantity = 100
            , volume = 0.3
            , products =
                [ { product = "Tritanium", quantity = 404 }
                , { product = "Pyerite", quantity = 29 }
                , { product = "Mexallon", quantity = 58 }
                , { product = "Nocxium", quantity = 6 }
                ]
            , skill = "Pyroxeres Reprocessing"
            }
          )
        , ( "Rakovene"
          , { name = "Rakovene"
            , refineQuantity = 100
            , volume = 16.0
            , products =
                [ { product = "Tritanium", quantity = 2200 }
                , { product = "Pyerite", quantity = 7200 }
                , { product = "Mexallon", quantity = 855 }
                , { product = "Nocxium", quantity = 450 }
                , { product = "Zydrine", quantity = 270 }
                , { product = "Megacyte", quantity = 83 }
                , { product = "Morphite", quantity = 2 }
                ]
            , skill = "Scordite Reprocessing"
            }
          )
        , ( "Scordite"
          , { name = "Scordite"
            , refineQuantity = 100
            , volume = 0.15
            , products =
                [ { product = "Tritanium", quantity = 346 }
                , { product = "Pyerite", quantity = 173 }
                ]
            , skill = "Scordite Reprocessing"
            }
          )
        , ( "Condensed Scordite"
          , { name = "Condensed Scordite"
            , refineQuantity = 100
            , volume = 0.15
            , products =
                [ { product = "Tritanium", quantity = 364 }
                , { product = "Pyerite", quantity = 182 }
                ]
            , skill = "Scordite Reprocessing"
            }
          )
        , ( "Massive Scordite"
          , { name = "Massive Scordite"
            , refineQuantity = 100
            , volume = 0.15
            , products =
                [ { product = "Tritanium", quantity = 381 }
                , { product = "Pyerite", quantity = 190 }
                ]
            , skill = "Scordite Reprocessing"
            }
          )
        , ( "Glossy Scordite"
          , { name = "Glossy Scordite"
            , refineQuantity = 100
            , volume = 0.15
            , products =
                [ { product = "Tritanium", quantity = 398 }
                , { product = "Pyerite", quantity = 199 }
                ]
            , skill = "Scordite Reprocessing"
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
    Browser.document
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



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


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model ""
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
    , Cmd.none
    )



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


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        ProductSelection product ->
            ( { model | product = product }, Cmd.none )

        UpdatePrice new_price ->
            ( { model | productPrices = Dict.insert model.product new_price model.productPrices }, Cmd.none )

        SkillSelection skill ->
            ( { model | skillSelection = skill }, Cmd.none )

        UpdateSkill level ->
            ( { model | skills = Dict.insert model.skillSelection level model.skills }, Cmd.none )

        SetNPC ->
            let
                currentAttributes =
                    model.stationAttributes
            in
            ( { model | stationAttributes = { currentAttributes | npc = True } }, Cmd.none )

        SetUpwell upwell ->
            let
                currentAttributes =
                    model.stationAttributes
            in
            ( { model | stationAttributes = { currentAttributes | npc = False, upwellType = upwell } }, Cmd.none )

        SetSecurityStatus security ->
            let
                currentAttributes =
                    model.stationAttributes
            in
            ( { model | stationAttributes = { currentAttributes | securityStatus = security } }, Cmd.none )

        SetRig rig ->
            let
                currentAttributes =
                    model.stationAttributes
            in
            ( { model | stationAttributes = { currentAttributes | rig = rig } }, Cmd.none )

        SetImplant implant ->
            ( { model | implant = implant }, Cmd.none )

        Failure ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Document Msg
view model =
    { title = "Eve Ore Assistant"
    , body =
        [ div
            [ style "float" "left"
            , style "width" "100%"
            ]
            [ viewConfiguration model
            , viewOreData model
            ]
        ]
    }


viewNumberInput : String -> String -> String -> (String -> msg) -> Html msg
viewNumberInput t p v toMsg =
    input [ type_ t, placeholder p, step "0.01", value v, onInput toMsg ] []


viewPricesConfiguration : Model -> Html Msg
viewPricesConfiguration model =
    div []
        [ h1 [] [ text "Refine Product Prices" ]
        , select []
            (List.map
                (\x ->
                    option
                        [ value x
                        , onClick (ProductSelection x)
                        , selected (model.product == x)
                        ]
                        [ text x ]
                )
                (Dict.keys model.productPrices)
            )
        , case Dict.get model.product model.productPrices of
            Just price ->
                viewNumberInput "number"
                    "Price"
                    (String.fromFloat price)
                    (Maybe.withDefault Failure << Maybe.map UpdatePrice << String.toFloat)

            Nothing ->
                p [] [ text "Failed to get selected refine product price." ]
        ]


viewSkillsConfiguration : Model -> Html Msg
viewSkillsConfiguration model =
    div []
        [ h1 [] [ text "Reprocessing Skills" ]
        , select []
            (List.map
                (\x ->
                    option
                        [ value x
                        , onClick (SkillSelection x)
                        , selected (model.skillSelection == x)
                        ]
                        [ text x ]
                )
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
        ]


viewStationConfiguration : Model -> Html Msg
viewStationConfiguration model =
    div []
        [ h1 [] [ text "Station Attributes" ]
        , h2 [] [ text "Station Type" ]
        , div []
            [ input
                [ type_ "radio"
                , id "npc"
                , name "station_type"
                , value "npc"
                , onInput (\_ -> SetNPC)
                , checked model.stationAttributes.npc
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


viewImplantConfiguration : Model -> Html Msg
viewImplantConfiguration model =
    div []
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


viewConfiguration : Model -> Html Msg
viewConfiguration model =
    div
        [ id "configuration"
        , style "float" "left"
        ]
        [ viewPricesConfiguration model
        , viewSkillsConfiguration model
        , viewStationConfiguration model
        , viewImplantConfiguration model
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
