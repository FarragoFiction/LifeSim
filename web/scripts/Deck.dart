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
    static List<String> allDeckNames = <String>["misc", "alternia","sburb"];
    static List<String> alternianSubDecks = <String>["burgundy","bronze","gold","lime","olive","jade","teal","cerulean","indigo","purple","violet","fucshia","mutant"];
    String name;
    AudioElement soundEffects = new AudioElement();

    List<String> _cards;

    ImageElement _image;

    int get numberCards {
        if(_cards.isNotEmpty) return _cards.length;
        return 1;
    }

    int get boosterCost {
        if(_cards.isNotEmpty) return _cards.length*13;
        return 10000*13;
    }

    int get deckCost {
        if(_cards.isNotEmpty) return _cards.length*113;
        return 10000000*13;
    }


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

    //240776__f4ngy__card-flip
    void playSoundEffect(String locationWithoutExtension) {
        if(soundEffects.canPlayType("audio/mpeg").isNotEmpty) soundEffects.src = "music/${locationWithoutExtension}.mp3";
        if(soundEffects.canPlayType("audio/ogg").isNotEmpty) soundEffects.src = "music/${locationWithoutExtension}.ogg";
        soundEffects.play();
    }

    Future<Element> makeShopElement(Element decks, Element purchasedCards) async{
        DivElement container = new DivElement()..classes.add("deck");
        decks.append(container);
        ImageElement tmp = await image;
        container.append(image);
        List<String> tmp2 = await cards;
        DivElement stats = new DivElement()..text = "$name: ${tmp2.length} cards";
        container.append(stats);
        makeButtons(container, purchasedCards);
        return container;
    }

    void makeButtons(Element container, Element purchasedCards) {
        ButtonElement boosterButton = new ButtonElement()..text = "Buy Booster For $boosterCost";
        ButtonElement deckButton = new ButtonElement()..text = "Buy Deck For $deckCost";
        container.append(boosterButton);
        container.append(deckButton);

        boosterButton.onClick.listen((Event e){
            processBooster(purchasedCards);
        });
    }



    ImageElement get image {
        if(_image == null) {
            _image = new ImageElement(src:"images/DeckBoxArt/${name}.png");
            _image.onError.listen((Event e) {
                _image.src = "images/DeckBoxArt/default.png";
            });
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

    Future<Null> processBooster(Element container) async {
        DivElement element = new DivElement();
        container.append(element);
        List<GenericScene> chosen = await makeBooster();
        for(GenericScene scene in chosen) {
            print("drawing card for $scene");
            await new Future.delayed(const Duration(seconds: 1), () => animateBoosterCard(scene,container));
            //new Timer(new Duration(milliseconds: 1000), () => animateBoosterCard(scene,container));
        }
    }

    Future<Null> animateBoosterCard(GenericScene scene, Element container) async{
        //240776__f4ngy__card-flip
        playSoundEffect("240776__f4ngy__card-flip");
        await scene.drawCard(container, -13);
        print("done animating booster card for $scene");

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