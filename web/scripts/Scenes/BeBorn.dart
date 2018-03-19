import "../LifeSimLib.dart";


class BeBorn extends Scene {
    String backgroundName = "Hospital.png";
  BeBorn(owner) : super(owner);


  @override
  bool triggered() {
      if(owner.hasStat(StatFactory.AGE) && StatFactory.AGE.value == 0) return true;
      return false;
  }

  @override
  Future<Null> renderContent(Element element, World w) async {
      text = "${owner.name} is born. This has made a lot of people very angry and been widely regarded as a bad move.";
      super.renderContent(element, w);
  }

}