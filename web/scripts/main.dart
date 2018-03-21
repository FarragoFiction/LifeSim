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
  cardLibrary.text = "Choose Scenes to be possible in the Life of your Protagonist. Choose however many you want. Just remember that if you have too many, none will really finish.";

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

void grabSelectedCardsAndStart() {
  List<Element> selected = querySelectorAll(".selectedCard");
  String text = "${selected.length} selected: ";
  for(Element e in selected) {
    int id = int.parse(e.id.replaceAll("card", ""));
    text += "${sceneCards[id]},";
  }
  window.alert(text);

}

//as opposed to a library card
Future<Null> displayCardLibrary() async {
  await Loader.preloadManifest();
  DivElement buttonHolder = new DivElement();
  ButtonElement button = new ButtonElement();
  button.text = "Start Life With Selected Cards";
  button.onClick.listen((e) => grabSelectedCardsAndStart());
  buttonHolder.append(button);
  cardLibrary.append(buttonHolder);

  print("card library");
  initCardLibrary();
  for(int i = 0; i<sceneCards.length; i++) {
      Scene s = sceneCards[i];
      s.drawCard(cardLibrary, i);
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
