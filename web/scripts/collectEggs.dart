import 'dart:html';
import "LifeSimLib.dart";


Element div;

void main() {
  div = querySelector("#output");
  StatFactory.initAllStats();
  SceneFactory.initScenes();
  testShit();
}

void testShit() {
  GenericScene gs = new GenericScene("Test Thing",<SVP>[new SVP(StatFactory.LIFESAUCE,-1*StatFactory.LIFESAUCE.maxValue), new SVP(StatFactory.SPOOK,StatFactory.SPOOK.maxValue)], "${GenericScene.OWNERNAME} helps me with this test. What's the worst that could happen?","THISISFINE.png",null, <GenericScene>[], triggerChance: 0.1, triggerStatsGreater:<SVP>[new SVP(StatFactory.JOBFLAKES,0)] );
  div.appendHtml(gs.toJSON().toString());

  DivElement d = new DivElement();
  d.text = gs.toDataString();
  div.append(d);
}
