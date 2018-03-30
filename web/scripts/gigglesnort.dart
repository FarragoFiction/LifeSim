import 'dart:html';
import "LifeSimLib.dart";
import 'dart:async';


Element div;
List<String> snorts = new List<String>();
void main() {
  loadNavbar();

  div = querySelector("#output");
  div.style.textAlign = "left";
  div.style.marginLeft = "auto";
  div.style.marginRight = "auto";
  //in theory i could strike through these as you find them...but then i'd need to know how to identify them
  allude("The Mathematician can calculate one for you.");
  allude("I wonder if LORAS has any eggs???");
  allude("Do you think there's an FAQ anywhere???");
  allude("Could the Prospitian Maillady have any eggs to deliver to you?");
  allude("Thinking like a Waste might find one for you, but only if you remember where to go.");
  allude("What if you combine all the things???");
  allude("Did JR ever even finish that bullet hell shooter they were working on?");
  allude("Have you seen what lies beyond the Void???");
  allude("Have you Been the Arms???");
  allude("I wonder what the Holy Preacher is up to???");
  allude("Have you met the Drunk Philosopher???");
  allude("Have you met Kid Boi???");
  allude("The Gourmet Nutritionist might know where to find rare and delectable eggs.");
  allude("Have you seen the Persistent Educator???");
  allude("I wouldn't recommend actually meteoring your dear sweet precious grubs, but it might not hurt to check it out as an option.");
  allude("A Maid's work is never done.");
  allude("Have you found a friend of Democracy???");
  allude("Do you know about EA???");
  allude("You know about the turtles...right???");
  allude("Ms. Paint would surely help you look for eggs.");
  allude("Have you heard the Jazz Singer's voice??? ");
  allude("The Creative Investigator might know where to find some eggs.");
  allude("Have you taken five minutes today to try to feel better about yourself?");
  allude("Maybe Mass Effect and his robot girlfriend have an egg???");
  allude("The Arch Agent likely knows where to find illicit eggs.");
  allude("I mean...you've made a doll. Right?");
  allude("Do you think there's a MiniSim index page???");
  allude("Ace Dick seems like the kind of guy who'd know about some choice eggs.");
  allude("Hearts Boxcar is known to have a softspot for eggs.");
  allude("The Dersite deliveryman might know where to find some eggs.");
  allude("I mean...if nothing else, you could expect a Jade Blood to have some eggs.");
  allude("The Mobster Kingpin is known to have a sweet tooth for eggs.");
  allude("Have you been to see the Yogistic Doctor lately??? His head kind of looks like an egg...");
  allude("Have you reviewed the exponential power of positive thoughts lately?");
  allude("Don't Royal Bakers have a lot of access to eggs???");
  allude("I hope the Hysterical Dame isn't too hysterical to give you an egg...");
  allude("Surely the Draconian Dignitary would be too ...dignified to have an egg?");
  allude("If you can put up with his disconcerting ogle, Pickle Inspector might be up for the job.");
  allude("Amethyst Copycat might have a gem in the shape of an egg???");
  allude("Your local Authority Regulator might know where to find an egg.");
  allude("Have you looked into making any Trading Cards lately?");
  allude("Sometimes it takes a good strife against a Dad to find an egg.");
  allude("Problem Sleuth is always available to help those in need.");
  allude("Huh. I can't even remember if I ever linked to Homestuck the Moive from anywhere. Oh well.");
  allude("It's a long shot, but maybe the Beetle Enthusiast has found an egg while out hunting for bugs?");
  allude("The Malpracticing Doctor might be able to get an egg for you, if you don't ask where it came from. ");
  allude("Clubs Deuce has been known to keep an egg or two under his hat."); //its funny cuz he has paired scenes
  allude("The Nervous Broad might have some SWEET TIPS for finding easter eggs, so long as you don't make her very nervous.");
  giggleSnort();
}

void giggleSnort() {
  //the shuffling is itself a sort of prank
  snorts = shufflesnorts(snorts);
  int i = 0;
  print("going to write ${snorts.length} snorts");
  for(String s in snorts) {
    i++;
    writeSnort(s,i);
  }
}

void allude(String hideytalk) {

  snorts.add(hideytalk);
}

List<String> shufflesnorts(List<String> s) {
  List<String> ret = new List<String>();
  Random rand = new Random();
  while(s.length > 0) {
    String chosen = rand.pickFrom(s);
    ret.add(chosen);
    s.remove(chosen);
  }
  return ret;

}

void writeSnort(String hideytalk, int index) {
  print("writing");
  DivElement snort = new DivElement();
  snort.setInnerHtml("<b>$index</b> $hideytalk");
  div.append(snort);
}
