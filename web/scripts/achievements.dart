import 'dart:html';
import "LifeSimLib.dart";


Random rand;
Element div = querySelector("#output");

void main() {
  loadNavbar();
  div.style.width = "100%";
  StatFactory.initAllStats();
  SceneFactory.initScenes();
  //if you care, can set the seed yourself later.
  rand = new Random();
  ButtonElement button = new ButtonElement();
  button.text = "Clear Viewed Scenes?";
  button.onClick.listen((e) {
    if(window.confirm("You can't undo this. Clear Viewed Scenes?")){
      CardLibrary.clearViewedScenes();
      window.location.href = window.location.href;
    }
  });
  div.append(button);
  displayAchievements();

}

Future<Null> displayAchievements() async {
  Set<String> scenes = CardLibrary.viewedScenes;
  List<String> debug = new List<String>();
  if(scenes.isEmpty) {
    DivElement inner = new DivElement();
    inner.setInnerHtml("No Scenes Viewed Yet Beyond Base Ones.");
    div.append(inner);
  }
  DivElement inner = new DivElement();
  inner.setInnerHtml("${scenes.length} Unique Scenes Viewed<br><br>");
  div.append(inner);
  for(String s in scenes) {
    GenericScene scene = GenericScene.fromDataString(s);
    if (scene != null) {
      if (debug.contains(s)) {
        //print("I have seen $scene before.");
      } else {
        //print("I have not seen $scene before");
      }

      if (scene.name.contains("Crimes")) {
        print("Crimes Scene is: ${scene.text}");
      }
      debug.add(s);
      scene.drawCard(inner, -13);
    }
  }
}