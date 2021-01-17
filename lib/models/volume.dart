import 'package:habit_tracker/models/unit.dart';

class Volume {
  int amount;
  Unit unit;

  Volume({
    this.amount,
    this.unit,
  });

  // TODO check for better implementation
  String getAmountDependingName() {
    String returnValue = unit.name;

    if (amount != 1) {
      returnValue += 's';
    }

    return returnValue;
  }

  String toExtendedText() {
    return '$amount ${getAmountDependingName()}';
  }

  String toSymbolText() {
    return '$amount${unit.symbol}';
  }
}
