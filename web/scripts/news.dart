import 'dart:html';
import "LifeSimLib.dart";
import 'dart:async';


Element div;
UListElement list;

void main() {
  //i just think it's funny to watch the style change as it loads.
  div = querySelector("#output");
  list = new UListElement();
  div.append(list);
  div.style.width = "1000px";
  div.style.marginLeft = "auto";
  div.style.marginRight = "auto";
  div.style.textAlign = "left";
  loadNavbar();
  makePosts();
}

void makePosts() {
  print("making posts");
  //post("","");
  post("August 31th", "Am I just now getting around to actually doing card packs? Wow.");
  post("May 15th, 2018", "I unbroke everything. Whoops.");
  post("May 12th, 2018","I've opened up Scene Designing to the masses so that LifeSim phase 2 can kick off on 6/12.");
  post("April 19th, 2018","So, I decided I needed actual newsposts now. <br><br>The 4/13 <a href = 'hallOfFame.html'>Hall of Fame</a> is closed, but people can still get into the 6/12 Hall of Fame if they actuall view the gigglesnorted scenes.<br><br>I made it so you can <a href = 'meteor.html'>manage your save data</a> (mostly clearing it out if it's glitched, or downloading backups or recover files to send to me). <br><br>Also, I'm working on things to do with your Life Bux. Don't your worry about a thing, it will be dumb and memey.");
}

void post(String date, String news) {
  LIElement li = new LIElement();
  li.setInnerHtml("<b>$date</b>: <hr>$news");
  list.append(li);
}