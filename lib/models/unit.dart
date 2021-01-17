import 'dart:convert';

import 'package:habit_tracker/models/id.dart';

import 'model.dart';

class Unit extends Model {
  final String symbol;
  final String name;

  Unit({
    Id id,
    this.symbol,
    this.name,
  }) : super(id: id);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'symbol': symbol,
      'name': name,
    };
  }

  factory Unit.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Unit(
      id: map['id'],
      symbol: map['symbol'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Unit.fromJson(String source) => Unit.fromMap(json.decode(source));

  @override
  List<Object> get props => [
        this.id,
        this.symbol,
        this.name,
      ];
}
