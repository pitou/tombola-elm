module Main exposing (main)

import Browser
import View exposing (view)
import Grid exposing (..)
import Grid_Dict exposing (..)
--import Grid_Set exposing (..)
import Model exposing (..)
import Ports exposing (..)
import Helpers exposing (..)


-- MAIN

main =
  Browser.element
  { init = init
  , update = update
  , subscriptions = subscriptions
  , view = view
  }

init : Flags -> (Model, Cmd msg)
init flags =
  let selectedTiles = getDecodedFlagsSelectedTiles flags.selectedTiles
  in (
    { grid = initGrid selectedTiles
    , latestTile = Nothing
    }
    , Cmd.none
  )


-- UPDATE

update : UpdateMsg -> Model -> (Model, Cmd msg)
update msg model =
  case msg of
    SelectTile tile ->
      let grid = selectTile tile model.grid
      in
      ( { model | grid = grid, latestTile = Just tile }
      , cacheSelectedTiles grid
      )

    RequestTileRevert tile ->
      ( model
      , askForTileRevertConfirmation tile
      )

    RevertTile tile ->
      let grid = revertTile tile model.grid
          latestTile = ifEqualsThenElse (model.latestTile, tile) (Nothing, model.latestTile)
      in
      ( { model | grid = grid, latestTile = latestTile }
      , cacheSelectedTiles grid
      )

    RequestGridReset ->
      ( model
      , askForGridResetConfirmation ()
      )

    ResetGrid () ->
      ( { model | grid = emptyGrid, latestTile = Nothing }
      , cacheSelectedTiles emptyGrid
      )


-- SUBSCRIPTIONS

subscriptions : Model -> Sub UpdateMsg
subscriptions model =
  Sub.batch
  [ tileRevertConfirmation RevertTile
  , gridResetConfirmation ResetGrid
  ]
