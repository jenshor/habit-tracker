import 'package:habit_tracker/models/id.dart';
import 'package:habit_tracker/models/unit.dart';
import 'package:habit_tracker/models/volume.dart';
import 'package:test/test.dart';

Id id = Id('1');
Volume createTimeBasedVolume(
  int amount,
) {
  return Volume(
      id: id,
      amount: amount,
      unit: Unit(
        name: 'minute',
        pluralName: 'minutes',
        symbol: 'm',
      ));
}

void testTextWithName(
  int amount,
  String expected,
) {
  var result = createTimeBasedVolume(amount).toExtendedText();
  expect(result, equals(expected));
}

main() {
  group('Test method', () {
    Volume unit = createTimeBasedVolume(30);

    test('toTextWithSymbol: Expect amount and symbol', () {
      var result = unit.toSymbolText();
      expect(result, equals('30m'));
    });

    test('toTextWithName: Expect 30 minutes',
        () => testTextWithName(30, '30 minutes'));
    test('toTextWithName: Expect 1 minute',
        () => testTextWithName(1, '1 minute'));
  });
}
