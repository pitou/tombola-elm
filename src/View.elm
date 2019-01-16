module View exposing (view)

import Html exposing (Html, Attribute, div, button, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Grid exposing (..)
import Grid_Dict exposing (..)
--import Grid_Set exposing (..)
import Model exposing (..)
import Helpers exposing (..)

resetButton : Html UpdateMsg
resetButton =
  div
  [ class "reset"
  , onClick RequestGridReset
  ]
  [ text "Reset"
  ]

--------------------------------------------------------

margin = 108

topGap = 20
leftGap = 32

getTileMarginTop : Tile -> Int
getTileMarginTop tile =
  let g = (tile - 1) // 10
  in margin + topGap * (g // 3)

getYindex : Tile -> Int
getYindex tile = (tile - 1) // 10

getTop : Tile -> Int
getTop tile =
  let index = getYindex tile
      tileMarginTop = getTileMarginTop tile
  in (index - 1) * margin + tileMarginTop

--------------------------------------------------------

getTileMarginLeft : Tile -> Int
getTileMarginLeft tile =
  if remainderBy 10 (tile - 1) >= 5
  then margin + leftGap
  else margin

getXindex : Tile -> Int
getXindex tile = remainderBy 10 (tile - 1)

getLeft : Tile -> Int
getLeft tile =
  let index = getXindex tile
      tileMarginLeft = getTileMarginLeft tile
  in (index - 1) * margin + tileMarginLeft

getPx : Int -> String
getPx value = String.fromInt(value) ++ "px"

maybeSelectedClass : Tile -> Grid -> String
maybeSelectedClass tile grid =
  if isTileSelected tile grid
  then " selected"
  else ""

maybeLatestTileClass : Tile -> Maybe Tile -> String
maybeLatestTileClass tile latestTile =
  ifEqualsThenElse (latestTile, tile) (" latest", "")

getTileClass : Tile -> Grid -> Maybe Tile -> String
getTileClass tile grid latestTile =
  "tile"
  ++ (maybeSelectedClass tile grid)
  ++ (maybeLatestTileClass tile latestTile)

toggleTile : Tile -> Grid -> UpdateMsg
toggleTile tile grid =
  if isTileSelected tile grid then
    RequestTileRevert tile
  else
    SelectTile tile

tilesComponentsList : Grid -> Maybe Tile -> List (Html UpdateMsg)
tilesComponentsList grid latestTile =
  List.map
    ( \tile ->
      button
      [ onClick (toggleTile tile grid)
      , class (getTileClass tile grid latestTile)
      , style "top" (getPx (getTop tile))
      , style "left" (getPx (getLeft tile))
      ]
      [ text (String.fromInt tile)
      ]
    )
    (List.range 1 90)

gridComponent : Grid -> Maybe Tile -> Html UpdateMsg
gridComponent grid latestTile =
  div
  [ class "grid"
  ]
  (tilesComponentsList grid latestTile)

view : Model -> Html UpdateMsg
view { grid, latestTile } =
  div
  [ class "gridContainer"
  ]
  [ gridComponent grid latestTile
  , resetButton
  ]
