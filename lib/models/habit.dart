import 'unit.dart';

class Habit {
  String id;
  String name;
  Unit unit;
  DateTime lastChangedTime;
  DateTime completionTime;

  Habit({
    this.id,
    this.name,
    this.unit,
    this.lastChangedTime,
    this.completionTime,
  });
}
