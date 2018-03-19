import "../LifeSimLib.dart";


class TakeKidToPark extends Scene {
    String backgroundName = "Perk.png";
    TakeKidToPark(owner) : super(owner);


    //should be bottom in list, only acitvates if nothing better to do.
  @override
  bool triggered() {
      if(owner.rand.nextDouble() > triggerChance) return false;
      if(owner.children.isNotEmpty) return true;
  }

  @override
  Future<Null> renderContent(Element element, World w) async {
      initOthers();
      text = "${owner.name} is a good parent.";
      owner.addStat(StatFactory.PARENTRITUDE, 1);
      super.renderContent(element, w);

  }

}