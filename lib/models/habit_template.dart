import 'dart:convert';

import 'package:habit_tracker/models/volume.dart';

class HabitTemplate {
  String name;
  Volume volume;
  DateTime creationTime;

  HabitTemplate({
    this.name,
    this.volume,
    this.creationTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'volume': volume?.toMap(),
      'creationTime': creationTime?.millisecondsSinceEpoch,
    };
  }

  factory HabitTemplate.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return HabitTemplate(
      name: map['name'],
      volume: Volume.fromMap(map['volume']),
      creationTime: DateTime.fromMillisecondsSinceEpoch(map['creationTime']),
    );
  }

  String toJson() => json.encode(toMap());

  factory HabitTemplate.fromJson(String source) =>
      HabitTemplate.fromMap(json.decode(source));
}
