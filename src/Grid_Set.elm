module Grid_Set exposing (Grid, toGrid, emptyGrid, initGrid, isTileSelected, getSelectedTiles, getEncodedSelectedTiles, selectTile, revertTile)

import Set exposing (Set)
import Grid exposing (..)
import Json.Encode as Encode exposing (..)

-- MODELS

type Grid =
  Grid (Set Tile)


-- HELPERS

toGrid : Set Tile -> Grid
toGrid set =
  Grid (set)

emptyGrid : Grid
emptyGrid =
  Grid (Set.empty)

initGrid : SelectedTiles -> Grid
initGrid (SelectedTiles selectedTiles) =
  Grid (Set.fromList selectedTiles)

isTileSelected : Tile -> Grid -> Bool
isTileSelected tile (Grid grid) =
  Set.member tile grid

getSelectedTilesAsList : Grid -> List Tile
getSelectedTilesAsList (Grid grid) =
  Set.toList grid

getSelectedTiles : Grid -> SelectedTiles
getSelectedTiles (Grid grid) =
  SelectedTiles (getSelectedTilesAsList (Grid grid))

getEncodedSelectedTiles : Grid -> Encode.Value
getEncodedSelectedTiles (Grid grid) =
  let selectedTiles = getSelectedTilesAsList (Grid grid)
  in Encode.list Encode.int selectedTiles

selectTile : Tile -> Grid -> Grid
selectTile tile (Grid grid) =
  Grid <|
    Set.insert tile grid

revertTile : Tile -> Grid -> Grid
revertTile tile (Grid grid) =
  Grid <|
    Set.remove tile grid
