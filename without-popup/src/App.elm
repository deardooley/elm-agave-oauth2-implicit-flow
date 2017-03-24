module App exposing (..)

import Html exposing (Html, text, div, img, a)
import Html.Attributes exposing (src, href)
import Ports exposing (..)
import Models exposing (..)
import Navigation exposing (Location)
import Http
import Token exposing (parseUrlParams)
import Dict


init : String -> Location -> ( Model, Cmd Msg )
init path location =
    let
        params =
            parseUrlParams location.hash

        maybeToken =
            Dict.get "access_token" params

        maybeError =
            Dict.get "error" params

        initMsg =
            case maybeToken of
                Just token ->
                    "You are logged in!"

                Nothing ->
                    "Please login"

        commands =
            initCmd maybeToken maybeError
    in
        { message = initMsg, logo = path, token = maybeToken, error = maybeError }
            ! commands


initCmd : Maybe String -> Maybe String -> List (Cmd Msg)
initCmd maybeToken maybeError =
    case maybeToken of
        Just token ->
            [ saveToken token, Navigation.modifyUrl "/" ]

        Nothing ->
            case maybeError of
                Just error ->
                    [ Cmd.none ]

                Nothing ->
                    [ check () ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CheckToken (Just token) ->
            ( { model | token = Just token, message = "You are logged in!" }, Cmd.none )

        CheckToken Nothing ->
            ( { model | message = "Please login" }, Cmd.none )

        UrlChange location ->
            ( model, Cmd.none )


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
            a [ href (loginLink config) ] [ text "Login with Facebook" ]


loginLink : OAuthConfig -> String
loginLink config =
    config.url
        ++ "?response_type=token&immediate=true&approval_prompt=auto&client_id="
        ++ config.client
        ++ "&redirect_uri="
        ++ (Http.encodeUri config.redirect)


subscriptions : Model -> Sub Msg
subscriptions model =
    tokenChecked CheckToken
