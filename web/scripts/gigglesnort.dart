import 'dart:html';
import "LifeSimLib.dart";
import 'dart:async';


Element div;
void main() {
  div = querySelector("#output");
  //in theory i could strike through these as you find them...but then i'd need to know how to identify them
  giggleSnort("The Mathematician can calculate one for you.");
  giggleSnort("I wonder if LORAS has any eggs???");
  giggleSnort("Could the Prospitian Maillady have any eggs to deliver to you?");
  giggleSnort("Thinking like a Waste might find one for you, but only if you remember where to go.");
  giggleSnort("What if you combine all the things???");
  giggleSnort("Have you seen what lies beyond the Void???");
  giggleSnort("Have you Been the Arms???");
  giggleSnort("I wonder what the Holy Preacher is up to???");
  giggleSnort("Have you met the Drunk Philosopher???");
  giggleSnort("Have you met Kid Boi???");
  giggleSnort("The Gourmet Nutritionist might know where to find rare and delectable eggs.");
  giggleSnort("Have you seen the Persistent Educator???");
  giggleSnort("A Maid's work is never done.");
  giggleSnort("Have you found a friend of Democracy???");
  giggleSnort("Do you know about EA???");
  giggleSnort("Ms. Paint would surely help you look for eggs.");
  giggleSnort("Have you heard the Jazz Singer's voice??? ");
  giggleSnort("The Creative Investigator might know where to find some eggs.");
  giggleSnort("Maybe Mass Effect and his robot girlfriend have an egg???");
  giggleSnort("The Arch Agent likely knows where to find illicit eggs.");
  giggleSnort("Ace Dick seems like the kind of guy who'd know about some choice eggs.");
  giggleSnort("Hearts Boxcar is known to have a softspot for eggs.");
  giggleSnort("The Dersite deliveryman might know where to find some eggs.");
  giggleSnort("The Mobster Kingpin is known to have a sweet tooth for eggs.");
  giggleSnort("Have you been to see the Yogistic Doctor lately??? His head kind of looks like an egg...");
  giggleSnort("Don't Royal Bakers have a lot of access to eggs???");
  giggleSnort("I hope the Hysterical Dame isn't too hysterical to give you an egg...");
  giggleSnort("Surely the Draconian Dignitary would be too ...dignified to have an egg?");
  giggleSnort("If you can put up with his disconcerting ogle, Pickle Inspector might be up for the job.");
  giggleSnort("Amethyst Copycat might have a gem in the shape of an egg???");
  giggleSnort("Your local Authority Regulator might know where to find an egg.");
  giggleSnort("Clubs Deuce has been known to keep an egg or two under his hat."); //its funny cuz he has paired scenes
  giggleSnort("The Nervous Broad might have some SWEET TIPS for finding easter eggs, so long as you don't make her very nervous.");
}

void giggleSnort(String hideytalk) {
    DivElement snort = new DivElement();
    snort.text = hideytalk;
    div.append(snort);
}
