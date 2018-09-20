import 'Deck.dart';
import 'dart:html';
import "LifeSimLib.dart";


World world;
List<Scene> sceneCards = new List<Scene>();

Map<int,Scene> chosenScenes = new Map<int,Scene>();
Random rand;
Element div = querySelector("#output");
Element cardLibraryDiv;
Element preStory;
Element story;
Element protagLoader;
Element coinToss;
CanvasElement protagPreview;
List<CanvasElement> cardCanvases = new List<CanvasElement>();
TextInputElement search;


void main() {
  div.style.width = "100%";
  loadNavbar();
  StatFactory.initAllStats();
  SceneFactory.initScenes();
  //if you care, can set the seed yourself later.
  rand = new Random();

  cardLibraryDiv = new DivElement();
  cardLibraryDiv.style.width = "100%";
  cardLibraryDiv.id = "cardLibrary"; //for humans
  cardLibraryDiv.text = "";

  preStory = new DivElement();
  preStory.id  = "preStory";

  story = new DivElement();
  story.id = "story";
  story.style.width = "1000px";

  Entity protagonist = new Entity("${Entity.randomFirstName(rand)}","${Entity.randomLastName(rand)}", new SuperbSuckDoll(), rand, chosenScenes.values);

  world = new World(rand, protagonist, story);

  protagLoader = new DivElement();
  protagLoader.id  = "protagLoader";

  coinToss = new DivElement();
  coinToss.id  = "protagLoader";

  preStory.append(protagLoader);
  preStory.append(cardLibraryDiv);
  div.append(preStory);
  div.append(story);
  story.append(coinToss);

  displayProtagLoader();
  displayDeckLibrary();
  displayCardLibrary();
  //pickCardsRandomly();
 // start();
}



Future<Null>  displayProtagLoader() async{

  protagPreview = await world.protagonist.canvas;
  DivElement nameLabel = new DivElement();
  nameLabel.text = "Name: ";
  TextInputElement firstName = new TextInputElement();
  firstName.value = world.protagonist.firstName;
  nameLabel.append(firstName);

  TextInputElement lastName = new TextInputElement();
  lastName.value = world.protagonist.lastName;
  nameLabel.append(lastName);

  DivElement dollStringLabel = new DivElement();
  dollStringLabel.text = "Data String: ";
  TextAreaElement dollString = new TextAreaElement();
  dollString.value = world.protagonist.doll.toDataBytesX();
  dollStringLabel.append(dollString);

  ButtonElement button = new ButtonElement();
  button.text = ("Load Changes");
  button.onClick.listen((e) {
    String  newdataString = dollString.value;
    if(newdataString != world.protagonist.doll.toDataBytesX()) {
      world.protagonist.doll = Doll.loadSpecificDoll(newdataString);
      world.protagonist.canvasDirty = true;
      loadProtagDoll();
    }

    world.protagonist.firstName = firstName.value;
    world.protagonist.lastName = lastName.value;
  });

  protagLoader.classes.add("protagLoader");
  protagLoader.append(protagPreview);
  protagLoader.append(nameLabel);
  protagLoader.append(dollStringLabel);
  protagLoader.append(button);
}

//decides which of two seeds to use: 0 or 1.
//means if you have the exact same cards the sim can only go one of two ways, instead of night infinite
void doCoinToss() {
  ImageElement img;
  //noo one ever said it was a fair coin
  double flip =   rand.nextDouble();
  print("flip was $flip");
  if(flip <0.87){ //100-13
    world.rand = new Random(0);
    img = new ImageElement(src: "images/sniperZeeABJCoinHmm.png");
    coinToss.text = "The coin flip decides: Hrmmm... ";
  }else{
    world.rand = new Random(1);
    //it's interesting by virtue of being rarer
    coinToss.text = "The coin flip decides: Interesting!!!";
    img = new ImageElement(src: "images/sniperZeeABJCoinInteresting.png");
  }
  world.protagonist.rand = world.rand;
  coinToss.append(img);
  //shuffled after aligning to one of two timelines
}

Future<Null> loadProtagDoll() async {
  CanvasElement tmp =  await world.protagonist.canvas;
  protagPreview.context2D.clearRect(0,0,protagPreview.width, protagPreview.height);
  protagPreview.context2D.drawImage(tmp,0,0);

}

void initCardLibrary() {
  sceneCards = CardLibrary.cards;
  //sceneCards = new List.from(CardLibrary.cardsWithSearchTerm("thot"));
}

//TODO redo this entierly, no more cards on screen
void grabSelectedCardsAndStartOld() {
  print("before selecting., there are ${chosenScenes}");

  List<Element> selected = querySelectorAll(".selectedCard");
  for(Element e in selected) {
    int id = int.parse(e.id.replaceAll("card", ""));
    chosenScenes[id] =sceneCards[id];
  }
  //start();
}

