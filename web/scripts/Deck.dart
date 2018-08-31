//a deck knows how to load its contents, render its box art, generate a booster, etc.
class Deck {
    static List<String> allDeckNames = <String>["misc", "alternia"];
    static List<String> alternianSubDecks = <String>["burgundy","bronze","gold","lime","olive","jade","teal","cerulean","indigo","purple","violet","fucshia","mutant"];
    String name;


    Deck(String this.name);

}