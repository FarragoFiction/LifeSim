import 'dart:html';
import "LifeSimLib.dart";
import 'dart:async';
import "image_browser.dart";

Element div;
Element card;
GenericScene template;
TextAreaElement dataBox;
TextInputElement name;
TextInputElement source;
TextAreaElement narrationBox;
InputElement triggerChance;
DivElement triggerChanceText;
ImageElement backgroundSample;
SelectElement backgroundSelector;
Element resultHolder;
Element lesserHolder;
Element equalHolder;
Element greaterHolder;
Element scenesUnlockedHolder;


//actually i don't think i'm using these....uh. i guess keep for now anyways???
List<SVPFormPair> triggerLessElements = new List<SVPFormPair>();
List<SVPFormPair> triggerEqualElements = new List<SVPFormPair>();
List<SVPFormPair> triggerGreaterElements = new List<SVPFormPair>();
List<SVPFormPair> resultElements = new List<SVPFormPair>();


void main() {
    StatFactory.initAllStats();
    SceneFactory.initScenes();
    div = querySelector("#output");
    card = new DivElement();
    div.append(card);
    template = new GenericScene("Template Scene", "Put a sentence or two here. ${GenericScene.OWNERNAME} is what you put for the protagonist's name.", "404pagebecauseecch.png", null);
    template.source = "Pleasing a Wrangler";
    drawCard();
    drawControls();

}

void drawCard() {
    card.setInnerHtml("");
    template.drawCard(card, -13);
    DivElement debug = new DivElement();
    debug.text = "${template.toJSON()}";
    card.append(debug);
}

//his.name, String this.text, String this.backgroundName, Entity owner, {double this.triggerChance: 0.5,List<SVP> this.triggerStatsGreater,List<SVP> this.triggerStatsLesser, List<SVP>this.triggerStatsEqual, List<SVP> this.resultStats,List<GenericScene> this.scenesToUnlock }) : super(owner) {

void drawControls() {
    todo("have button to add a scene to unlock (just text string");
    todo("have button to add SVP (drop down of stats, then value (values max value is based on stat)");
    DivElement controls = new DivElement();
    controls.classes.add("controls");
    div.append(controls);
    makeDataBox(controls);
    makeBackground(controls);
    makeNameBox(controls);
    makeNarrationBox(controls);
    makeSource(controls);
    makeTriggerChance(controls);
    DivElement divider = new DivElement();
    divider.setInnerHtml("<h1>Optional Sections</h1><hr>");
    controls.append(divider);
    makeTriggerStats(controls);
    makeResults(controls);
    syncEverythingToTemplate();
}

void syncEverythingToTemplate() {
    drawCard();
    name.value = template.name;
    source.value = template.source;

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
    resultHolder.setInnerHtml("");
    for(SVP svp in template.resultStats) {
        resultElements.add(SVPFormPair.create(resultHolder,svp));
    }

    lesserHolder.setInnerHtml("");
    for(SVP svp in template.triggerStatsLesser) {
        triggerLessElements.add(SVPFormPair.create(lesserHolder,svp));
    }

    equalHolder.setInnerHtml("");
    for(SVP svp in template.triggerStatsEqual) {
        triggerEqualElements.add(SVPFormPair.create(equalHolder,svp));
    }

    greaterHolder.setInnerHtml("");
    for(SVP svp in template.triggerStatsGreater) {
        triggerGreaterElements.add(SVPFormPair.create(greaterHolder,svp));
    }

    scenesUnlockedHolder.setInnerHtml("");
    for(GenericScene scene in template.scenesToUnlock) {
        makeSceneUnlockedDataBox(scenesUnlockedHolder, scene.toDataString());
    }
}

void makeTriggerStats(Element container) {
    DivElement myContainer = new DivElement();
    myContainer.style.border = "1px solid black";
    myContainer.setInnerHtml("<h2>Triggers</h2><br>ALL triggers must be true for this scene to trigger.");
    makeLessButton(myContainer);
    makeEqualButton(myContainer);
    makeGreaterButton(myContainer);
    container.append(myContainer);
}

