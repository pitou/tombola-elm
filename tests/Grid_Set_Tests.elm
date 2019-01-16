module Grid_Set_Tests exposing (..)

import Test exposing (..)
import Expect exposing (Expectation)
import Json.Encode as Encode exposing (..)
import Grid_Set exposing (..)
import Grid exposing (..)
import Set exposing (Set)

suite : Test
suite =
  describe "Helpers Set module"
    [ test "emptyGrid" <|
      \_ ->
        let expectedEmptyGrid = toGrid (Set.fromList([]))
        in Expect.equal emptyGrid expectedEmptyGrid
    , test "isTileSelected: False if not selected" <|
      \_ ->
        let grid = toGrid (Set.fromList([]))
        in Expect.equal (isTileSelected 3 grid) False
    , test "isTileSelected: True if selected" <|
      \_ ->
        let grid = toGrid (Set.fromList([2, 5, 10]))
        in Expect.equal (isTileSelected 5 grid) True
    , test "getSelectedTiles" <|
      \_ ->
        let grid = toGrid (Set.fromList([2, 5, 10]))
        in Expect.equal (getSelectedTiles grid) (SelectedTiles [2, 5, 10])
    , test "getEncodedSelectedTiles" <|
      \_ ->
        let grid = toGrid (Set.fromList([3, 7, 20]))
        in Expect.equal (Encode.encode 0 (getEncodedSelectedTiles grid)) "[3,7,20]"
    , test "selectTile" <|
      \_ ->
        let grid = toGrid (Set.fromList([1, 2, 3, 4, 5]))
            expectedGrid = toGrid (Set.fromList([1, 2, 3, 4, 5, 6]))
        in Expect.equal (selectTile 6 grid) expectedGrid
    , test "revertTile" <|
        \_ ->
          let grid = toGrid (Set.fromList([1, 2, 3, 4, 5]))
              expectedGrid = toGrid (Set.fromList([1, 2, 4, 5]))
          in Expect.equal (revertTile 3 grid) expectedGrid
    ]
