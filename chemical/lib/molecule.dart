import 'dart:convert';
import 'dart:io';
import 'element.dart';

class Molecule implements Comparable {
  final String formula;
  final String name;

  Molecule({
    required this.formula,
    required this.name,
  });
  get elementsAll => moleculess();

  List<Element> moleculess() {
    List<Element> molecules = [];

    var file = File('./elementjson/elements.json').readAsStringSync();
    final json = jsonDecode(file) as List<dynamic>;
    for (var elementOne in json) {
      int weight = int.parse(elementOne['weight']);
      molecules.add(Element(symbol: elementOne['symbol'], weight: weight));
    }

    return molecules;
  }

  List<ElementInfo> get elements => splitFormula();

  List<ElementInfo> splitFormula() {
    List<ElementInfo> elements = [];
    RegExp regExp = RegExp(r'([A-Z][a-z]*)(\d*)');

    Iterable<RegExpMatch> matches = regExp.allMatches(formula);

    for (RegExpMatch match in matches) {
      String symbol = match.group(1)!;
      String quantityMatch = match.group(2)!;
      int quantity = quantityMatch.isEmpty ? 1 : int.parse(quantityMatch);

      elements.add(ElementInfo(symbol, quantity));
    }

    return elements;
  }

  num get weight => weightElements();

  num weightElements() {
    num totalWeight = 0;

    for (var elementInfo in elements) {
      for (var element in elementsAll) {
        if (element.symbol == elementInfo.symbol) {
          totalWeight += element.weight * elementInfo.quantity;
          break;
        }
      }
    }

    return totalWeight;
  }

  @override
  String toString() {
    return '$elementsAll';
  }

  @override
  int compareTo(other) {
    try {
      if (weight == other.weight) return 0;
      return (weight > other.weight) ? 1 : -1;
    } catch (e) {
      throw Exception(e);
    }
  }
}

class ElementInfo {
  final String symbol;
  final int quantity;

  ElementInfo(this.symbol, this.quantity);

  @override
  String toString() {
    return '$symbol$quantity';
  }
}
