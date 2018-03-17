import "package:DollLibCorrect/DollRenderer.dart";
import "dart:html";
import "dart:async";

class Entity {
    int age = 0;
    int money = 0;
    //assume max 100 and min 0, don't fall into SBURBSim's trap.
    int insanity = 0;

    Doll doll;
    String firstName;
    //AD's last name was clearly Herst. Wife Herst and Son Herst, etc.
    String lastName;

    bool canvasDirty = false;
    CanvasElement cachedCanvas;

    Future<CanvasElement> get canvas  async{
        if(canvasDirty || cachedCanvas == null) {
            cachedCanvas = new CanvasElement(width: doll.width, height: doll.height);
            await DollRenderer.drawDoll(cachedCanvas, doll);
        }
        return cachedCanvas;
    }
}