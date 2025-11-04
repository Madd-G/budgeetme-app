import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF6366F1);
  static const Color secondary = Color(0xFF8B5CF6);

  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);

  static const Color income = success;
  static const Color expense = error;

  static const Color overlay = Color(0x66000000);
}

extension ThemeExtension on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

}
