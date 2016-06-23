port module MediumEditor.Ports exposing (mapOptions, initMediumEditor, updateMediumEditor)

{-| The `Ports` module defines the communication between Javascript and Elm.
it is used to initialize the `medium-editor` javascript library, and to update
Elm component state with each DOM change.

# Port Data
@docs mapOptions

# Ports
@docs initMediumEditor, updateMediumEditor
-}

import MediumEditor.Options exposing (EditorOptions, ToolbarOptions, PlaceholderOptions, Button(..), ToolbarAlignment(..))

{- `PortEditorOptions` contains all the necessary data to initialize
a `MediumEditor` in Javascript. -}
type alias PortEditorOptions
  = { id : String
    , initialContent : String
    , toolbar : PortToolbarOptions
    , delay : Int
    , activeButtonClass : String
    , buttonLabels : String
    , disableReturn : Bool
    , disableDoubleReturn : Bool
    , disableExtraSpaces : Bool
    , disableEditing : Bool
    , spellcheck : Bool
    , targetBlank : Bool
    , toolbar : PortToolbarOptions
    , placeholder : PlaceholderOptions
    }

{- `PortToolbarOptions` define the toolbar for medium-editor at the Javascript side. -}
type alias PortToolbarOptions
  = { buttons : List String
    , align : String
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

{- `PortEditorData` is a proxy type alias that we get from serializing the MediumEditor.
This type alias is passed through the `updateMediumEditor` port.
-}
type alias PortEditorData
  = { value : String }

{-| Use `mapOptions` before sending your `Editor` through the `initMediumEditor` port. It
converts the types to JS friendly data
-}
mapOptions : String -> String -> EditorOptions -> PortEditorOptions
mapOptions id content options =
  { id = id
  , initialContent = content
  , toolbar = mapToolbar options.toolbar
  , delay = options.delay
  , activeButtonClass = options.activeButtonClass
  , buttonLabels = case options.buttonLabels of
                     Nothing -> ""
                     Just l -> l
  , disableReturn = options.disableReturn
  , disableDoubleReturn = options.disableDoubleReturn
  , disableExtraSpaces = options.disableExtraSpaces
  , disableEditing = options.disableEditing
  , spellcheck = options.spellcheck
  , targetBlank = options.targetBlank
  , placeholder = options.placeholder
  }

mapToolbar : ToolbarOptions -> PortToolbarOptions
mapToolbar toolbar =
  { buttons = List.map buttonToString toolbar.buttons
  , align = case toolbar.align of
              Left -> "left"
              Center -> "center"
              Right -> "right"
  , updateOnEmptySelection = toolbar.updateOnEmptySelection
  , sticky = toolbar.sticky
  , allowMultiParagraphSelection = toolbar.allowMultiParagraphSelection
  , diffLeft = toolbar.diffLeft
  , diffTop = toolbar.diffTop
  , firstButtonClass = toolbar.firstButtonClass
  , lastButtonClass = toolbar.lastButtonClass
  , standardizeSelectionStart = toolbar.standardizeSelectionStart
  , static = toolbar.static
  }

buttonToString : Button -> String
buttonToString button =
  case button of
    Bold -> "bold"
    Italic -> "italic"
    Underline -> "underline"
    Strikethrough -> "strikethrough"
    Subscript -> "subscript"
    Superscript -> "superscript"
    Anchor -> "anchor"
    Image -> "image"
    Quote -> "quote"
    Pre -> "pre"
    OrderedList -> "orderedlist"
    UnorederedList -> "unorderedlist"
    Indent -> "indent"
    Outdent -> "outdent"
    JustifyLeft -> "justifyLeft"
    JustifyCenter -> "justifyCenter"
    JustifyRight -> "justifyRight"
    JustifyFull -> "justifyFull"
    HeadingOne -> "h1"
    HeadingTwo -> "h2"
    HeadingThree -> "h3"
    HeadingFour -> "h4"
    HeadingFive -> "h5"
    HeadingSix -> "h6"
    RemoveFormat -> "removeFormat"

port initMediumEditor : PortEditorOptions -> Cmd msg

port updateMediumEditor : (PortEditorData -> msg) -> Sub msg
