module Grid_Dict exposing (Grid, toGrid, emptyGrid, initGrid, isTileSelected, getSelectedTiles, getEncodedSelectedTiles, selectTile, revertTile)

import Dict exposing (Dict)
import Grid exposing (..)
import Json.Encode as Encode exposing (..)


-- MODELS

type Grid =
  Grid (Dict Tile Bool)


-- HELPERS

toGrid : Dict Tile Bool -> Grid
toGrid dict =
  Grid (dict)

emptyGrid : Grid
emptyGrid =
  Grid <|
    (List.range 1 90
      |> List.map (\tile -> (tile, False))
      |> Dict.fromList
    )

initGrid : SelectedTiles -> Grid
initGrid (SelectedTiles selectedTiles) =
  Grid <|
    (selectedTiles
      |> List.map (\tile -> (tile, True))
      |> Dict.fromList
    )

isTileSelected : Tile -> Grid -> Bool
isTileSelected tile (Grid grid) =
  if Dict.get tile grid == Just True
  then True
  else False

getSelectedTilesAsList : Grid -> List Tile
getSelectedTilesAsList (Grid grid) =
  (grid
    |> Dict.filter (\k v -> v)
    |> Dict.keys
  )

getSelectedTiles : Grid -> SelectedTiles
getSelectedTiles (Grid grid) =
  SelectedTiles <|
    getSelectedTilesAsList (Grid grid)

getEncodedSelectedTiles : Grid -> Encode.Value
getEncodedSelectedTiles (Grid grid) =
  let selectedTiles = getSelectedTilesAsList (Grid grid)
  in Encode.list Encode.int selectedTiles

selectTile : Tile -> Grid -> Grid
selectTile tile grid =
  changeTileValue tile True grid

revertTile : Tile -> Grid -> Grid
revertTile tile grid =
  changeTileValue tile False grid

changeTileValue : Tile -> Bool -> Grid -> Grid
changeTileValue tile value (Grid grid) =
  let changedTileDict = Dict.singleton tile value
  in Grid (Dict.union changedTileDict grid)
