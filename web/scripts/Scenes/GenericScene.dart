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

    static String OWNERNAME = 'ownerenamer';
    List<Scene> scenesToUnlock;

    @override
    String name;

    GenericScene(String this.name, List<SVP> this.triggerStats,List<SVP> this.resultStats, String this.text, String this.backgroundName, Entity owner, List<Scene> this.scenesToUnlock, [double this.triggerChance = 0.5]) : super(owner);

    @override
    Colour get cardColor {
        if(resultStats.isNotEmpty) {
            return resultStats.first.stat.color;
        }else {
            return new Colour(255,255,255);
        }
    }

    @override
    String get description {
        String ret = "This scenes has the following results: ";
        if(resultStats.isNotEmpty) {
            ret += " Stats: ";
            for(SVP svp in resultStats) {
                ret += "${svp.stat.name}: ${svp.value} ,";
            }
        }
        if(scenesToUnlock.isNotEmpty) {
            ret += "Scenes: ";
            for(Scene s in scenesToUnlock) {
                ret += "${s.name} ,";
            }
        }
        return ret;
    }




  @override
  bool triggered() {
      //print("checking $backgroundName");
      if(owner.rand.nextDouble() > triggerChance) return false;
      for(SVP svp in triggerStats) {
          if(!svp.triggered()) return false;
      }
      //made it through gauntlet of negativity
      return true;
  }

    @override
    Future<Null> renderContent(Element element, World w) async {
       text =   text.replaceAll("$OWNERNAME", "${owner.name}");

       for(SVP svp in resultStats) {
            svp.apply(owner);
        }
        if(scenesToUnlock.isNotEmpty) {
            for(Scene s in scenesToUnlock) {
                if(!owner.scenes.contains(s)) {
                    owner.addHighPriorityScene(s);
                }
            }
        }
        super.renderContent(element, w);
    }

    Future<Null> drawCardRest(CanvasElement canvas) async {
        await Renderer.drawWhateverFuture(canvas, cardLocation);
        Renderer.swapColors(canvas, cardColor);
        ImageElement image = await Loader.getResource(("${Scene.bgStartLocation}$backgroundName"));
        //get rekt
        canvas.context2D.drawImageToRect(image, new Rectangle(31,34,260,210));
        int fontSize = 18;
        canvas.context2D.font = "${fontSize}px Times New Roman";
        canvas.context2D.fillText("$name",40,260);

        //Renderer.wrap_text(canvas.context2D, description,40, 290, fontSize, 220, "left");

        Renderer.wrapTextAndResizeIfNeeded(canvas.context2D, "Stats Modified: ${Scene.turnArrayIntoHumanSentence(resultStats)}", "Times New Roman", 40, 290, fontSize, 250, 134);
        if(scenesToUnlock.isNotEmpty) Renderer.wrapTextAndResizeIfNeeded(canvas.context2D, "Scenes Unlocked: ${Scene.turnArrayIntoHumanSentence(scenesToUnlock)}", "Times New Roman", 40, 350, fontSize, 250, 134);

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

    String toString() {
        return "${stat.name}: ${value}";
    }
}