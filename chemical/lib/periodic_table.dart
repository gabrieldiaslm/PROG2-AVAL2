import 'dart:convert';
import 'dart:io';
import 'element.dart';

class PeriodicTable {

  static var elements = loadElements();



  static Map<String, Element> loadElements() {
    var l = File('elements.json').readAsStringSync();
    var jsonData = jsonDecode(l) as List<dynamic>;
    
  return Map.fromEntries(
    jsonData.map((c) => MapEntry(
      c['symbol'],
      Element(
        symbol: c['symbol'],
        name: c['name'],
        latinName: c['latinName'],
        weight: int.parse(c['weight']),
      ),
    )),
  );

    
  }
}
