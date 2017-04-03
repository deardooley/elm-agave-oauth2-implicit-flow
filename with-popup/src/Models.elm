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
    { client = "1676489349323550"
    , url = "https://www.facebook.com/dialog/oauth"
    , redirect = "http://localhost:8000"
    , scope = ""
    }



{-
   TODO: remove these aliases
-}


type alias OAuthError =
    { error : String }


type alias OAuthSuccess =
    { access_token : String
    }
