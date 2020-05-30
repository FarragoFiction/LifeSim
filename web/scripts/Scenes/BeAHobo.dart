import "../LifeSimLib.dart";
import "package:CommonLib/Colours.dart";

class BeAHobo extends Scene {
    @override
    String name = "Be a Hobo";
    @override
    String description = "Lacking money, the Protagonist lives on the street and develops a prestigious SMELL WAVE meter.";
    @override
    Colour cardColor = StatFactory.SMELLWAVES.color;

    @override
    int id = -133;


    @override
    double triggerChance = 0.9;
    String backgroundName = "GetInTheBoxObserver.png";
    BeAHobo(owner) : super(owner);


    //should be bottom in list, only acitvates if nothing better to do.
  @override
  bool triggered() {
    return owner.hasStat(StatFactory.COMMERCE) && StatFactory.COMMERCE.value <= 0;
  }

  @override
  Future<Null> renderContent(Element element, World w) async {
      initOthers();
      text = "${owner.name} is destitute.";
      owner.addStatLater(StatFactory.SMELLWAVES, 3);
      owner.addStatLater(StatFactory.ESTEEM, -3);

      super.renderContent(element, w);

  }

}