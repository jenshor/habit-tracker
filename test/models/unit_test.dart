import 'package:habit_tracker/models/unit.dart';
import 'package:test/test.dart';

Unit createTimeBasedUnit(
  int amount,
) {
  return Unit(
    name: 'minute',
    amount: amount,
    symbol: 'm',
  );
}

void testTextWithName(
  int amount,
  String expected,
) {
  var result = createTimeBasedUnit(amount).toTextWithName();
  expect(result, equals(expected));
}

main() {
  group('Test method', () {
    Unit unit = createTimeBasedUnit(30);

    test('toTextWithSymbol: Expect amount and symbol', () {
      var result = unit.toTextWithSymbol();
      expect(result, equals('30m'));
    });

    test('toTextWithName: Expect 30 minutes',
        () => testTextWithName(30, '30 minutes'));
    test('toTextWithName: Expect 1 minute',
        () => testTextWithName(1, '1 minute'));
  });
}
