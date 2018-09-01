import "../LifeSimLib.dart";

abstract class StatFactory {
  static Stat SMELLWAVES;
  static Stat GARLICITUDE;
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
  static Stat GUMPTION;
  static Stat FAME;
  static Stat ASSHOLERY;
  static Stat HORSE;
  static Stat TWOFIFTYSIX;
  static Stat SPEED;
  static Stat MAGNITUTDE;
  static Stat DIRECTION;
  static Stat PATIENCE;
  static Stat PATIENTS;
  static Stat TALLNESSQUOTIENT;
  static Stat SMOLNESSQUOTIENT;
  static Stat TURDUCKENOCITY;
  static Stat SESQUIPEDALIANLOQUACIOUSNESS;
  static Stat OMNILOATHING;
  static Stat BLINKSPEED;
  static Stat CAFFINATION;
  static Stat GIRTH;
  static Stat FUCKITUDERCOURSE;
  static Stat SARCASTITUDE;
  static Stat CORRUPTIONCOEFFICIENT;
  static Stat BLASPHEMOXY;
  static Stat SEINFIELDSCALAGE;
  static Stat BREADCRAFT;
  static Stat SNEAKAPACITY;
  static Stat PANACHE;
  static Stat THOT;
  static Stat VIM;
  static Stat IMAGINATION;
  static Stat SQUIDDLESENSE;
  static Stat HENDERSON;
  static Stat DOMINANCE;
  static Stat QUIETUDE;
  //DISCORD MEMES, have enough feel goods and you level up
  static Stat LEVEL;
  static Stat POSITIVITY;

  static Stat  DANCFIMILISM;

  //from wiggler sim
  static Stat PATIENT;
  static Stat ENERGETIC;
  static Stat IDEALISTIC;
  static Stat CURIOUS;
  static Stat LOYAL;
  static Stat EXTERNAL;
  static Stat IMPATIENT;
  static Stat CALM;
  static Stat REALISTIC;
  static Stat ACCEPTING;
  static Stat FREE;
  static Stat INTERNAL;




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
        //for alternia

        PATIENT = new Stat("PATIENT","","They were a very patient person.",0,new Colour.fromStyleString("#00ff00"),113);
        ENERGETIC = new Stat("ENERGETIC","","They had so much energy!!!!!!!!!!!.",0,new Colour.fromStyleString("#494132"),113);
        IDEALISTIC= new Stat("IDEALISTIC","","They always hoped for the best.",0,new Colour.fromStyleString("#ffcc66"),113);
        CURIOUS = new Stat("CURIOUS","","They constantly investigated the world around them.",0,new Colour.fromStyleString("#ff9933"),113);
        LOYAL= new Stat("LOYAL","","They never betrayed their friends.",0,new Colour.fromStyleString("#993300"),113);
        EXTERNAL= new Stat("EXTERNAL","","They loved learning about other people.",0,new Colour.fromStyleString("#3da35a"),113);
        IMPATIENT= new Stat("IMPATIENT","","They were always on the move.",0,new Colour.fromStyleString("#ff0000"),113);
        CALM= new Stat("CALM","","They were a very calm and collected person.",0,new Colour.fromStyleString("#003300"),113);
        REALISTIC= new Stat("REALISTIC","","They made sure to always have realistic expectations.",0,new Colour.fromStyleString("#9900cc"),113);
        ACCEPTING= new Stat("ACCEPTING","","They accepted the world for what it was.",0,new Colour.fromStyleString("#000066"),113);
        FREE= new Stat("FREE","","They never let themself get tied down, even by friends.",0,new Colour.fromStyleString("#3399ff"),113);
        INTERNAL= new Stat("INTERNAL","","They had a solid understanding of who they were.",0,new Colour.fromStyleString("#ff3399"),113);

        DANCFIMILISM  = new Stat("DANCFIMILISM","","They were groovy to the max.",0,new Colour.fromStyleString("#ff00ff"),3);
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
        FURY = new Stat("RIGHTEOUS FURY","","They were a very righteous person.",0,new Colour.fromStyleString("#ff0000"));

