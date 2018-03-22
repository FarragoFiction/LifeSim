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

     List<Scene> shuffleDeck(List<Scene> scenes) {
        List<Scene> ret = new List<Scene>();
        while(scenes.length > 0) {
            Scene chosen = rand.pickFrom(scenes);
            ret.add(chosen);
            scenes.remove(chosen);
        }
        return ret;

    }

    void showDeck(List<Scene> chosenScenes) {
        DivElement container = new DivElement();
        div.append(container);
        String text;
        if(chosenScenes.isEmpty) {
            text = "Uh. You didn't pick any cards. Actually. Why did you do that?";
        }else {
            text = "${Scene.turnArrayIntoHumanSentence(chosenScenes)}";
        }
        
        container.text = text;
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
        StatFactory.COMMERCE.value += -1;
    }





}