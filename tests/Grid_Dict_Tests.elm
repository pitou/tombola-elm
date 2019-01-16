module Grid_Dict_Tests exposing (..)

import Test exposing (..)
import Expect exposing (Expectation)
import Json.Encode as Encode exposing (..)
import Grid_Dict exposing (..)
import Grid exposing (..)
import Dict exposing (Dict)

suite : Test
suite =
  describe "Helpers Dict module"
    [ test "emptyGrid" <|
      \_ ->
        let expectedEmptyGridTuplesList = [(1,False),(2,False),(3,False),(4,False),(5,False),(6,False),(7,False),(8,False),(9,False),(10,False),(11,False),(12,False),(13,False),(14,False),(15,False),(16,False),(17,False),(18,False),(19,False),(20,False),(21,False),(22,False),(23,False),(24,False),(25,False),(26,False),(27,False),(28,False),(29,False),(30,False),(31,False),(32,False),(33,False),(34,False),(35,False),(36,False),(37,False),(38,False),(39,False),(40,False),(41,False),(42,False),(43,False),(44,False),(45,False),(46,False),(47,False),(48,False),(49,False),(50,False),(51,False),(52,False),(53,False),(54,False),(55,False),(56,False),(57,False),(58,False),(59,False),(60,False),(61,False),(62,False),(63,False),(64,False),(65,False),(66,False),(67,False),(68,False),(69,False),(70,False),(71,False),(72,False),(73,False),(74,False),(75,False),(76,False),(77,False),(78,False),(79,False),(80,False),(81,False),(82,False),(83,False),(84,False),(85,False),(86,False),(87,False),(88,False),(89,False),(90,False)]
            expectedEmptyGrid = toGrid (Dict.fromList expectedEmptyGridTuplesList)
        in Expect.equal emptyGrid expectedEmptyGrid
    , test "isTileSelected: False if not selected" <|
      \_ ->
        let grid = toGrid (Dict.fromList([(1,False),(2,False),(3,False),(4,False),(5,False)]))
        in Expect.equal (isTileSelected 3 grid) False
    , test "isTileSelected: True if selected" <|
      \_ ->
        let grid = toGrid (Dict.fromList([(1,False),(2,False),(5,True),(8,False),(10,True)]))
        in Expect.equal (isTileSelected 5 grid) True
    , test "getSelectedTiles" <|
      \_ ->
        let grid = toGrid (Dict.fromList([(1,False),(2,True),(5,False),(8,True),(10,False)]))
        in Expect.equal (getSelectedTiles grid) (SelectedTiles [2, 8])
    , test "getEncodedSelectedTiles" <|
      \_ ->
        let grid = toGrid (Dict.fromList([(1,True),(2,False),(5,False),(8,True),(10,False)]))
        in Expect.equal (Encode.encode 0 (getEncodedSelectedTiles grid)) "[1,8]"
    , test "selectTile" <|
      \_ ->
        let grid = toGrid (Dict.fromList([(1,True),(2,False),(3,False),(4,True),(5,False)]))
            expectedGrid = toGrid (Dict.fromList([(1,True),(2,False),(3,False),(4,True),(5,False),(6,True)]))
        in Expect.equal (selectTile 6 grid) expectedGrid
    , test "revertTile" <|
      \_ ->
        let grid = toGrid (Dict.fromList([(1,True),(2,False),(3,False),(4,True),(5,False)]))
            expectedGrid = toGrid (Dict.fromList([(1,True),(2,False),(3,False),(4,False),(5,False)]))
        in Expect.equal (revertTile 4 grid) expectedGrid
    ]
