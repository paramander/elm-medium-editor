import MediumEditor

import MediumEditor.Ports as Ports

import Html.App as Html
import Html exposing (div, Html)
import Html.Attributes exposing (class)

main =
  Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> subscriptions
        }

type alias Model
  = { editor : MediumEditor.Editor }

type Msg
  = MediumMsg MediumEditor.Msg
  | NoOp

init : (Model, Cmd Msg)
init =
  let
    (editor, childMsgs) = MediumEditor.init "editor" "editor"
  in
    ( { editor = editor }
    , Cmd.map MediumMsg childMsgs
    )

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    MediumMsg act ->
      let
        (childModel, childCmds) = MediumEditor.update act model.editor
      in
        ( { model | editor = childModel }
        , Cmd.map MediumMsg childCmds
        )
    NoOp ->
      ( model
      , Cmd.none
      )

view : Model -> Html Msg
view model =
  div
    [ class "container" ]
    [ Html.map MediumMsg (MediumEditor.view model.editor) ]

subscriptions : Sub Msg
subscriptions =
  Sub.batch [ Ports.updateMediumEditor <| MediumMsg << MediumEditor.UpdateContent << .value << .editor ]
