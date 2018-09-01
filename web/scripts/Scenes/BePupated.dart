import "../LifeSimLib.dart";


class BePupated extends Scene {
    String backgroundName = "AlterniaBroodingCaverns.png";
    BePupated(owner) : super(owner);
    @override
    String description = "The Protagonist begins life post brooding caverns.";
    @override
    Colour cardColor = StatFactory.LIFESAUCE.color;

    @override
    int id = -135;

  @override
  bool triggered() {
      if(owner.hasStat(StatFactory.AGE) && StatFactory.AGE.value == 0) return true;
      return false;
  }

  @override
  Future<Null> renderContent(Element element, World w) async {
      text = "${owner.name} has survived the Brooding Caverns. What will they do next?";
      super.renderContent(element, w);
  }

}