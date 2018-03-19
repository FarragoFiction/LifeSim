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

    static Stat GRADITUDE = new Stat("GRADITUDE","They had good grades.",0,new Colour.fromStyleString("#0000ff"));
    static Stat BRAINITUDE = new Stat("BRAINITUDE","They were really smart.",0,new Colour.fromStyleString("#3ede89"));
    static Stat JOBFLAKES = new Stat("JOBFLAKES","They worked hard at their career.",0,new Colour.fromStyleString("#888888") );
    static Stat COMMERCE = new Stat("COMMERCE","They had a lot of money.",0,new Colour.fromStyleString("#78c34a"));
    static Stat ROMCOMMERY = new Stat("ROMCOMMERY","They were a good romantic partner.",0,new Colour.fromStyleString("#f3bfbf"));
    static Stat PARENTRITUDE = new Stat("PARENTRITUDE","They were a good parent.",0,new Colour.fromStyleString("#A8A8A8"));
    static Stat LIFESAUCE = new Stat("LIFESAUCE","They had a good life.",10,new Colour.fromStyleString("#ff0000"));
    static Stat AGE = new Stat("AGE","",0,new Colour.fromStyleString("#000000"),15);

}