import "../LifeSimLib.dart";

class GenericScene extends Scene {

    @override
    String backgroundName;

    //trigger stat must be above max
    List<SVP> triggerStats;
    //you get reward unit of this
    List<SVP> resultStats;
    @override
    String text;
    static String OWNERNAME = 'ownerenamer';

    GenericScene(List<SVP> this.triggerStats,List<SVP> this.resultStats, String this.text, String this.backgroundName, Entity owner) : super(owner);


  @override
  bool triggered() {
      //NEEDED BE CAUSE I DON'T HAVE AN OWNER AT CREATION TIME
      if(owner.rand.nextDouble() > triggerChance) return false;
      //TODO DO FOR LOOP ON SVP AND SEE IF THEY ARE ALL OKAY
      if(owner.hasStat(StatFactory.AGE) && StatFactory.AGE.value < StatFactory.AGE.maxValue/2) return true;
      return false;
  }

}


//stat value pairs
class SVP

{
    Stat stat;
    //what threshold does it need to be at or how much do i add to it
    int value;
    SVP(Stat this.stat, int this.value);
}