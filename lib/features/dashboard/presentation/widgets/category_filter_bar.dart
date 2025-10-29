import 'package:budgeetme/core/theme/app_colors.dart';
import 'package:budgeetme/features/transaction/domain/constants/transaction_constants.dart';
import 'package:budgeetme/features/dashboard/presentation/providers/category_filter/category_filter_provider.dart';
import 'package:budgeetme/features/dashboard/presentation/widgets/filter_chip_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryFilterBar extends ConsumerWidget {
  const CategoryFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(categoryFilterProvider);

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            FilterChipWidget(
              label: 'Semua',
              isSelected: selectedCategory == null,
              onTap: () =>
                  ref.read(categoryFilterProvider.notifier).clearFilter(),
            ),
            const SizedBox(width: 8),
            FilterChipWidget(
              label: 'Pemasukan',
              icon: Icons.arrow_downward_rounded,
              color: AppColors.income,
              isSelected:
                  selectedCategory == TransactionConstants.incomeCategoryId,
              onTap: () =>
                  ref.read(categoryFilterProvider.notifier).selectCategory(1),
            ),
            const SizedBox(width: 8),
            FilterChipWidget(
              label: 'Pengeluaran',
              icon: Icons.arrow_upward_rounded,
              color: AppColors.expense,
              isSelected:
                  selectedCategory == TransactionConstants.expenseCategoryId,
              onTap: () =>
                  ref.read(categoryFilterProvider.notifier).selectCategory(2),
            ),
          ],
        ),
      ),
    );
  }
}
