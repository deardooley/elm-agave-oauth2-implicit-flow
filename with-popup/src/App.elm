module App exposing (..)

import Html exposing (Html, text, div, img, button)
import Html.Attributes exposing (src)
import Html.Events exposing (onClick)
import Ports exposing (..)
import Models exposing (..)
import Json.Decode as Decode


init : String -> ( Model, Cmd Msg )
init path =
    ( { message = "", logo = path, token = Nothing, error = Nothing }, check () )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        -- type of token is Maybe Token as it is defined by decoToken function
        CheckToken (Ok maybeToken) ->
            ( { model | token = maybeToken, message = "You are logged in!" }, Cmd.none )

        CheckToken (Err err) ->
            ( { model | message = "Please login", error = Just err }, Cmd.none )

        Login ->
            ( model, oauth config )

        Authorized success ->
            ( { model | token = Just success.access_token, error = Nothing, message = "You are logged in!" }, Cmd.none )

        NotAuthorized errObj ->
            ( { model | token = Nothing, error = Just errObj.error }, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ img [ src model.logo ] []
        , div [] [ text model.message ]
        , showToken model
        ]


showToken : Model -> Html Msg
showToken model =
    case model.token of
        Just token ->
            div [] [ text ("Token:" ++ token) ]

        Nothing ->
            button [ onClick Login ] [ text "Login using the Agave Platform" ]


decodeToken : Decode.Value -> Result String (Maybe String)
decodeToken =
    Decode.decodeValue
        (Decode.maybe (Decode.field "token" Decode.string))



{-
    TODO: change this when using new Msg types (See TODOs in Models.elm)
    We should have only one port function for OAuth check e.g.
   `onOAuthDone (decodeOAuthToken >> OnAuthorized)`
-}


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ tokenChecked (decodeToken >> CheckToken)
        , onOAuthFailed NotAuthorized
        , onOAuthSuccess Authorized
        ]
