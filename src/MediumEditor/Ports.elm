port module MediumEditor.Ports exposing (..)

{-| The `Ports` module defines the communication between Javascript and Elm.
it is used to initialize the `medium-editor` javascript library, and to update
Elm component state with each DOM change.

# Port Data
@docs PortEditorOptions, PortToolbarOptions, PortEditorData, PortEditorValue

## Defaults
@docs defaultToolbar, defaultOptions, withContent

# Ports
@docs initMediumEditor, updateMediumEditor
-}

{-| `PortEditorOptions` contains all the necessary data to initialize
a `MediumEditor` in Javascript.
-}
type alias PortEditorOptions
  = { id : String
    , initialContent : String
    , toolbar : PortToolbarOptions
    , activeButtonClass : String
    , disableReturn : Bool
    , spellcheck : Bool
    , targetBlank : Bool
    }

{-| `PortToolbarOptions` define the toolbar for medium-editor at the Javascript side.
-}
type alias PortToolbarOptions
  = { buttons : List String
    , align : String
    , sticky : Bool
    , updateOnEmptySelection : Bool
    }

{-| `PortEditorData` is a proxy type alias that we get from serializing the MediumEditor.
This type alias is passed through the `updateMediumEditor` port.
-}
type alias PortEditorData
  = { editor : PortEditorValue }

{-| The `PortEditorValue` type alias contains the editor state at the DOM level.
-}
type alias PortEditorValue
  = { value : String }

{-| The default options of `MediumEditor` as mentioned in [their repo](https://github.com/yabwe/medium-editor/tree/5.16.1#mediumeditor-options).
-}
defaultOptions : String -> PortEditorOptions
defaultOptions id =
  { id = id
  , initialContent = ""
  , toolbar = defaultToolbar
  , activeButtonClass = "medium-editor-button-active"
  , disableReturn = False
  , spellcheck = False
  , targetBlank = True
  }

{-| The default toolbar of `MediumEditor` as mentioned in [their repo](https://github.com/yabwe/medium-editor/tree/5.16.1#toolbar-options).
-}
defaultToolbar : PortToolbarOptions
defaultToolbar =
  { buttons = [ "bold", "italic", "underline", "anchor", "h2", "h3", "quote" ]
  , align = "center"
  , sticky = False
  , updateOnEmptySelection = False
  }

{-| Helper method to pass initial content to `PortEditorOptions`
-}
withContent : String -> PortEditorOptions -> PortEditorOptions
withContent content options =
  { options | initialContent = content }

port initMediumEditor : PortEditorOptions -> Cmd msg

port updateMediumEditor : (PortEditorData -> msg) -> Sub msg
