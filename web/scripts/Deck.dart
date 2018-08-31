//a deck knows how to load its contents, render its box art, generate a booster, etc.
//can also make a custom deck.

import 'Scenes/GenericScene.dart';
import 'Scenes/SceneFactory.dart';
import 'dart:async';
import 'dart:html';
import 'package:CommonLib/Random.dart';


class Deck {
    static String ALTERNIA = "ALTERNIA";
    static int boosterSize = 13;
    static Map<String, Deck> _allDecks;
    static List<String> allDeckNames = <String>["misc", "alternia"];
    static List<String> alternianSubDecks = <String>["burgundy","bronze","gold","lime","olive","jade","teal","cerulean","indigo","purple","violet","fucshia","mutant"];
    String name;

    List<String> _cards;

    ImageElement _image;


    Deck(String this.name);

    static  Map<String, Deck> allDecks() {
        if(_allDecks == null) {
            _allDecks = new Map<String, Deck>();
            for(String s in allDeckNames) {
                Deck deck = new Deck(s);
                _allDecks[s] = deck;
            }
        }
        return _allDecks;
    }

    Future<Element> makeShopElement() async{
        DivElement container = new DivElement();
        ImageElement tmp = await image;
        container.append(image);
        List<String> tmp2 = await cards;
        DivElement stats = new DivElement()..text = "$name: ${tmp2.length} cards";
        container.append(stats);
    }



    ImageElement get image {
        if(_image == null) {
            _image = new ImageElement(src:"images/DeckBoxArt/${name}.png");
        }
        return _image;
    }

    Future<List<String>> get cards async {
        if(_cards == null) {
            _cards = await SceneFactory.slurpStringsInFileName(name);
            if(name == ALTERNIA) {
                for(String subName in Deck.alternianSubDecks) {
                    List<String> tmp = await SceneFactory.slurpStringsInFileName(subName);
                    _cards.addAll(tmp);

                }
            }
        }
        return _cards;
    }

    Future<List<GenericScene>> makeBooster() async {
        List<String> c = await cards;
        List<GenericScene> ret = new List<GenericScene>();
        Random rand = new Random();
        for(int i = 0; i<Deck.boosterSize; i++) {
            ret.add(GenericScene.fromDataString(rand.pickFrom(c)));
        }
        return ret;
    }



}