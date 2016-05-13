port module MediumEditor.Ports exposing (..)

{-| @docs PortEditorOptions, PortToolbarOptions, defaultToolbar, defaultOptions, initMediumEditor -}

type alias PortEditorOptions
  = { id : String
    , initialContent : String
    , toolbar : PortToolbarOptions
    , activeButtonClass : String
    , disableReturn : Bool
    , spellcheck : Bool
    , targetBlank : Bool
    }

type alias PortToolbarOptions
  = { buttons : List String
    , align : String
    , sticky : Bool
    , updateOnEmptySelection : Bool
    }

type alias PortEditorData
  = { editor : PortEditorValue }

type alias PortEditorValue
  = { value : String }

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

defaultToolbar : PortToolbarOptions
defaultToolbar =
  { buttons = [ "bold", "italic", "underline", "anchor", "h2", "h3", "quote" ]
  , align = "center"
  , sticky = False
  , updateOnEmptySelection = False
  }

withContent : String -> PortEditorOptions -> PortEditorOptions
withContent content options =
  { options | initialContent = content }

port initMediumEditor : PortEditorOptions -> Cmd msg

port updateMediumEditor : (PortEditorData -> msg) -> Sub msg
