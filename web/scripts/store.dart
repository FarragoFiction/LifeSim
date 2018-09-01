import 'CardLibrary.dart';
import 'Deck.dart';
import 'Scenes/GenericScene.dart';
import 'Scenes/Scene.dart';
import 'Scenes/SceneFactory.dart';
import 'Stats/StatFactory.dart';
import 'dart:async';
import 'dart:html';
import 'navbar.dart';

import 'package:RenderingLib/RendereringLib.dart';



DivElement output = querySelector("#output");
Future<Null> main() async{
    loadNavbar();
    await Loader.preloadManifest();
    StatFactory.initAllStats();
    SceneFactory.initScenes();
    sellAll();
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


void sellAll() {
    Element wrapper = new DivElement()..text = ("I would be willing to give you X LifeBux for your entire card library (Y cards).");
    output.append(wrapper);
    List<Scene> cards = CardLibrary.cards;
    int paymentAmount = 0;
    int amount = 0;
    for(Scene s in cards) {
        if(s is GenericScene) {
            GenericScene gs = s as GenericScene;
            paymentAmount += gs.price;
            amount ++;
        }
    }
    wrapper.text = "I would be willing to give you $paymentAmount LifeBux for your entire card library ($amount cards).";
    ButtonElement button = new ButtonElement()..text = "Yes";
    wrapper.append(button);
    button.onClick.listen((Event e) {
        CardLibrary.clearLibrary();
        CardLibrary.money += paymentAmount;
        window.location.href = window.location.href;
    });


}