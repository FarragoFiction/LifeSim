import 'dart:html';
import "LifeSimLib.dart";
import 'dart:async';


Element div;
List<String> snorts = new List<String>();
void main() {
  loadNavbar();
  showLibrary();
  showFound();
  showViewd();

}
void showLibrary() {
  ButtonElement button =  new ButtonElement();
  button.text = "destroy your card library save data?";
  querySelector('#output').append(button);

  button.onClick.listen((e) {
    if(window.confirm("Are you sure? You can't undo this...")) {
      window.localStorage.remove(CardLibrary.CARDSAVESTRING);
      window.location.href = "index.html";
    }
  });

  if(window.localStorage.containsKey(CardLibrary.CARDSAVESTRING)) {
    AnchorElement saveLink = new AnchorElement();
    saveLink.href = new UriData.fromString(window.localStorage[CardLibrary.CARDSAVESTRING], mimeType: "text/plain").toString();
    saveLink.target = "_blank";
    saveLink.download = "recoverFileLifeSimLibrary.txt";
    saveLink.setInnerHtml("Download Last Minute Backup/Recover file for Library?");
    querySelector('#output').append(saveLink);
  }
}


void showViewd() {
  ButtonElement button =  new ButtonElement();
  button.text = "destroy your viewed scene save data?";
  querySelector('#output').append(button);

  button.onClick.listen((e) {
    if(window.confirm("Are you sure? You can't undo this...")) {
      window.localStorage.remove(CardLibrary.VIEWEDSCENES);
      window.location.href = "index.html";
    }
  });

  if(window.localStorage.containsKey(CardLibrary.VIEWEDSCENES)) {
    AnchorElement saveLink = new AnchorElement();
    saveLink.href = new UriData.fromString(window.localStorage[CardLibrary.VIEWEDSCENES], mimeType: "text/plain").toString();
    saveLink.target = "_blank";
    saveLink.download = "recoverFileLifeSimViewedScenes.txt";
    saveLink.setInnerHtml("Download Last Minute Backup/Recover file for Viewed Scenes?");
    querySelector('#output').append(saveLink);
  }
}


void showFound() {
  ButtonElement button =  new ButtonElement();
  button.text = "destroy your found but unclaimed cards?";
  querySelector('#output').append(button);

  button.onClick.listen((e) {
    if(window.confirm("Are you sure? You can't undo this...")) {
      window.localStorage.remove(CardLibrary.FOUNDCARDSSTRING);
      window.location.href = "index.html";
    }
  });

  if(window.localStorage.containsKey(CardLibrary.FOUNDCARDSSTRING)) {
    AnchorElement saveLink = new AnchorElement();
    saveLink.href = new UriData.fromString(window.localStorage[CardLibrary.FOUNDCARDSSTRING], mimeType: "text/plain").toString();
    saveLink.target = "_blank";
    saveLink.download = "recoverFileLifeSimFoundCards.txt";
    saveLink.setInnerHtml("Download Last Minute Backup/Recover file for Found Cards?");
    querySelector('#output').append(saveLink);
  }
}