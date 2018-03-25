import "../LifeSimLib.dart";

abstract class SceneFactory {

    static Scene BERICH;
    //the simplicity of this pleases me so damn much

    //GenericScene(List<SVP> this.triggerStats,List<SVP> this.resultStats, String this.text, String this.backgroundName, Entity owner) : super(owner);

   static List<GenericScene> allGenericScenes  = new List<GenericScene>();

   static void initScenes() {
       GenericScene DIEINFIRE = new GenericScene("Die in a Fire",<SVP>[new SVP(StatFactory.LIFESAUCE,-1*StatFactory.LIFESAUCE.maxValue), new SVP(StatFactory.SPOOK,StatFactory.SPOOK.maxValue)], "${GenericScene.OWNERNAME} fails to put their job knowledge to practice, and dies in a fire.","THISISFINE.png",null, <GenericScene>[], triggerChance: 0.1, triggerStatsGreater:<SVP>[new SVP(StatFactory.JOBFLAKES,0)] );
       GenericScene BEFIREHERO = new GenericScene("Be a Fire Hero",<SVP>[new SVP(StatFactory.ESTEEM,3), new SVP(StatFactory.COMMERCE,20)], "${GenericScene.OWNERNAME} fights a terrible fire and is the hero of the hour.","THISISFINE.png",null, <GenericScene>[],triggerStatsGreater:<SVP>[new SVP(StatFactory.JOBFLAKES,StatFactory.JOBFLAKES.maxValue)]);

       GenericScene KILLAPATIENT = new GenericScene("Kill a Patient",<SVP>[new SVP(StatFactory.COMMERCE,-5), new SVP(StatFactory.ESTEEM,-1*StatFactory.ESTEEM.maxValue)], "${GenericScene.OWNERNAME} fails to put their job knowledge to practice, and loses a patient through terrible incompetance.","Hospitalbed.png",null, <GenericScene>[], triggerChance:0.1,triggerStatsGreater:<SVP>[new SVP(StatFactory.JOBFLAKES,0)]);
       GenericScene SAVEAPATIENT = new GenericScene("Save A Patient",<SVP>[new SVP(StatFactory.ESTEEM,3), new SVP(StatFactory.COMMERCE,20)], "${GenericScene.OWNERNAME} spends 18 hours straight doing everything they can and save a patients life.","Hospitalbed.png",null, <GenericScene>[],triggerStatsGreater:<SVP>[new SVP(StatFactory.JOBFLAKES,StatFactory.JOBFLAKES.maxValue)]);

       GenericScene FIREMAN = new GenericScene("Be A Fireman",<SVP>[new SVP(StatFactory.JOBFLAKES,3), new SVP(StatFactory.COMMERCE,2)], "${GenericScene.OWNERNAME} works hard as a firefighter, saving lives.","Firestation.png",null, <GenericScene>[DIEINFIRE,BEFIREHERO],triggerStatsGreater:<SVP>[new SVP(StatFactory.GRADEMOXY,1)]);
       GenericScene DOCTOR = new GenericScene("Be A Doctor",<SVP>[new SVP(StatFactory.JOBFLAKES,1), new SVP(StatFactory.COMMERCE,4)], "${GenericScene.OWNERNAME} works hard as a doctor, saving lives.","Hospital.png",null, <GenericScene>[KILLAPATIENT, SAVEAPATIENT],triggerStatsGreater:<SVP>[new SVP(StatFactory.GRADEMOXY,StatFactory.GRADEMOXY.maxValue)]);

       BERICH = new GenericScene("Be Rich",<SVP>[new SVP(StatFactory.ESTEEM,10)], "${GenericScene.OWNERNAME} is now rich.","GoodMansion.png",null, <GenericScene>[],triggerChance: 0.9,triggerStatsGreater:<SVP>[new SVP(StatFactory.COMMERCE,StatFactory.COMMERCE.maxValue)]);

       GenericScene BEFRIENDALIENS = new GenericScene("Befriend Aliens",<SVP>[new SVP(StatFactory.ESTEEM,10)], "${GenericScene.OWNERNAME}'s terrible odor attracts an alien invasion. Luckly, the Power of Love protects them. They are recognized publicly for their heroism.","ThrowTheCheese.png",null, <GenericScene>[],triggerChance:0.99, triggerStatsGreater:<SVP>[new SVP(StatFactory.SMELLWAVES,StatFactory.SMELLWAVES.maxValue),new SVP(StatFactory.ROMCOMMERY, StatFactory.ROMCOMMERY.maxValue)]);
       GenericScene DIETOALIENS = new GenericScene("Die To Aliens",<SVP>[new SVP(StatFactory.LIFESAUCE,-1 * StatFactory.LIFESAUCE.maxValue)], "${GenericScene.OWNERNAME}'s terrible odor attracts an alien invasion. They die.","ThrowTheCheese.png",null, <GenericScene>[],triggerChance:0.9,triggerStatsGreater:<SVP>[new SVP(StatFactory.SMELLWAVES,StatFactory.SMELLWAVES.maxValue)]);

   }
}

