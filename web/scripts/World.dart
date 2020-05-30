import "LifeSimLib.dart";
import "package:LoaderLib/Loader.dart";
/*
    The world has a protogaonist. That's....actually kind of it. Each month it asks the protagonist what they want to do.
    ONLY the protagonist can do everything. Everyone else is supporting chars, thought they still age, too.
 */
class World {
    Random rand;
    bool ended = false;
    int renderingSpeed = 100;

    //datastrings
    Set<String> viewedScenes = new Set<String>();

    int age = 0;
    int maxAge = 100;
    Entity protagonist;
    //where do i draw to?
    Element div;
    List<Entity> sideChars = new List<Entity>();

    World(Random this.rand, Entity this.protagonist, Element this.div) {
        window.onError.listen((e) {
            window.alert("haha it broke.");
            Element error = new DivElement();
            error.classes.add("error");
            error.text = ("Uh. Fuck. I think it broke. Sure hope it was something the asshole living this life did, and not me.");
            div.append(error);
            storeCard("N4Igzg9grgTgxgUxALhAQQC4YQWwA7YAmABAEJQDmxAFACq54A2AhjAJQgA0IAdszklQApZgEtGCEgDMIMYsywMixAOqzGhAEYwEzANaieFLiGwAPDChAA5UYmIYYAT07F6+FnOaMdzQk4cIDWIhACV5TWgMBwALUTBiTUoAOmIAcQhiQlEdOAxGAIxMgCsxRldCTJ4IaLxmMASKCAqqmuI4IIk84gAmAAY+gBJkk01mOD0KGGgeQmt+QRAAZRYcERwV-gARKB4DI1oYhE2cARhkvCMTR1EKCgQYAGEY5h5EKwBGEzBEHgQwWgQACqPEYEAmVgA2gBdEw6MBQRgYMBLDAKMBQ4AAHV4CxxyBxABkAJIAMQAoks0EDHuScZwcQA3bxQBD4nEAWg+fRxAF9YdwbncHqj0YT-mAHlCBaYYLd7jBRci0r5sDBMTi+AJ2SASRSqTS6VwmSy2SgcTyQPzrnLhYq0cjyQBHKDeaVWoA");
        });
        viewedScenes.addAll(CardLibrary.viewedScenes);
    }

    Entity makeEntity(String firstName, String lastName) {
        return new Entity(firstName, lastName, new SuperbSuckDoll(rand), rand, <Scene>[]);
    }

    Entity makeSpouse() {
        return new Entity(Entity.randomSpouseName(protagonist.rand),protagonist.lastName, new SuperbSuckDoll(rand), rand, <Scene>[]);
    }

    Entity makeKid() {
        return new Entity(Entity.randomChildName(protagonist.rand),protagonist.lastName, new SuperbSuckDoll(rand), rand, <Scene>[]);
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
        print("tick!");
        if(!ended && age < maxAge) {
            await protagonist.tick(div, this);
            timePasses();
            new Timer(new Duration(milliseconds: renderingSpeed), () => tick());
        }else {
            CardLibrary.viewedScenes = viewedScenes; //save
        }
    }

    void timePasses() {
        age ++;
        StatFactory.AGE.value += 1;
        StatFactory.COMMERCE.value += -1;
    }





}