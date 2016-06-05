import Html.App exposing (beginnerProgram)
import Html exposing (div, input, text)

--MODEL
model =
  "Hello, World!"

--VIEW
view model =
  div [] [
    text model,
    div [] [
      input [] []
    ]
  ]

--UPDATE
update msg model =
  model

main =
  beginnerProgram {model = model, view = view, update = update}

