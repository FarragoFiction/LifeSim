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
      if(owner.rand.nextDouble() > triggerChance) return false;
      for(SVP svp in triggerStats) {
          if(!svp.triggered()) return false;
      }
      //made it through gauntlet of negativity
      return true;
  }

    @override
    Future<Null> renderContent(Element element, World w) async {
        for(SVP svp in triggerStats) {
            svp.apply(owner);
        }
        super.renderContent(element, w);
    }

}


//stat value pairs
class SVP

{
    Stat stat;
    //what threshold does it need to be at or how much do i add to it
    int value;
    SVP(Stat this.stat, int this.value);

    bool triggered() {
        return stat.value >= value;
    }

    void apply(Entity owner) {
        owner.addStat(stat, value);
    }
}