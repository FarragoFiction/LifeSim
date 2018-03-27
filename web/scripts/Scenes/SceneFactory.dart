import "../LifeSimLib.dart";

abstract class SceneFactory {

    static Scene BERICH;
    //the simplicity of this pleases me so damn much

    //GenericScene(List<SVP> this.triggerStats,List<SVP> this.resultStats, String this.text, String this.backgroundName, Entity owner) : super(owner);

   static List<GenericScene> allGenericScenes  = new List<GenericScene>();

   static void initScenes() {
       GenericScene DIEINFIRE = new GenericScene("Die in a Fire", "${GenericScene.OWNERNAME} fails to put their job knowledge to practice, and dies in a fire.","THISISFINE.png",null, triggerChance: 0.1, triggerStatsGreater:<SVP>[new SVP(StatFactory.JOBFLAKES,0)], resultStats: <SVP>[new SVP(StatFactory.LIFESAUCE,-1*StatFactory.LIFESAUCE.maxValue), new SVP(StatFactory.SPOOK,StatFactory.SPOOK.maxValue)] );
       GenericScene BEFIREHERO = new GenericScene("Be a Fire Hero", "${GenericScene.OWNERNAME} fights a terrible fire and is the hero of the hour.","THISISFINE.png",null,triggerStatsGreater:<SVP>[new SVP(StatFactory.JOBFLAKES,StatFactory.JOBFLAKES.maxValue)], resultStats:<SVP>[new SVP(StatFactory.ESTEEM,3), new SVP(StatFactory.COMMERCE,20)] );

       GenericScene KILLAPATIENT = new GenericScene("Kill a Patient", "${GenericScene.OWNERNAME} fails to put their job knowledge to practice, and loses a patient through terrible incompetance.","Hospitalbed.png",null, triggerChance:0.1,triggerStatsGreater:<SVP>[new SVP(StatFactory.JOBFLAKES,0)], resultStats: <SVP>[new SVP(StatFactory.COMMERCE,-5), new SVP(StatFactory.ESTEEM,-1*StatFactory.ESTEEM.maxValue)]);
       GenericScene SAVEAPATIENT = new GenericScene("Save A Patient", "${GenericScene.OWNERNAME} spends 18 hours straight doing everything they can and save a patients life.","Hospitalbed.png",null,triggerStatsGreater:<SVP>[new SVP(StatFactory.JOBFLAKES,StatFactory.JOBFLAKES.maxValue)], resultStats: <SVP>[new SVP(StatFactory.ESTEEM,3), new SVP(StatFactory.COMMERCE,20)]);

       GenericScene FIREMAN = new GenericScene("Be A Fireman", "${GenericScene.OWNERNAME} works hard as a firefighter, saving lives.","Firestation.png",null,triggerStatsGreater:<SVP>[new SVP(StatFactory.GRADEMOXY,1)], resultStats: <SVP>[new SVP(StatFactory.JOBFLAKES,3), new SVP(StatFactory.COMMERCE,2)], scenesToUnlock: <GenericScene>[DIEINFIRE,BEFIREHERO]);
       GenericScene DOCTOR = new GenericScene("Be A Doctor", "${GenericScene.OWNERNAME} works hard as a doctor, saving lives.","Hospital.png",null, triggerStatsGreater:<SVP>[new SVP(StatFactory.GRADEMOXY,StatFactory.GRADEMOXY.maxValue)], resultStats: <SVP>[new SVP(StatFactory.JOBFLAKES,1), new SVP(StatFactory.COMMERCE,4)], scenesToUnlock: <GenericScene>[KILLAPATIENT, SAVEAPATIENT],);

       BERICH = new GenericScene("Be Rich", "${GenericScene.OWNERNAME} is now rich.","GoodMansion.png",null,triggerChance: 0.9,triggerStatsGreater:<SVP>[new SVP(StatFactory.COMMERCE,StatFactory.COMMERCE.maxValue)],resultStats: <SVP>[new SVP(StatFactory.ESTEEM,10)]);

       //GenericScene AtticSpook = new GenericScene("Be Terrified in An Attic",<SVP>[new SVP(StatFactory.GNOSIS,1)], "Oh fuck, ${GenericScene.OWNERNAME} is trapped in an attic and being terrified by this Spooky Wolf!","Attic.png",null,triggerStatsLesser:<SVP>[new SVP(StatFactory.GNOSIS,StatFactory.GNOSIS.maxValue)]);
       //AtticSpook.source = "BEATING LORAS";

       //GenericScene BecomeAWaste = new GenericScene("Become a Waste",<SVP>[new SVP(StatFactory.GNOSIS,1)], "${GenericScene.OWNERNAME} is learning how to be a Waste. Huh. Uh. Is this supposed to be happening?","LoRaSiguess.png",null, <GenericScene>[AtticSpook],triggerStatsLesser:<SVP>[new SVP(StatFactory.GNOSIS,StatFactory.GNOSIS.maxValue)]);
       //BecomeAWaste.source = "BEATING LORAS";

       //GenericScene beconfused = new GenericScene("Be Confused at LORAS",<SVP>[new SVP(StatFactory.GNOSIS,1)], "${GenericScene.OWNERNAME} has absolutely no idea how this LORAS thing works.","LoRaSiguess.png",null,triggerStatsEqual:<SVP>[new SVP(StatFactory.GNOSIS,0)]);
       //beconfused.source = "LORAS";
       //print(BecomeAWaste.toDataString());

       GenericScene BEFRIENDALIENS = new GenericScene("Befriend Aliens", "${GenericScene.OWNERNAME}'s terrible odor attracts an alien invasion. Luckly, the Power of Love protects them. They are recognized publicly for their heroism.","ThrowTheCheese.png",null,triggerChance:0.99, triggerStatsGreater:<SVP>[new SVP(StatFactory.SMELLWAVES,StatFactory.SMELLWAVES.maxValue),new SVP(StatFactory.ROMCOMMERY, StatFactory.ROMCOMMERY.maxValue)], resultStats: <SVP>[new SVP(StatFactory.ESTEEM,10)]);
       GenericScene DIETOALIENS = new GenericScene("Die To Aliens", "${GenericScene.OWNERNAME}'s terrible odor attracts an alien invasion. They die.","ThrowTheCheese.png",null,triggerChance:0.9,triggerStatsGreater:<SVP>[new SVP(StatFactory.SMELLWAVES,StatFactory.SMELLWAVES.maxValue)], resultStats: <SVP>[new SVP(StatFactory.LIFESAUCE,-1 * StatFactory.LIFESAUCE.maxValue)]);

   }
}

