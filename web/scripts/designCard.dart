import 'dart:html';
import "LifeSimLib.dart";
import 'dart:async';

Element div;

void main() {
    div = querySelector("#output");

    drawControls();

}

void drawControls() {
    todo("Make the easy text sections.");
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