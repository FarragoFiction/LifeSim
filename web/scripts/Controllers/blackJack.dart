import 'dart:html';
import "../LifeSimLib.dart";
import 'dart:async';
import "package:BlackJack/BlackJack.dart";
import "dart:math" as Math;

Game game;
Element div;
int bet = 113;
int minBet = 113;
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

void drawBetButton() {
    clearDiv();
    if(CardLibrary.money < minBet) {
        div.setInnerHtml("Sorry, but you can't afford to bet.");
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
}

Future<Null> start() async{
    clearDiv();
    CardLibrary.money = CardLibrary.money + -1* bet;
    await Loader.preloadManifest();
    game = new Game(Card.getFreshDeck(),div, finishGame);
    game.start();
}

void finishGame() {
    String result = " You lost, thems the breaks.";
    if(!game.lost) {
        int winnings = 2* bet;
        result = (" You won ${winnings} Life Bux!!!");
        CardLibrary.money = CardLibrary.money + winnings;
    }
    querySelector("#money").appendText(result);
    ButtonElement restartButton = new ButtonElement();
    restartButton.text = "New Deal?";
    div.append(restartButton);
    restartButton.onClick.listen((e) {
        drawBetButton();
    });
}