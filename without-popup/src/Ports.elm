port module Ports exposing (..)

{-| interface to Elm <--> Javascript
-}

import Json.Decode exposing (..)


{-| check if there is a token in the local storage
-}
port check : () -> Cmd msg


{-| send a JSON record to Elm app. Will be decoded on Elm side
-}
port tokenChecked : (Value -> msg) -> Sub msg


{-| save token in the local storage after successful login
-}
port saveToken : String -> Cmd msg
