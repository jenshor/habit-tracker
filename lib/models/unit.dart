class Unit {
  String id;
  double amount;
  String symbol;
  String name;

  Unit({
    this.id,
    this.amount,
    this.symbol,
    this.name,
  });

  String toTextWithSymbol() {
    return '$amount $symbol';
  }

  String toTextWithName() {
    return '$amount $name';
  }
}
