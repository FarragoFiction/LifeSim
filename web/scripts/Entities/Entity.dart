import "../LifeSimLib.dart";


class Entity {

    bool turnways = false;

    //take from world
    Random rand;
    List<Scene> scenes = new List<Scene>();
    List<Scene> scenesToAdd = new List<Scene>();

    bool born = false;

    //tend to have only one but that's not guaranteed.
    List<Entity>  spouses = new List<Entity>();
    List<Entity>  pets = new List<Entity>();
    List<Entity> children = new List<Entity>();

    bool dead = false;
    List<Stat> _stats = new List<Stat>();

    Doll doll;
    String firstName;
    //AD's last name was clearly Herst. Wife Herst and Son Herst, etc.
    String lastName;

    bool canvasDirty = false;
    CanvasElement cachedCanvas;

    Entity(String this.firstName, String this.lastName, Doll this.doll, Random this.rand, List<Scene> nonDefaultScenes) {
        //all entities have these three scenes no matter what
        scenes.add(new DieOfOldAge(this));
        scenes.add(new DickAround(this));
        for(Scene s in nonDefaultScenes) {
            s.owner = this; //couldn't own it before i existed, now could i
        }
        addAllHighPriorityScenes(nonDefaultScenes);
        addStat(StatFactory.LIFESAUCE,0);
        addStat(StatFactory.AGE,0);
    }

    static String randomSpouseName( Random rand) {
        List<String> firstNames = <String>["Wife","Husband","Hubby","Wifey","Spouse","Lover","Mistress","Master","Mrs.","Mr."];
        return rand.pickFrom(firstNames);
    }

    static String randomChildName( Random rand) {
        List<String> firstNames = <String>["Son","Daughter","Junior","Progeny","Child","Offspring"];
        return rand.pickFrom(firstNames);
    }

    static String randomFirstName(Random rand) {
        List<String> firstNames = <String>["Luigi","Teddy","Morgan","Gordon","Tom","Crow","George","Jim","Stan","Isaac","Nikalo","Thomas","Santa","Milton","Peter","Micheal","Freddy","Hugo","Steven","Peewee","Stevie","James","Harvey","Oswald","Selina","Obnoxio","Irving","Zygmunt","Waluigi","Wario","Tony","Ivo","Albert","Hannibal","Mike","Scooby","Scoobert","Barney","Sauce","Juice","Juicy","Chuck", "Jerry", "Capybara", "Bibbles", "Jiggy", "Jibbly", "Wiggly", "Zoosmell", "Farmstink", "Bubbles", "Nic", "Lil", "Liv", "Charles", "Meowsers", "Casey","Candy", "Sterling", "Fred", "Kid", "Meowgon", "Fluffy", "Meredith", "Bill", "Ted", "Ash", "Frank", "Flan", "Quill", "Squeezykins", "Spot", "Squeakems", "Stephen", "Edward", "Hissy", "Scaley", "Glubglub", "Mutie", "Donnie", "Clattersworth", "Bonebone", "Nibbles", "Fossilbee", "Skulligan", "Jack", "Nigel", "Dazzle", "Fancy", "Pounce"];
        firstNames.addAll(<String>["Nervous","Hysterical","Pickle","Problem","Ace","Jimbo","Cheddar", "Bob", "Winston", "Lobster", "Snookems", "Squeezy Face", "Cutie", "Sugar", "Sweetie", "Squishy","Katana","Sakura", "Snuffles", "Sniffles", "John", "Rose", "Dave", "Jade","Brock", "Dirk", "Roxy", "Jane", "Jake", "Sneezy", "Bubbly", "Bubbles", "Licky", "Fido", "Spot", "Grub", "Elizabeth", "Malory", "Elenora", "Vic", "Jason", "Christmas", "Hershey", "Mario","Judy"]);
        return rand.pickFrom(firstNames);
    }

