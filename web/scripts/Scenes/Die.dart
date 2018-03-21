import "../LifeSimLib.dart";


class Die extends Scene {

    @override
    String name = "Die of Old Age";
    @override
    String description = "The Protagonist dies, their epitaph is written.";
    @override
    Colour cardColor = StatFactory.AGE.color;


    String backgroundName = "SomeoneFuckinDied.png";
    Die(owner) : super(owner);


  @override
  bool triggered() {
      if(StatFactory.AGE.value > StatFactory.AGE.maxValue) return true;
      if(StatFactory.LIFESAUCE.value <= 0) return true;
      return false;
  }

  String epitaph() {
      String ret = "";
      for(Stat s in owner.readOnlyStats) {
          if(s.value >= 3*s.maxValue/4) {
              ret = "$ret ${s.epitaphSentence}";
          }
      }

      if(others.isNotEmpty) {
            ret =  "$ret They are mourned by ${Scene.turnArrayIntoHumanSentence(others)}";
      }
      if(ret.isNotEmpty) return ret;

      return "DIDN'T ACOMPLISH MUCH OF ANYTHING.";
  }

  @override
  Future<Null> renderContent(Element element, World w) async {
      initOthers();

      print("seriously, make their tombstone dynamic and a canvas");
      text = "${owner.name} has finally died. Their tombstone reads: ${epitaph()}";
      w.ended = true;
      owner.dead = true;
      owner.canvasDirty = true;
      super.renderContent(element, w);
  }

}