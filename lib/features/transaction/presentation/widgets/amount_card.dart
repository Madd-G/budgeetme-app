import 'package:budgeetme/core/theme/theme.dart';
import 'package:budgeetme/core/utils/currency_input_formatter.dart';
import 'package:flutter/material.dart';

class AmountCard extends StatelessWidget {
  const AmountCard({
    required this.controller,
    required this.focusNode,
    required this.isIncome,
    required this.isEditing,
    required this.onChanged,
    super.key,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isIncome;
  final bool isEditing;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isIncome
              ? [
                  AppColors.income.withValues(alpha: 0.1),
                  AppColors.income.withValues(alpha: 0.05),
                ]
              : [
                  AppColors.expense.withValues(alpha: 0.1),
                  AppColors.expense.withValues(alpha: 0.05),
                ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: (isIncome ? AppColors.income : AppColors.expense)
              .withValues(alpha: 0.2),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color:
                      (isIncome ? AppColors.income : AppColors.expense)
                          .withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isIncome
                      ? Icons.arrow_downward_rounded
                      : Icons.arrow_upward_rounded,
                  color: isIncome
                      ? AppColors.income
                      : AppColors.expense,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Jumlah',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: AppFont.semiBold,
                  color: colorScheme.onSurface.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Rp',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isIncome
                        ? AppColors.income
                        : AppColors.expense,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    hintText: '0',
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    filled: false,
                    hintStyle: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface.withValues(alpha: 0.2),
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isIncome
                        ? AppColors.income
                        : AppColors.expense,
                    letterSpacing: -1,
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: false,
                  ),
                  inputFormatters: [CurrencyInputFormatter()],
                  autofocus: !isEditing,
                  onChanged: (_) => onChanged(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
