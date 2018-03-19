import "../LifeSimLib.dart";


class GetTrappedInAAttic extends Scene {
    @override
    String name = "Get Trapped In Attic";

    String backgroundName = "Attic.png";
    GetTrappedInAAttic(owner) : super(owner);


    //should be bottom in list, only acitvates if nothing better to do.
  @override
  bool triggered() {
      if(owner.rand.nextDouble() > triggerChance) return false;
      return StatFactory.GNOSIS.value >= StatFactory.GNOSIS.maxValue;
  }

  @override
  Future<Null> renderContent(Element element, World w) async {
      text = "Oh fuck, ${owner.name} is trapped in an attic and being terrified by this Spooky Wolf!";
      owner.addStat(StatFactory.SPOOK, 1);
      super.renderContent(element, w);
  }

}