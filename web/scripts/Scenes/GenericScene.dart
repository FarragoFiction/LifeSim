import "../LifeSimLib.dart";
import '../lz-string.dart';
import "dart:convert";


class GenericScene extends Scene {
    @override
    String backgroundName;

    //ALL of these must be true.
    List<SVP> triggerStatsGreater;
    List<SVP> triggerStatsLesser;
    //useful if you want it to only go once
    List<SVP> triggerStatsEqual;


    //you get reward unit of this
    List<SVP> resultStats;
    @override
    String text;

    @override
    double triggerChance;

    static String OWNERNAME = 'ownerenamer';
    //can't be a regular scene or can't serialize
    List<GenericScene> scenesToUnlock;

    @override
    String name;

    GenericScene(String this.name, List<SVP> this.resultStats, String this.text, String this.backgroundName, Entity owner, List<GenericScene> this.scenesToUnlock, {double this.triggerChance: 0.5,List<SVP> this.triggerStatsGreater,List<SVP> this.triggerStatsLesser, List<SVP>this.triggerStatsEqual }) : super(owner) {
        if(triggerStatsLesser == null) triggerStatsLesser = new List<SVP>();
        if(triggerStatsGreater == null) triggerStatsGreater = new List<SVP>();
        if(triggerStatsEqual == null) triggerStatsEqual = new List<SVP>();


        SceneFactory.allGenericScenes.add(this);
    }

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
      for(SVP svp in triggerStatsGreater) {
          if(!svp.triggeredGreater()) return false;
      }

      for(SVP svp in triggerStatsLesser) {
          if(!svp.triggeredLesser()) return false;
      }

