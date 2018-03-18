import 'dart:html';
import "LifeSimLib.dart";


World world;
List<Scene> sceneCards = new List<Scene>();

void main() {
  start();
}

void start() {
  Random rand = new Random();
  Entity protagonist = new Entity("${Entity.randomFirstName(rand)}","${Entity.randomLastName(rand)}", new SuperbSuckDoll(), sceneCards);
  world = new World(rand, protagonist, querySelector("#output"));
  world.tick();
}
