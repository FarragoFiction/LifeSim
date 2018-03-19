import "../LifeSimLib.dart";

abstract class SceneFactory {

    //GenericScene(List<SVP> this.triggerStats,List<SVP> this.resultStats, String this.text, String this.backgroundName, Entity owner) : super(owner);
    static GenericScene DIEINFIRE = new GenericScene(<SVP>[new SVP(StatFactory.JOBFLAKES,0)],<SVP>[new SVP(StatFactory.LIFESAUCE,-1*StatFactory.LIFESAUCE.maxValue), new SVP(StatFactory.SPOOK,StatFactory.SPOOK.maxValue)], "${GenericScene.OWNERNAME} fails to put their job knowledge to practice, and dies in a fire.","THISISFINE.png",null, <Scene>[]);
    static GenericScene BEFIREHERO = new GenericScene(<SVP>[new SVP(StatFactory.JOBFLAKES,StatFactory.JOBFLAKES.maxValue)],<SVP>[new SVP(StatFactory.ESTEEM,3), new SVP(StatFactory.COMMERCE,20)], "${GenericScene.OWNERNAME} fights a terrible fire and is the hero of the hour.","THISISFINE.png",null, <Scene>[]);

    static GenericScene KILLAPATIENT = new GenericScene(<SVP>[new SVP(StatFactory.JOBFLAKES,0)],<SVP>[new SVP(StatFactory.COMMERCE,-5), new SVP(StatFactory.ESTEEM,-1*StatFactory.ESTEEM.maxValue)], "${GenericScene.OWNERNAME} fails to put their job knowledge to practice, and loses a patient through terrible incompetance.","Hospitalbed.png.png",null, <Scene>[]);
    static GenericScene SAVEAPATIENT = new GenericScene(<SVP>[new SVP(StatFactory.JOBFLAKES,StatFactory.JOBFLAKES.maxValue)],<SVP>[new SVP(StatFactory.ESTEEM,3), new SVP(StatFactory.COMMERCE,20)], "${GenericScene.OWNERNAME} spends 18 hours straight doing everything they can and save a patients life.","Hospitalbed.png.png",null, <Scene>[]);

    static GenericScene FIREMAN = new GenericScene(<SVP>[new SVP(StatFactory.GRADEMOXY,1)],<SVP>[new SVP(StatFactory.JOBFLAKES,1), new SVP(StatFactory.COMMERCE,2)], "${GenericScene.OWNERNAME} works hard as a firefighter, saving lives.","Firestation.png",null, <Scene>[DIEINFIRE,BEFIREHERO]);
    static GenericScene DOCTOR = new GenericScene(<SVP>[new SVP(StatFactory.GRADEMOXY,StatFactory.GRADEMOXY.maxValue)],<SVP>[new SVP(StatFactory.JOBFLAKES,1), new SVP(StatFactory.COMMERCE,4)], "${GenericScene.OWNERNAME} works hard as a doctor, saving lives.","Hospital.png",null, <Scene>[KILLAPATIENT, SAVEAPATIENT]);
}