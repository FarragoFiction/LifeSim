import "../LifeSimLib.dart";

class Stat {


    Colour color;
    int width = 100; //59
    int height = 165;
    int vialMaxHeight = 137;
    String name;
    String imageName = "images/vial.png";
    int _value = 0;
    int maxValue;
    String epitaphSentence;

    Stat(String this.name, this.epitaphSentence, int this._value, this.color, [int this.maxValue = 10]);

    int get vialHeight {
        return (_value/maxValue * vialMaxHeight).round();
    }

    int get value => _value;

    void set value(value) {
        _value = value;
        if(_value < 0) _value = 0;
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