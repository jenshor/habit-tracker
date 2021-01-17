import 'dart:convert';
import 'package:habit_tracker/models/model.dart';
import 'package:habit_tracker/models/volume.dart';
import 'package:meta/meta.dart';
import 'id.dart';

class HabitTemplate extends Model {
  final String name;
  final Volume volume;

  HabitTemplate({
    @required Id id,
    this.name,
    this.volume,
  }) : super(id: id);

  Map<String, dynamic> toMap() {
    return {
      'id': id.toMap(),
      'name': name,
      'volume': volume?.toMap(),
    };
  }

  factory HabitTemplate.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return HabitTemplate(
      id: Id.fromMap(map['id']),
      name: map['name'],
      volume: Volume.fromMap(map['volume']),
    );
  }

  String toJson() => json.encode(toMap());

  factory HabitTemplate.fromJson(String source) =>
      HabitTemplate.fromMap(json.decode(source));

  @override
  List<Object> get props => [
        this.name,
        this.volume,
        this.id,
      ];
}
