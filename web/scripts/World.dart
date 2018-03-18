import "LifeSimLib.dart";
/*
    The world has a protogaonist. That's....actually kind of it. Each month it asks the protagonist what they want to do.
    ONLY the protagonist can do everything. Everyone else is supporting chars, thought they still age, too.
 */
class World {
    bool ended = false;
    int renderingSpeed = 1000;

    int age = 0;
    int maxAge = 1000;
    Entity protagonist;
    //where do i draw to?
    Element div;
    List<Entity> sideChars = new List<Entity>();

    World(Entity this.protagonist, Element div);

    Future<Null> tick() async {
        print("tick!");
        if(!ended && age < maxAge) {
            await protagonist.tick(div, this);
            timePasses();
            new Timer(new Duration(milliseconds: renderingSpeed), () => tick());
        }
    }

    void timePasses() {
        age ++;
        protagonist.age ++;
        for(Entity sideChar in sideChars) {
            sideChar.age ++;
        }
    }





}