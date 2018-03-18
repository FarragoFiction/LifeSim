import 'dart:html';
import "LifeSimLib.dart";


World world;
List<Scene> sceneCards = new List<Scene>();

void main() {

}

void start() {
  Entity protagonist = new Entity("Jimbo","Herst", new SuperbSuckDoll(), sceneCards);
  world = new World(protagonist, querySelector("#output"));
  world.tick();
}