    static String randomLastName(Random rand) {
        List<String> lastNames = <String>["Lickface", "McProblems", "Pooper", "von Wigglesmith", "von Horn", "Grub", "Dumbface", "Buttlass", "Pooplord", "Cage", "Sebastion", "Taylor", "Dutton", "von Wigglebottom","Kazoo", "von Salamancer", "Savage", "Rock", "Spangler", "Fluffybutton", "Wigglesona", "S Preston", "Logan", "Juice", "Clowder", "Squeezykins", "Boi", "Oldington the Third", "Malone", "Ribs", "Noir", "Sandwich"];
        lastNames.addAll(<String>["Sauce","Juice","Lobster", "Butter", "Pie", "Poofykins", "Snugglepuff", "Diabetes", "Face", "Puffers", "Dorkbutt", "Butt","Katanta","Sakura", "Legs", "Poppenfresh", "Stubblies", "Licker","Kilobyte","Samson","Terabyte","Gigabyte","Megabyte", "Puker", "Edington", "Rockerfeller", "Archer", "Addington", "Ainsworth", "Gladestone", "Valentine", "Heart", "Love", "Sniffles"]);
        //these last names from duckking
        lastNames.addAll(<String>["Herman","Powers","Bond","King","Karl","Forbush","Gorazdowski","Costanza","Sinatra","Stark","Parker","Thornberry","Robotnik","Wily","Frankenstein","Machino","Lecter","Wazowski","P. Sullivan","Doo","Doobert","Rubble","Ross", "Churchill", "Washington", "Adams", "Jefferson", "Madison", "Monroe", "Jackson", "Van Buren", "Harrison", "Knox", "Polk", "Taylor", "Fillmore", "T Robot", "Servo", "Wonder", "Pierce", "Buchanan", "Grant", "Hayes", "Garfield", "Arthur", "Cleveland", "Ketchum", "Williams", "Quill", "Weave", "Myers", "Voorhees", "Kramer", "Seinfeld", "Dent", "Nigma", "Cobblepot", "Strange", "Universe", "Darko"]);
        lastNames.addAll(<String>["McKinley", "Roosevelt", "Taft", "Harding", "Wilson", "Coolidge", "Hoover", "Truman", "Eisenhower", "Kennedy", "Johnson", "Wilson", "Carter", "Arbuckle", "Rodgers", "T", "G", "Henson", "Newton", "Tesla", "Edison", "Valentine", "Claus", "Hershey", "Freeman", "Nietzsche"]);
        return rand.pickFrom(lastNames);
    }

    void addAllHighPriorityScenes(List<Scene>priorityScenes) {
        scenes.insertAll(0, priorityScenes);
    }

    bool hasStat(Stat s) {
        return _stats.contains(s);
    }

    void addStat(Stat s, int value) {
        s.value += value;
        if(!hasStat(s)){
            _stats.add(s);
        }else{
        }
    }


    List<Stat> get readOnlyStats => _stats;

    void addHighPriorityScene(Scene scene) {
        scenes.insert(0,scene);
    }

    String get name {
        return "$firstName $lastName";
    }

    String toString() {
        return name;
    }

    Future<Null> tick(Element div, World w) async {
        if(dead) return;
        //be born first asshole
        if(!born) {
           Scene s = new BeBorn(this);
           await s.renderContent(div, w);
           born = true;
           return;
        }
        addAllHighPriorityScenes(scenesToAdd);
        scenesToAdd.clear();
        print("tick for $name div is $div");
        //only one scene per tick.
        for(Scene s in scenes) {
            if(s.triggered()) {
                await s.renderContent(div, w);
                return;
            }
        }
    }

    Future<CanvasElement> get canvas  async{
        if(canvasDirty || cachedCanvas == null) {
            cachedCanvas = new CanvasElement(width: doll.width, height: doll.height);
            //cachedCanvas.context2D.fillRect(0,0,doll.width,doll.height);

            cachedCanvas.context2D.scale(1, 1);
            await DollRenderer.drawDoll(cachedCanvas, doll);

            if(turnways) {
                CanvasElement ret  = new CanvasElement(width: doll.width, height: doll.height);

                ret.context2D.translate(ret.width/2, ret.height/2);
                ret.context2D.scale(-1*1, 1);
                ret.context2D.drawImage(cachedCanvas, -ret.width/2, -ret.height/2);
                //ret.context2D.drawImage(cachedCanvas, 0, 0);

                cachedCanvas = ret;
                return ret;
            }
            //cachedCanvas.context2D.drawImage(cachedCanvas, -cachedCanvas.width/2, -cachedCanvas.height/2);
        }
        return cachedCanvas;
    }
}