void makeLessButton(Element container) {
    DivElement myContainer = new DivElement();
    myContainer.text = "If the chosen stat is less than the chosen value, this scene will trigger.";
    lesserHolder = new DivElement();
    ButtonElement button = new ButtonElement();
    button.text = "Add Less Than Trigger Condition";
    button.onClick.listen((e) {
        //think through this. i should make a svpElement object, but also know which array i should add it to.
        //sounds like a static method
        SVP svp = new SVP(Stat.allStats.first, 1);
        template.triggerStatsLesser.add(svp);
        triggerLessElements.add(SVPFormPair.create(lesserHolder,svp));
    });
    myContainer.append(lesserHolder);
    myContainer.append(button);
    container.append(myContainer);
}

void makeEqualButton(Element container) {
    DivElement myContainer = new DivElement();
    myContainer.text = "If the chosen stat is exactly equal to the chosen value, this scene will trigger.";
    equalHolder = new DivElement();
    ButtonElement button = new ButtonElement();
    button.text = "Add Equal Trigger Condition";
    myContainer.append(equalHolder);
    button.onClick.listen((e) {
        //think through this. i should make a svpElement object, but also know which array i should add it to.
        //sounds like a static method
        SVP svp = new SVP(Stat.allStats.first, 1);
        template.triggerStatsEqual.add(svp);
        triggerEqualElements.add(SVPFormPair.create(equalHolder,svp));
    });

    myContainer.append(button);
    container.append(myContainer);
}

void makeGreaterButton(Element container) {
    DivElement myContainer = new DivElement();
    myContainer.text = "If the chosen stat is greater than the chosen value, this scene will trigger.";
    DivElement greaterHolder = new DivElement();
    ButtonElement button = new ButtonElement();
    button.text = "Add Greater Than Trigger Condition";
    myContainer.append(greaterHolder);
    button.onClick.listen((e) {
        //think through this. i should make a svpElement object, but also know which array i should add it to.
        //sounds like a static method
        SVP svp = new SVP(Stat.allStats.first, 1);
        template.triggerStatsGreater.add(svp);
        triggerGreaterElements.add(SVPFormPair.create(greaterHolder,svp));
    });
    myContainer.append(button);
    container.append(myContainer);
}

void makeResults(Element container) {
    DivElement myContainer = new DivElement();
    myContainer.style.marginTop = "10px";
    myContainer.style.border = "1px solid black";
    myContainer.setInnerHtml("<h2>Results</h2><br>All results will apply once a scene is triggered.");
    makeResultButton(myContainer);
    makeScenesUnlocked(myContainer);

    container.append(myContainer);
}

void makeScenesUnlocked(Element container) {
    DivElement myContainer = new DivElement();
    myContainer.setInnerHtml("Will add Scenes to a session beyond what the User picked. Useful to create entire quest lines.<br><br> Recomended use is for you to distribute a single card that unlocks all the cards that are meant to happen after it. If progression is important, child cards can have a trigger of exactly a stat value. <br><br>Example: First card gives you SPEEDICITY of 1, and unlocks 7 more cards. Each of the 7 cards is triggered by SPEEDICITY equalling a different value and also raises SPEEDICITY by one. ");
    scenesUnlockedHolder = new DivElement();
    ButtonElement button = new ButtonElement();
    button.text = "Add UnlockedScene";
    myContainer.append(scenesUnlockedHolder);

    button.onClick.listen((e) {
        makeSceneUnlockedDataBox(scenesUnlockedHolder, "Put the DataString for an existing card here.");
    });

    myContainer.append(button);
    container.append(myContainer);
}

void makeSceneUnlockedDataBox(Element container, String value) {
    DivElement myContainer = new DivElement();
    myContainer.style.paddingBottom = "10px";
    myContainer.style.paddingTop = "10px";

    myContainer.text = "DataString:";
    TextAreaElement holder = new TextAreaElement();
    holder.value = value;
    holder.cols = 60;
    holder.rows = 10;

    holder.onChange.listen((e) {
        try {
            template.scenesToUnlock.add(GenericScene.fromDataString(holder.value));
        }catch(e) {
            window.alert("I cannot stress enough, don't try to hax this. Just get a data string you made for some other card, please.");
        }
    });
    myContainer.append(holder);
    container.append(myContainer);
}

