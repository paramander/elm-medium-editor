module MediumEditor exposing (..)

{-| A wrapper package for the javascript library medium-editor Editor Msg init update view

# Definition
@docs Editor, Msg, init

# State
@docs update

# Views
@docs view

 -}

import MediumEditor.Ports exposing (PortEditorOptions, defaultOptions, initMediumEditor)

import Html exposing (..)
import Html.Attributes exposing (..)

{-| test -}
type alias Editor
  = { id : String
    , class : String
    , content : String
    , options : PortEditorOptions
    }

{-| test -}
type Msg
  = NoOp
  | UpdateContent String

{-| test -}
init : String -> String -> (Editor, Cmd Msg)
init id class =
  let
    options =
      defaultOptions id
    editor =
      { id = id
      , class = class
      , content = ""
      , options = options
      }
  in
    ( editor
    , initMediumEditor options
    )

{-| test -}
update : Msg -> Editor -> (Editor, Cmd Msg)
update msg model =
  case msg of
    UpdateContent str ->
      ( { model | content = str }
      , Cmd.none
      )
    NoOp ->
      ( model
      , Cmd.none
      )

{-| test -}
view : Editor -> Html Msg
view editor =
  div
    [ class editor.class
    , id editor.id
    ]
    []