//combination of old and new, for now
void grabSelectedCardsAndStart() {
  grabSelectedCardsAndStartOld();
  print("before selecting., there are ${chosenScenes.values.length}");
  start();
}

void selectAllCards() {
  print("select all cards");
  for(CanvasElement canvas in cardCanvases) {
      canvas.classes.add('selectedCard');
      canvas.classes.remove('unSelectedCard');

  }
}

void selectNoCards() {
  print("select no cards");
  for(CanvasElement canvas in cardCanvases) {
      canvas.classes.add('unSelectedCard');
      canvas.classes.remove('selectedCard');
  }
}

void selectRandomCards() {
  print("select random cards");
  Random rand = new Random();
  rand.nextInt();
  for(CanvasElement canvas in cardCanvases) {
    if (rand.nextBool()) {
      canvas.classes.add('selectedCard');
      canvas.classes.remove('unSelectedCard');
    } else {
      canvas.classes.add('unSelectedCard');
      canvas.classes.remove('selectedCard');
    }
  }
}

Future<Null> displayDeckLibrary() async {
  await Loader.preloadManifest();
  DivElement selectedHolder = new DivElement()..text = "0 Cards Selected";

  DivElement buttonHolder = new DivElement();
  ButtonElement button = new ButtonElement();
  button.style.display = "block";
  button.text = "Start Life With Selected Cards";
  button.onClick.listen((e) => grabSelectedCardsAndStart());


  buttonHolder.append(button);
  cardLibraryDiv.append(selectedHolder);
  cardLibraryDiv.append(buttonHolder);

  Deck.drawDecksToSelect(cardLibraryDiv, selectedHolder, chosenScenes);


}

//as opposed to a library card
Future<Null> displayCardLibrary() async {
  await Loader.preloadManifest();
  DivElement buttonHolder = new DivElement();
  ButtonElement button = new ButtonElement();
  button.style.display = "block";
  button.text = "Start Life With Selected Cards";
  button.onClick.listen((e) => grabSelectedCardsAndStart());


  ButtonElement buttonAll = new ButtonElement();
  buttonAll.text = "Select All Cards";
  buttonAll.onClick.listen((e) => selectAllCards());

  DivElement searchContainer = new DivElement();
  searchContainer.text = "Search Cards: ";
  search = new TextInputElement();
  searchContainer.append(search);
  cardLibraryDiv.append(searchContainer);
  search.onInput.listen((e) => searchCards());


  ButtonElement buttonNone = new ButtonElement();
  buttonNone.text = "Select No Cards";
  buttonNone.onClick.listen((e) => selectNoCards());

  ButtonElement buttonRandom = new ButtonElement();
  buttonRandom.text = "Select Random Cards";
  buttonRandom.onClick.listen((e) => selectRandomCards());

  buttonHolder.append(button);
  buttonHolder.append(buttonAll);
  buttonHolder.append(buttonNone);
  buttonHolder.append(buttonRandom);

  cardLibraryDiv.append(buttonHolder);

  initCardLibrary();
  for(int i = 0; i<sceneCards.length; i++) {
      Scene s = sceneCards[i];
      DivElement span = new DivElement();
      span.style.display = "inline-block";
      cardLibraryDiv.append(span);
      CanvasElement c = await s.drawCard(span, i);
      cardCanvases.add(c);
      if(s is GenericScene) s.drawSellButton(span);
  }
}

void searchCards() {
  String term = search.value;
  print("searching for prices and  $term ");
  /*
    List<Element> selected = querySelectorAll(".selectedCard");
  for(Element e in selected) {
    int id = int.parse(e.id.replaceAll("card", ""));
    chosenScenes.add(sceneCards[id]);

   */

  Set<Scene> searchedSet = CardLibrary.cardsWithSearchTerm(term);
  //need to go through the scene cards one by one and turn on or off based on existance in this set.
  for(int i = 0; i<sceneCards.length; i++) {
    Scene s = sceneCards[i];
    Element found = querySelector("#card${i}");
    if(found != null) { //if you sell it it will be null.

      if (searchedSet.contains(s)) {
        found.classes.remove("invisibleCard");
        if (found.parent != null) {
          found.parent.children.forEach((f) {
            f.classes.remove("invisibleCard");
          });
        }
      } else {
        found.classes.add("invisibleCard");
        if (found.parent != null) {
          found.parent.children.forEach((f) {
            f.classes.add("invisibleCard");
          });
        }
      }
    }
  }

}



void start() {
  div.style.width = "1000px";
 // print("before starting., there are ${chosenScenes}");
  doCoinToss();
  preStory.style.display = "none";

  //print("before showing., there are ${chosenScenes}
  //shuffling post coin toss means the order is coin toss aligned
  List<Scene> tmp = new List<Scene>.from(chosenScenes.values);
  tmp = world.shuffleDeck(tmp);

  world.protagonist.addAllHighPriorityScenes(tmp);
  world.showDeck(tmp);
  world.tick();
}
