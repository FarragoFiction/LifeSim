import "../LifeSimLib.dart";


class Entity {

    //TODO put this on the stat itself
    static int maxValue = 100;

    List<Scene> scenes = new List<Scene>();

    //tend to have only one but that's not guaranteed.
    List<Entity>  spouses;
    List<Entity>  pets;
    List<Entity> children;

    bool dead = false;
    //TODO have a dynamic map of stats made from a stat factory.
    //start out with just age and money, but different scenes can assign new and more stupid stats to me.
    //if it tries to modify a stat i don't have, that stat gets added.
    //imagination, pulchritude, gruffness, etc.

    //assume max 100 and min 0, don't fall into SBURBSim's trap.
    int age = 0;
    int money = 0;

    Doll doll;
    String firstName;
    //AD's last name was clearly Herst. Wife Herst and Son Herst, etc.
    String lastName;

    bool canvasDirty = false;
    CanvasElement cachedCanvas;

    Entity(String this.firstName, String this.lastName, Doll this.doll, List<Scene> nonDefaultScenes) {
        //all entities have these three scenes no matter what
        scenes.add(new BeBorn(this));
        scenes.add(new DieOfOldAge(this));
        scenes.add(new DickAround(this));
        addAllHighPriorityScenes(nonDefaultScenes);
    }

    void addAllHighPriorityScenes(List<Scene>priorityScenes) {
        scenes.insertAll(0, priorityScenes);
    }

    void addHighPriorityScene(Scene scene) {
        scenes.insert(0,scene);
    }

    String get name {
        return "$firstName $lastName";
    }

    Future<Null> tick(Element div, World w) async {
        if(dead) return;
        print("tick for $name");
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
            await DollRenderer.drawDoll(cachedCanvas, doll);
        }
        return cachedCanvas;
    }
}