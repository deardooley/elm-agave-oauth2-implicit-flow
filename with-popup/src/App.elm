module App exposing (..)

import Html exposing (Html, text, div, img, button)
import Html.Attributes exposing (src)
import Html.Events exposing (onClick)
import Ports exposing (..)
import Models exposing (..)


init : String -> ( Model, Cmd Msg )
init path =
    ( { message = "", logo = path, token = Nothing, error = Nothing }, check () )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CheckToken (Just token) ->
            ( { model | token = Just token, message = "You are logged in!" }, Cmd.none )

        CheckToken Nothing ->
            ( { model | message = "Please login" }, Cmd.none )

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
            button [ onClick Login ] [ text "Login with Facebook" ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ tokenChecked CheckToken
        , onOAuthFailed NotAuthorized
        , onOAuthSuccess Authorized
        ]
