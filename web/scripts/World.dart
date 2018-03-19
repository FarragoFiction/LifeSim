import "LifeSimLib.dart";
/*
    The world has a protogaonist. That's....actually kind of it. Each month it asks the protagonist what they want to do.
    ONLY the protagonist can do everything. Everyone else is supporting chars, thought they still age, too.
 */
class World {
    Random rand;
    bool ended = false;
    int renderingSpeed = 100;

    int age = 0;
    int maxAge = 100;
    Entity protagonist;
    //where do i draw to?
    Element div;
    List<Entity> sideChars = new List<Entity>();
    bool loadedManifest = false;

    World(Random this.rand, Entity this.protagonist, Element this.div) {
        window.onError.listen((e) {
            window.alert("haha it broke.");
            Element error = new DivElement();
            error.classes.add("error");
            error.text = ("Uh. Fuck. I think it broke. Sure hope it was something the asshole living this life did, and not me.");
            div.append(error);
        });
    }

    Future<Null> preloadManifest() async {
        await Loader.preloadManifest();
        loadedManifest = true;
    }

    Future<Null> tick() async {
        if(!loadedManifest) await preloadManifest();
        print("tick!");
        if(!ended && age < maxAge) {
            await protagonist.tick(div, this);
            timePasses();
            new Timer(new Duration(milliseconds: renderingSpeed), () => tick());
        }
    }

    void timePasses() {
        age ++;
        StatFactory.AGE.value += 1;
    }





}