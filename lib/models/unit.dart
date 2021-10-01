import 'dart:convert';
import 'package:habit_tracker/models/id.dart';
import 'model.dart';
import 'package:meta/meta.dart';

class Unit extends Model {
  final String symbol;
  final String name;
  final String pluralName;

  Unit({
    Id id,
    @required this.symbol,
    @required this.name,
    @required this.pluralName,
  }) : super(id: id);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'symbol': symbol,
      'name': name,
      'pluralName': pluralName,
    };
  }

  factory Unit.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Unit(
      id: map['id'],
      symbol: map['symbol'],
      name: map['name'],
      pluralName: map['pluralName'],
    );
  }

  String toText(int amount) {
    return amount == 1 ? this.name : this.pluralName;
  }

  String toJson() => json.encode(toMap());

  factory Unit.fromJson(String source) => Unit.fromMap(json.decode(source));

  @override
  List<Object> get props => [
        this.id,
        this.symbol,
        this.name,
        this.pluralName,
      ];
}
