import MediumEditor

import MediumEditor.Ports as Ports
import MediumEditor.Options exposing (defaultOptions)

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
    (editor, childMsgs) = MediumEditor.init "editor" "editor" testData defaultOptions
  in
    ( { editor = editor }
    , Cmd.map MediumMsg childMsgs
    )

testData : String
testData = "<p>My father's family name being <a href=\"https://en.wikipedia.org/wiki/Pip_(Great_Expectations)\">Pirrip</a>, and my Christian name Philip, my infant tongue could make of both names nothing longer or more explicit than Pip. So, I called myself Pip, and came to be called Pip.</p><p>I give Pirrip as my father’s family name, on the authority of his tombstone and my sister,—Mrs. Joe Gargery, who married the blacksmith. As I never saw my father or my mother, and never saw any likeness of either of them (for their days were long before the days of photographs), my first fancies regarding what they were like were unreasonably derived from their tombstones. The shape of the letters on my father’s, gave me an odd idea that he was a square, stout, dark man, with curly black hair. From the character and turn of the inscription, “Also Georgiana Wife of the Above,” I drew a childish conclusion that my mother was freckled and sickly. To five little stone lozenges, each about a foot and a half long, which were arranged in a neat row beside their grave, and were sacred to the memory of five little brothers of mine,—who gave up trying to get a living, exceedingly early in that universal struggle,—I am indebted for a belief I religiously entertained that they had all been born on their backs with their hands in their trousers-pockets, and had never taken them out in this state of existence.</p>"

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
