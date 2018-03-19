import "../LifeSimLib.dart";

class Stat {


    Colour color;
    int width = 59; //59
    int height = 200;
    String name;
    String imageName = "images/vial.png";
    int value = 0;
    int maxValue;

    Stat(String this.name, int this.value, this.color, [int this.maxValue = 10]);

    int get vialHeight {
        return (value/maxValue * height).round();
    }

    //vial should have transparency, fill it up based on how full you are.
    Future<CanvasElement> renderSelf() async{
        //vial of liquid pointing up
        CanvasElement canvas = new CanvasElement(width: width, height: height);
        canvas.context2D.fillStyle = color.toStyleString();
        canvas.context2D.fillRect(0, height-vialHeight, width, vialHeight);
        await Renderer.drawWhateverFuture(canvas, imageName);
        return canvas;
    }
}