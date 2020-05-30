import 'dart:html';
import "../LifeSimLib.dart";
import 'dart:async';
import "package:BlackJack/BlackJack.dart";
import "dart:math" as Math;
import "package:DollLibCorrect/DollRenderer.dart";
import "package:LoaderLib/Loader.dart";

BlackJackGame game;
Element div;
int bet = 113;
int minBet = 113;
CanvasElement dealerCanvas;
CanvasElement meCanvas;
Element newGame;
void main() {
    loadNavbar();
    div = querySelector("#output");

    drawBetButton();
}

void clearDiv() {
    List<Element> children = new List.from(div.children);
    children.forEach((f) {
        f.remove();
    });
}

Future<Null> drawMe() async{
    SuperbSuckDoll doll = new SuperbSuckDoll();
    CanvasElement canvas = new CanvasElement(width: doll.width, height: doll.height);
    DollRenderer.drawDoll(canvas, doll);
    div.append(canvas);
}

Future<Null> drawHooker() async{
    SuperbSuckDoll doll = new SuperbSuckDoll();
    doll.body.imgNumber = 3;
    CanvasElement canvas = new CanvasElement(width: doll.width, height: doll.height);
    DollRenderer.drawDoll(canvas, doll);
    div.append(canvas);
    newGame = new DivElement();
    div.append(newGame);
}

void drawBetButton() {
    clearDiv();

    if(CardLibrary.money < minBet) {
        div.setInnerHtml("Sorry, but you can't afford to bet. You might want to sell some cards.");
        return;
    }
    ButtonElement betButton = new ButtonElement();
    betButton.text = "Bet";
    InputElement value = new InputElement();
    value.value = "$bet";
    value.min = "$minBet";
    int max = Math.max(bet, CardLibrary.money);
    value.max = "${max}";

    SpanElement valueMarker = new SpanElement();
    valueMarker.text = "$bet";

    value.type = "range";
    div.append(valueMarker);
    div.append(value);
    div.append(betButton);

    value.onChange.listen((e) {
        valueMarker.text = value.value;
        bet = int.parse(value.value);
    });

    betButton.onClick.listen((e) {
        start();
    });

    newGame = new DivElement();
    div.append(newGame);
}

Future<Null> start() async{
    clearDiv();

    CardLibrary.money = CardLibrary.money + -1* bet;
    await drawHooker();
    game = new BlackJackGame(Card.getFreshDeck(),div, finishGame);
    game.dealer.name = "Hooker";
    game.player.name = "You";
    game.dealerLostQuips = <String>["Oh no! I lost?","How could you beat me!?","That's not fair!"];
    game.dealerWonQuips = <String>["Oh! You nearly won! You should try again!","You were so close, too!","No refunds."];
    game.start();
    drawMe();
}

void finishGame() {
    String result = " You lost, thems the breaks.";
    if(game.result == BlackJackGame.WON) {
        int winnings = 2* bet;
        result = (" You won ${winnings} Life Bux!!!");
        CardLibrary.money = CardLibrary.money + winnings;
    }else if(game.result == BlackJackGame.TIED) {
        int winnings = bet;
        result = (" You got back ${winnings} Life Bux!!!");
        CardLibrary.money = CardLibrary.money + winnings;
    }
    querySelector("#money").appendText(result);
    ButtonElement restartButton = new ButtonElement();
    restartButton.text = "New Deal?";
    newGame.append(restartButton);
    restartButton.onClick.listen((e) {
        drawBetButton();
    });
}