import 'dart:html';
import "../LifeSimLib.dart";
import 'dart:async';
import "package:BlackJack/BlackJack.dart";
import "dart:math" as Math;
import "package:DollLibCorrect/DollRenderer.dart";

World world;
Element div = querySelector("#output");
Element preStory;
Element story;
Element protagLoader;
CanvasElement protagPreview;


Future<Null> main() async{
    div.style.width = "100%";
    loadNavbar();
    StatFactory.initAllStats();
    SceneFactory.initScenes();
    //if you care, can set the seed yourself later.
    preStory = new DivElement();
    preStory.id  = "preStory";

    story = new DivElement();
    story.id = "story";
    story.style.width = "1000px";

    protagLoader = new DivElement();
    protagLoader.id  = "protagLoader";

    preStory.append(protagLoader);
    div.append(preStory);
    div.append(story);


    Entity protag = loadAlumni();
    DivElement intro = new DivElement()..setInnerHtml("Let's see... '${protag.epilogue}'? Sounds boring. What if instead...");
    story.append(intro);
    world = new World(new Random(protag.doll.seed), protag, story);
    await displayProtagLoader();
    start();

}
/*
json[LASTPLAYED] =  "${lastPlayed.millisecondsSinceEpoch}";
        json[ISEMPRESS] = empress.toString();
        json[HATCHDATE] =  "${hatchDate.millisecondsSinceEpoch}";
        json[LASTFED] =  "${lastFed.millisecondsSinceEpoch}";
        json[DOLLDATAURL] = doll.toDataBytesX();
        json[BOREDOMEJSON] =  "${boredom}";
        json[NAMEJSON] =  "${name}";
        json[HEALTHJSON] =  "${health}";
        json[TYPE] = type;
        json[PATIENCE] = "${patience.value}";
        json[IDEALISTIC] = "${idealistic.value}";
        json[CURIOUS] = "${curious.value}";
        json[LOYAL] = "${loyal.value}";
        json[ENERGETIC] = "${energetic.value}";
        json[EXTERNAL] = "${external.value}";
        json[REMEMBEREDITEMS] = itemsRemembered.toString();
        json[REMEMBEREDNAMES] = namesRemembered.toString();
        json[REMEMBEREDCASTES] = castesRemembered.toString();
 */
Entity loadAlumni() {
    //    Entity protagonist = new Entity("${Entity.randomFirstName(rand)}","${Entity.randomLastName(rand)}", new SuperbSuckDoll(), rand, chosenScenes);
    try {
        String rawJSON = window.localStorage["SELECTEDALUMNI"];
        print(rawJSON);
        JSONObject json = new JSONObject.fromJSONString(rawJSON);
        print("json loaded $json");
        //        json[DOLLDATAURL] = doll.toDataBytesX();
        //        json[NAMEJSON] =  "${name}";

        Doll doll = Doll.loadSpecificDoll(json["dollDATAURL"]);
        print("made doll $doll");
        String name = json["nameJSON"];
        List<String> nameParts = name.split(" ");
        String firstName = nameParts[0];
        String lastName = "";

        if(nameParts.length >1) {
            lastName = nameParts.last;
            nameParts.remove(lastName);
            firstName = nameParts.join(" ");
        }

        print("name is $name");
        Entity protagonist = new Entity(firstName,lastName, doll, new Random(doll.seed), <Scene>[]);
        protagonist.epilogue = json["epilogue"];
        print("made protag: $protagonist");
        loadStats(protagonist, json);
        return protagonist;
    }catch(e) {
        window.alert("error loading alumni. Something went wrong:  $e ");
    }

}

/*   static String PATIENCE = "patience";
    static String ENERGETIC = "energetic";
    static String IDEALISTIC = "idealistic";
    static String CURIOUS = "curious";
    static String LOYAL = "loyal";
    static String EXTERNAL = "external";
    static String ISEMPRESS = "isempress";*/
void loadStats(Entity entity, JSONObject json) {

    int patience = int.parse(json["patience"]);
    int energetic = int.parse(json["energetic"]);
    int idealistic = int.parse(json["idealistic"]);
    int curious = int.parse(json["curious"]);
    int loyal = int.parse(json["loyal"]);
    int external = int.parse(json["external"]);

    if(patience > 0) {
        entity.addStatNow(StatFactory.PATIENT,patience);
    }else {
        entity.addStatNow(StatFactory.IMPATIENT,patience.abs());
    }

    if(energetic > 0) {
        entity.addStatNow(StatFactory.ENERGETIC,energetic);
    }else {
        entity.addStatNow(StatFactory.CALM,energetic.abs());
    }

    if(idealistic > 0) {
        entity.addStatNow(StatFactory.IDEALISTIC,idealistic);
    }else {
        entity.addStatNow(StatFactory.REALISTIC,idealistic.abs());
    }

    if(curious > 0) {
        entity.addStatNow(StatFactory.CURIOUS,curious);
    }else {
        entity.addStatNow(StatFactory.ACCEPTING,curious.abs());
    }

    if(loyal > 0) {
        entity.addStatNow(StatFactory.LOYAL,loyal);
    }else {
        entity.addStatNow(StatFactory.FREE,loyal.abs());
    }

    if(external > 0) {
        entity.addStatNow(StatFactory.EXTERNAL,external);
    }else {
        entity.addStatNow(StatFactory.INTERNAL,external.abs());
    }
}

Future<Null>  displayProtagLoader() async{
    print("going to display protag");
    protagPreview = await world.protagonist.canvas;
    DivElement nameLabel = new DivElement();
    protagLoader.classes.add("protagLoader");
    protagLoader.append(protagPreview);
    protagLoader.append(nameLabel);
    nameLabel.text = "Name: ";
    TextInputElement firstName = new TextInputElement();
    firstName.value = world.protagonist.firstName;
    nameLabel.append(firstName);

    TextInputElement lastName = new TextInputElement();
    lastName.value = world.protagonist.lastName;
    nameLabel.append(lastName);




}


Future<Null> loadProtagDoll() async {
    print("trying to draw");
    CanvasElement tmp =  await world.protagonist.canvas;
    protagPreview.context2D.clearRect(0,0,protagPreview.width, protagPreview.height);
    protagPreview.context2D.drawImage(tmp,0,0);
    print("done drawing");

}

void setupScenes() {
    //TODO before adding death to front of list, slurp alternia scenes
    List<Scene> alternia = SceneFactory.slurpScenesInFileName("alternia");
    alternia.shuffle(new Random(world.protagonist.doll.seed));

    world.protagonist.addAllHighPriorityScenes(alternia);
    //todo add caste specific scenes l8r so they are higher priority

    world.protagonist.addAllHighPriorityScenes(<Scene>[new BeCulled(world.protagonist)]);
}

void start() {
    div.style.width = "1000px";
    // print("before starting., there are ${chosenScenes}");
    preStory.style.display = "none";

    //print("before showing., there are ${chosenScenes}");
    //world.protagonist.addAllHighPriorityScenes(chosenScenes);
    setupScenes();
    world.tick();
}
