import 'package:budgeetme/core/theme/theme.dart';
import 'package:budgeetme/core/extensions/number_extensions.dart';
import 'package:budgeetme/features/dashboard/domain/entities/dashboard_transaction_summary.dart';
import 'package:budgeetme/features/dashboard/presentation/widgets/stat_card_detail_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({required this.summary, this.isLoading = false, super.key});

  final DashboardTransactionSummary summary;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isPositive = summary.balance >= 0;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isPositive
              ? [
                  colorScheme.primaryContainer,
                  colorScheme.primaryContainer.withValues(alpha: 0.7),
                ]
              : [
                  colorScheme.errorContainer,
                  colorScheme.errorContainer.withValues(alpha: 0.7),
                ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: (isPositive ? colorScheme.primary : colorScheme.error)
                .withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.surface.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isPositive
                      ? Icons.trending_up_rounded
                      : Icons.trending_down_rounded,
                  color: isPositive ? AppColors.income : AppColors.expense,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Saldo Anda',
                      style: AppFont.bodyMedium.copyWith(
                        color: colorScheme.onPrimaryContainer,
                        fontWeight: AppFont.medium,
                      ),
                    ),
                    const SizedBox(height: 4),
                    isLoading
                        ? ShimmerBox(width: 180, height: 32)
                        : Text(
                            summary.balance.toRupiah(),
                            style: AppFont.headlineMedium.copyWith(
                              color: colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.5,
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: StatCard(
                  icon: Icons.arrow_downward_rounded,
                  label: 'Pemasukan',
                  amount: summary.totalIncome,
                  color: AppColors.income,
                  isLoading: isLoading,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatCard(
                  icon: Icons.arrow_upward_rounded,
                  label: 'Pengeluaran',
                  amount: summary.totalExpense,
                  color: AppColors.expense,
                  isLoading: isLoading,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  const StatCard({
    required this.icon,
    required this.label,
    required this.amount,
    required this.color,
    required this.isLoading,
    super.key,
  });

  final IconData icon;
  final String label;
  final double amount;
  final Color color;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          StatCardDetailDialog.show(
            context,
            icon: icon,
            label: label,
            amount: amount,
            color: color,
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surface.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: color, size: 20),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      label,
                      style: AppFont.bodySmall.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.7),
                        fontWeight: AppFont.medium,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.touch_app_rounded,
                    color: colorScheme.onSurface.withValues(alpha: 0.4),
                    size: 16,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              isLoading
                  ? const ShimmerBox(width: 120, height: 24)
                  : Text(
                      amount.toRupiah(),
                      style: AppFont.titleLarge.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShimmerBox extends StatelessWidget {
  const ShimmerBox({required this.width, required this.height, super.key});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return Shimmer.fromColors(
      baseColor: colorScheme.surfaceContainerHighest.withValues(
        alpha: 0.3,
      ),
      highlightColor: colorScheme.surfaceContainerLow.withValues(
        alpha: 0.5,
      ),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
