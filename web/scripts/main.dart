import 'dart:html';
import "LifeSimLib.dart";


World world;
List<Scene> sceneCards = new List<Scene>();

void main() {
  start();
}

void start() {
  Random rand = new Random();
  sceneCards.add(new GoToSchool(null));
  //sceneCards.add(new GetASpouse(null));
  sceneCards.add(SceneFactory.FIREMAN);
  sceneCards.add(SceneFactory.DOCTOR);
  //sceneCards.add(new BecomeAWaste(null));
  sceneCards.add(new BreakTheGame(null));
  sceneCards.add(new GetTrappedInAAttic(null));


  Entity protagonist = new Entity("${Entity.randomFirstName(rand)}","${Entity.randomLastName(rand)}", new SuperbSuckDoll(), rand, sceneCards);
  world = new World(rand, protagonist, querySelector("#output"));
  world.tick();
}