/* TODO

list all scene strings i know about here.

N4Igzg9grgTgxgUxALhASQHZwDZQCYJ4AEAlhkQEICGYCRA4lQLZIA0IGzSqAIiXWSJUiAMRIw2IAC4IAHlJQgIAdwwIJnFjCIAzKiWxgiUiEQAOUKcYAWCcUQBWEAEZEA1hhXZCAczonzGCo4KRJEViEMYjx+I0FhHXEEADoQdmdgtx8YaCiAOS5FABUACTQAZQqRNDyAUWSzDB806RgSHz8YAGFrKixuEAAGZIBGFrBENTAiiABVDGwIODdFAG0AXRaJMChsKTByqSp9teAAHQ4uC+QLgBk0EVrygEFZrtqL1guANypcBGuFwAtCNBhcAL4Rc6XFiAkDlAAKAHkkQBpT4-P5QAEoC6giGbdhSNoddSHY5gW4IMC0GBrQmtdqdcn7egSY7qU4XTQ4m4gABSSIoIluz1RTwxIF+-zhYJA4IZxKZZKO+1qAEcoH96fKgA

N4Igzg9grgTgxgUxALhASQHZwDZQCYJ4AEAlhkQEICGYCRA4lQLZIA0IGzSqFdVRAMRIw6ACQQwIIdgBcEADxkoQEAO4YJCTixhEAZiQDmACxlgi-OTBgkARtjoGRFjMRLmZxul8lEIeok9vaBgAOmkQWyo4AGtDSShXADkuZQAVUTQAZWyBNCSAUVCABwxDCJkbQ0MJAGFjKixuEAAGUIBWCLBEDTA0iABVDGwIWOUAbQBdCJEwKGwzLJkqMwngAB0OLk3kTYKstIKCgFlN1k2ANypcBB3NgGZNgF9WIg2tljuQWoB5Y+OCgAlWoFM6Xa5QW4oTYAJhaz2msiqNRgSxWYAAMggwLQYBNESBKkYUWizPQRCsJGtNtoobsQAApH4UAQYgCCAGl9mCQFcbl92giKsiJKSwAUAI5Qa74kBPIA

N4Igzg9grgTgxgUxALhASQHZwDZQCYJ4AEAlhkQEICGYCRA4lQLZIA0IGzSqA0idtiJUiABSoAXEggziQ7cQgAes1BADuGBDGlcYRAGZV+YIuIhEADlHGmAFghJ6AVhABGRANYZ12QgHM6M0sYKjhJRFYhDGJsCFoTYQsJKRk7GGg-W1MtGBJXX1IsCCYLBHEqLAQAOjkQV1CPP3SoaIA5LhQQAAk4ixJy7FdCKosMP1rxXL8AmABhWwrEToAGKoBGWrBETTAAFQgAVQxYuA9OgG0AXVrtMChscTAAZXLHi+AAHQ4uL+Qv2YA8gBZIEAUQASrNQV9WF8AG5UXAIX5fAC0AFYvgBfSKfb4sFEgUFPXag0FAmHwxFQZEoNEAZmx13kUxmLwkYAAMggwLQYBdmSBJiRplp2Y96NoJFp3l9OAS6SAAFIAigAMU5AEEeMTKSAEUjCcsmRNWWLXmBQQBHKCIgUgLFAA

N4Igzg9grgTgxgUxALhASQHZwDZQCYJ4AEAlhkQEICGYCRA4lQLZIA0IGzSqAylQG50AgkQAKVAC4kEGCSHYSEADzmoIAdwwIYMrjCJgADjLxgiARgAcRABbQYZsBJhUSAcxsSieCGTdEEQRgATwkbPyIwhGCiOCpyeOIwAToqIkNJaVkzbBIAMwQAOnkQACMqOABrNxhoDDwAOS4UEAAJCCMSCSpsUsJCwww3Eud3N20AYRt4xBaABkKAVhKwRC0wABUIAFUMbAgqloBtAF0SnTAobAkwHm6b4+AAHQ4uF+QXgFEeDc-PgFkXqwXvwelAEO8XgBmF4AX1YRGerxYkJAEwA8v9-p8AEoTT5AkFgiEoF4AJjmcLOChgY20d0kYAAMggwLQYMdqSBRm5xjAGTd6DpJNpHi9OCjSSAAFLoigAMSZQgA0t9CSBQbgSR8QIsqSNabz6fcwJ8AI5QHqckCwoA

N4Igzg9grgTgxgUxALhASQHZwDZQCYJ4AEAlhkQEICGYCRA4lQLZIA0IGzSqFdAgkQBiJGAiZUMIdgBcEAD2koQEAO4YEozixhEVEGAGswRABZUYxGkSpEAZiIT2A5idkxWRMFQBuZJ0WwSbwQwADopEAAjKjgDJxhoDDwAOS4lYVEwaSppEggMUIAHDCcI6RgSJycNAGEzLG4QAAZQgFYIsER1MAAVCABVDGwIWKUAbWAAHXBoeARp5GnMHHxCUnJqWgYuadZprXmUaYAREjoyayEHXenZBQXp1XVNLh1bKhJsY2kIIkKoaREaQmBAiIgAKwgkSIBgwqmwhGqQN+hRgMVyiA8EmIeDOxguNnsolCNyiMTiCSgSVSLAeIB6AAk0ABlFmCNDJACiRRKpPKlWqMDqEkQdJaAEZSZ0EN0+oNhrE6WMALqkzJQbDSMDM7JapVTSb7HaGo4mgAyaEEnOZfH6NU5hpuJu8VFw8xNixNAFpxU1HSAAL4eA1G2ke-3MgAKAHlowBpf17Z2uqDuh4m33+gOqqS3CpVDQ6nJgM0hWgwJU5vYgfkFmBFrX0UQ5DT6-0Hf2e6YAKWjFEEZr4cetif9Lrdnf9fpN2b5+cFDbAnIAjlBXZXpkGiFMZrBRUd0FhcARiBdNnRGLTcxwdgfeJcMnQGRoIHz5NI6U8NDLXnZKq5jBsNwKkiBE-1EawklIb4QVMF8iAgWwgVgkxZhJa9olieJEhSW9FnpJlWWZdkuR5Jw5wFWp6n3fCWlaKUuhCOUhhGAwN2vdVNW1XUwDbE0O3DE1rR6TlOQAWVHZMJ0E6YAGYs2DdtjXTaYamjMSxM5AAle1JOmcdU0nE0ACZp03Ks80o+seNLMBy3Y6tawXHimwQFsKwPCYlLDFSQF7ftB2HZk9JAAy01NaZ6JnCya3nQseJXNdsHY7MIk4rVF3GHcOwPfyByHEdrzCul5MDRSbyvfC1I07TdKKlNDnw4zzLKOLrOLWzy3GZVWqsxdXPcrLQ0a6Z6C0vhjk5IgxOjAANABNUlioPSVAx6mQ2sXRLXW6wMgA

N4Igzg9grgTgxgUxALhASQHZwDZQCYJ4AEAlhkQEICGYCRA4lQLZIA0IGzSqFdAgkQAiEOABcIMEO1EIAHqJQgIAdwwIYCTixhFlEgNZgiACyoxiNIlSJ4R4mKyJgqANzIBzIthIuEYAHRSIABGVHD67jDQGHgAclyKABIQYAAOJKJU2P6pGO5BojAk7u7qAMKmWNwgAAz+AKxBYIhqYAAqEACqGNgi+ooA2sAAOuDQ8AijyKOYOPiEpOTUtAxco6yjWpMoowDSJNjYVkQAClSiJJqi66My8lOjKmoaWzoAZlQHRuJEqVCiRFExgQJB0ACsIMEiPoMCpsIRSoCIL8YGELohHFQYl4Un5jqlzpcMACgVEoO5jID1EVgvDFnAIExUghMlV-DcQmEImSYvEWA8QMk0hkssFCDk8hzCsVSjAKljEAK6gBGDnNTR+DrdXrhAUDAC6HI0YCg2FEYAAyplzXqRsNNmt7TsnWUAPIAWXdAFEAEplL32m5OlxZKCTJ3TJ0AWnqgZAAF9HHaHfyI3GvRa2l6ve64xtg6Hww9owBmOPxw1SW5FErqK3nMAAGT8tBgesrGxA0trMHr5voGnO6ltca2ccjowAUq6KAAxRt8XYZvNxkO4IvO0Y1csd6syuvWsBegCOUCy7dGiaIIzGsEVO3QWFwBGIZEoNDojH5VY4awfFtcfhTkJK4pTka4HyedRNC4HQ0k0PAjGVAAOExxiMMBCk+CkAVsDwiAQXwYAATyBfCgQQYiiDgLErGxZxfHxEDiSMbw3gQdkf1CcJImiOI-2mQUUnSTJsDFPAJXcKUa1leUqiVBo1RaTUuh6PoLx-Y1TXNPswBHJ0xzTJ0MyzHMVwLddxzjMsnSvZNf1TYtRjdT1fX9czRjXMMrKdAAmbdbN3LsZIPBtmzAVsNM7btZV0gcECHNsHyGUdHSckBpznBclwtDyQC8jcJxAWNAuk-de0PE8z2wDSKyCLSzUtQ9BhvMcH0y+dF2XH8CoFVUEyTFNtkElzvT9AMesLAUABZL31AoQoqsKW3UQZ5ukRa4sHGRJFQFKHOG0Z6B9PhBC9Ih3VdAANABNDleofMsE3W4Lyt0qqsjWhMgA

N4Igzg9grgTgxgUxALhASQHZwDZQCYJ4AEAlhkQEICGYCRA4lQLZIA0IGzSqFdASiTgALEOwAuCAB5iUICAHcMCGAk4sYpMEQwKiMQUIB0okACMqcANYBzGNAx4Acl1n0IEPAFkqGMCQgYhgAOGNYmYvrW1soAwkI+iLIADIYAnCZgiEpgACoQAKoY2BBWsgDaALomKmBQ2GJgAMpiVA3lwAA6HFxdyF0Aoo05-f2eXaxdAG5UuAi9XQCMSV0AvlXikdEwza1gADIIYLQw5esgESRRyjsN9Cqtyu1danMoXTEA8p6e-Xwx-eMpjMoK8+iAlqszhcrtsWg1+gBHKAzU4gFZAA

N4Igzg9grgTgxgUxALhASQHZwDZQCYJ4AEAlhkQEICGYCRA4lQLZIA0IGzSqFCAZjBIIMxAILYhGMCHYAXBAA9ZKEBADuGBDGFcYAcjBF5MQQCNsdCHggwiVWbJhU4sw1XJUJw0hgBuNEggMADoiABkoOABrbABPViMACzoABXUtIgg+cIhfOgAHGAh5F0NZZKZQgBVk2LttIm04CABzDBIAL0IifKhzEhw6vhskhBJbZKKSMEqZEFNnKJaiqBEAOS4VGqK1GoQAYWSEWmD8jBa5xxIWlq1D90QVAAZggE5XubBETTAqiABVDDYCDRFQAbQAunNtGAoNhXABlWT2aSoMHAAA6HC4WOQWIAogiqvj8QBZLGsLH+XAIXFYgCMTyxAF8oXJBDctEiUWFjrQYOC2SArpyYNzXPRtPYtODMdiWHSQAjSfiwmEiAB1UQANUJFKpnigtJQWIAbCyEnLOAqTSAAEoAeVJ+ydKrtAE19SBqUbFYyWUKRbcxcjXPiAI5QTyCkDMoA

 */