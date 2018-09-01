import 'dart:html';
import "LifeSimLib.dart";
import 'dart:async';


Element div;

Element numberScenes;

void main() {
  loadNavbar();

  start();
  //CardLibrary.clearLibrary();
  //testShit();
  //testSaving();
  //testLoading();
}

Future<Null> start() async {
  await Loader.preloadManifest();
  div = querySelector("#output");
  StatFactory.initAllStats();
  SceneFactory.initScenes();
  numberScenes = new DivElement();
  div.append(numberScenes);
  syncNumberScenes();
  displayBox();
  displayFoundCards();

}

void displayBox() {
  DivElement container = new DivElement();
  container.text = "Any scenes you find throughout Farrago Fiction will automatically show up here.  You can enter them manually here, too. I wonder how you find their dataStrings to do this???";
  DivElement subContainer = new DivElement();
  TextAreaElement box = new TextAreaElement();
  subContainer.append(box);
  ButtonElement button = new ButtonElement();
  button.text = ("Load");
  subContainer.append(button);
  container.append(subContainer);
  div.append(container);

  button.onClick.listen((e) {
    processString(box.value);
  });
}

void   displayFoundCards() {
  List<GenericScene> foundCards = CardLibrary.foundCards;
  for(GenericScene s in foundCards) {
    displayNewScene(s);
    CardLibrary.addCard(s);
  }
  CardLibrary.clearFoundCards();
}

void processString(String s) {
  try {
    GenericScene scene = GenericScene.fromDataString(s);
    displayNewScene(scene);
  }catch(e) {
    DivElement error = new DivElement();
    error.text = "Look. I am proud that you're trying. But I don't recomend bullshiting theses. $s just isn't a scene.";
    div.append(error);
  }
}

Future<Null> displayNewScene(GenericScene scene) async {
  DivElement container = new DivElement();

  DivElement text = new DivElement();
  text.text = "You got a card: ${scene.name}!!!";
  DivElement picture = new DivElement();
  container.append(text);
  container.append(picture);
  div.append(container);

  CardLibrary.addCard(scene);
  syncNumberScenes();

  await scene.drawCard(picture, -13);

}

void syncNumberScenes() {
  numberScenes.text = "Number Cards In Library: ${CardLibrary.cards.length}";
}

void testSaving()
{
  GenericScene gs = new GenericScene("Test Thing", "${GenericScene.OWNERNAME} helps me with this test. What's the worst that could happen?","THISISFINE.png",null, triggerChance: 0.1, triggerStatsGreater:<SVP>[new SVP(StatFactory.JOBFLAKES,0)], resultStats: <SVP>[new SVP(StatFactory.LIFESAUCE,-1*StatFactory.LIFESAUCE.maxValue), new SVP(StatFactory.SPOOK,StatFactory.SPOOK.maxValue)] );
  CardLibrary.addCard(gs);
  CardLibrary.saveLibrary();
  div.text = "Saved. Probably.";
}

void testLoading() {
  List<Scene> scenes = CardLibrary.genericCards;
  for(Scene s in scenes) {
    DivElement d = new DivElement();
    if(s is GenericScene) {
      d.setInnerHtml("${s.toString()}<br><br>${s.toDataString()}");
    }else {
      d.text = s.toString();
    }
    div.append(d);
  }
}

void testShit() {
  GenericScene gs = new GenericScene("Test Thing", "${GenericScene.OWNERNAME} helps me with this test. What's the worst that could happen?","THISISFINE.png",null, triggerChance: 0.1, triggerStatsGreater:<SVP>[new SVP(StatFactory.JOBFLAKES,0)], resultStats: <SVP>[new SVP(StatFactory.LIFESAUCE,-1*StatFactory.LIFESAUCE.maxValue), new SVP(StatFactory.SPOOK,StatFactory.SPOOK.maxValue)] );

  String json = gs.toJSON().toString();
  div.appendHtml(json);

  DivElement d = new DivElement();
  d.text = gs.toDataString();
  div.append(d);


  DivElement d2 = new DivElement();
  GenericScene gs2= GenericScene.fromDataString(gs.toDataString());
  d2.text = gs2.toJSON().toString();
  div.append(d2);
}
