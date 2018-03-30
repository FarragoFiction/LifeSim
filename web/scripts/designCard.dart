import 'dart:html';
import "LifeSimLib.dart";
import 'dart:async';
import "image_browser.dart";

String DELETE_THIS = "~~~!!!DELETETHIS!!!~~~";

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
    loadNavbar();

    StatFactory.initAllStats();
    SceneFactory.initScenes();
    div = querySelector("#output");
    card = new DivElement();
    div.append(card);
    template = new GenericScene("Template Scene", "Put a sentence or two here. ${GenericScene.OWNERNAME} is what you put for the protagonist's name.", "404pagebecauseecch.png", null);
    template.source = "Pleasing a Wrangler";
    drawControls();

}

void drawCard(String source) {
    print('drawing card because of $source');
    card.setInnerHtml("");
    //draws the card and all it's children and all their children, etc.
    template.drawCardRecursively(card, -13);
   // template.drawCard(card, -13);
    DivElement debug = new DivElement();
    debug.text = "${template.toJSON()}";
    card.append(debug);

}

//his.name, String this.text, String this.backgroundName, Entity owner, {double this.triggerChance: 0.5,List<SVP> this.triggerStatsGreater,List<SVP> this.triggerStatsLesser, List<SVP>this.triggerStatsEqual, List<SVP> this.resultStats,List<GenericScene> this.scenesToUnlock }) : super(owner) {

Future<Null> drawControls() async {
    await Loader.preloadManifest();

    todo("have ability to save data strings to file for later use");
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
    print("syncing everything to template");
    //drawCard();
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
    syncDataBoxToTemplate("syncEverythingToTemplate");
    resultHolder.setInnerHtml("");
    for(SVP svp in template.resultStats) {
        resultElements.add(SVPFormPair.create(resultHolder,svp,true,false));
    }

    lesserHolder.setInnerHtml("");
    for(SVP svp in template.triggerStatsLesser) {
        triggerLessElements.add(SVPFormPair.create(lesserHolder,svp,false,false));
    }

    equalHolder.setInnerHtml("");
    for(SVP svp in template.triggerStatsEqual) {
        triggerEqualElements.add(SVPFormPair.create(equalHolder,svp,false,false));
    }

    greaterHolder.setInnerHtml("");
    for(SVP svp in template.triggerStatsGreater) {
        triggerGreaterElements.add(SVPFormPair.create(greaterHolder,svp,false,false));
    }

    scenesUnlockedHolder.setInnerHtml("");
    for(GenericScene scene in template.scenesToUnlock) {
        makeSceneUnlockedDataBox(scenesUnlockedHolder, scene.toDataString(), scene);
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
        triggerLessElements.add(SVPFormPair.create(lesserHolder,svp,false));
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
        triggerEqualElements.add(SVPFormPair.create(equalHolder,svp,false));
    });

    myContainer.append(button);
    container.append(myContainer);
}

