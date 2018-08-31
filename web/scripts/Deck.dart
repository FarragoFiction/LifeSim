//a deck knows how to load its contents, render its box art, generate a booster, etc.
//can also make a custom deck.

import 'CardLibrary.dart';
import 'Scenes/GenericScene.dart';
import 'Scenes/Scene.dart';
import 'Scenes/SceneFactory.dart';
import 'dart:async';
import 'dart:html';
import 'package:CommonLib/Random.dart';


class Deck {
    static String ALTERNIA = "alternia";
    static int boosterSize = 13;
    static Map<String, Deck> _allDecks;
    static List<String> allDeckNames = <String>["misc", "alternia","sburb",];
    static List<String> alternianSubDecks = <String>["burgundy","bronze","gold","lime","olive","jade","teal","cerulean","indigo","purple","violet","fuchsia","mutant"];
    String name;
    AudioElement soundEffects = new AudioElement();

    Future<List<GenericScene>> get cardsOwned async {
        List<Scene> myCards = new List<Scene>.from(CardLibrary.cards);
        List<GenericScene> ret = new List<GenericScene>();
        List<String> cardsInMe = await cards("getting owned cards");
        for(Scene scene in myCards) {
            if(scene is GenericScene) {
                GenericScene gs = scene as GenericScene;
                String sceneString = GenericScene.dataStringWithoutLabel(gs.toDataString());
                for(String string in cardsInMe) {
                    String cardInDeckString = GenericScene.dataStringWithoutLabel(string);
                    if(cardInDeckString==(sceneString)) {
                        //print("found scene $gs in deck $name");
                        ret.add(gs);
                        break;
                    }
                }
                //print("$gs is not in deck $name");
            }
        }
        //print("found ${ret.length} cards in deck $name");
        return ret;
    }

    Future<Set<GenericScene>> get cardsOwnedNoDuplicates async{
        List<GenericScene> cardsInMe = await cardsOwned;
        Map<String, GenericScene>map =  new Map<String, GenericScene>();

        for(GenericScene s in cardsInMe) {
            map[s.toDataString()] = s;
        }
        return new Set.from(map.values);
    }

    List<String> _cards;

    ImageElement _image;

    int get numberCards {
        if(_cards.isNotEmpty) return _cards.length;
        return 1;
    }

    int get boosterCost {
        if(_cards != null && _cards.isNotEmpty) return _cards.length*13;
        return 10000*13;
    }

    int get deckCost {
        if(_cards != null && _cards.isNotEmpty) return _cards.length*113;
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
        DivElement stats = new DivElement()..text = "$name: ";
        container.append(stats);
        makeButtons(container, purchasedCards);
        makeStats(stats); //async but don't wait
        return container;
    }

    Future<Null> makeStats(Element stats) async {
        List<String> tmp2 = await cards("making stats");
        //print("got cards for making stats for $name");
        Set<GenericScene> uniq = await cardsOwnedNoDuplicates;
        List<GenericScene> all = await cardsOwned;
        DivElement youOwn = new DivElement()..text = "You own: ${uniq.length}/${tmp2.length} cards";
        DivElement duplicates = new DivElement()..text = "You have: ${all.length - uniq.length} duplicates";

        stats.append(youOwn);
        stats.append(duplicates);


    }

    Future<Null> makeButtons(Element container, Element purchasedCards) async {
        await cards("getting buttons"); //make sure its init
        ButtonElement boosterButton = new ButtonElement()..text = "Buy Booster For $boosterCost";
        ButtonElement deckButton = new ButtonElement()..text = "Buy Deck For $deckCost";
        ButtonElement sellButton = new ButtonElement()..text = "Sell All Duplicates?";

        container.append(boosterButton);
        container.append(deckButton);

        boosterButton.onClick.listen((Event e){
            processBooster(purchasedCards);
        });

        deckButton.onClick.listen((Event e){
            processDeck(purchasedCards);
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

    Future<List<String>> cards(String reason) async {
        //print("getting cards for deck $name for reason $reason");
        if(_cards == null) {
            //print("cards for $name is null");
            _cards = await SceneFactory.slurpStringsInFileName(name);
            //print("got the strings in file name for $name");
            if(name == ALTERNIA) {
                //print("alternian sub decks are ${Deck.alternianSubDecks}");
                for(String subName in Deck.alternianSubDecks) {
                    List<String> tmp = await SceneFactory.slurpStringsInFileName(subName);
                    //print("adding ${tmp.length} cards to alternian deck that already has ${_cards.length} for caste $subName");
                    _cards.addAll(tmp);

                }
                //print("got the sub files for alternia");
            }
        }
        //print("returning deck $name with ${_cards.length} files");
        return _cards;
    }

    Future<Null> processBooster(Element container) async {
        container.setInnerHtml("You got: ");
        DivElement element = new DivElement();
        container.append(element);
        List<GenericScene> chosen = await makeBooster();
        for(GenericScene scene in chosen) {
            print("drawing card for $scene");
            await animateBoosterCard(scene,container);
            await new Future.delayed(const Duration(seconds: 1), () => print("next"));
            //new Timer(new Duration(milliseconds: 1000), () => animateBoosterCard(scene,container));
        }
    }

    Future<Null> processDeck(Element container) async {
        container.setInnerHtml("You got: ");
        DivElement element = new DivElement();
        container.append(element);
        List<String> chosen = await cards("processing deck");
        for(String string in chosen) {
            GenericScene scene = GenericScene.fromDataString(string);
            print("drawing card for $scene");
            await animateBoosterCard(scene,container);
            await new Future.delayed(const Duration(seconds: 1), () => print("next"));
            //new Timer(new Duration(milliseconds: 1000), () => animateBoosterCard(scene,container));
        }
    }

    Future<Null> animateBoosterCard(GenericScene scene, Element container) async{
        //240776__f4ngy__card-
        CardLibrary.addCard(scene);
        playSoundEffect("240776__f4ngy__card-flip");
        await scene.drawCard(container, -13);
        print("done animating booster card for $scene");

    }

    Future<List<GenericScene>> makeBooster() async {
        List<String> c = await cards("making booster");
        List<GenericScene> ret = new List<GenericScene>();
        Random rand = new Random();
        for(int i = 0; i<Deck.boosterSize; i++) {
            ret.add(GenericScene.fromDataString(rand.pickFrom(c)));
        }
        return ret;
    }



}