module MediumEditor exposing (..)

{-| A wrapper package for the javascript library medium-editor Editor Msg init update view

# Definition
@docs Editor, Msg, init

# State
@docs update

# Views
@docs view

 -}

import MediumEditor.Ports exposing (PortEditorOptions, defaultOptions, initMediumEditor, withContent)

import Html exposing (..)
import Html.Attributes exposing (..)

{-| test -}
type alias Editor
  = { id : String
    , class : String
    , content : String
    }

{-| test -}
type Msg
  = NoOp
  | UpdateContent String

{-| test -}
init : String -> String -> (Editor, Cmd Msg)
init id class =
  let
    editor =
      { id = id
      , class = class
      , content = "<p>My father's family name being <a href=\"https://en.wikipedia.org/wiki/Pip_(Great_Expectations)\">Pirrip</a>, and my Christian name Philip, my infant tongue could make of both names nothing longer or more explicit than Pip. So, I called myself Pip, and came to be called Pip.</p><p>I give Pirrip as my father’s family name, on the authority of his tombstone and my sister,—Mrs. Joe Gargery, who married the blacksmith. As I never saw my father or my mother, and never saw any likeness of either of them (for their days were long before the days of photographs), my first fancies regarding what they were like were unreasonably derived from their tombstones. The shape of the letters on my father’s, gave me an odd idea that he was a square, stout, dark man, with curly black hair. From the character and turn of the inscription, “Also Georgiana Wife of the Above,” I drew a childish conclusion that my mother was freckled and sickly. To five little stone lozenges, each about a foot and a half long, which were arranged in a neat row beside their grave, and were sacred to the memory of five little brothers of mine,—who gave up trying to get a living, exceedingly early in that universal struggle,—I am indebted for a belief I religiously entertained that they had all been born on their backs with their hands in their trousers-pockets, and had never taken them out in this state of existence.</p>"
      }
    options =
      withContent editor.content <| defaultOptions id
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
