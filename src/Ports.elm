port module Ports exposing (..)

import Grid_Dict exposing (..)
--import Grid_Set exposing (..)
import Grid exposing (..)
import Json exposing (..)
import Json.Encode as Encode exposing (..)
import Json.Decode as Decode exposing (..)

-- FLAGS

type alias Flags =
  { selectedTiles : String -- JSON encoded
  }

getDecodedFlagsSelectedTiles : String -> SelectedTiles
getDecodedFlagsSelectedTiles encodedSelectedTiles =
  let decoded = getDecodedValue (Decode.list Decode.int) encodedSelectedTiles
  in SelectedTiles (
    case decoded of
      Just list -> list
      Nothing -> []
  )

-- OUTGOING MESSAGES

port cache : Encode.Value -> Cmd msg

cacheSelectedTiles : Grid -> Cmd msg
cacheSelectedTiles grid =
  cache (getEncodedSelectedTiles grid)

-- INCOMING MESSAGES

port askForTileRevertConfirmation : Tile -> Cmd msg
port tileRevertConfirmation : (Tile -> msg) -> Sub msg

port askForGridResetConfirmation : () -> Cmd msg
port gridResetConfirmation : (() -> msg) -> Sub msg
