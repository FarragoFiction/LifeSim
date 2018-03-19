import "dart:html";
import "package:DollLibCorrect/DollRenderer.dart";
import "dart:async";
import "../LifeSimLib.dart";

abstract class Scene {

    //for scenes with random in them. they can override this if they want
    //higher the chance, more likely it is to happen
    double triggerChance = 0.5;
    //what should be displayed on screen, will be set in rendercontent
    String text;
    //includes extension, like .png, will be set in each subclass
    String backgroundName;
    //will be set on creation.
    Entity owner;
    List<Entity> others = new List<Entity>();

    //put things on the ground yo, if it exists
    int groundPos = 300;

    Scene(Entity this.owner);

    //all scenes are the same size
    static int width = 800;
    static int height = 600;
    static String bgStartLocation = "images/LifeSimBGs/";

    //should probably take in the MainChar
    bool triggered();

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
        //don't await it
        canvasWork(canvas,w);
        statWork(container,w);

    }

    Future<Null> canvasWork(CanvasElement canvas, World w) async {
        //and now we async
        await Renderer.drawWhateverFuture(canvas, "$bgStartLocation$backgroundName");

        //TODO check trading card sim to see how to render this on the 'ground' instead of upper left
        CanvasElement ownerCanvas = await owner.canvas;
        await canvas.context2D.drawImage(ownerCanvas,0,height-groundPos);
        int x = 0;
        for(Entity e in others) {
            CanvasElement otherCanvas = await e.canvas;
           // x += 50;
            await canvas.context2D.drawImage(otherCanvas,x,height-groundPos);
        }
    }

    Future<Null> statWork(Element div, World w) async {
        CanvasElement canvas = new CanvasElement(width: width, height: 200);
        canvas.classes.add("stats");
        div.append(canvas);

        int x = 0;
        for(Stat s in owner.readOnlyStats) {
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