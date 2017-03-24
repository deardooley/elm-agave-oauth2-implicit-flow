module Models exposing (..)

import Navigation exposing (Location)


type alias Token =
    String


type alias Model =
    { message : String
    , logo : String
    , token : Maybe Token
    , error : Maybe String
    }


type Msg
    = CheckToken (Maybe Token)
    | UrlChange Location


type alias OAuthConfig =
    { client : String
    , url : String
    , redirect : String
    , scope : String
    }


config : OAuthConfig
config =
    { client = "1676489349323550"
    , url = "https://www.facebook.com/dialog/oauth"
    , redirect = "http://localhost:8000"
    , scope = ""
    }
