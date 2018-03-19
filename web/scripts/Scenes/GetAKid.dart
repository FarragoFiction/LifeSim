import "../LifeSimLib.dart";


class GetAKid extends Scene {
    double triggerChance = 0.2;

    String backgroundName = "Hospitalbed.png";
    GetAKid(owner) : super(owner);
    //should be bottom in list, only acitvates if nothing better to do.
  @override
  bool triggered() {
      //getting a spouse will let you have this scene, but other things can, too.
      if(owner.rand.nextDouble() < triggerChance ) return true;
      return false;
  }

  @override
  Future<Null> renderContent(Element element, World w) async {
      initOthers();
      Entity kid = new Entity(Entity.randomChildName(owner.rand), owner.lastName, new SuperbSuckDoll(), owner.rand, <Scene>[]);
      //for some reason turnways makes them invisible???
      //spouse.doll.orientation = Doll.TURNWAYS;
      kid.turnways = true;
      String outOfWedlock = "";
      if(owner.spouses.isEmpty) outOfWedlock = " through shenanigans.";
      text = "${owner.name} produces a baby named ${kid.name}$outOfWedlock.";
      owner.addStat(StatFactory.PARENTRITUDE, 1);
      owner.addStat(StatFactory.ROMCOMMERY, 1);
      owner.scenesToAdd.add(new TakeKidToPark(owner));
      owner.children.add(kid);
      others.add(kid);
      owner.addStat(StatFactory.ESTEEM, 1);
      owner.addStat(StatFactory.COMMERCE, -1);
      super.renderContent(element, w);
  }

}