port module Ports exposing (..)

{-| interface to Elm <--> Javascript
-}

import Json.Decode exposing (..)
import Models exposing (OAuthConfig, OAuthError, OAuthSuccess)


{-| check if there is a token in the local storage
-}
port check : () -> Cmd msg


{-| trigger oauth flow
-}
port oauth : OAuthConfig -> Cmd msg


{-| send a JSON record to Elm app. Will be decoded on Elm side
-}
port tokenChecked : (Value -> msg) -> Sub msg


{-| send the result of OAuth2 flow back to Elm app
-}
port onOAuthFailed : (OAuthError -> msg) -> Sub msg


{-| send the result of OAuth2 flow back to Elm app
-}
port onOAuthSuccess : (OAuthSuccess -> msg) -> Sub msg



{-
   TODO: combine these last 2 methods into one like `onOAuthDone` (See TODOs in App.elm)
-}
