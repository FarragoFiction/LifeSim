import "../LifeSimLib.dart";


class GoToSchool extends Scene {
    String backgroundName = "Skule.png";
    @override
    double triggerChance = 0.75;
    GoToSchool(owner) : super(owner);


    //should be bottom in list, only acitvates if nothing better to do.
  @override
  bool triggered() {
      if(owner.rand.nextDouble() > triggerChance) return false;
      if(owner.hasStat(StatFactory.AGE) && StatFactory.AGE.value < StatFactory.AGE.maxValue/2) return true;
      return false;
  }

  @override
  Future<Null> renderContent(Element element, World w) async {
      text = "${owner.name} does a school.";
      owner.addStat(StatFactory.GRADITUDE, 1);
      super.renderContent(element, w);
  }

}