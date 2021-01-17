import 'unit.dart';

class Habit {
  String id;
  String name;
  Unit unit;
  DateTime creationTime;
  DateTime lastChangedTime;
  DateTime completionTime;

  Habit({
    this.id,
    this.name,
    this.unit,
    this.creationTime,
    this.lastChangedTime,
    this.completionTime,
  });
}
