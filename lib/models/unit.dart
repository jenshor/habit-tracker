class Unit {
  String id;
  int amount;
  String symbol;
  String name;

  Unit({
    this.id,
    this.amount,
    this.symbol,
    this.name,
  });

  String toTextWithSymbol() {
    return '$amount$symbol';
  }

  // TODO check for a better implementation later
  String nameToText() {
    String returnValue = name;

    if (amount != 1) {
      returnValue += 's';
    }

    return returnValue;
  }

  String toTextWithName() {
    return '$amount ${nameToText()}';
  }
}
