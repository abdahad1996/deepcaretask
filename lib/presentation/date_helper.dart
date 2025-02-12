extension DateTimeExtensions on DateTime {
  /// Returns time in "HH:mm" format
  String toFormattedTime() {
    return '${_twoDigits(hour)}:${_twoDigits(minute)}';
  }

  /// Returns date in "So. 2. Feb. KW 5" format
  String toFormattedDate() {
    final List<String> weekdays = [
      "Mo.",
      "Di.",
      "Mi.",
      "Do.",
      "Fr.",
      "Sa.",
      "So."
    ]; // German short day names
    final List<String> months = [
      "Jan.",
      "Feb.",
      "März",
      "Apr.",
      "Mai",
      "Juni",
      "Juli",
      "Aug.",
      "Sep.",
      "Okt.",
      "Nov.",
      "Dez."
    ];

    String weekdayStr = weekdays[weekday - 1]; // Ensure weekday is an integer
    String monthStr = months[month - 1];

    return '$weekdayStr $day. $monthStr  KW ${_getWeekOfYear()}';
  }

  /// Returns the week number of the year
  int _getWeekOfYear() {
    final firstDayOfYear = DateTime(year, 1, 1);
    return ((difference(firstDayOfYear).inDays + firstDayOfYear.weekday) / 7)
        .ceil();
  }

  static String _twoDigits(int n) => n.toString().padLeft(2, '0');
}
