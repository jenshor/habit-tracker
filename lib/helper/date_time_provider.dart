class DateTimeProvider {
  DateTime getCurrentTime() {
    return DateTime.now();
  }

  DateTime getCurrentDay() {
    DateTime currentTime = getCurrentTime();
    return DateTime(
      currentTime.year,
      currentTime.month,
      currentTime.day,
    );
  }
}
