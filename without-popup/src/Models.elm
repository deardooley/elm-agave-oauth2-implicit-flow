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
    = CheckToken (Result String (Maybe Token))
    | UrlChange Location


type alias OAuthConfig =
    { client : String
    , url : String
    , redirect : String
    , scope : String
    }


config : OAuthConfig
config =
    { client = "PEAB2SsoKtYG25tjzg0_fCSxLssa"
    , url = "https://public.agaveapi.co/authorize"
    , redirect = "http://localhost:8000/"
    , scope = "PRODUCTION"
    }
