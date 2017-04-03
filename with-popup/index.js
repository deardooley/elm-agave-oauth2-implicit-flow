import './main.css'
import { getToken, setToken } from './js/token'
import authorize from './js/oauth'

const logoPath = 'logo.svg'

const Elm = require('./src/Main.elm')

const app = Elm.Main.embed(document.getElementById('root'), logoPath)

// check if there is a token in local storage
app.ports.check.subscribe(() => {
  const token = getToken()
  console.log("LOADING Token from localStorage", token)

  app.ports.tokenChecked.send({token: token})
})

// TODO: combine these 2 port methods into one
// e.g. onOAuthDone (See App.elm and Ports.elm)
app.ports.oauth.subscribe( (config) => {
    authorize(config).then(
      (token) => {
        console.log("GOT TOKEN:", token)
        setToken(token.access_token)
        app.ports.onOAuthSuccess.send(token)
      },
      (error) => {
        console.log("ERROR:", error)
        app.ports.onOAuthFailed.send({error:error})
      }
    )
})
