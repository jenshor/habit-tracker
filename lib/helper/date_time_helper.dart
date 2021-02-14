import 'package:habit_tracker/helper/date_time_provider.dart';
import 'package:habit_tracker/models/habit.dart';

class DateTimeHelper {
  final DateTimeProvider dateTimeProvider;

  DateTimeHelper({DateTimeProvider dateTimeProvider})
      : this.dateTimeProvider = dateTimeProvider ?? DateTimeProvider();

  bool isCompletedToday(Habit habit) {
    DateTime today = dateTimeProvider.getCurrentDay();
    DateTime time = habit.completionDates.firstWhere(
      (DateTime date) => date.isAtSameMomentAs(today),
      orElse: () => null,
    );

    return time != null;
  }

  bool isCompletedOnDay(Habit habit, DateTime date) {
    DateTime day = dateTimeProvider.getDayWithoutTime(date);
    DateTime time = habit.completionDates.firstWhere(
      (DateTime date) => date.isAtSameMomentAs(day),
      orElse: () => null,
    );

    return time != null;
  }

  bool isDateInList(
    List<DateTime> list,
    DateTime date,
  ) {
    for (DateTime dateItem in list) {
      if (dateItem.day == date.day &&
          dateItem.month == date.month &&
          dateItem.year == date.year) {
        return true;
      }
    }
    return false;
  }
}
