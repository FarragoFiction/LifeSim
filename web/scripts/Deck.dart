//a deck knows how to load its contents, render its box art, generate a booster, etc.

import 'Scenes/GenericScene.dart';
import 'Scenes/SceneFactory.dart';
import 'dart:async';
import 'dart:html';

class Deck {
    static String ALTERNIA = "ALTERNIA";

    static List<String> allDeckNames = <String>["misc", "alternia"];
    static List<String> alternianSubDecks = <String>["burgundy","bronze","gold","lime","olive","jade","teal","cerulean","indigo","purple","violet","fucshia","mutant"];
    String name;

    List<GenericScene> _cards;

    ImageElement _image;


    Deck(String this.name);

    ImageElement get image {
        if(_image == null) {
            _image = new ImageElement(src:"images/DeckBoxArt/${name}.png");
        }
        return _image;
    }

    Future<List<GenericScene>> get cards async {
        if(_cards == null) {
            _cards = await SceneFactory.slurpScenesInFileName(name);
            if(name == ALTERNIA) {
                for(String subName in Deck.alternianSubDecks) {
                    List<GenericScene> tmp = await SceneFactory.slurpScenesInFileName(subName);
                    _cards.addAll(tmp);

                }
            }
        }
        return _cards;
    }



}