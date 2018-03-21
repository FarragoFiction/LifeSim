import "../LifeSimLib.dart";


class DickAround extends Scene {

    @override
    String description = "The Protagonist doesn't do very much at all.";
    @override
    Colour cardColor = StatFactory.JOBFLAKES.color;


    String backgroundName = "City.png";
    DickAround(owner) : super(owner);


    //should be bottom in list, only acitvates if nothing better to do.
  @override
  bool triggered() {
    return true;
  }

  @override
  Future<Null> renderContent(Element element, World w) async {
      initOthers();
      text = "${owner.name} completely wastes their time in this life.";
      super.renderContent(element, w);

  }

}