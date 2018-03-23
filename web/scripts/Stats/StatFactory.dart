import "../LifeSimLib.dart";

abstract class StatFactory {
  static Stat SMELLWAVES;
  static Stat ESTEEM;
  static Stat GNOSIS;
  static Stat GRADEMOXY;
  static Stat SPOOK;
  static Stat JOBFLAKES;
  static Stat COMMERCE;
  static Stat ROMCOMMERY;
  static Stat PARENTRITUDE;
  static Stat LIFESAUCE;
  static Stat AGE;
  static Stat FURY;
  static Stat BRAINITUDE;

  /*
  Squiddlesense
  Termilocity
  Sneakapacity
  PULCHRITUDE
  Gumption
Spunk
Moxie
Chutzpah
Guts
jib cuttery
je ne sais quoi
Henderson Scaling (0 or 1)
Sarcastitude, the brown of Daria's hair.
magnetism
Conductivity
Days Since Counter Reset? -flesh colored
girth
Meme Depth- brown
Dankness- black
Stankness -grey
Spankness-awkward pink(edited)
Corruption Coefficent
vim
panache
waffle artisanship
Jerry Seinfield Scalage
Caffination
Blasphemoxy
Heresexy
breadcraft
Deus-Vultcraft
Patience
Fuckitudercourse
turducken level,
patients
Google image searching "256x256 jpg": 1 - 256. White.
Sock condimenticity: 1-10, off-white
Blink speed: 1-1563, orange
Sinus clearage: 0-5382, dull green
Dolphin communication: 0-1023, light blue
Anomalimity: 0-3999, reddish
Tommy Wiseau: 0-12250, black
meganger, anathemalice, omniloathing, abhorrination. all would be 1-9999 and black.(edited)
Power Level, 9001-10,000, red
Sesquipedalian Loquaciousness: one to ten, ultramarine
 Jump and Stability and Magic Find.
  */


  //who cares if it's static, only the protagonist gets any stats anyways. ... ....
    //FINE brain ghost dm. I will not do that dumb thing. No. You can't control me. I'm doing it this way.
    //BECAUSE I DON'T WANT ANY TEMPTATIONT O MAKE THIS MORE COMPLCIATED. ONE CHAR, THAT'S IT
    //EVERYONE ELSE IS DUMB GAME PIECES

    //GRADITUDE is their school power
    //BRAINITUDE is their intelligence, which is NOT the same as how good they are doing in school
    //JOB FLAKES is how well their job is going
    //COMMERCE is their money power

    static void initAllStats(){
        SMELLWAVES = new Stat("SMELL WAVES","","They had poor hygiene.",0,new Colour.fromStyleString("#827f00"),6 );
        ESTEEM = new Stat("ESTEEM","","They were a valued member of the community.",0,new Colour.fromStyleString("#ffff00"),3); //almost white, you ass
        GNOSIS = new Stat("GNOSIS","","They were kind of a dick.",0,new Colour.fromStyleString("#eeeeee"),3); //almost white, you ass
        GRADEMOXY = new Stat("GRADE MOXY","","They had good grades.",0,new Colour.fromStyleString("#0000ff"),3);
        SPOOK = new Stat("SPOOK","","They were always afraid.",0,new Colour.fromStyleString("#aa94b0"));
        BRAINITUDE = new Stat("BRAINITUDE","","They were really smart.",0,new Colour.fromStyleString("#3ede89"));
        JOBFLAKES = new Stat("JOBFLAKES","","They worked hard at their career.",0,new Colour.fromStyleString("#888888"),5 );
        COMMERCE = new Stat("COMMERCE","","They had a lot of money.",0,new Colour.fromStyleString("#78c34a"));
        ROMCOMMERY = new Stat("ROMCOMMERY","","They were a good romantic partner.",0,new Colour.fromStyleString("#f3bfbf"));
        PARENTRITUDE = new Stat("PARENTRITUDE","","They were a good parent.",0,new Colour.fromStyleString("#00ffff"));
        LIFESAUCE = new Stat("LIFESAUCE","","They had a good life.",10,new Colour.fromStyleString("#ff0000"));
        AGE = new Stat("AGE","","They lived a long life.",0,new Colour.fromStyleString("#000000"),15);
        FURY = new Stat("RIGHTEOUS FURY","","They were a very righteous person.",10,new Colour.fromStyleString("#ff0000"));

    }

}