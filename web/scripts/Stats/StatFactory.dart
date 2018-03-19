import "../LifeSimLib.dart";

abstract class StatFactory {
    //who cares if it's static, only the protagonist gets any stats anyways. ... ....
    //FINE brain ghost dm. I will not do that dumb thing. No. You can't control me. I'm doing it this way.
    //BECAUSE I DON'T WANT ANY TEMPTATIONT O MAKE THIS MORE COMPLCIATED. ONE CHAR, THAT'S IT
    //EVERYONE ELSE IS DUMB GAME PIECES

    //GRADITUDE is their school power
    //BRAINITUDE is their intelligence, which is NOT the same as how good they are doing in school
    //JOB FLAKES is how well their job is going
    //COMMERCE is their money power
    //LIFESAUCE is how old they are, but turnways.

    static Stat GRADITUDE = new Stat("GRADITUDE",0,new Colour.fromStyleString("#0000ff"));
    static Stat BRAINITUDE = new Stat("BRAINITUDE",0,new Colour.fromStyleString("#3ede89"));
    static Stat JOBFLAKES = new Stat("JOBFLAKES",0,new Colour.fromStyleString("#888888") );
    static Stat COMMERCE = new Stat("COMMERCE",0,new Colour.fromStyleString("#78c34a"));
    static Stat LIFESAUCE = new Stat("LIFESAUCE",10,new Colour.fromStyleString("#ff0000"));
    static Stat AGE = new Stat("AGE",0,new Colour.fromStyleString("#000000"),5);

}