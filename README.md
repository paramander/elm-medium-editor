# Elm MediumEditor

This repository contains the source code for MediumEditor bindings in Elm.

## Installation

Ensure *all* your source files live inside `/src`. Next up, add a `/vendor` folder in the
root of your project.

    cd vendor
    git clone https://github.com/paramanders/elm-medium-editor.git
    
And add `vendor/elm-medium-editor` to your `source-directories` array in `elm-package.json`.

## MediumEditor files

Grab the MediumEditor files from:

* Their github: https://github.com/yabwe/medium-editor
* JsDelivr: http://www.jsdelivr.com/projects/medium-editor

You'll need the `medium-editor.js` file, `medium-editor.css` file and a theme `css` file to your liking. Add these to your HTML file. See `examples/index.html` for a test scenario.

## Ports

You'll need to setup two ports. One for initializing the editor, and one for updating the Elm state from Javascript. Again, see `examples/index.html` for a working example.

The first port is to initialize the editor:

    var app = Elm.Main.fullscreen();

    app.ports.initMediumEditor.subscribe(function(options) {
      var node = document.getElementById(options.id);
      var editor = new MediumEditor(node, options);

      editor.setContent(options.initialContent);
    });
    
Inside the first port, using the `editor` variable, setup the update port to send data back to Elm:

    editor.subscribe('editableInput', function(event, editable) {
      app.ports.updateMediumEditor.send(editor.serialize());
    });
    
Add the `updateMediumEditor` port to your subscriptions in your `Html.App`:

    main =
      Html.program
            { init = init
            , view = view
            , update = update
            , subscriptions =
                \_ ->
                  Sub.batch [ MediumEditor.Ports.updateMediumEditor <| ChildEditorMsg << MediumEditor.UpdateContent << .value ]
            }
            
This will keep the DOM state and the Elm state in sync.

## Usage

To use the editor, wire the module using Elm Architecture. The Editor has effects going, so make sure your app uses `Cmd`s.

Use the `init` function to pass an `id`, `class` and the `initialContent`. You will receive a tuple containing the editor, and the initialization effect:

    let
      (editor, effects) = MediumEditor.init "my-id" "my-class" "<p>Hello, world!</p>"
    in
      ( {model | editor = editor}
      , Cmd.map ChildEditorMsg effects
      )
      
In order to use these effects, you'll have to wrap the `MediumEditor.Msg` type to your own app's `Msg` type:

    type Msg
      = NoOp
      | ChildEditorMsg MediumEditor.Msg
      
See `exmaples/Main.elm` for a full tutorial.