      for(SVP svp in triggerStatsEqual) {
          if(!svp.triggeredEqual()) return false;
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
                    CardLibrary.addCard(s);
                }
            }
        }
        super.renderContent(element, w);
    }

    String toString() {
        return toJSON().toString();
    }

    String toDataString() {
        String json = toJSON().toString();
        return LZString.compressToEncodedURIComponent(json);
    }

    static GenericScene fromDataString(String string) {
        String json = LZString.decompressFromEncodedURIComponent(string);
        return GenericScene.fromJSON(new JSONObject.fromJSONString(json));
    }

    static GenericScene fromJSON(JSONObject json) {
        //    GenericScene(String this.name, List<SVP> this.resultStats, String this.text, String this.backgroundName, Entity owner, List<Scene> this.scenesToUnlock, {double this.triggerChance: 0.5,List<SVP> this.triggerStatsGreater,List<SVP> this.triggerStatsLesser }) : super(owner) {
        //print("the json object is $json");
        String name = json["name"];
        String text = json["text"];
        String bg = json["backgroundName"];
        double trigger = double.parse(json["triggerChance"]);
        GenericScene ret = new GenericScene(name, [], text, bg, null, [], triggerChance: trigger);
        ret.source = json["source"];

        String scenesToUnlockString = json["scenesToUnlock"];
        ret.loadScenesToUnlock(scenesToUnlockString);
        String resultStatsString = json["resultsStats"];
        ret.loadResultsSVPs(resultStatsString);
        String triggerStatsLesserString = json["triggerStatsLesser"];
        ret.loadLesserTriggers(triggerStatsLesserString);
        String triggerStatsGreater = json["triggerStatsGreater"];
        ret.loadGreaterTriggers(triggerStatsGreater);
        String triggerStatsEqual = json["triggerStatsEqual"];
        ret.loadEqualTriggers(triggerStatsEqual);
        return ret;
    }

    void loadScenesToUnlock(String weirdString) {
        List<dynamic> what = JSON.decode(weirdString);
        for(dynamic d in what) {
            //print("dynamic json thing is  $d");
            JSONObject j = new JSONObject();
            j.json = d;
            scenesToUnlock.add(GenericScene.fromJSON(j));
        }
    }

    void loadResultsSVPs(String weirdString) {
        List<dynamic> what = JSON.decode(weirdString);
        for(dynamic d in what) {
            //print("dynamic json thing is  $d");
            JSONObject j = new JSONObject();
            j.json = d;
            resultStats.add(SVP.fromJSON(j));
        }
    }

    void loadGreaterTriggers(String weirdString) {
        List<dynamic> what = JSON.decode(weirdString);
        for(dynamic d in what) {
            //print("dynamic json thing is  $d");
            JSONObject j = new JSONObject();
            j.json = d;
            triggerStatsGreater.add(SVP.fromJSON(j));
        }
    }


    void loadLesserTriggers(String weirdString) {
        List<dynamic> what = JSON.decode(weirdString);
        for(dynamic d in what) {
            //print("dynamic json thing is  $d");
            JSONObject j = new JSONObject();
            j.json = d;
            triggerStatsLesser.add(SVP.fromJSON(j));
        }
    }

    void loadEqualTriggers(String weirdString) {
        List<dynamic> what = JSON.decode(weirdString);
        for(dynamic d in what) {
            //print("dynamic json thing is  $d");
            JSONObject j = new JSONObject();
            j.json = d;
            triggerStatsEqual.add(SVP.fromJSON(j));
        }
    }

    JSONObject toJSON() {
        JSONObject json = new JSONObject();
        //    GenericScene(String this.name, List<SVP> this.resultStats, String this.text, String this.backgroundName, Entity owner, List<Scene> this.scenesToUnlock, {double this.triggerChance: 0.5,List<SVP> this.triggerStatsGreater,List<SVP> this.triggerStatsLesser }) : super(owner) {
        json["source"] = source;
        json["name"] = name;
        json["text"] = text;
        json["backgroundName"] = backgroundName;
        json["triggerChance"] = "$triggerChance";
        List<JSONObject> sceneArray = new List<JSONObject>();
        for(Scene s in scenesToUnlock) {
            if(s is GenericScene) sceneArray.add((s as GenericScene).toJSON());
        }
        json["scenesToUnlock"] = sceneArray.toString();

        List<JSONObject> resultStatsJSON = new List<JSONObject>();
        for(SVP s in resultStats) {
            resultStatsJSON.add(s.toJSON());
        }
        json["resultsStats"] = resultStatsJSON.toString();

        List<JSONObject> triggerStatsLesserJSON = new List<JSONObject>();
        for(SVP s in triggerStatsLesser) {
            triggerStatsLesserJSON.add(s.toJSON());
        }
        json["triggerStatsLesser"] = triggerStatsLesserJSON.toString();

        List<JSONObject> triggerStatsGreaterJSON = new List<JSONObject>();
        for(SVP s in triggerStatsGreater) {
            triggerStatsGreaterJSON.add(s.toJSON());
        }
        json["triggerStatsGreater"] = triggerStatsGreaterJSON.toString();

        List<JSONObject> triggerStatsEqual = new List<JSONObject>();
        for(SVP s in triggerStatsGreater) {
            triggerStatsGreaterJSON.add(s.toJSON());
        }
        json["triggerStatsEqual"] = triggerStatsEqual.toString();
        return json;
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
        int y = 290;
        String statsChecked = "";
        if(triggerStatsGreater.isNotEmpty) {
            statsChecked = "${Scene.turnArrayIntoHumanSentence(triggerStatsGreater)}";
        }

        if(triggerStatsLesser.isNotEmpty) {
            if(statsChecked.isNotEmpty) statsChecked = "$statsChecked , ";
            statsChecked = "${Scene.turnArrayIntoHumanSentence(triggerStatsLesser)}";
        }

        if(statsChecked.isEmpty) statsChecked == "None";

        int textBlockHeight = 40;

        canvas.context2D.fillText("Found: $source",textBlockHeight/2,textBlockHeight/2+8);

        Renderer.wrapTextAndResizeIfNeeded(canvas.context2D, "Stats Checked: $statsChecked", "Times New Roman", 40, y, fontSize, 250, textBlockHeight);
        y += textBlockHeight;
        if(resultStats.isNotEmpty) Renderer.wrapTextAndResizeIfNeeded(canvas.context2D, "Stats Modified: ${Scene.turnArrayIntoHumanSentence(resultStats)}", "Times New Roman", 40, y, fontSize, 250, textBlockHeight);
        if(scenesToUnlock.isNotEmpty) {
            y += textBlockHeight;
            Renderer.wrapTextAndResizeIfNeeded(canvas.context2D, "Scenes Unlocked: ${Scene.turnArrayIntoHumanSentence(scenesToUnlock)}", "Times New Roman", 40, y, fontSize, 250, textBlockHeight);
        }

    }



}


//stat value pairs
class SVP {
    Stat stat;

    //what threshold does it need to be at or how much do i add to it
    int value;

    SVP(Stat this.stat, int this.value);

    bool triggeredGreater() {
        return stat.value >= value;
    }

    bool triggeredLesser() {
        return stat.value > value;
    }

    bool triggeredEqual() {
        return stat.value == value;
    }

    void apply(Entity owner) {
        owner.addStat(stat, value);
    }

    String toString() {
        return "${stat.name}: ${value}";
    }

    JSONObject toJSON() {
        JSONObject json = new JSONObject();
        //don't need to store the stat, just the name
        json["name"] = stat.name;
        json["value"] = "$value";
        return json;
    }

    static SVP fromJSON(JSONObject json) {
        return new SVP(Stat.findStatWithName(json["name"]), int.parse(json["value"]));
    }

}