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
}
