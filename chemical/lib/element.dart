import 'dart:convert';
import 'dart:io';
import 'atom.dart';

class Element {
  final String symbol;
  final String? name;
  final String? latinName;
  final int weight;

  Element({
    required String symbol,
    this.name,
    this.latinName,
    required this.weight,
  }) : symbol = symbol {
    if (validateSymbol(symbol) == false) {
      throw Exception("invalid");
    }
  }

  bool validateSymbol(String symbol) {
    var jsonData = jsonDecode(File('./elementjson/elements.json').readAsStringSync());
    for (var s in jsonData) {
      if (s['symbol'] == symbol) {
        return true;
      }
    }
    return false;
  }
  
  @override
  String toString() {
    return 'symbol: $symbol, name: $name, latinName: $latinName, weight: $weight';
  }
}
