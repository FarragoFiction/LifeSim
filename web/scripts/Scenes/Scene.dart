import "dart:html";
import "package:DollLibCorrect/DollRenderer.dart";
import "dart:async";
import "../LifeSimLib.dart";

abstract class Scene {

    //TODO have scenes have ids so you can store and load them as cards
    /*TODO have a 'blank' scene object that has the stat it is triggered by
    and the stat it gives when it happens be variables, as well as the text it displays
    that means TODO stats have ids as well
    also have optional scene that is unlocked if this scene plays
    TODO store image as an INT from an array i have.
    TODO test this blank scene object with RANDOMIZED scenes as well.

    and TODO convert the simplist existing scenes into the blank format and store in a factory.

    make sure you don't use the factory scenes directly, instead copy them
     */


    String name = "???";
    String description = "This is a pre-built card, without a standard way of indicating end results";
    //for scenes with random in them. they can override this if they want
    //higher the chance, more likely it is to happen
    double triggerChance = 0.2;
    //what should be displayed on screen, will be set in rendercontent
    String text;
    //includes extension, like .png, will be set in each subclass
    String backgroundName;
    //will be set on creation.
    Entity owner;
    List<Entity> others = new List<Entity>();

    String cardLocation = "images/blank.png";

    //put things on the ground yo, if it exists
    int groundPos = 300;

    Scene(Entity this.owner);

    //all scenes are the same size
    static int width = 800;
    static int height = 600;
    static String bgStartLocation = "images/LifeSimBGs/";

    //should probably take in the MainChar
    bool triggered();

    @override
    String toString() {
        return name;
    }

    Future<Null> drawCard(Element element) async {
        print("tring to draw $name card");
        CanvasElement canvas = new CanvasElement(width:322, height: 450);
        canvas.classes.add('sceneCard');
        element.append(canvas);
        drawCardRest(canvas);
    }

    //the async part of drawing a card, genericScene overrides this
    Future<Null> drawCardRest(CanvasElement canvas) async {
        await Renderer.drawWhateverFuture(canvas, cardLocation);
        int fontSize = 18;
        canvas.context2D.font = "${fontSize}px Times New Roman";
        canvas.context2D.fillText("$name",40,260);

        //Renderer.wrap_text(canvas.context2D, description,40, 290, fontSize, 220, "left");

        Renderer.wrapTextAndResizeIfNeeded(canvas.context2D, description, "Times New Roman", 40, 290, fontSize, 250, 134);
    }

    //by default just puts background, doll and text in places.
    //most scenes should do what they need to to change vars and set text, then call super.
    //some scenes could add another div after super is called if they need something fancy, but
    //image with caption underneath should be standard.
    Future<Null> renderContent(Element element, World w) async {
        DivElement container = new DivElement();
        //as long as i get this appended soon, it goes on screen then we async
        element.append(container);

        CanvasElement canvas = new CanvasElement(width: width, height: height);
        canvas.classes.add("picture");
        DivElement narration = new DivElement();
        narration.classes.add("narration");
        narration.setInnerHtml(text);
        container.append(canvas);
        container.append(narration);

        //get stats now so it's not happening asnc style
        List<Stat> readOnlyStats = owner.readOnlyStats;
        await statWork(readOnlyStats,container,w);

        //don't await it
        canvasWork(canvas,w);
    }


    void initOthers() {
        others.clear();
        addSpouseToOthers();
    }

    void addSpouseToOthers() {
        others.addAll(owner.spouses);
        others.addAll(owner.children);

    }

    Future<Null> canvasWork(CanvasElement canvas, World w) async {
        //and now we async
        await Renderer.drawWhateverFuture(canvas, "$bgStartLocation$backgroundName");

        if(!owner.dead) {
            CanvasElement ownerCanvas = await owner.canvas;
            await canvas.context2D.drawImage(ownerCanvas, 0, height - groundPos);
        }
        int x = 100;
        for(Entity e in others) {
            if(!e.dead) {
                CanvasElement otherCanvas = await e.canvas;
                x += 100;
                await canvas.context2D.drawImage(otherCanvas, x, height - groundPos);
            }
        }
    }


    static String turnArrayIntoHumanSentence(List<dynamic> retArray) {
        return [retArray.sublist(0, retArray.length - 1).join(', '), retArray.last].join(retArray.length < 2 ? '' : ' and ');
    }

    Future<Null> statWork(List<Stat> readOnlyStats, Element div, World w) async {
        CanvasElement canvas = new CanvasElement(width: width, height: 200);
        canvas.classes.add("stats");
        div.append(canvas);

        int x = 0;
        for(Stat s in readOnlyStats) {
           // print("iterating on stat ${s.name}");
            CanvasElement statCanvas = await s.renderSelf();
            canvas.context2D.drawImage(statCanvas,x,0);
            int fontSize = 12;
            canvas.context2D.font = "${fontSize}px Strife";
            canvas.context2D.fillText(s.name, x, fontSize);
            canvas.context2D.fillText("${s.value}/${s.maxValue}", x, fontSize*3);
            x += s.width;
        }

    }

}