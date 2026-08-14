import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static String hourLabel(DateTime dt) => DateFormat('h a').format(dt);

  static String dayLabel(DateTime dt) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(dt.year, dt.month, dt.day);
    final diff = target.difference(today).inDays;
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Tomorrow';
    return DateFormat('EEEE').format(dt);
  }

  static String shortDate(DateTime dt) => DateFormat('MMM d, yyyy').format(dt);

  static String timeOnly(DateTime dt) => DateFormat('h:mm a').format(dt);

  static String lastUpdated(DateTime dt) =>
      'Updated ${DateFormat('h:mm a').format(dt)}';
}
