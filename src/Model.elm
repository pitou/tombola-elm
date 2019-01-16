module Model exposing (..)

import Grid exposing (..)
import Grid_Dict exposing (..)
--import Grid_Set exposing (..)

type alias Model =
  { grid : Grid
  , latestTile : Maybe Tile
  }
