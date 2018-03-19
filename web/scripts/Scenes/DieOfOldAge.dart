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

      if(others.isNotEmpty) {
            return "They are mourned by ${Scene.turnArrayIntoHumanSentence(others)}";
      }
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