import "../LifeSimLib.dart";

abstract class SceneFactory {
    //the simplicity of this pleases me so damn much

    //GenericScene(List<SVP> this.triggerStats,List<SVP> this.resultStats, String this.text, String this.backgroundName, Entity owner) : super(owner);
    static GenericScene DIEINFIRE = new GenericScene("Die in a Fire",<SVP>[new SVP(StatFactory.LIFESAUCE,-1*StatFactory.LIFESAUCE.maxValue), new SVP(StatFactory.SPOOK,StatFactory.SPOOK.maxValue)], "${GenericScene.OWNERNAME} fails to put their job knowledge to practice, and dies in a fire.","THISISFINE.png",null, <Scene>[], triggerChance: 0.1, triggerStatsGreater:<SVP>[new SVP(StatFactory.JOBFLAKES,0)] );
    static GenericScene BEFIREHERO = new GenericScene("Be a Fire Hero",<SVP>[new SVP(StatFactory.ESTEEM,3), new SVP(StatFactory.COMMERCE,20)], "${GenericScene.OWNERNAME} fights a terrible fire and is the hero of the hour.","THISISFINE.png",null, <Scene>[],triggerStatsGreater:<SVP>[new SVP(StatFactory.JOBFLAKES,StatFactory.JOBFLAKES.maxValue)]);

    static GenericScene KILLAPATIENT = new GenericScene("Kill a Patient",<SVP>[new SVP(StatFactory.COMMERCE,-5), new SVP(StatFactory.ESTEEM,-1*StatFactory.ESTEEM.maxValue)], "${GenericScene.OWNERNAME} fails to put their job knowledge to practice, and loses a patient through terrible incompetance.","Hospitalbed.png",null, <Scene>[], triggerChance:0.1,triggerStatsGreater:<SVP>[new SVP(StatFactory.JOBFLAKES,0)]);
    static GenericScene SAVEAPATIENT = new GenericScene("Save A Patient",<SVP>[new SVP(StatFactory.ESTEEM,3), new SVP(StatFactory.COMMERCE,20)], "${GenericScene.OWNERNAME} spends 18 hours straight doing everything they can and save a patients life.","Hospitalbed.png",null, <Scene>[],triggerStatsGreater:<SVP>[new SVP(StatFactory.JOBFLAKES,StatFactory.JOBFLAKES.maxValue)]);

    static GenericScene FIREMAN = new GenericScene("Be A Fireman",<SVP>[new SVP(StatFactory.JOBFLAKES,3), new SVP(StatFactory.COMMERCE,2)], "${GenericScene.OWNERNAME} works hard as a firefighter, saving lives.","Firestation.png",null, <Scene>[DIEINFIRE,BEFIREHERO],triggerStatsGreater:<SVP>[new SVP(StatFactory.GRADEMOXY,1)]);
    static GenericScene DOCTOR = new GenericScene("Be A Doctor",<SVP>[new SVP(StatFactory.JOBFLAKES,1), new SVP(StatFactory.COMMERCE,4)], "${GenericScene.OWNERNAME} works hard as a doctor, saving lives.","Hospital.png",null, <Scene>[KILLAPATIENT, SAVEAPATIENT],triggerStatsGreater:<SVP>[new SVP(StatFactory.GRADEMOXY,StatFactory.GRADEMOXY.maxValue)]);


    static GenericScene BERICH = new GenericScene("Be Rich",<SVP>[new SVP(StatFactory.ESTEEM,10)], "${GenericScene.OWNERNAME} is now rich.","GoodMansion.png",null, <Scene>[],triggerChance: 0.9,triggerStatsGreater:<SVP>[new SVP(StatFactory.COMMERCE,StatFactory.COMMERCE.maxValue)]);


    static GenericScene BEFRIENDALIENS = new GenericScene("Befriend Aliens",<SVP>[new SVP(StatFactory.ESTEEM,10)], "${GenericScene.OWNERNAME}'s terrible odor attracts an alien invasion. Luckly, the Power of Love protects them. They are recognized publicly for their heroism.","ThrowTheCheese.png",null, <Scene>[],triggerChance:0.99, triggerStatsGreater:<SVP>[new SVP(StatFactory.SMELLWAVES,StatFactory.SMELLWAVES.maxValue),new SVP(StatFactory.ROMCOMMERY, StatFactory.ROMCOMMERY.maxValue)]);
    static GenericScene DIETOALIENS = new GenericScene("Die To Aliens",<SVP>[new SVP(StatFactory.LIFESAUCE,-1 * StatFactory.LIFESAUCE.maxValue)], "${GenericScene.OWNERNAME}'s terrible odor attracts an alien invasion. They die.","ThrowTheCheese.png",null, <Scene>[],triggerChance:0.9,triggerStatsGreater:<SVP>[new SVP(StatFactory.SMELLWAVES,StatFactory.SMELLWAVES.maxValue)]);

   static List<GenericScene> allGenericScenes  = new List<GenericScene>();
}