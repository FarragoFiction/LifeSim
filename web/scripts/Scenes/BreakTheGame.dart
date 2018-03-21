import "../LifeSimLib.dart";


class BreakTheGame extends Scene {


    @override
    String description = "Fucking Wastes. Stay out of my game!";
    @override
    Colour cardColor = StatFactory.GNOSIS.color;

    @override
    String name = "Break the Game";

    String backgroundName = "404pagebecauseecch.png";
    BreakTheGame(owner) : super(owner);


    //should be bottom in list, only acitvates if nothing better to do.
  @override
  bool triggered() {
      if(owner.rand.nextDouble() >= triggerChance) return false;
      return StatFactory.GNOSIS.value >= StatFactory.GNOSIS.maxValue;
  }

  @override
  Future<Null> renderContent(Element element, World w) async {
      initOthers();
      text = "Uh. Is ${owner.name} supposed to be.... Fuck.";
      super.renderContent(element, w);
      throw("whoops");
  }

}