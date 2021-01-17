import 'dart:convert';

class Unit {
  String id;
  String symbol;
  String name;

  Unit({
    this.id,
    this.symbol,
    this.name,
  });

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
}
