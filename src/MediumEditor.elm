module MediumEditor exposing (..)

{-| A wrapper package for the javascript library medium-editor.

# Definition
@docs Editor, init

# State
@docs Msg, update

# Views
@docs view
-}

import MediumEditor.Ports exposing (PortEditorOptions, defaultOptions, initMediumEditor, withContent)

import Html exposing (..)
import Html.Attributes exposing (..)

{-| Define the editor with its own id, or class. You have the freedom to either
use the id, or the class when creating the editor via ports. The contents are stored
as a `String`.

    init "my-editor-id-1" "editable-class"

-}
type alias Editor
  = { id : String
    , class : String
    , content : String
    }

{-| The possible mutations this `Editor` can handle are defined in `Msg`. When using
elm-medium-editor, you are meant to wrap this `Msg` into your own `Msg` constructor.
After wrapping the `MediumEditor.Msg` type, you can use `Html.map` to communicate
state changes to your `Editor`.

    type Msg
      = NoOp
      | EditorMsg MediumEditor.Msg

-}
type Msg
  = NoOp
  | UpdateContent String

{-| To initialize a new editor, use the init function. It takes an id, class and
the initial HTML content as a String. It is strongly advised you use this init
method and not the Record constructor.

Setting up an editor is an effect. It will call the initialization port for you.
In this initialization port, the editor is setup given a set of options defined
in the `Ports` module.
-}
init : String -> String -> String -> (Editor, Cmd Msg)
init id class content =
  let
    editor =
      { id = id
      , class = class
      , content = content
      }
    options =
      withContent content <| defaultOptions id
  in
    ( editor
    , initMediumEditor options
    )

{-| Following The Elm Architecture, in the `update` function, state changes are handled
such as updated the editor content as the javascript library medium-editor changes
the DOM. These changes are communicated back to Elm via ports.
-}
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

{-| The view of an editor is only displaying it's class and id. The javascript
library itself will handle initializing the toolbars and data attributes. Note that
the initial content is not rendered. If the initial content were to be rendered,
the `contenteditable` selection state would be lost with every content state update.
Therefor, we leave the content rendering to the DOM itself.
-}
view : Editor -> Html Msg
view editor =
  div
    [ class editor.class
    , id editor.id
    ]
    []
