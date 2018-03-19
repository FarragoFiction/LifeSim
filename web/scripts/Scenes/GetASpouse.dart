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
      spouse.doll.orientation = Doll.TURNWAYS;
      text = "${owner.name} finds true love in ${spouse.name}.";
      owner.addStat(StatFactory.ROMCOMMERY, 1);
      owner.spouses.add(spouse);
      others.add(spouse);
      super.renderContent(element, w);
  }

}