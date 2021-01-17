import 'dart:convert';

import 'package:habit_tracker/models/unit.dart';

class Volume {
  int amount;
  Unit unit;

  Volume({
    this.amount,
    this.unit,
  });

  // TODO check for better implementation
  String getAmountDependingName() {
    String returnValue = unit.name;

    if (amount != 1) {
      returnValue += 's';
    }

    return returnValue;
  }

  String toExtendedText() {
    return '$amount ${getAmountDependingName()}';
  }

  String toSymbolText() {
    return '$amount${unit.symbol}';
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'unit': unit?.toMap(),
    };
  }

  factory Volume.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Volume(
      amount: map['amount'],
      unit: Unit.fromMap(map['unit']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Volume.fromJson(String source) => Volume.fromMap(json.decode(source));
}
