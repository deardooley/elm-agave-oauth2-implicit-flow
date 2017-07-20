module Models exposing (..)


type alias Model =
    { message : String
    , logo : String
    , token : Maybe String
    , error : Maybe String
    }



{-
   TODO: use better message like e.g. OnAuthorized (Result String (Maybe String))
   and baiscally have just:

    type Msg
        = CheckToken (Result String (Maybe String))
        | OnAuthorized (Result String (Maybe String))
        | Login
-}


type Msg
    = CheckToken (Result String (Maybe String))
    | Authorized OAuthSuccess
    | NotAuthorized OAuthError
    | Login


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



{-
   TODO: remove these aliases
-}


type alias OAuthError =
    { error : String }


type alias OAuthSuccess =
    { access_token : String
    }
