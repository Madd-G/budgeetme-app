import 'package:budgeetme/core/theme/theme.dart';
import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.expense,
          side: const BorderSide(color: AppColors.expense),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.delete_rounded),
            const SizedBox(width: 8),
            Text(
              'Hapus Transaksi',
              style: AppFont.titleMedium.copyWith(
                color: AppColors.expense,
                fontWeight: AppFont.semiBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
