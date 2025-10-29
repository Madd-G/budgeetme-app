import 'package:budgeetme/core/theme/theme.dart';
import 'package:flutter/material.dart';

class TransactionHistoryHeader extends StatelessWidget {
  const TransactionHistoryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(
            Icons.history_rounded,
            size: 20,
            color: colorScheme.onSurface.withValues(alpha: 0.6),
          ),
          const SizedBox(width: 8),
          Text(
            'Riwayat Transaksi',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: AppFont.semiBold,
            ),
          ),
        ],
      ),
    );
  }
}
