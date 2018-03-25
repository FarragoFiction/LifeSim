import "LifeSimLib.dart";
import "dart:convert";

/**
 * handles saving and loading the card library. static.
 */
abstract class CardLibrary {

    static List<GenericScene> _genericCards;
    static List<Scene> _regularCards;
    static String CARDSAVESTRING = "LIFESIMCARDLIBRARY";



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

    //can't be removed or added. goal is to convert as many of these as possible to generic
    static List<Scene> get regularCards {
        if(_regularCards == null) {
            _regularCards = new List<Scene>();
            _regularCards.add(new GetASpouse(null));
            _regularCards.add(new BecomeAWaste(null));
            _regularCards.add(new BeAHobo(null));
            _regularCards.add(new DickAround(null));
            _regularCards.add(new Die(null));
            _regularCards.add(new GetAKid(null));
            _regularCards.add(new GoOnDates(null));
            _regularCards.add(new GoToSchool(null));
            _regularCards.add(new TakeKidToPark(null));
            _regularCards.add(new BreakTheGame(null));
            _regularCards.add(new GetTrappedInAAttic(null));
        }
        return _regularCards;
    }

    static List<Scene> get cards {
        List<Scene> ret = new List<Scene>();
        ret.addAll(genericCards);
        ret.addAll(regularCards);
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
            print("dynamic thing is  $d");
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
    }



}