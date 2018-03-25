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
        }

        return _genericCards;
    }

    //can't be removed or added. goal is to convert as many of these as possible to generic
    static List<Scene> get regularCards {
        if(_regularCards == null) {
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
        String idontevenKnow = window.localStorage[CARDSAVESTRING];
        List<dynamic> what = JSON.decode(idontevenKnow);
        //print("what json is $what");
        for(dynamic d in what) {
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

    static void addCard(GenericScene scene) {
        genericCards; //to load
        _genericCards.add(scene);
    }



}