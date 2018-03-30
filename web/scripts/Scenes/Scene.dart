import "dart:html";
import "package:DollLibCorrect/DollRenderer.dart";
import "dart:async";
import "../LifeSimLib.dart";

abstract class Scene {

    String source = "Included in Base Game";



    String name = "???";
    //for scenes with random in them. they can override this if they want
    //higher the chance, more likely it is to happen
    double triggerChance = 0.2;
    //what should be displayed on screen, will be set in rendercontent
    String text;
    String displayedText;
    //includes extension, like .png, will be set in each subclass
    String backgroundName;
    //will be set on creation.
    Entity owner;
    List<Entity> others = new List<Entity>();

    String description = "This is a pre-built card, without a standard way of indicating end results";
    Colour cardColor = new Colour(255,255,255);
    String cardLocation = "images/blank.png";

    //put things on the ground yo, if it exists
    int groundPos = 300;

    Scene(Entity this.owner);

    String get backGroundImageFullName {
        return "$bgStartLocation$backgroundName";
    }

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




    Future<Null> drawCard(Element element, int id) async {
       // print("tring to draw $name card");
        CanvasElement canvas = new CanvasElement(width:322, height: 450);
        canvas.classes.add('sceneCard');
        Random rand = new Random();
        rand.nextInt();
        if(rand.nextBool() || id < 0) {
            canvas.classes.add('selectedCard');
        }else {
            canvas.classes.add('unSelectedCard');
        }

        canvas.id = "card$id"; //needed to know which were selected
        element.append(canvas);
        canvas.onClick.listen((e) {
            if(canvas.classes.contains("selectedCard")){
                canvas.classes.add('unSelectedCard');
                canvas.classes.remove('selectedCard');
            }else{
                canvas.classes.add('selectedCard');
                canvas.classes.remove('unSelectedCard');
            }
        });

        drawCardRest(canvas);
        //print("finished allocating space for card $name");
    }

    //the async part of drawing a card, genericScene overrides this
    Future<Null> drawCardRest(CanvasElement canvas) async {
        await Renderer.drawWhateverFuture(canvas, cardLocation);
        Renderer.swapColors(canvas, cardColor);
        int fontSize = 18;
        //await Renderer.drawWhateverFuture(canvas, "$bgStartLocation$backgroundName");
        ImageElement image = await Loader.getResource(("$bgStartLocation$backgroundName"));
        //get rekt
        canvas.context2D.drawImageToRect(image, new Rectangle(31,34,260,210));

        canvas.context2D.font = "${fontSize}px Times New Roman";
        canvas.context2D.fillText("$name",40,260);

        int textBlockHeight = 40;
        //Renderer.wrap_text(canvas.context2D, description,40, 290, fontSize, 220, "left");
        canvas.context2D.fillText("Found: $source",textBlockHeight/2,textBlockHeight/2+8);

        Renderer.wrapTextAndResizeIfNeeded(canvas.context2D, description, "Times New Roman", 40, 290, fontSize, 250, 134);
        //print("finished drawing card $name");

    }

    //by default just puts background, doll and text in places.
    //most scenes should do what they need to to change vars and set text, then call super.
    //some scenes could add another div after super is called if they need something fancy, but
    //image with caption underneath should be standard.
    Future<Null> renderContent(Element element, World w) async {
        //print('rendering a scene $name');
        DivElement container = new DivElement();
        //as long as i get this appended soon, it goes on screen then we async
        element.append(container);

        CanvasElement canvas = new CanvasElement(width: width, height: height);
        canvas.classes.add("picture");
        DivElement narration = new DivElement();
        narration.classes.add("narration");
        narration.setInnerHtml(displayedText);
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
        //print("rendering stats for $name");
        CanvasElement canvas = new CanvasElement(width: width, height: 200);
        canvas.classes.add("stats");
        div.append(canvas);

        int x = 0;

        readOnlyStats.sort(); //naturally sorted by date of last access

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