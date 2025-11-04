import 'package:budgeetme/core/theme/theme.dart';
import 'package:flutter/material.dart';

class AppSnackbar {
  AppSnackbar._();

  static void showSuccess(BuildContext context, {required String message}) {
    if (!context.mounted) return;

    final colorScheme = context.colorScheme;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle_rounded, color: colorScheme.onPrimary),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static void showError(BuildContext context, {required String message}) {
    if (!context.mounted) return;

    final colorScheme = context.colorScheme;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error_rounded, color: colorScheme.onError),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
