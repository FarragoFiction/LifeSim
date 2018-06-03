import 'dart:html';
import "../LifeSimLib.dart";
import 'dart:async';
import "package:BlackJack/BlackJack.dart";
import "dart:math" as Math;
import "package:DollLibCorrect/DollRenderer.dart";

Element div = querySelector("#output");

String target = "alternia";

Future<Null> main() async {
    div.style.width = "100%";
    loadNavbar();
    StatFactory.initAllStats();
    SceneFactory.initScenes();
    if(getParameterByName("target") != null) {
        target = getParameterByName("target");
    }

    start();
}

Future<Null> start() async{
    List<GenericScene> toTest = await SceneFactory.slurpScenesInFileName(target);
    int id = -13;
    for(GenericScene s in toTest) {
        DivElement container = new DivElement();
        div.append(container);
        DivElement label = new DivElement()..text = s.text;
        container.append(label);
        s.drawCard(container, id);
    }
}