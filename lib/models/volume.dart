import 'dart:convert';

import 'package:habit_tracker/models/model.dart';
import 'package:habit_tracker/models/unit.dart';
import 'package:meta/meta.dart';

import 'id.dart';

class Volume extends Model {
  final int amount;
  final Unit unit;

  Volume({
    @required Id id,
    this.amount,
    this.unit,
  }) : super(id: id);

  String toExtendedText() {
    return '$amount ${unit.toText(amount)}';
  }

  String toSymbolText() {
    return '$amount${unit.symbol}';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id.toMap(),
      'amount': amount,
      'unit': unit?.toMap(),
    };
  }

  factory Volume.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Volume(
      id: map['id'],
      amount: map['amount'],
      unit: Unit.fromMap(map['unit']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Volume.fromJson(String source) => Volume.fromMap(json.decode(source));

  @override
  List<Object> get props => [
        this.id,
        this.amount,
        this.unit,
      ];
}
