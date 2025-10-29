import 'package:budgeetme/core/extensions/number_extensions.dart';
import 'package:flutter/services.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  CurrencyInputFormatter({this.maxDigits = 12});

  final int maxDigits;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final digitsOnly = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    if (digitsOnly.length > maxDigits) {
      return oldValue;
    }

    final number = int.tryParse(digitsOnly);
    if (number == null) {
      return oldValue;
    }

    final formatted = number.toCompactCurrency();

    final newCursorPosition = formatted.length;

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: newCursorPosition),
    );
  }

  static double? parse(String formattedValue) {
    if (formattedValue.isEmpty) return null;
    final digitsOnly = formattedValue.replaceAll(RegExp(r'[^\d]'), '');
    return double.tryParse(digitsOnly);
  }
}
