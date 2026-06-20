class ReminderTimeResolver {
  const ReminderTimeResolver();

  DateTime nextLocalOccurrence({
    required DateTime day,
    required int hour,
    required int minute,
  }) {
    return DateTime(day.year, day.month, day.day, hour, minute);
  }
}
