import 'package:habit_tracker/helper/date_time_provider.dart';
import 'package:habit_tracker/models/habit.dart';

class DateTimeHelper {
  final DateTimeProvider dateTimeProvider;

  DateTimeHelper({DateTimeProvider dateTimeProvider})
      : this.dateTimeProvider = dateTimeProvider ?? DateTimeProvider();

  bool isCompletedToday(Habit habit) {
    DateTime today = dateTimeProvider.getCurrentDay();
    DateTime time = habit.completionTimes.firstWhere(
      (DateTime date) => date.isAtSameMomentAs(today),
      orElse: () => null,
    );

    return time != null;
  }
}
