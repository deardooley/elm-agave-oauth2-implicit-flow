port module Ports exposing (..)

{-| interface to Elm <--> Javascript
-}

import Models exposing (OAuthConfig, OAuthError, OAuthSuccess)


{-| check if there is a token in the local storage
-}
port check : () -> Cmd msg


{-| trigger oauth flow
-}
port oauth : OAuthConfig -> Cmd msg


{-| send a token to Elm app
-}
port tokenChecked : (Maybe String -> msg) -> Sub msg


{-| send the result of OAuth2 flow back to Elm app
-}
port onOAuthFailed : (OAuthError -> msg) -> Sub msg


{-| send the result of OAuth2 flow back to Elm app
-}
port onOAuthSuccess : (OAuthSuccess -> msg) -> Sub msg
