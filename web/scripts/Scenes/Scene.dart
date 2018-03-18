import "dart:html";
import "package:DollLibCorrect/DollRenderer.dart";
import "dart:async";
import "../LifeSimLib.dart";

abstract class Scene {

    //what should be displayed on screen, will be set in rendercontent
    String text;
    //includes extension, like .png, will be set in each subclass
    String backgroundName;
    //will be set on creation.
    Entity owner;

    Scene(owner);

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

        //and now we async
        await Renderer.drawWhateverFuture(canvas, "$bgStartLocation$backgroundName");

        //TODO check trading card sim to see how to render this on the 'ground' instead of upper left
        CanvasElement ownerCanvas = await owner.canvas;
        await canvas.context2D.drawImage(ownerCanvas,0,0);

    }

}