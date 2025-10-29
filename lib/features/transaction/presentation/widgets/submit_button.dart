import 'package:budgeetme/core/theme/theme.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    required this.isLoading,
    required this.isIncome,
    required this.isEditing,
    required this.onPressed,
    super.key,
  });

  final bool isLoading;
  final bool isIncome;
  final bool isEditing;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final buttonColor = isIncome ? AppColors.income : AppColors.expense;

    return SizedBox(
      height: 56,
      child: FilledButton(
        onPressed: isLoading ? null : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: buttonColor,
          disabledBackgroundColor: buttonColor.withValues(alpha: 0.5),
        ),
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: colorScheme.onPrimary,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(isEditing ? Icons.check_rounded : Icons.add_rounded),
                  const SizedBox(width: 8),
                  Text(
                    isEditing ? 'Simpan Perubahan' : 'Tambah Transaksi',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: AppFont.semiBold,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
