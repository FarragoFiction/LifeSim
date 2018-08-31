import 'Deck.dart';
import 'dart:async';
import 'dart:html';



DivElement output = querySelector("#output");
Future<Null> main() async{
    Map<String, Deck> decks = Deck.allDecks();
    for(Deck d in decks.values) {
        print("loaded deck ${d.name}");
       // Element e = await d.makeShopElement();
        //output.append(e);
    }
}
