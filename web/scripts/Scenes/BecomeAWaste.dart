import "../LifeSimLib.dart";


class BecomeAWaste extends Scene {
    @override
    double triggerChance = 0.75;
    String backgroundName = "LoRaSiguess.png";
    BecomeAWaste(owner) : super(owner);


    //should be bottom in list, only acitvates if nothing better to do.
  @override
  bool triggered() {
      if(owner.rand.nextDouble() > triggerChance) return false;
      return StatFactory.GNOSIS.value < StatFactory.GNOSIS.maxValue;
  }

  @override
  Future<Null> renderContent(Element element, World w) async {
      text = "${owner.name} is learning how to be a Waste. Huh. Uh. Is this supposed to be happening?";
      owner.addStat(StatFactory.GNOSIS, 1);
      super.renderContent(element, w);

  }

}