//a deck knows how to load its contents, render its box art, generate a booster, etc.
//can also make a custom deck.

import 'CardLibrary.dart';
import 'Scenes/GenericScene.dart';
import 'Scenes/Scene.dart';
import 'Scenes/SceneFactory.dart';
import 'dart:async';
import 'dart:html';
import 'navbar.dart';
import 'package:CommonLib/Random.dart';


class Deck {
    static String ALTERNIA = "alternia";
    static int boosterSize = 13;
    static String RANDOMDECK = "random";
    static Map<String, Deck> _allDecks;
    static List<String> allDeckNames = <String>["misc", "alternia","sburb","memes"];
    static List<String> alternianSubDecks = <String>["burgundy","bronze","gold","lime","olive","jade","teal","cerulean","indigo","purple","violet","fuchsia","mutant"];
    String name;
    AudioElement soundEffects = new AudioElement();

    //slightly different behavior for random deck
    Future<List<Scene>> get cardsOwnedForSelection async {
        List<Scene> ret = new List<GenericScene>();
        if(name == RANDOMDECK) {
            return CardLibrary.cards;
        }else {
            return await cardsOwned;
        }
    }

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
                    if(name == "sburb") {
                        print("${gs
                            .name} string is $cardInDeckString in deck $name");
                        print("owned card is $sceneString");
                    }

