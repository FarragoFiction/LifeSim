import "LifeSimLib.dart";
import "dart:convert";

/**
 * handles saving and loading the card library. static.
 */
abstract class CardLibrary {

    static List<GenericScene> _genericCards;
    static List<Scene> _regularCards;
    static String CARDSAVESTRING = "LIFESIMCARDLIBRARY";
    static String FOUNDCARDSSTRING = "LIFESIMFOUNDCARDS";
    //will be a set.
    static String VIEWEDSCENES = "LIFESIMVIEWEDSCENES";
    //eventually, once i open up the card builder, booster packs will be able to be bought with in game currency
    static String MONEYSTRING = "LIFESIMMONEY";





    static List<Scene> get genericCards {
        if(_genericCards == null) {
            CardLibrary.loadLibrary();
            if(_genericCards.length == 0) {
                _genericCards.addAll(SceneFactory.allGenericScenes);
                saveLibrary();
            }
        }
        return _genericCards;
    }

    static int get money {
        if(window.localStorage.containsKey(MONEYSTRING)){
            return int.parse(window.localStorage[MONEYSTRING]);
        }else {
            return 0;
        }
    }

    static set money(int value) {
        window.localStorage[MONEYSTRING] = "$value";
    }

    static void clearViewedScenes(){
        window.localStorage.remove(VIEWEDSCENES);
    }


    static Set<String> get viewedScenes {
        Set<String> scenes = new Set<String>();
        if(window.localStorage.containsKey(VIEWEDSCENES)){
            scenes = JSONObject.jsonStringToStringSet(window.localStorage[VIEWEDSCENES]);
        }
        print("getting ${scenes.length} viewed scenes");
        return scenes;
    }

    static set viewedScenes(Set<String> scenes) {
        print("saving ${scenes.length} viewed scenes");
        window.localStorage[VIEWEDSCENES] = scenes.toString();
    }

    //can't be removed or added. goal is to convert as many of these as possible to generic
    static List<Scene> get regularCards {
        if(_regularCards == null) {
            _regularCards = new List<Scene>();
            _regularCards.add(new GetASpouse(null));
            _regularCards.add(new BeAHobo(null));
            _regularCards.add(new DickAround(null));
            _regularCards.add(new Die(null));
            _regularCards.add(new GetAKid(null));
            _regularCards.add(new GoOnDates(null));
            _regularCards.add(new GoToSchool(null));
            _regularCards.add(new TakeKidToPark(null));
            _regularCards.add(new BreakTheGame(null));
        }
        return _regularCards;
    }

    static List<Scene> get cards {
        List<Scene> ret = new List<Scene>();
        ret.addAll(genericCards);
        ret.addAll(regularCards);
        return ret;
    }

    static Set<Scene> cardsWithSearchTerm(String term) {
        // (GenericScene scene) => scene.toJson();
        Set<Scene> ret = Search.textSearch(genericCards,term,(Scene scene) => (scene as GenericScene).toJSON().toString());
        ret.addAll(Search.textSearch(regularCards,term,(Scene scene) => scene.description));
        return ret;
    }

    static void loadLibrary() {
        _genericCards = new List<GenericScene>();
        if(!window.localStorage.containsKey(CARDSAVESTRING)) return ;
        String datastrings = window.localStorage[CARDSAVESTRING];
        datastrings = datastrings.replaceAll("[", "");
        datastrings = datastrings.replaceAll("]", "");
        datastrings = datastrings.replaceAll(" ", "");
        List<String> subsets = datastrings.split(",");
        for(String d in subsets) {
           // print("dynamic thing is  $d");
            _genericCards.add(GenericScene.fromDataString(d));
        }
    }

    static void saveLibrary() {
        List<String> sceneArray = new List<String>();
        List genericScenes = genericCards;
        for(GenericScene s in genericScenes) {
            sceneArray.add(s.toDataString());
        }
        window.localStorage[CARDSAVESTRING] = sceneArray.toString();
    }

    static void clearLibrary() {
        window.localStorage.remove(CARDSAVESTRING);
    }

    static void addCard(GenericScene scene) {
        genericCards; //to load
        _genericCards.add(scene);
        CardLibrary.saveLibrary();
    }

    static void removeCard(GenericScene scene) {
        genericCards; //to load
        _genericCards.remove(scene);
        CardLibrary.saveLibrary();
    }

    static void clearFoundCards() {
        window.localStorage.remove(FOUNDCARDSSTRING);
    }

    static List<GenericScene> get foundCards {
        List<GenericScene> ret = new List<GenericScene>();
        //so there are no repeats in one slurp
        List<String> checked = new List<String>();
        if(window.localStorage.containsKey(FOUNDCARDSSTRING)) {
            try{
                List<String> dataStrings = window.localStorage[FOUNDCARDSSTRING].split(",");
                for(String s in dataStrings) {
                    if(!checked.contains(s)){
                        ret.add(GenericScene.fromDataString(s));
                        checked.add(s);
                    }
                }
            }catch(e) {
                ret.add(new GenericScene("Uh. Whoops? Loading Your Card Fucked Up...", "${GenericScene.OWNERNAME} gets caught in a shitty error space. It's terrifying.","404pagebecauseecch.png",null, triggerChance: 0.1, resultStats: <SVP>[new SVP(StatFactory.SPOOK,1)]));
            }
        }
        return ret;
    }

}