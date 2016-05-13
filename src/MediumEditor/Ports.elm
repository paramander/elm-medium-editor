port module MediumEditor.Ports exposing (..)

{-| @docs PortEditorOptions, PortToolbarOptions, defaultToolbar, defaultOptions, initMediumEditor -}

type alias PortEditorOptions
  = { id : String
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

defaultOptions : String -> PortEditorOptions
defaultOptions id =
  { id = id
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

port initMediumEditor : PortEditorOptions -> Cmd msg
