import 'dart:html';
import "LifeSimLib.dart";


World world;

void main() {
  Entity protagonist = new Entity("Jimbo","Herst", new SuperbSuckDoll());
  world = new World(protagonist, querySelector("#output"));
}
