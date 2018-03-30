import 'dart:html';
import "LifeSimLib.dart";


World world;
List<Scene> sceneCards = new List<Scene>();
List<Scene> chosenScenes = new List<Scene>();
Random rand;
Element div = querySelector("#output");

void main() {
  loadNavbar();
  StatFactory.initAllStats();
  SceneFactory.initScenes();
  //if you care, can set the seed yourself later.
  rand = new Random();

}

