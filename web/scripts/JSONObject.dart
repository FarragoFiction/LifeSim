/*
    should be a wrapper for a map.
    new JsonObject.fromJsonString(json); should be implemented.
 */
import 'dart:collection';
import 'dart:convert';

class JSONObject extends Object with MapMixin<String,String>{
    Map<String, String> jsonData = new Map<String,String>();
    JSONObject();

    JSONObject.fromJSONString(String j){
        jsonData  = json.decode(j);
    }

    static Set<int> jsonStringToIntSet(String str) {
        if(str == null) return new Set<int>();
        //;
        str = str.replaceAll("{", "");
        str = str.replaceAll("}", "");
        str = str.replaceAll(" ", "");

        List<String> tmp = str.split(",");
        Set<int> ret = new Set<int>();
        for(String s in tmp) {
            //;
            try {
                int i = int.parse(s);
                //;
                ret.add(i);
            }catch(e) {
                //oh well. probably a bracket or a space or something
            }
        }
        return ret;
    }

    static List<int> jsonStringToIntArray(String str) {
        if(str == null) return new List<int>();
        //;
        str = str.replaceAll("[", "");
        str = str.replaceAll("]", "");
        str = str.replaceAll(" ", "");

        List<String> tmp = str.split(",");
        List<int> ret = new List<int>();
        for(String s in tmp) {
            //;
            try {
                int i = int.parse(s);
                //;
                ret.add(i);
            }catch(e) {
                //oh well. probably a bracket or a space or something
            }
        }
        return ret;
    }

    static Set<String> jsonStringToStringSet(String str) {
        if(str == null) return new Set<String>();
        //;
        str = str.replaceAll("{", "");
        str = str.replaceAll("}", "");
        str = str.replaceAll(" ", "");

        List<String> tmp = str.split(",");
        Set<String> ret = new Set<String>();
        for(String s in tmp) {
            //;
            try {
                //;
                ret.add(s);
            }catch(e) {
                //oh well. probably a bracket or a space or something
            }
        }
        return ret;
    }

    @override
    String toString() {
        return json.encode(jsonData);
    }

  @override
  String operator [](Object key) {
    return jsonData[key];
  }

  @override
  void operator []=(String key, String value) {
    jsonData[key] = value;
  }

  @override
  void clear() {
    jsonData.clear();
  }

  @override
  Iterable<String> get keys => jsonData.keys;

  @override
  String remove(Object key) {
   jsonData.remove(key);
  }
}