        // = new Stat("SNEAKAPACITY","","They had a certain style.",0,new Colour.fromStyleString("#182855"));
        //NEGATE THOT scene makes the thot stat strongly negative, hide in attic sim
        THOT = new Stat("THOT","","They were a thot.",0,new Colour.fromStyleString("#edbda5"),8); //so you can have a NEGATE THOT scene
        QUIETUDE = new Stat("QUIETUDE","","They were very quiet.",0,new Colour.fromStyleString("#daccf1"),3); //it goes up to 11
        HENDERSON = new Stat("HENDERSON SCALING","","They probably made Life's DM mad.",0,new Colour.fromStyleString("#8383ff"),1);
        GUMPTION = new Stat("GUMPTION","","They had a lot of chutzpah.",0,new Colour.fromStyleString("#3c00a0"),5);
        FAME = new Stat("FAME","","They were known to everyone.",0,new Colour.fromStyleString("#ffff00"));
        ASSHOLERY = new Stat("ASSHOLERY","","They were an asshole.",0,new Colour.fromStyleString("#c39480"));
        HORSE = new Stat("HORSE","","They were actually a horse in a clever disguise.",0,new Colour.fromStyleString("#642306"),8);
        TWOFIFTYSIX = new Stat("256 x 256","","They had a love for images sized 256 x 256 that you could find on google.",0,new Colour.fromStyleString("#d0af15"),256);
        SPEED = new Stat("SPEED","","They probably wore red running shoes.",0,new Colour.fromStyleString("#ff0000"));
        MAGNITUTDE = new Stat("MAGNITUTDE","","They did everything with magnitude and direction. Or maybe just magnitude.",0,new Colour.fromStyleString("#ffa912"));
        DIRECTION = new Stat("DIRECTION","","They were very direct.",0,new Colour.fromStyleString("#888888"));
        PATIENCE =  new Stat("PATIENCE","","They were very patient.",0,new Colour.fromStyleString("#74a77b"));
        PATIENTS = new Stat("PATIENTS","","They had many patients.",0,new Colour.fromStyleString("#eeeeee"));
        TALLNESSQUOTIENT = new Stat("TALLNESS QUOTIENT","","They were really tall, which sounds kind of useless to me. Just saying.",0,new Colour.fromStyleString("#00ff00"),6);
        SMOLNESSQUOTIENT = new Stat("SMOLNESS QUOTIENT","","They were the King Bun.",0,new Colour.fromStyleString("#06FFC9"),5);
        TURDUCKENOCITY = new Stat("TURDUCKENOCITY","","They liked putting things into other things.",0,new Colour.fromStyleString("#c97422"),3);
        SESQUIPEDALIANLOQUACIOUSNESS =new Stat("SESQUIPEDALIAN LOQUACIOUSNESS","","They had really liked to talk.",0,new Colour.fromStyleString("#ff1dd2"));
        OMNILOATHING = new Stat("OMNILOATHING","","They hated everything.",0,new Colour.fromStyleString("#000000"));
        BLINKSPEED = new Stat("BLINK SPEED","","They could blink just. So fast.",0,new Colour.fromStyleString("#ffbd1d"));
        CAFFINATION = new Stat("CAFFINATION","","They were extremely awake.",0,new Colour.fromStyleString("#b48207"));
        GIRTH = new Stat("GIRTH","","They were very large.",0,new Colour.fromStyleString("#e9ec9f"));
        FUCKITUDERCOURSE= new Stat("FUCKITUDERCOURSE","","They uh. You know what. Nevermind.",0,new Colour.fromStyleString("#005a27"),69);
        SARCASTITUDE = new Stat("SARCASTITUDE","","They were sarcastic and witty.",0,new Colour.fromStyleString("#6f2d1f"));
        CORRUPTIONCOEFFICIENT = new Stat("CORRUPTION COEFFICIENT","","They had eldritch power.",0,new Colour.fromStyleString("#501855"));
        BLASPHEMOXY = new Stat("BLASPHEMOXY","","They ran head first into blasphemies.",0,new Colour.fromStyleString("#131313"),666);
        SEINFIELDSCALAGE = new Stat("SEINFIELD SCALAGE","","They had traits in common with Jerry Seinfield.",0,new Colour.fromStyleString("#182855"),9);
        BREADCRAFT  = new Stat("BREADCRAFT","","They had very warm hands.",0,new Colour.fromStyleString("#553a18"),3);
        SNEAKAPACITY = new Stat("SNEAKAPACITY","","They had were a sneak thief.",0,new Colour.fromStyleString("#182855"));
        PANACHE = new Stat("PANACHE","","They had a certain je ne sais quoi.",0,new Colour.fromStyleString("#987d9f"));
        DOMINANCE = new Stat("DOMINANCE","","They dominated the playing field.",0,new Colour.fromStyleString("#00ff00"));
        VIM = new Stat("VIM","","They were very good at punching snouts to establish dominance.",0,new Colour.fromStyleString("#0000ff"));
        IMAGINATION = new Stat("IMAGINATION","","They were very imaginative.",0,new Colour.fromStyleString("#00ff00"));
        SQUIDDLESENSE = new Stat("SQUIDDLESENSE","","They were very otherworldly.",0,new Colour.fromStyleString("#77bcba"));
        LEVEL = new Stat("LEVEL","","They were high level.",0,new Colour.fromStyleString("#000000"),3);
        GARLICITUDE  = new Stat("GARLICITUDE","","They never stopped adding garlic to food. Never.",0,new Colour.fromStyleString("#ccccaa"),3);
        POSITIVITY = new Stat("POSITIVITY","","They were a very helpful and supportive person.",0,new Colour.fromStyleString("#ffff00"),3);



    }

}