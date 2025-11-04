import 'package:budgeetme/core/theme/theme.dart';
import 'package:budgeetme/features/transaction/domain/entities/transaction_type.dart';
import 'package:budgeetme/features/transaction/presentation/widgets/type_chip.dart';
import 'package:flutter/material.dart';

class TypeSelector extends StatelessWidget {
  const TypeSelector({
    required this.selectedType,
    required this.isEnabled,
    required this.onTypeChanged,
    super.key,
  });

  final TransactionType selectedType;
  final bool isEnabled;
  final Function(TransactionType) onTypeChanged;

  @override
  Widget build(BuildContext context) {
    final isIncome = selectedType == TransactionType.income;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tipe Transaksi',
          style: AppFont.bodyLarge.copyWith(
            fontWeight: AppFont.semiBold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TypeChip(
                label: 'Pemasukan',
                icon: Icons.arrow_downward_rounded,
                color: AppColors.income,
                isSelected: isIncome,
                isEnabled: isEnabled,
                onTap: isEnabled
                    ? () => onTypeChanged(TransactionType.income)
                    : () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TypeChip(
                label: 'Pengeluaran',
                icon: Icons.arrow_upward_rounded,
                color: AppColors.expense,
                isSelected: !isIncome,
                isEnabled: isEnabled,
                onTap: isEnabled
                    ? () => onTypeChanged(TransactionType.expense)
                    : () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
