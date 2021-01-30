import 'dart:convert';

import 'package:meta/meta.dart';

import 'id.dart';
import 'model.dart';
import 'unit.dart';

class Habit extends Model {
  final String name;
  final Unit unit;
  final DateTime completionTime;

  Habit({
    @required Id id,
    this.name,
    this.unit,
    this.completionTime,
  }) : super(id: id);

  @override
  List<Object> get props => [
        this.id,
        this.name,
        this.unit,
        this.completionTime,
      ];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'unit': unit?.toMap(),
      'completionTime': completionTime?.millisecondsSinceEpoch,
    };
  }

  factory Habit.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Habit(
      id: Id.fromMap(map['id']),
      name: map['name'],
      unit: Unit.fromMap(map['unit']),
      completionTime:
          DateTime.fromMillisecondsSinceEpoch(map['completionTime']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Habit.fromJson(String source) => Habit.fromMap(json.decode(source));
}
