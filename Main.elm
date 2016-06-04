import Html.App exposing (beginnerProgram)
import Html exposing (text)

--MODEL
model =
  "Hello, World!"

--VIEW
view model =
  text model

--UPDATE
update msg model =
  model

main =
  beginnerProgram {model = model, view = view, update = update}