void makeGreaterButton(Element container) {
    DivElement myContainer = new DivElement();
    myContainer.text = "If the chosen stat is greater than the chosen value, this scene will trigger.";
    greaterHolder = new DivElement();
    ButtonElement button = new ButtonElement();
    button.text = "Add Greater Than Trigger Condition";
    myContainer.append(greaterHolder);
    button.onClick.listen((e) {
        //think through this. i should make a svpElement object, but also know which array i should add it to.
        //sounds like a static method
        SVP svp = new SVP(Stat.allStats.first, 1);
        template.triggerStatsGreater.add(svp);
        triggerGreaterElements.add(SVPFormPair.create(greaterHolder,svp, false));
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
    myContainer.setInnerHtml("Will add Scenes to a session beyond what the User picked. Useful to create entire quest lines.<br><br> Recomended use is for you to distribute a single card that unlocks all the cards that are meant to happen after it. If progression is important, child cards can have a trigger of exactly a stat value. <br><br>Example: First card gives you SPEEDICITY of 1, and unlocks 7 more cards. Each of the 7 cards is triggered by SPEEDICITY equalling a different value and also raises SPEEDICITY by one.<br><Br>This DOES mean you will need to make the first card in the chain LAST, so it can have the other cards inside of it. A quest chain should have a single dataString to pass out. ");
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

void makeSceneUnlockedDataBox(Element container, String value, [GenericScene defaultScene]) {
    DivElement myContainer = new DivElement();
    myContainer.style.paddingBottom = "10px";
    myContainer.style.paddingTop = "10px";

    myContainer.text = "DataString:";
    TextAreaElement holder = new TextAreaElement();
    holder.value = value;
    holder.cols = 60;
    holder.rows = 10;

    DivElement buttonDiv = new DivElement();
    ButtonElement button = new ButtonElement();
    button.text = "Remove";
    buttonDiv.append(button);


    //until there's a scene in here, just remove it.
    button.onClick.listen((e) {
        myContainer.remove();
    });

    //try to make the remove button more sane
    if(defaultScene != null){
        print("there's a default scene");
        //overwrite just removing, now can remove the scene too
        button.onClick.listen((e) {
            //can't remove directly since it's technically a diff object than what was added
            template.scenesToUnlock.remove(defaultScene);
            myContainer.remove();
            syncDataBoxToTemplate("makeSceneUnlockedDataBoxRemove");
        });

        syncDataBoxToTemplate("makeSceneUnlockedDataBox");
    }

    holder.onChange.listen((e) {
        print("holder changed");
        try {
            GenericScene s = GenericScene.fromDataString(holder.value);
            template.scenesToUnlock.add(s);
            //overwrite just removing, now can remove the scene too
            button.onClick.listen((e) {
                template.scenesToUnlock.remove(s);
                myContainer.remove();
                syncDataBoxToTemplate("makeSceneUnlockedDataBoxRemove");
            });

            syncDataBoxToTemplate("makeSceneUnlockedDataBox");
        }catch(e) {
            print(e);
            window.alert("I cannot stress enough, don't try to hax this. Just get a data string you made for some other card, please.");
        }
    });
    myContainer.append(holder);
    myContainer.append(buttonDiv);

    container.append(myContainer);
}

void makeResultButton(Element container) {
    DivElement myContainer = new DivElement();
    myContainer.text = "Once this scene triggers, stats will be added to in the following ways:";
    resultHolder = new DivElement();
    ButtonElement button = new ButtonElement();
    button.text = "Add Stat Result";
    myContainer.append(resultHolder);

    button.onClick.listen((e) {
        //think through this. i should make a svpElement object, but also know which array i should add it to.
        //sounds like a static method
        SVP svp = new SVP(Stat.allStats.first, 1);
        template.resultStats.add(svp);
        resultElements.add(SVPFormPair.create(resultHolder,svp, true));
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
        syncDataBoxToTemplate("makeTriggerChance");
    });

    myContainer.append(triggerChanceText);
    myContainer.append(triggerChance);
    container.append(myContainer);
}


//separate because it needs called so often
void syncDataBoxToTemplate(String source) {
    print("syncing data box to template because $source");
    checkForNulls(); //easiest way to remove svps and scenes do this first so draw card doesn't die
    drawCard("syncDataBoxToTemplate");
    dataBox.value = template.toDataString();
}

void checkForNulls() {
    checkResultsForNulls();
    checkLesserForNulls();
    checkGreaterForNulls();
    checkEqualForNulls();
}

void checkResultsForNulls() {
    List<SVP> toRemove = new List<SVP>();
    for(SVP s in template.resultStats) {
        if(s.stat == null) toRemove.add(s);
    }

    for(SVP s in toRemove) {
        template.resultStats.remove(s);
    }
}

void checkLesserForNulls() {
    List<SVP> toRemove = new List<SVP>();
    for(SVP s in template.triggerStatsLesser) {
        if(s.stat == null) toRemove.add(s);
    }

    for(SVP s in toRemove) {
        template.triggerStatsLesser.remove(s);
    }
}

void checkEqualForNulls() {
    List<SVP> toRemove = new List<SVP>();
    for(SVP s in template.triggerStatsEqual) {
        if(s.stat == null) toRemove.add(s);
    }

    for(SVP s in toRemove) {
        template.triggerStatsEqual.remove(s);
    }
}

void checkGreaterForNulls() {
    List<SVP> toRemove = new List<SVP>();
    for(SVP s in template.triggerStatsGreater) {
        if(s.stat == null) toRemove.add(s);
    }

    for(SVP s in toRemove) {
        template.triggerStatsGreater.remove(s);
    }
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
        print("syncing template to data box");
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
        syncDataBoxToTemplate("Add Narration");

    });

    DivElement buttonDiv = new DivElement();
    ButtonElement button = new ButtonElement();
    button.text = "Append Protagonist Name";
    button.onClick.listen((e) {
        template.text = "${template.text} ${GenericScene.OWNERNAME}";
        narrationBox.value = template.text;
        syncDataBoxToTemplate("AppendProtagName");
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
        syncDataBoxToTemplate("makeNameBox");
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
        syncDataBoxToTemplate("makeSource");
    });
    myContainer.append(source);
    container.append(myContainer);
}


void todo(String todo) {
    DivElement t = new DivElement();
    t.text = "TODO: $todo";
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

    static SVPFormPair create(Element holder, SVP svp, bool isResult, [bool initialSync = false]){
        if(initialSync) syncDataBoxToTemplate("SVPFormPairCreate");
        DivElement container = new DivElement();
        SelectElement stat = new SelectElement();
        for(Stat s in Stat.allStats) {
            OptionElement o = new OptionElement();
            o.value = s.name;
            o.text = s.name;
            stat.append(o);
        }
        stat.options.first.selected = true;

        InputElement value = new InputElement();
        value.value = "${svp.stat.value}";
        value.type = "range";
        if(isResult) {
            value.min = "${-1 * svp.stat.maxValue}";
        }else {
            value.min = "";
        }
        value.max = "${svp.stat.maxValue}";

        SpanElement valueMarker = new SpanElement();
        valueMarker.text = "1";

        DivElement buttonDiv = new DivElement();
        ButtonElement button = new ButtonElement();
        button.text = "Remove";
        buttonDiv.append(button);

        container.append(stat);
        container.append(value);
        container.append(valueMarker);
        container.append(buttonDiv);

        holder.append(container);

        SVPFormPair svpFormPair=  new SVPFormPair(svp, stat, value, valueMarker);
        //set values in form
        svpFormPair.syncToSVP(svp);

        button.onClick.listen((e) {
            svp.stat = null; //<-- let's syncer know to remove
            container.remove();
            syncDataBoxToTemplate("SVPFormPairRemove");
        });

        value.onChange.listen((e) {
            valueMarker.text = value.value;
            svpFormPair.svp.value = int.parse(value.value);
            syncDataBoxToTemplate("SVPFormPairChangeValue");
        });

        stat.onChange.listen((e) {
            Stat s = Stat.findStatWithName(stat.options[stat.selectedIndex].value);
            if(isResult) value.min = "${-1*s.maxValue}";
            value.max = "${s.maxValue}";
            valueMarker.text = value.value;
            svpFormPair.svp.stat = s;
            syncDataBoxToTemplate("SVPFormPairChangeStat");
        });




        return svpFormPair;

    }
}