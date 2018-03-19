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

    @override
    double triggerChance;

    //will you die in this scene?
    bool die;

    static String OWNERNAME = 'ownerenamer';
    List<Scene> scenesToUnlock;

    GenericScene(List<SVP> this.triggerStats,List<SVP> this.resultStats, String this.text, String this.backgroundName, Entity owner, List<Scene> this.scenesToUnlock, [double this.triggerChance = 0.5, bool die = false]) : super(owner);


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
        if(scenesToUnlock.isNotEmpty) {
            for(Scene s in scenesToUnlock) {
                if(!owner.scenes.contains(s)) {
                    owner.addHighPriorityScene(s);
                }
            }
        }
        if(die) owner.dead = true;
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