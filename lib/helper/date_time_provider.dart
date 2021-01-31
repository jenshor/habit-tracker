class DateTimeProvider {
  DateTime getCurrentTime() {
    return DateTime.now();
  }

  DateTime getCurrentDay() {
    return getDayWithoutTime(getCurrentTime());
  }

  DateTime getDayWithoutTime(DateTime dateTime) {
    return DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
    );
  }
}
