import 'dart:collection';

import 'package:habit_tracker/helper/date_time_provider.dart';
import 'package:habit_tracker/models/habit.dart';

class StreakProvider {
  final DateTimeProvider dateTimeProvider;

  StreakProvider({DateTimeProvider dateTimeProvider})
      : this.dateTimeProvider = dateTimeProvider ?? DateTimeProvider();

  int getStreak(Habit habit) {
    List<DateTime> completionDates = habit.completionDates;
    completionDates.sort();
    completionDates = completionDates.reversed.toList();
    Queue<DateTime> dates = Queue<DateTime>.from(completionDates);
    DateTime today = dateTimeProvider.getCurrentDay();

    bool hasStreakEnded = false;
    DateTime currentDate = today;
    int streak = 0;
    while (!hasStreakEnded && dates.isNotEmpty) {
      DateTime nextDate = dates.removeFirst();
      Duration difference = currentDate.difference(nextDate);
      if (today == nextDate) {
        streak++;
      } else if (difference == Duration(days: 1)) {
        streak++;
      } else {
        hasStreakEnded = true;
      }

      currentDate = nextDate;
    }

    return streak;
  }
}
