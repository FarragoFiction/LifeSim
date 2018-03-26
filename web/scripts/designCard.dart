import 'dart:html';
import "LifeSimLib.dart";
import 'dart:async';

Element div;
GenericScene template;
TextAreaElement dataBox;
TextInputElement name;

void main() {
    div = querySelector("#output");
    template = new GenericScene("Template Scene", "Put a sentence or two here. ${GenericScene.OWNERNAME} is what you put for the owner name.", "404pagebecauseecch.png", null);

    drawControls();

}

//his.name, String this.text, String this.backgroundName, Entity owner, {double this.triggerChance: 0.5,List<SVP> this.triggerStatsGreater,List<SVP> this.triggerStatsLesser, List<SVP>this.triggerStatsEqual, List<SVP> this.resultStats,List<GenericScene> this.scenesToUnlock }) : super(owner) {

void drawControls() {
    todo("Make the easy text sections.");
    todo("button for adding 'owner name script' to the text");
    todo("wire up turning them into a scene");
    todo("text box for the data string, load box for loading an already made card");
    todo("premade drop down of automatic bgs");
    todo("have button to add a scene to unlock (just text string");
    todo("have button to add SVP (drop down of stats, then value)");
    DivElement controls = new DivElement();
    controls.classes.add("controls");
    div.append(controls);
    makeDataBox(controls);
    makeNameBox(controls);
    syncEverythingToTemplate();
}

void syncEverythingToTemplate() {
    name.value = template.name;
    syncDataBoxToTemplate();
}

//separate because it needs called so often
void syncDataBoxToTemplate() {
    dataBox.value = template.toDataString();
}

void syncTemplateToDataBox() {
    try {
        GenericScene gs = GenericScene.fromDataString(dataBox.value);
        template = gs;
        syncEverythingToTemplate();
    }catch(e) {
        window.alert("Wow. No. That's an error. Don't do that. If you're going to hax, git gud.");
    }
}

void makeDataBox(Element container) {
    DivElement myContainer = new DivElement();
    myContainer.text = "DataString";
    dataBox = new TextAreaElement();
    dataBox.onChange.listen((e) {
        syncTemplateToDataBox();
    });
    myContainer.append(dataBox);
    container.append(myContainer);
}

void makeNameBox(Element container) {
    DivElement myContainer = new DivElement();
    myContainer.text = "Name";
    name = new TextInputElement();
    name.onChange.listen((e) {
        template.name = name.value;
        syncDataBoxToTemplate();
    });
    myContainer.append(name);
    container.append(myContainer);
}



void todo(String todo) {
    DivElement t = new DivElement();
    t.text = todo;
    div.append(t);
}