/* TODO

list all scene strings i know about here.

N4Igzg9grgTgxgUxALhASQHZwDZQCYJ4AEAlhkQEICGYCRA4lQLZIA0IGzSqAIiXWSJUiAMRIw2IAC4IAHlJQgIAdwwIJnFjCIAzKiWxgiUiEQAOUKcYAWCcUQBWEAEZEA1hhXZCAczonzGCo4KRJEViEMYjx+I0FhHXEEADoQdmdgtx8YaCiAOS5FABUACTQAZQqRNDyAUWSzDB806RgSHz8YAGFrKixuEAAGZIBGFrBENTAiiABVDGwIODdFAG0AXRaJMChsKTByqSp9teAAHQ4uC+QLgBk0EVrygEFZrtqL1guANypcBGuFwAtCNBhcAL4Rc6XFiAkDlAAKAHkkQBpT4-P5QAEoC6giGbdhSNoddSHY5gW4IMC0GBrQmtdqdcn7egSY7qU4XTQ4m4gABSSIoIluz1RTwxIF+-zhYJA4IZxKZZKO+1qAEcoH96fKgA

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-Xwx-eMpjMoK8+iAlqszhcrtsWg1+gBHKAzU4gFZAA

N4Igzg9grgTgxgUxALhASQHZwDZQCYJ4AEAlhkQEICGYCRA4lQLZIA0IGzSqFCAZjBIIMxAILYhGMCHYAXBAA9ZKEBADuGBDGFcYAcjBF5MQQCNsdCHggwiVWbJhU4sw1XJUJw0hgBuNEggMADoiABkoOABrbABPViMACzoABXUtIgg+cIhfOgAHGAh5F0NZZKZQgBVk2LttIm04CABzDBIAL0IifKhzEhw6vhskhBJbZKKSMEqZEFNnKJaiqBEAOS4VGqK1GoQAYWSEWmD8jBa5xxIWlq1D90QVAAZggE5XubBETTAqiABVDDYCDRFQAbQAunNtGAoNhXABlWT2aSoMHAAA6HC4WOQWIAogiqvj8QBZLGsLH+XAIXFYgCMTyxAF8oXJBDctEiUWFjrQYOC2SArpyYNzXPRtPYtODMdiWHSQAjSfiwmEiAB1UQANUJFKpnigtJQWIAbCyEnLOAqTSAAEoAeVJ+ydKrtAE19SBqUbFYyWUKRbcxcjXPiAI5QTyCkDMoA

be waste
N4Igzg9grgTgxgUxALhAIQKIEEAqBJAOQHEACAGQHkAlLAZRABoQA7AQwFslU0E4JOSrEgHVWYAC5ImkgB7iUICAHdmCGAjacYJAJZgSAGwSsYzHcwDmJABbKS4iCQBGCQSLGSAdCQASUa94AqgEkePri1nokYFAADrEQYAgAJvaOLjas8RrmFgD8jCBOrHAA1hYw0MzJBBxcIGQQVKy0OhZQCGBgnrGWheIwbRZqAMLWrMyICgAMngCshWCIqmA4EIHMBhBlCgDawAA64NDwCEfIR5i4hKSUNLRHDEeaZyiXrjhqgwBmOim6zBIWEBWHE4h0cEeR1k4nORwo1hI3ygZQYJGUqnUL20UQGWVi-3MgkBrDBEOJqRcuXsXx0v3+TgAnvZIvpaAkIKVmcIIAZvgBCKFFErlSpQaq1ThwhpNFptDpdHqWIUDIajcaTV4XECzOZCpYaTprDZbMrS3YAXSF6hiBnEYFo4lJYHNhwOzzq7rh7pARAIFFoeAePqePoAbqwDB0vW8fQBGGMAXytjGhgwswxgjudZE6SRgrpjLxjFx9foDQZjoaOEajZx9paOAGYkymniBVRm1Nn7UR1KS1Oa22m1VmnfaMABHKCRodHZOFG1QO0O8dgPaHFiet6+-2Bh6pkC16M7hMgBfSdOZntgXNdNQbj1Snfl-dC49a5vzi39K-dtd9sYkgwHsP6XqON5TjOBigeeQA+CABVDGwIEy0AbQBdUpgeqGxZMDTZfzAj4AAdDi4X5Bf6Wu00tDSX1gvABuVFwCHeLwAjC8AL6nFTCCLjGC3e6NHq0GCPF52cEoT7fX7-ZTA0HdCEgADMsPhIFGSMEqOu9HO-kER1p9ORTLAAFEAI5QUEckAwoA

be confused
N4Igzg9grgTgxgUxALhAGQPICUCCBlEAGhADsBDAWyVQCEEACAYQhIDMowEATesgF3qZcBYnwQAPPihAQA7iQQwE5KjHoALMmF4AjSABsoY-QE96JCPQCWXBGQ1z6fdVe1D8TlyQDm9WRBgAazAAOiIQHTI4QO8YaBIuADlKanQILDI8K28oBDBQgAcfcL4YbO9FRk0SRGkABhCAVnCwRAUwABUIAFUSfQho6QBtAF1wpTAofT4wPD5+MGHgAB1SFNXkVYBxRIw8AEk8VcJVgDcyQwQN1YBGVYBfMdEy7wqYOYW0PM4YYaeQUrlRQfGZbJT8RR-EovN4gsAAUQAjlALlD7kA

smoke alarm
N4Igzg9grgTgxgUxALhAGQQQxgOwJY4DmABJgEbQAuxAIgLIgA0IOmAtkqgMpsQDWCWgkoI4lCDGIAhTJREwAnsTQQA7kxAiAHpRQg1OBDASsOMAORhiYADYIEAB2J4rBeTCgORAE2JklmMQAFniEQQC0DniUcEEIvrF4MA4AdMTSCABmEoIGRibsRsRwmDjE3i4lML4hYAD0cZJwEDhgcHjQYIZgrtSJyVaYhJgEadJQ1HnGpkWYNsaY3kqxpYTxxJRxfrLyeAhWmy7EClgwYwCSB42CgWCixtRgvALlwqLiklMFZuUQ+zjmah8HBqUgUCYAfgAhBoyJg4HxCDBoDhvAA5Qp6Wz2Lx4Dj0FIOIgaSgwUJrGAAYSCpUQegADCkAEwaNomfYAFQgAFUcDYIAi9ABtAC6GmMYCgNkoYC4lFkYGFYuYpPJRjlCowPSMwuAAB0WIUDcgDVIAEoAQXOaPOHO5NAAogbGAaAG5zKAIY0GgAsBoAvsrNGTCBSNTKAOILeRKkkhsPymUOgCOUDmsf9QA

rs
N4Igzg9grgTgxgUxALhAVTAgBAFwBbYDKCCMA8gGYBqEAlgCZYICGYOpTA5p1hAHZYASoQDkYLACNaEAHQgANCD7MAtklQA5UozJQcWAOq18QwgpDsAHjhQgIAdz6kEytTCydmALwTjafHAhcAiwANzpGZj5GABsWGD5xFQgYbDA8YwBCcwlmOABrThhoaI1VdRAAFgAGSoAHZk4ECQQ4ZihMVrg8GTq+TnMcGFpuUgBhPCjEW2qZAFZzMEQnMAAVCDQ+GIgC2wBtAF1zVLAoGJwwQhxmC-3gAB0lcsfkR4AhQQBBAEkNb9W0AARACij3kj1CzBiUAQL0ec0eAF95FgHk81HCQABxDRkQjfQhgiFQmGYgCMSKOiiGIyaMCuNzAABlfJgYPsqRZhqN6dcLljUjdSBzBty6QyLsCAI5QKEixFAA+OCLgJYAbnSMzHyMADYsMAIqEDDYYHjGAITmEsxwANacMNAhGqrqIAAsAAyFAA7MnAgSCHDMUJi1cHgyZXyc5jgwtNykAMJ4wYi2xTIArOZgiHwIYAAqEGh8oRAZtgDaALrmsWBQoThghDjMhxvAADpK+VfIVwBCggCCAJIaL3NoACIAolfyVz8zFCUAQtyuYyuAF95FhLtc1OCQABxDRkQgvQj-QHA0FIgCM0O2ii6PSqMGOpzAABlZpgYBtiRZur0KSdDsjYqdSIzOizyZTDj8AI5QYG8qFAA-bAi4Zhh6AEJzCWY4RM4YaD56DVV1EAAWAAZegAdmTgQJBCqoTEm4PBkhvk5zHBhablIAYVK+RFt+mQBWczBEPgQwABUIND545tsAbQBdc1ywKFicMEIcVLAnsAADpKbog5AggBCggAggBJDRwy5oAAiAFEQfIQf5mLEoAhwSDDiCAL4ZYGgtSEkAAcQ0ZEIcMImOxuPx1IAjKTXopVusxjBfv8ADIXTAwJ48ixrDaCv7fGm5VKkSUrGUCoXfNEARyguNVJKAA




*/