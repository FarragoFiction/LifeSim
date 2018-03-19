import 'dart:html';
import "LifeSimLib.dart";


World world;
List<Scene> sceneCards = new List<Scene>();
List<Scene> chosenScenes = new List<Scene>();
Random rand;

void main() {
  //if you care, can set the seed yourself later.
  rand = new Random();
  pickCardsRandomly();
  start();
}

void pickCardsRandomly() {
  sceneCards.add(new GetASpouse(null));
  sceneCards.add(new BecomeAWaste(null));
  sceneCards.add(new BreakTheGame(null));
  sceneCards.add(new GetTrappedInAAttic(null));
  sceneCards.addAll(SceneFactory.allGenericScenes);

  chosenScenes = new List<Scene>();
  for(int i=0; i<10; i++) {
    Scene chosen = rand.pickFrom(sceneCards);
    print("adding a ${chosen.name} to the deck");
    chosenScenes.add(chosen);
  }
  print("after adding, there are ${chosenScenes}");
}

void start() {
  Entity protagonist = new Entity("${Entity.randomFirstName(rand)}","${Entity.randomLastName(rand)}", new SuperbSuckDoll(), rand, chosenScenes);
  world = new World(rand, protagonist, querySelector("#output"));
  print("before showing., there are ${chosenScenes}");

  world.showDeck(chosenScenes);
  world.tick();
}
