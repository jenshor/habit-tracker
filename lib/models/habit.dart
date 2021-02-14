import 'dart:convert';

import 'package:meta/meta.dart';

import 'package:habit_tracker/models/volume.dart';

import 'id.dart';
import 'model.dart';
import 'unit.dart';

class Habit extends Model {
  final String name;
  final Unit unit;
  final Volume volume;
  final List<DateTime> completionDates;
  final int streak;

  Habit({
    @required Id id,
    this.name,
    this.unit,
    this.volume,
    this.streak = 0,
    List<DateTime> completionDates,
  })  : this.completionDates = completionDates ?? <DateTime>[],
        super(id: id);

  Habit.fromDate({
    @required String name,
    Unit unit,
    Volume volume,
    @required DateTime date,
  }) : this(
          name: name,
          unit: unit,
          volume: volume,
          id: Id.fromDate(date: date),
        );

  Habit copyWith({
    Id id,
    String name,
    Unit unit,
    Volume volume,
    int streak,
    List<DateTime> completionTimes,
  }) {
    return Habit(
      id: id ?? this.id,
      name: name ?? this.name,
      unit: unit ?? this.unit,
      volume: volume ?? this.volume,
      streak: streak ?? this.streak,
      completionDates: completionTimes ?? this.completionDates,
    );
  }

  @override
  List<Object> get props => [
        this.id,
        this.name,
        this.volume,
        this.unit,
        ...this.completionDates,
      ];

  Map<String, dynamic> toMap() {
    return {
      'id': id?.toMap(),
      'name': name,
      'unit': unit?.toMap(),
      'volume': volume?.toMap(),
      'completionDates':
          completionDates?.map((x) => x?.millisecondsSinceEpoch)?.toList(),
    };
  }

  factory Habit.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Habit(
      id: Id.fromMap(map['id']),
      name: map['name'],
      unit: Unit.fromMap(map['unit']),
      volume: Volume.fromMap(map['volume']),
      completionDates: List<DateTime>.from(map['completionDates']
              ?.map((x) => DateTime.fromMillisecondsSinceEpoch(x)) ??
          <DateTime>[]),
    );
  }

  String toJson() => json.encode(toMap());

  factory Habit.fromJson(String source) => Habit.fromMap(json.decode(source));
}
