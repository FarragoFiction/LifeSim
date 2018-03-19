import "../LifeSimLib.dart";


class GetASpouse extends Scene {
    String backgroundName = "ThisIsLoveIGuess.png";
    GetASpouse(owner) : super(owner);
    //should be bottom in list, only acitvates if nothing better to do.
  @override
  bool triggered() {
      if(owner.spouses.isEmpty && owner.rand.nextDouble() < triggerChance ) return true;
      return false;
  }

  @override
  Future<Null> renderContent(Element element, World w) async {
      Entity spouse = new Entity(Entity.randomSpouseName(owner.rand), owner.lastName, new SuperbSuckDoll(), owner.rand, <Scene>[]);
      //for some reason turnways makes them invisible???
      //spouse.doll.orientation = Doll.TURNWAYS;
      spouse.turnways = true;
      text = "${owner.name} finds true love in ${spouse.name}.";
      owner.addStat(StatFactory.ROMCOMMERY, 1);
      owner.spouses.add(spouse);
      others.add(spouse);
      owner.scenesToAdd.add(new GetAKid(owner));
      owner.scenesToAdd.add(new GoOnDates(owner));

      super.renderContent(element, w);
  }

}