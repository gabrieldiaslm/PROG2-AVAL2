import 'dart:convert';
import 'dart:io';

class Atom {
  final String symbol;
  Atom(this.symbol);

  bool validateSymdol(String symbol) {
    var file = File('elements.json').readAsStringSync();
    final json = jsonDecode(file);
    for (var a in json) {
      if (a['symbol'] == symbol) {
        return true;
      }
    }
    return false;
  }
}
