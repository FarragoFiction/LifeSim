import 'dart:html';
import "LifeSimLib.dart";


World world;
List<Scene> sceneCards = new List<Scene>();
List<Scene> chosenScenes = new List<Scene>();
Random rand;
Element div = querySelector("#output");
Element cardLibraryDiv;
Element preStory;
Element story;
Element protagLoader;
Element coinToss;
CanvasElement protagPreview;


void main() {
  loadNavbar();
  StatFactory.initAllStats();
  SceneFactory.initScenes();
  //if you care, can set the seed yourself later.
  rand = new Random();

  cardLibraryDiv = new DivElement();
  cardLibraryDiv.id = "cardLibrary"; //for humans
  cardLibraryDiv.text = "Choose Scenes to be possible in the Life of your Protagonist. Choose however many you want. Just remember that if you have too many, none will really finish.";

  preStory = new DivElement();
  preStory.id  = "preStory";

  story = new DivElement();
  story.id = "story";

  Entity protagonist = new Entity("${Entity.randomFirstName(rand)}","${Entity.randomLastName(rand)}", new SuperbSuckDoll(), rand, chosenScenes);

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
  chosenScenes = world.shuffleDeck(chosenScenes);
}

Future<Null> loadProtagDoll() async {
  CanvasElement tmp =  await world.protagonist.canvas;
  protagPreview.context2D.clearRect(0,0,protagPreview.width, protagPreview.height);
  protagPreview.context2D.drawImage(tmp,0,0);

}

void initCardLibrary() {
  sceneCards = CardLibrary.cards;
}

void grabSelectedCardsAndStart() {
  print("before selecting., there are ${chosenScenes}");

  List<Element> selected = querySelectorAll(".selectedCard");
  for(Element e in selected) {
    int id = int.parse(e.id.replaceAll("card", ""));
    chosenScenes.add(sceneCards[id]);
  }
  start();
}

//as opposed to a library card
Future<Null> displayCardLibrary() async {
  await Loader.preloadManifest();
  DivElement buttonHolder = new DivElement();
  ButtonElement button = new ButtonElement();
  button.text = "Start Life With Selected Cards";
  button.onClick.listen((e) => grabSelectedCardsAndStart());
  buttonHolder.append(button);
  cardLibraryDiv.append(buttonHolder);

  initCardLibrary();
  for(int i = 0; i<sceneCards.length; i++) {
      Scene s = sceneCards[i];
      s.drawCard(cardLibraryDiv, i);
  }
}

void pickCardsRandomly() {
  initCardLibrary();

  chosenScenes = new List<Scene>();
  for(int i=0; i<10; i++) {
    Scene chosen = rand.pickFrom(sceneCards);
    //print("adding a ${chosen.name} to the deck");
    chosenScenes.add(chosen);
  }
  //print("after adding, there are ${chosenScenes}");
}

void start() {
 // print("before starting., there are ${chosenScenes}");
  doCoinToss();
  preStory.style.display = "none";

  //print("before showing., there are ${chosenScenes}");
  world.protagonist.addAllHighPriorityScenes(chosenScenes);
  world.showDeck(chosenScenes);
  world.tick();
}
