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
    static Stat SMELLWAVES = new Stat("SMELL WAVES","They had poor hygine.",0,new Colour.fromStyleString("#827f00") );
    static Stat ESTEEM = new Stat("ESTEEM","They were a valued member of the community.",0,new Colour.fromStyleString("#ffff00"),3); //almost white, you ass
    static Stat GNOSIS = new Stat("GNOSIS","They were kind of a dick.",0,new Colour.fromStyleString("#eeeeee"),3); //almost white, you ass
    static Stat GRADEMOXY = new Stat("GRADE MOXY","They had good grades.",0,new Colour.fromStyleString("#0000ff"),3);
    static Stat SPOOK = new Stat("SPOOK","They were always afraid.",0,new Colour.fromStyleString("#aa94b0"));
    static Stat BRAINITUDE = new Stat("BRAINITUDE","They were really smart.",0,new Colour.fromStyleString("#3ede89"));
    static Stat JOBFLAKES = new Stat("JOBFLAKES","They worked hard at their career.",0,new Colour.fromStyleString("#888888"),5 );
    static Stat COMMERCE = new Stat("COMMERCE","They had a lot of money.",0,new Colour.fromStyleString("#78c34a"));
    static Stat ROMCOMMERY = new Stat("ROMCOMMERY","They were a good romantic partner.",0,new Colour.fromStyleString("#f3bfbf"));
    static Stat PARENTRITUDE = new Stat("PARENTRITUDE","They were a good parent.",0,new Colour.fromStyleString("#00ffff"));
    static Stat LIFESAUCE = new Stat("LIFESAUCE","They had a good life.",10,new Colour.fromStyleString("#ff0000"));
    static Stat AGE = new Stat("AGE","They lived a long life.",0,new Colour.fromStyleString("#000000"),15);

}