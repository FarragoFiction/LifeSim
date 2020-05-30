import "../LifeSimLib.dart";
import "package:CommonLib/Colours.dart";

class BeCulled extends Scene {

    @override
    String name = "Be Culled";
    @override
    String description = "The Protagonist dies, whether of natural causes or culling, their epitaph is written.";
    @override
    Colour cardColor = StatFactory.AGE.color;

    @override
    int id = -134;


    String backgroundName = "AlterniaCulled.png";
    BeCulled(owner) : super(owner);


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
      text = "${owner.name} has finally died. History notes: ${epitaph()} <br><br>This is definitely way better than '${owner.epilogue}', you are suddenly sure of it.";
      w.ended = true;
      owner.dead = true;
      owner.canvasDirty = true;
      super.renderContent(element, w);
  }

}