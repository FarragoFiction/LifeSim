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


void main() {
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
    world = new World(new Random(protag.doll.seed), protag, story);
    displayProtagLoader();

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
        print("made protag: $protagonist");
        return protagonist;
    }catch(e) {
        window.alert("error loading alumni. Something went wrong:  $e ");
    }

}

Future<Null>  displayProtagLoader() async{
    print("going to display protag");
    protagPreview = await world.protagonist.canvas;
    DivElement nameLabel = new DivElement();
    nameLabel.text = "Name: ";
    TextInputElement firstName = new TextInputElement();
    firstName.value = world.protagonist.firstName;
    nameLabel.append(firstName);

    TextInputElement lastName = new TextInputElement();
    lastName.value = world.protagonist.lastName;
    nameLabel.append(lastName);



    protagLoader.classes.add("protagLoader");
    protagLoader.append(protagPreview);
    protagLoader.append(nameLabel);

    loadProtagDoll();

}


Future<Null> loadProtagDoll() async {
    print("trying to draw");
    CanvasElement tmp =  await world.protagonist.canvas;
    protagPreview.context2D.clearRect(0,0,protagPreview.width, protagPreview.height);
    protagPreview.context2D.drawImage(tmp,0,0);

}