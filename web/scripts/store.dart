import 'Deck.dart';
import 'Scenes/SceneFactory.dart';
import 'Stats/StatFactory.dart';
import 'dart:async';
import 'dart:html';
import 'navbar.dart';



DivElement output = querySelector("#output");
Future<Null> main() async{
    loadNavbar();
    StatFactory.initAllStats();
    SceneFactory.initScenes();
    Element purchasedCards = new DivElement()..classes.add("purchased")..text = "You got:";
    Element availableDecks = new DivElement();
    output.append(purchasedCards);
    output.append(availableDecks);
    Map<String, Deck> decks = Deck.allDecks();
    for(Deck d in decks.values) {
        print("loaded deck ${d.name}");
        await d.makeShopElement(availableDecks, purchasedCards);
    }
}
