import "../LifeSimLib.dart";


class DieOfOldAge extends Scene {
    String backgroundName = "SomeoneFuckinDied.png";
    DieOfOldAge(owner) : super(owner);


  @override
  bool triggered() {
    if(owner.age > Entity.maxValue) return true;
    return false;
  }

  @override
  Future<Null> renderContent(Element element, World w) async {
      print("seriously, make their tombstone dynamic and a canvas");
      text = "The ${owner.name} has finally died of old age. Their tombstone reads: DIDN'T ACOMPLISH MUCH OF ANYTHING.";
      w.ended = true;
      super.renderContent(element, w);
  }

}