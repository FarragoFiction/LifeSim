import "../LifeSimLib.dart";


class Entity {
    static int youngestOldAgeDeath = 100;
    static int oldestOldAgeDeath = 200;

    List<Scene> scenes = new List<Scene>();

    //tend to have only one but that's not guaranteed.
    List<Entity>  spouses;
    List<Entity>  pets;
    List<Entity> children;

    bool dead = false;
    int age = 0;
    int naturalDeathAge = new Random().nextIntRange(youngestOldAgeDeath, oldestOldAgeDeath);
    int money = 0;
    //assume max 100 and min 0, don't fall into SBURBSim's trap.
    int insanity = 0;

    Doll doll;
    String firstName;
    //AD's last name was clearly Herst. Wife Herst and Son Herst, etc.
    String lastName;

    bool canvasDirty = false;
    CanvasElement cachedCanvas;

    Entity(String this.firstName, String this.lastName, Doll this.doll);

    String get name {
        return "$firstName $lastName";
    }

    void tick(Element div, World w) {
        if(dead) return;
        //only one scene per tick.
        for(Scene s in scenes) {
            if(s.triggered()) {
                s.renderContent(div, w);
                return;
            }
        }
    }

    Future<CanvasElement> get canvas  async{
        if(canvasDirty || cachedCanvas == null) {
            cachedCanvas = new CanvasElement(width: doll.width, height: doll.height);
            await DollRenderer.drawDoll(cachedCanvas, doll);
        }
        return cachedCanvas;
    }
}