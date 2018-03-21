import "../LifeSimLib.dart";


class BeAHobo extends Scene {

    @override
    String description = "Lacking money, the Protagonist lives on the street and develops a prestigious SMELL WAVE meter.";
    @override
    Colour cardColor = StatFactory.SMELLWAVES.color;


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
      owner.addStat(StatFactory.SMELLWAVES, 3);
      owner.addStat(StatFactory.ESTEEM, -3);

      super.renderContent(element, w);

  }

}