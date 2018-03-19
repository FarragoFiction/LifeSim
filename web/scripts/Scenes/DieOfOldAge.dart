import "../LifeSimLib.dart";


class DieOfOldAge extends Scene {
    String backgroundName = "SomeoneFuckinDied.png";
    DieOfOldAge(owner) : super(owner);


  @override
  bool triggered() {
      if(owner.hasStat(StatFactory.LIFESAUCE)){
          if(StatFactory.AGE.value > StatFactory.AGE.maxValue) return true;
      }
      //literally immortal, somehow.
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
      text = "${owner.name} has finally died of old age. Their tombstone reads: ${epitaph()}";
      w.ended = true;
      owner.dead = true;
      owner.canvasDirty = true;
      super.renderContent(element, w);
  }

}