import 'dart:html';
import "../LifeSimLib.dart";
import 'dart:async';
import "package:BlackJack/BlackJack.dart";

Game game;
void main() {
    loadNavbar();
    start();
}

Future<Null> start() async{
    await Loader.preloadManifest();


    game = new Game(Card.getFreshDeck(),querySelector("#output"), finishGame);
    game.start();
}

void finishGame() {
    window.alert("TODO: process bets");
}