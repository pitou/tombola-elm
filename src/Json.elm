module Json exposing (..)

import Json.Decode as Decode exposing (..)

getDecodedValue : Decoder a -> String -> Maybe a
getDecodedValue decoderType string =
  case Decode.decodeString decoderType string of
    Ok value ->
      Just value
    Err _ ->
      Nothing
