import Html.App exposing (beginnerProgram)
import Html.Events exposing (onInput)
import Html exposing (div, input, text)

--MODEL
model =
  "Hello, World!"

--VIEW
view model =
  div [] [
    text model,
    div [] [
      input [onInput Greet] []
    ]
  ]

--UPDATE
type Message = Greet String
update msg model =
  case msg of
    Greet name ->
      "Hello, " ++ name ++ "!"

main =
  beginnerProgram {model = model, view = view, update = update}

