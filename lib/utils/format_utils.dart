import 'package:intl/intl.dart';

class FormatUtils {
  /// Formats the date to a relative format or MMM d.
  static String formatDateRelative(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final input = DateTime(date.year, date.month, date.day);
    final difference = input.difference(today).inDays;

    if (difference == 0) return 'Today';
    if (difference == -1) return 'Yesterday';
    if (difference == 1) return 'Tomorrow';

    return DateFormat('MMM d').format(date); // e.g. May 12
  }

  /// Formats the date to a full date format.
  static String formatDateFull(DateTime date) {
    return DateFormat(
      "MMM d'${_getDaySuffix(date.day)}', y (EEEE)",
    ).format(date);
  }

  /// Formats the date to a short date format.
  static String formatDateShort(DateTime date) {
    return DateFormat('MMMM d, y').format(date);
  }

  /// Gets suffix for day of the month.
  static String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  /// Formats the number with commas.
  static String formatNumberComma(num number) {
    return NumberFormat('#,###').format(number);
  }
}
