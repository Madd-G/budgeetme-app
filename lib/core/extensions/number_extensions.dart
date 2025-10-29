import 'package:intl/intl.dart';

extension NumberExtensions on num {
  /// Formats number as Indonesian Rupiah currency
  /// Example: 50000 → "Rp 50.000"
  String toRupiah() {
    final formatted = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(this);

    return formatted.replaceFirst('Rp', 'Rp ').trim();
  }

  /// Example: 50000 → "50.000"
  String toCompactCurrency() {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: '',
      decimalDigits: 0,
    ).format(this).trim();
  }
}
