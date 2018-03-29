import 'dart:html';
import "LifeSimLib.dart";
import 'dart:async';


Element div;

void main() {
  //i just think it's funny to watch the style change as it loads.
  div = querySelector("#output");
  div.style.width = "1000px";
  div.style.marginLeft = "300px";
  div.style.textAlign = "left";
  loadNavbar();
}