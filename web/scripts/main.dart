import 'dart:html';
import "LifeSimLib.dart";


World world;
List<Scene> sceneCards = new List<Scene>();
List<Scene> chosenScenes = new List<Scene>();
Random rand;
Element div = querySelector("#output");
Element cardLibrary;
Element story;

void main() {
  //if you care, can set the seed yourself later.
  rand = new Random();
  cardLibrary = new DivElement();
  cardLibrary.id = "cardLibrary"; //for humans

  story = new DivElement();
  story.id = "story";

  div.append(cardLibrary);
  div.append(story);

  displayCardLibrary();
  pickCardsRandomly();
 // start();
}

void initCardLibrary() {
  sceneCards.add(new GetASpouse(null));
  sceneCards.add(new BecomeAWaste(null));
  sceneCards.add(new BeAHobo(null));
  sceneCards.add(new DickAround(null));
  sceneCards.add(new Die(null));
  sceneCards.add(new GetAKid(null));
  sceneCards.add(new GoOnDates(null));
  sceneCards.add(new GoToSchool(null));
  sceneCards.add(new TakeKidToPark(null));
  sceneCards.add(new BreakTheGame(null));
  sceneCards.add(new GetTrappedInAAttic(null));
  sceneCards.addAll(SceneFactory.allGenericScenes);
}

//as opposed to a library card
Future<Null> displayCardLibrary() async {
  await Loader.preloadManifest();

  print("card library");
  initCardLibrary();
  for(int i = 0; i<sceneCards.length; i++) {
      Scene s = sceneCards[i];
      s.drawCard(div, i);
  }
}

void pickCardsRandomly() {
  initCardLibrary();

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
  world = new World(rand, protagonist, story);
  print("before showing., there are ${chosenScenes}");

  world.showDeck(chosenScenes);
  world.tick();
}
