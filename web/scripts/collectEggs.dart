import 'dart:html';
import "LifeSimLib.dart";



void main() {
  StatFactory.initAllStats();
  SceneFactory.initScenes();
  testShit();
}

void testShit() {
  GenericScene gs = new GenericScene("Test Thing",<SVP>[new SVP(StatFactory.LIFESAUCE,-1*StatFactory.LIFESAUCE.maxValue), new SVP(StatFactory.SPOOK,StatFactory.SPOOK.maxValue)], "${GenericScene.OWNERNAME} helps me with this test. What's the worst that could happen?","THISISFINE.png",null, <GenericScene>[], triggerChance: 0.1, triggerStatsGreater:<SVP>[new SVP(StatFactory.JOBFLAKES,0)] );
  print(gs.toJSON());
}
