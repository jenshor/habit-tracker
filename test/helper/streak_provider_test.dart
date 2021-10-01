import 'package:habit_tracker/helper/date_time_provider.dart';
import 'package:habit_tracker/helper/streak_provider.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/models/id.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../mocks/date_time_provider_mock.dart';

Id defaultId = Id('1');
DateTime defaultDay = DateTime(2021, 01, 01);
main() {
  group('StreakProvider', () {
    DateTimeProvider dateTimeProvider = DateTimeProviderMock();
    when(dateTimeProvider.getCurrentDay()).thenReturn(defaultDay);
    test('returns 0 if habit has no completions', () {
      Habit habit = new Habit(id: defaultId, completionDates: []);
      StreakProvider().getStreak(habit);
    });

    test('returns 1 if habit has been completed today', () {
      Habit habit = new Habit(id: defaultId, completionDates: []);
      StreakProvider(dateTimeProvider: dateTimeProvider).getStreak(habit);
    });

    test(
        'returns 4 if habit has been completed on four consecutive days including today',
        () {
      List<DateTime> dateTimes = List<DateTime>.generate(
        3,
        (index) => defaultDay.subtract(Duration(days: index)),
      );

      Habit habit =
          new Habit(id: defaultId, completionDates: [defaultDay, ...dateTimes]);
      StreakProvider(dateTimeProvider: dateTimeProvider).getStreak(habit);
    });

    test(
        'returns 3 if habit has been completed on four consecutive days excluding today',
        () {
      List<DateTime> dateTimes = List<DateTime>.generate(
        3,
        (index) => defaultDay.subtract(Duration(days: index)),
      );

      Habit habit = new Habit(id: defaultId, completionDates: [...dateTimes]);
      StreakProvider(dateTimeProvider: dateTimeProvider).getStreak(habit);
    });

    test(
        'returns 0 if habit has not been completed on consecutive recent days but other days exist',
        () {
      List<DateTime> dateTimes = List<DateTime>.generate(
        3,
        (index) => defaultDay.subtract(Duration(days: index + 1)),
      );

      Habit habit =
          new Habit(id: defaultId, completionDates: [defaultDay, ...dateTimes]);
      StreakProvider(dateTimeProvider: dateTimeProvider).getStreak(habit);
    });
  });
}
