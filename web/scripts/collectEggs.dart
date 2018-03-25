import 'dart:html';
import "LifeSimLib.dart";


Element div;

void main() {
  div = querySelector("#output");
  StatFactory.initAllStats();
  SceneFactory.initScenes();
  //testShit();
  //testSaving();
  testLoading();
}

void testSaving()
{
  GenericScene gs = new GenericScene("Test Thing",<SVP>[new SVP(StatFactory.LIFESAUCE,-1*StatFactory.LIFESAUCE.maxValue), new SVP(StatFactory.SPOOK,StatFactory.SPOOK.maxValue)], "${GenericScene.OWNERNAME} helps me with this test. What's the worst that could happen?","THISISFINE.png",null, <GenericScene>[], triggerChance: 0.1, triggerStatsGreater:<SVP>[new SVP(StatFactory.JOBFLAKES,0)] );
  CardLibrary.addCard(gs);
  CardLibrary.saveLibrary();
  div.text = "Saved. Probably.";
}

void testLoading() {
  List<Scene> scenes = CardLibrary.cards;
  for(Scene s in scenes) {
    DivElement d = new DivElement();
    d.text = s.toString();
    div.append(d);
  }
}

void testShit() {
  GenericScene gs = new GenericScene("Test Thing",<SVP>[new SVP(StatFactory.LIFESAUCE,-1*StatFactory.LIFESAUCE.maxValue), new SVP(StatFactory.SPOOK,StatFactory.SPOOK.maxValue)], "${GenericScene.OWNERNAME} helps me with this test. What's the worst that could happen?","THISISFINE.png",null, <GenericScene>[], triggerChance: 0.1, triggerStatsGreater:<SVP>[new SVP(StatFactory.JOBFLAKES,0)] );

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
