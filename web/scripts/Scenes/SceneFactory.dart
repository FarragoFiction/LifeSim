import "../LifeSimLib.dart";

abstract class SceneFactory {

    //GenericScene(List<SVP> this.triggerStats,List<SVP> this.resultStats, String this.text, String this.backgroundName, Entity owner) : super(owner);

    static GenericScene FIREMAN = new GenericScene(<SVP>[new SVP(StatFactory.GRADEMOXY,1)],<SVP>[new SVP(StatFactory.JOBFLAKES,1), new SVP(StatFactory.COMMERCE,2)], "${GenericScene.OWNERNAME} works hard as a firefighter, saving lives.","Firestation.png",null);
    static GenericScene DOCTOR = new GenericScene(<SVP>[new SVP(StatFactory.GRADEMOXY,StatFactory.GRADEMOXY.maxValue)],<SVP>[new SVP(StatFactory.JOBFLAKES,1), new SVP(StatFactory.COMMERCE,4)], "${GenericScene.OWNERNAME} works hard as a doctor, saving lives.","Hospital.png",null);
}