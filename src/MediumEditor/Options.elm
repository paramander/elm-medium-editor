module MediumEditor.Options exposing (..)

type Button
  = Bold
  | Italic
  | Underline
  | Strikethrough
  | Subscript
  | Superscript
  | Anchor
  | Image
  | Quote
  | Pre
  | OrderedList
  | UnorederedList
  | Indent
  | Outdent
  | JustifyLeft
  | JustifyCenter
  | JustifyRight
  | JustifyFull
  | HeadingOne
  | HeadingTwo
  | HeadingThree
  | HeadingFour
  | HeadingFive
  | HeadingSix
  | RemoveFormat

type ToolbarAlignment
  = Left
  | Center
  | Right


type alias EditorOptions
  = { delay : Int
    , activeButtonClass : String
    , buttonLabels : Maybe String
    , disableReturn : Bool
    , disableDoubleReturn : Bool
    , disableExtraSpaces : Bool
    , disableEditing : Bool
    , spellcheck : Bool
    , targetBlank : Bool
    , toolbar : ToolbarOptions
    , placeholder : PlaceholderOptions
    }

type alias ToolbarOptions
  = { buttons : List Button
    , align : ToolbarAlignment
    , updateOnEmptySelection : Bool
    , sticky : Bool
    , allowMultiParagraphSelection : Bool
    , diffLeft : Int
    , diffTop : Int
    , firstButtonClass : String
    , lastButtonClass : String
    , standardizeSelectionStart : Bool
    , static : Bool
    }

type alias PlaceholderOptions
  = { text : String
    , hideOnClick : Bool
    }


{-| The default options of `MediumEditor` as mentioned in [their repo](https://github.com/yabwe/medium-editor/tree/5.16.1#mediumeditor-options).
-}
defaultOptions : EditorOptions
defaultOptions =
  { activeButtonClass = "medium-editor-button-active"
  , buttonLabels = Nothing
  , delay = 0
  , disableReturn = False
  , disableDoubleReturn = False
  , disableExtraSpaces = False
  , disableEditing = False
  , spellcheck = True
  , targetBlank = False
  , toolbar = defaultToolbar
  , placeholder = defaultPlaceholder
  }

{-| The default toolbar of `MediumEditor` as mentioned in [their repo](https://github.com/yabwe/medium-editor/tree/5.16.1#toolbar-options).
-}
defaultToolbar : ToolbarOptions
defaultToolbar =
  { allowMultiParagraphSelection = True
  , buttons = [ Bold, Italic, Underline, Anchor, HeadingTwo, HeadingThree, Quote ]
  , diffLeft = 0
  , diffTop = -10
  , firstButtonClass = "medium-editor-button-first"
  , lastButtonClass = "medium-editor-button-last"
  , standardizeSelectionStart = False
  , static = False
  , align = Center
  , sticky = False
  , updateOnEmptySelection = False
  }

defaultPlaceholder : PlaceholderOptions
defaultPlaceholder =
  { text = "Type your text"
  , hideOnClick = True
  }