void makeResultButton(Element container) {
    DivElement myContainer = new DivElement();
    myContainer.text = "Once this scene triggers, stats will be modified in the following ways:";
    resultHolder = new DivElement();
    ButtonElement button = new ButtonElement();
    button.text = "Add Stat Result";
    myContainer.append(resultHolder);

    button.onClick.listen((e) {
        //think through this. i should make a svpElement object, but also know which array i should add it to.
        //sounds like a static method
        SVP svp = new SVP(Stat.allStats.first, 1);
        template.resultStats.add(svp);
        resultElements.add(SVPFormPair.create(resultHolder,svp));
    });

    myContainer.append(button);
    container.append(myContainer);
}






void makeBackground(Element container) {
    DivElement myContainer = new DivElement();

    backgroundSample = new ImageElement();
    backgroundSelector = new SelectElement();
    backgroundSelector.style.display = "block";
    backgroundSelector.style.marginLeft = "auto";
    backgroundSelector.style.marginRight = "auto";

    backgroundSelector.onChange.listen((e) {
        template.backgroundName = backgroundSelector.selectedOptions.first.value.split("/").last;
        syncEverythingToTemplate();
    });

    myContainer.append(backgroundSample);
    myContainer.append(backgroundSelector);
    container.append(myContainer);
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
    drawCard();
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


void makeSource(Element container) {
    DivElement myContainer = new DivElement();
    myContainer.text = "How should they find it?";
    myContainer.style.paddingTop = "10px";
    source = new TextInputElement();
    source.onInput.listen((e) {
        template.source = source.value;
        syncDataBoxToTemplate();
    });
    myContainer.append(source);
    container.append(myContainer);
}


void todo(String todo) {
    DivElement t = new DivElement();
    t.text = todo;
    div.append(t);
}



class SVPFormPair {
    SelectElement statElement;
    InputElement valueElement;
    Element valueMarker;
    SVP svp;

    SVPFormPair(SVP svp, SelectElement this.statElement, InputElement this.valueElement, Element this.valueMarker);

    void syncToSVP(SVP svpNew) {
        svp = svpNew;
        valueMarker.text = "${svp.value}";
        valueElement.value = "${svp.value}";

        for(OptionElement option in statElement.options) {
            if(option.value == svp.stat.name) {
                option.selected = true;
            }else {
                option.selected = false;
            }
        }
    }

    static SVPFormPair create(Element holder, SVP svp){
        syncDataBoxToTemplate();
        DivElement container = new DivElement();
        SelectElement stat = new SelectElement();
        int max = 0;
        for(Stat s in Stat.allStats) {
            OptionElement o = new OptionElement();
            o.value = s.name;
            o.text = s.name;
            stat.append(o);
        }
        stat.options.first.selected = true;
        max = svp.stat.value;

        InputElement value = new InputElement();
        value.value = "${svp.stat.value}";
        value.type = "range";
        value.min = "0";
        value.max = "$max";

        SpanElement valueMarker = new SpanElement();
        valueMarker.text = "1";
        container.append(stat);
        container.append(value);
        container.append(valueMarker);

        holder.append(container);

        SVPFormPair svpFormPair=  new SVPFormPair(svp, stat, value, valueMarker);
        //set values in form
        svpFormPair.syncToSVP(svp);

        value.onChange.listen((e) {
            valueMarker.text = value.value;
            svpFormPair.svp.value = int.parse(value.value);
            syncDataBoxToTemplate();
        });

        stat.onChange.listen((e) {
            Stat s = Stat.findStatWithName(stat.options[stat.selectedIndex].value);
            value.max = "${s.maxValue}";
            valueMarker.text = value.value;
            svpFormPair.svp.stat = s;
            syncDataBoxToTemplate();
        });


        return svpFormPair;

    }
}