                    if(cardInDeckString.contains(sceneString) || cardInDeckString == sceneString) {
                        print("found scene $gs in deck $name");
                        ret.add(gs);
                        break;
                    }
                }
                //print("$gs is not in deck $name");
            }
        }
        print("found ${ret.length} owned cards in deck $name, out of ${myCards.length} cards owned total");
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
        if(name == RANDOMDECK) return 33 * 13;
        if(_cards != null && _cards.isNotEmpty) return (_cards.length/60).ceil()*57*13;
        return 10000*13;
    }

    int get deckCost {
        if(_cards != null && _cards.isNotEmpty) return _cards.length*114;
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
            _allDecks[RANDOMDECK] = new Deck(RANDOMDECK);
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
        await makeButtons(container, purchasedCards);
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

    void makeRefreshButton(Element container) {
        ButtonElement button = new ButtonElement()..text = "Refresh Page?"..style.display="block";
        button.onClick.listen((Event e) {
            window.location.href = window.location.href;
        });
        container.append(button);
    }

    Future<Null> makeButtons(Element container, Element purchasedCards) async {
        await cards("getting buttons"); //make sure its init
        int costb = boosterCost;
        int costd = deckCost;
        ButtonElement boosterButton = new ButtonElement()..text = "Buy Booster For $costb";
        ButtonElement deckButton = new ButtonElement()..text = "Buy Deck For $costd";
        ButtonElement sellButton = new ButtonElement()..text = "Sell All Duplicates?";

        container.append(boosterButton);
        container.append(deckButton);
        container.append(sellButton);

        boosterButton.onClick.listen((Event e){
            processBooster(purchasedCards, costb);
        });

        deckButton.onClick.listen((Event e){
            processDeck(purchasedCards, costd);
        });

        sellButton.onClick.listen((Event e){
            processSellingDuplicates(purchasedCards);
        });
    }

    Future<Null> makeSelectButtons(Element container, Element selectedStatsHolder, Map<int, Scene> chosenScenes) async {
        List<String> c = await cards("getting buttons"); //make sure its init

        ButtonElement allCards = new ButtonElement()..text = "Select All Cards";
        InputElement amountElement = new InputElement()..type="range";
        amountElement.min = "0";
        amountElement.max = "${c.length}";
        amountElement.value = "${c.length}";
        ButtonElement randomCards = new ButtonElement()..text = "Select ${amountElement.value} Random Cards";

        container.append(allCards);
        container.append(amountElement);
        container.append(randomCards);

        //TODO detect selected from something OTHER than on screen images

        allCards.onClick.listen((Event e){
            //select all
            selectAllCards(container, selectedStatsHolder, chosenScenes);
        });

        amountElement.onChange.listen((Event e){
            randomCards.text = "Select ${amountElement.value} Random Cards";
        });

        randomCards.onClick.listen((Event e){
            int amount = int.parse(amountElement.value);
        });
    }

    Future<Null> selectAllCards(Element container, Element selectedStatsHolder, Map<int, Scene> chosenScenes) async {
        List<Scene> all = await cardsOwnedForSelection;
        for(Scene s in all) {
            //this way automatically avoids caring about repeats
            chosenScenes[s.id] = s;
        }
        selectedStatsHolder.text = "${chosenScenes.keys.length} Cards Selected";

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

    Future<List<String>> cards(String reason, [bool dontGetRandom = false]) async {
        print("getting cards for deck $name for reason $reason");
        if(dontGetRandom && name == RANDOMDECK) return null; //don't fucking recusrse for the love of god
        if(_cards == null) {
            //print("cards for $name is null");
            _cards = await SceneFactory.slurpStringsInFileName(name);
            //print("got the strings in file name for $name");
            if(name == ALTERNIA) {
                //print("alternian sub decks are ${Deck.alternianSubDecks}");
                for(String subName in Deck.alternianSubDecks) {
                    List<String> tmp = await SceneFactory.slurpStringsInFileName(subName);
                    print("adding ${tmp.length} cards to alternian deck that already has ${_cards.length} for caste $subName");
                    _cards.addAll(tmp);
                }
                //print("got the sub files for alternia");
            }else if(name == RANDOMDECK) {
                print("getting all cards from all decks for the random deck");
                Map<String, Deck> all = allDecks();
                for(Deck deck in all.values) {
                    print("getting cards from deck ${deck.name}");
                    List<String> tmp = await deck.cards("random card thingy", true);
                    if(tmp != null) _cards.addAll(tmp);
                }
            }
        }
        print("returning deck $name with ${_cards.length} files");
        return _cards;
    }

    Future<Null> processBooster(Element container, int cost) async {
        container.setInnerHtml("You got: ");
        DivElement element = new DivElement();
        container.append(element);
        List<GenericScene> chosen = await makeBooster();
        CardLibrary.money = CardLibrary.money - cost;
        for(GenericScene scene in chosen) {
            print("drawing card for $scene");
            await animateBoosterCard(scene,container);
            await new Future.delayed(const Duration(milliseconds: 500), () => print("next"));
            //new Timer(new Duration(milliseconds: 1000), () => animateBoosterCard(scene,container));
        }
        makeRefreshButton(container);
    }

    Future<Null> processSellingDuplicates(Element container) async{
        Set<GenericScene> uniq = await cardsOwnedNoDuplicates;
        List<GenericScene> all = await cardsOwned;
        container.setInnerHtml("");
        //duplicates are the cards that are NOT in common between them....fucking....set theory
        Set<GenericScene> duplicates = new Set<GenericScene>.from(all).difference(uniq);
        int amount = 0;
        for(GenericScene gs in duplicates) {
            amount += gs.price;
            CardLibrary.money = CardLibrary.money + gs.price;
            CardLibrary.removeCard(gs);
            syncMoney();
            DivElement sold = new DivElement()..text = "Sold $gs for ${gs.price}";
            container.append(sold);
        }
        DivElement sold = new DivElement()..text = "Total Gained:  ${amount}";
        container.append(sold);
        makeRefreshButton(container);

    }

    Future<Null> processDeck(Element container, int cost) async {
        container.setInnerHtml("You got: ");
        DivElement element = new DivElement();
        container.append(element);
        List<String> chosen = await cards("processing deck");
        CardLibrary.money = CardLibrary.money - cost;

        for(String string in chosen) {
            GenericScene scene = GenericScene.fromDataString(string);
            print("drawing card for $scene");
            await animateBoosterCard(scene,container);
            await new Future.delayed(const Duration(milliseconds: 500), () => print("next"));
            //new Timer(new Duration(milliseconds: 1000), () => animateBoosterCard(scene,container));
        }
        makeRefreshButton(container);

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

    static Future<Null> drawDecksToSelect(Element container, Element selectedHolder, Map<int, Scene> chosenScenes) async{
        //get all decks
        Map<String, Deck> decks = Deck.allDecks();
        for(Deck d in decks.values) {
            print("loaded deck ${d.name}");
            await d.makeSelectElement(container, selectedHolder, chosenScenes);
        }
    }

    Future<Null> makeSelectElement(Element decks, Element selectedStatsHolder, Map<int, Scene> chosenScenes)  async{
        DivElement container = new DivElement()..classes.add("deck");
        decks.append(container);
        ImageElement tmp = await image;
        container.append(tmp);
        DivElement stats = new DivElement()..text = "$name: ";
        container.append(stats);
        await makeSelectButtons(container, selectedStatsHolder, chosenScenes);
        return container;
    }



}