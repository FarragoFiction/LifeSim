import "dart:async";
import "dart:html";



class ArtCategory {
    static const String testPath = "http://farragofiction.com/LifeSim/";
    static const bool testMode = true;

    String name;
    String title;
    String tag;
    String url;

    ArtCategory(String this.name, String this.title, String this.tag, {String this.url = null});
}

class ImageHandler {


//############################################################################################
// DATA! Mmmmm data.
//############################################################################################


    static List<String> extensions = <String>[
        "png",
        "gif",
        "jpg",
        "jpeg",
    ];

//############################################################################################

    RegExp filePattern = new RegExp('<a href="([^?]*?)">');
    RegExp extensionPattern = new RegExp("\\\.(${extensions.join("|")})\$");
    RegExp numberedFilePattern = new RegExp("([a-zA-Z_]+?)(\\d+?)\\.");
    Element imageContainer;
    List<ImageElement> images;
    ArtCategory category;

    //new ArtCategory("Smut","Smut", "smut",url: "images/misc/fanArt/miscFanArt/")
    ImageHandler(Element this.imageContainer, ArtCategory this.category) {
        //whoever calls this  await the category
    }

    List<Element> imageTiles = <Element>[];

    String adjustURL(String url) {
        if (ArtCategory.testMode) {
            return "${ArtCategory.testPath}$url";
        }
        return url;
    }


    void addImageToPage(Element image, String title, bool alwaysShowTitle, {String imageClass = "image", String tileClass = "imageTile"}) {
        image.className = imageClass;

        Element tile = new DivElement()
            ..className = tileClass
            ..dataset["name"] = title;

        if (image is ImageElement) {
            tile
                ..append(new AnchorElement(href: image.src)
                    ..target = "_blank"
                    ..append(image)
                );
        } else {
            tile..append(image);
        }

        if (alwaysShowTitle) {
            tile
                ..append(new DivElement()
                    ..className = "imagename_always"
                    ..text = title);
        } else {
            tile
                ..append(new DivElement()
                    ..className = "imagename"
                    ..text = title);
        }

        imageContainer.append(tile);
        imageTiles.add(tile);
    }


    Future<List<String>> getDirectoryListing(String url) async {
        url = adjustURL(url);
        List<String> files = <String>[];
        String content = await HttpRequest.getString(url);
        Iterable<Match> matches = filePattern.allMatches(content); // find all link targets
        for (Match m in matches) {
            String filename = m.group(1);
            if (!extensionPattern.hasMatch(filename)) {
                continue;
            } // extension rejection

            //print(filename);

            files.add(filename);
        }

        return files;
    }

    Future<List<ImageElement>> getImageCategory() async {
        List<String> files = await getDirectoryListing(category.url);
        List<ImageElement> ret = new List<ImageElement>();
        for (String filename in files) {
            ret.add(new ImageElement(src: "${adjustURL(category.url)}$filename"));
        }
        return ret;
    }


}




