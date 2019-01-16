module Grid exposing (..)

type alias Tile =
  Int

type SelectedTiles =
  SelectedTiles (List Tile)

type UpdateMsg
  = SelectTile Tile
  | RequestTileRevert Tile
  | RevertTile Tile
  | RequestGridReset
  | ResetGrid ()
