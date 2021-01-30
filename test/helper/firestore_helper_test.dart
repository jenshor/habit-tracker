import 'package:habit_tracker/helper/firestore_helper.dart';
import 'package:test/test.dart';

main() {
  group('FirestoreHelper', () {
    test('returns correct path when called with two subpaths', () {
      String expected = 'test/anothertest';
      String result = FirestoreHelper.getCollectionPath([
        'test',
        'anothertest',
      ]);
      expect(expected, equals(result));
    });

    test('returns correct path when called with empty list', () {
      String expected = '';
      String result = FirestoreHelper.getCollectionPath([]);
      expect(expected, equals(result));
    });

    test('returns correct path when called with single path', () {
      String expected = 'test';
      String result = FirestoreHelper.getCollectionPath([expected]);
      expect(expected, equals(result));
    });
  });
}
