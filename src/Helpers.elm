module Helpers exposing (..)

isNothing : Maybe a -> Bool
isNothing m =
  case m of
    Nothing -> True
    Just _  -> False

ifEqualsThenElse : (Maybe a, a) -> (b, b) -> b
ifEqualsThenElse (op1, op2) (out1, out2) =
  if isNothing op1
  then out2
  else
    if op1 == Just op2
    then out1
    else out2
