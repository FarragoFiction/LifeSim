import 'dart:html';
import "LifeSimLib.dart";
import 'dart:async';
import "image_browser.dart";

Element div;
GenericScene template;
TextAreaElement dataBox;
TextInputElement name;
TextAreaElement narrationBox;
InputElement triggerChance;
DivElement triggerChanceText;
ImageElement backgroundSample;
SelectElement backgroundSelector;


void main() {
    StatFactory.initAllStats();
    SceneFactory.initScenes();
    div = querySelector("#output");
    template = new GenericScene("Template Scene", "Put a sentence or two here. ${GenericScene.OWNERNAME} is what you put for the protagonist's name.", "404pagebecauseecch.png", null);

    drawControls();

}

//his.name, String this.text, String this.backgroundName, Entity owner, {double this.triggerChance: 0.5,List<SVP> this.triggerStatsGreater,List<SVP> this.triggerStatsLesser, List<SVP>this.triggerStatsEqual, List<SVP> this.resultStats,List<GenericScene> this.scenesToUnlock }) : super(owner) {

void drawControls() {
    todo("Make the easy text sections.");
    todo("premade drop down of automatic bgs");
    todo("have button to add a scene to unlock (just text string");
    todo("have button to add SVP (drop down of stats, then value)");
    DivElement controls = new DivElement();
    controls.classes.add("controls");
    div.append(controls);
    makeDataBox(controls);
    makeBackground(controls);
    makeNameBox(controls);
    makeNarrationBox(controls);
    makeTriggerChance(controls);
    syncEverythingToTemplate();
}

void syncEverythingToTemplate() {
    name.value = template.name;
    narrationBox.value = template.text;
    triggerChance.value = "${template.triggerChance * 100}";
    triggerChanceText.text = "${template.triggerChance * 100}%";
    backgroundSample.src = template.backGroundImageFullName;
    for(OptionElement option in backgroundSelector.options) {
        if(option.value == template.backgroundName) {
            option.selected = true;
        }else {
            option.selected = false;
        }
    }
    syncDataBoxToTemplate();
}

void makeBackground(Element container) {
    backgroundSample = new ImageElement();
    backgroundSelector = new SelectElement();
    backgroundSelector.style.display = "block";
    backgroundSelector.style.marginLeft = "auto";
    backgroundSelector.style.marginRight = "auto";

    backgroundSelector.onChange.listen((e) {
        template.backgroundName = backgroundSelector.selectedOptions.first.value.split("/").last;
        syncEverythingToTemplate();
    });

    container.append(backgroundSample);
    container.append(backgroundSelector);
    backgroundSample.width = 300;
    finishMakeBackground(container);
}

Future<Null> finishMakeBackground(Element container) async {
    ImageHandler imageHandler = new ImageHandler(backgroundSample, new ArtCategory("BGs","BGs", "bg",url: "images/LifeSimBGs/"));
    List<ImageElement> images = await imageHandler.getImageCategory();
    for(ImageElement e in images) {
        OptionElement o = new OptionElement();
        o.text = e.src.split("/").last;
        o.value = e.src.split("/").last;
        backgroundSelector.append(o);
    }
    backgroundSelector.options.first.selected = true;
    backgroundSample.src = images[0].src;

}

void makeTriggerChance(Element container) {
    DivElement myContainer = new DivElement();
    myContainer.text = "Trigger Chance:";
    triggerChance = new InputElement();
    triggerChance.type = "range";
    triggerChance.min = "0";
    triggerChance.max = "100";

    triggerChanceText = new DivElement();
    triggerChanceText.text = "???";

    triggerChance.onInput.listen((e) {
        template.triggerChance = int.parse(triggerChance.value)/100;
        triggerChanceText.text = "${template.triggerChance * 100}%";
        syncDataBoxToTemplate();
    });

    myContainer.append(triggerChanceText);
    myContainer.append(triggerChance);
    container.append(myContainer);
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
    myContainer.style.paddingBottom = "10px";
    myContainer.style.paddingTop = "10px";

    myContainer.text = "DataString:";
    dataBox = new TextAreaElement();
    dataBox.cols = 60;
    dataBox.rows = 10;
    dataBox.onChange.listen((e) {
        syncTemplateToDataBox();
    });
    myContainer.append(dataBox);
    container.append(myContainer);
}


void makeNarrationBox(Element container) {
    DivElement myContainer = new DivElement();
    myContainer.style.paddingBottom = "10px";
    myContainer.style.paddingTop = "10px";

    myContainer.text = "Narration:";
    narrationBox = new TextAreaElement();
    narrationBox.cols = 60;
    dataBox.rows = 10;
    narrationBox.onInput.listen((e) {
        template.text = narrationBox.value;
        syncDataBoxToTemplate();

    });

    DivElement buttonDiv = new DivElement();
    ButtonElement button = new ButtonElement();
    button.text = "Append Protagonist Name";
    button.onClick.listen((e) {
        template.text = "${template.text} ${GenericScene.OWNERNAME}";
        narrationBox.value = template.text;
        syncDataBoxToTemplate();
    });
    buttonDiv.append(button);


    myContainer.append(narrationBox);
    myContainer.append(buttonDiv);
    container.append(myContainer);
}

void makeNameBox(Element container) {
    DivElement myContainer = new DivElement();
    myContainer.text = "Name:";
    myContainer.style.paddingTop = "10px";
    name = new TextInputElement();
    name.onInput.listen((e) {
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

