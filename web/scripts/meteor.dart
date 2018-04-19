import 'dart:html';
import "LifeSimLib.dart";
import 'dart:async';


List<String> snorts = new List<String>();
Element div;
void main() {
  loadNavbar();
  div = querySelector('#output');
  Element libraryDiv = new DivElement();
  Element foundDiv = new DivElement();
  Element viewDiv = new DivElement();
  div.append(libraryDiv);
  div.append(foundDiv);
  div.append(viewDiv);
  showLibrary(libraryDiv);
  showFound(foundDiv);
  showViewd(viewDiv);

}


void displayShit(Element container, String saveString, String name) {
  ButtonElement button =  new ButtonElement();
  button.text = "destroy your $name save data?";
  container.append(button);

  button.onClick.listen((e) {
    if(window.confirm("Are you sure? You can't undo this...")) {
      window.localStorage.remove(saveString);
      window.location.href = window.location.href;
    }
  });

  if(window.localStorage.containsKey(saveString)) {
    AnchorElement saveLink = new AnchorElement();
    saveLink.href = new UriData.fromString(window.localStorage[saveString], mimeType: "text/plain").toString();
    saveLink.target = "_blank";
    saveLink.download = "recoverFileLifeSim${name.replaceAll(" ", "_")}.txt";
    saveLink.setInnerHtml("Download Last Minute Backup/Recover file for $name?");
    container.append(saveLink);
  }

  InputElement fileElement = new InputElement();
  fileElement.type = "file";
  fileElement.setInnerHtml("Restore from Save Backup?");
  container.append(fileElement);
  container.append(container);

  fileElement.onChange.listen((e) {
    List<File> loadFiles = fileElement.files;
    File file = loadFiles.first;
    FileReader reader = new FileReader();
    reader.readAsText(file);
    reader.onLoadEnd.listen((e) {
      String loadData = reader.result;
      window.localStorage[saveString] = loadData;
      window.location.href = window.location.href;
    });
  });
}


void showLibrary(Element container) {
  displayShit(container, CardLibrary.CARDSAVESTRING, "Card Library");
}


void showViewd(Element container) {
  displayShit(container, CardLibrary.VIEWEDSCENES, "Viewed Scenes");
}


void showFound(Element container) {
  displayShit(container, CardLibrary.FOUNDCARDSSTRING, "Found But Unclaimed Cards");
}