import 'package:intl/intl.dart';

const _weekdays = [
  'Senin',
  'Selasa',
  'Rabu',
  'Kamis',
  'Jumat',
  'Sabtu',
  'Minggu',
];

const _monthsFull = [
  'Januari',
  'Februari',
  'Maret',
  'April',
  'Mei',
  'Juni',
  'Juli',
  'Agustus',
  'September',
  'Oktober',
  'November',
  'Desember',
];

const _monthsShort = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'Mei',
  'Jun',
  'Jul',
  'Agt',
  'Sep',
  'Okt',
  'Nov',
  'Des',
];

extension DateTimeExtensions on DateTime {
  /// Example: "Senin, 28 Oktober 2024"
  String toIndonesianLongFormat() {
    final weekday = _weekdays[this.weekday - 1];
    final month = _monthsFull[this.month - 1];
    return '$weekday, $day $month $year';
  }

  /// Example: "28 Okt 2024"
  String toShortDateFormat() {
    return '$day ${_monthsShort[month - 1]} $year';
  }

  /// Example: "2024-10-28"
  String toApiFormat() {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  /// Converts to Indonesia Western Time (WIB, UTC+7)
  DateTime toWib() {
    return toUtc().add(const Duration(hours: 7));
  }

  /// Gets date part only
  DateTime get dateOnly {
    return DateTime(year, month, day);
  }

  /// Returns "Hari ini", "Kemarin", weekday name, or full date
  String toRelativeDateLabel() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final thisDate = DateTime(year, month, day);

    if (thisDate == today) {
      return 'Hari ini';
    } else if (thisDate == yesterday) {
      return 'Kemarin';
    } else if (now.difference(this).inDays < 7) {
      return _weekdays[weekday - 1];
    } else {
      return '$day ${_monthsShort[month - 1]}';
    }
  }

  /// Example: "28 Januari, 2024"
  String toGroupingFormat() {
    return '$day ${_monthsFull[month - 1]}, $year';
  }
}

extension StringDateExtensions on String {
  DateTime? parseTransactionDate() {
    final raw = trim();
    if (raw.endsWith('Z')) {
      final stripped = raw.substring(0, raw.length - 1);
      return DateTime.tryParse(stripped);
    }
    return DateTime.tryParse(raw);
  }
}
