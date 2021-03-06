import "../LifeSimLib.dart";
import "package:CommonLib/Colours.dart";

class TakeKidToPark extends Scene {


    @override
    String name = "Take Kid To Park";
    @override
    String description = "The Protagonist spends time with their many and various OFFSPRING. ";
    @override
    Colour cardColor = StatFactory.PARENTRITUDE.color;

    @override
    int id = -143;


    String backgroundName = "Perk.png";
    TakeKidToPark(owner) : super(owner);


    //should be bottom in list, only acitvates if nothing better to do.
  @override
  bool triggered() {
      if(owner.rand.nextDouble() > triggerChance) return false;
      if(owner.children.isNotEmpty) return true;
      return false;
  }

  @override
  Future<Null> renderContent(Element element, World w) async {
      initOthers();
      text = "${owner.name} is a good parent.";
      owner.addStatLater(StatFactory.PARENTRITUDE, 1);
      super.renderContent(element, w);

  }

}