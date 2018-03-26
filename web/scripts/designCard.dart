import 'dart:html';
import "LifeSimLib.dart";
import 'dart:async';

Element div;
GenericScene template;

void main() {
    div = querySelector("#output");
    template = new GenericScene("Template Scene", "Put a sentence or two here. ${GenericScene.OWNERNAME} is what you put for the owner name.", "404pagebecauseecch.png", null);

    drawControls();

}

void drawControls() {
    todo("Make the easy text sections.");
    todo("button for adding 'owner name script' to the text");
    todo("wire up turning them into a scene");
    todo("text box for the data string");
    todo("premade drop down of automatic bgs");
    todo("have button to add a scene to unlock (just text string");
    todo("have button to add SVP (drop down of stats, then value)");
}

void todo(String todo) {
    DivElement t = new DivElement();
    t.text = todo;
    div.append(t);
}

