import 'package:budgeetme/features/dashboard/domain/entities/dashboard_transaction_summary.dart';
import 'package:budgeetme/features/dashboard/presentation/widgets/category_filter_bar.dart';
import 'package:budgeetme/features/dashboard/presentation/widgets/loading_shimmer.dart';
import 'package:budgeetme/features/dashboard/presentation/widgets/summary_card.dart';
import 'package:flutter/material.dart';

/// Widget untuk menampilkan loading state dengan summary card
class DashboardLoadingView extends StatelessWidget {
  const DashboardLoadingView({
    this.summary,
    this.isLoading = true,
    super.key,
  });

  final DashboardTransactionSummary? summary;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final displaySummary = summary ??
        const DashboardTransactionSummary(
          totalIncome: 0,
          totalExpense: 0,
          balance: 0,
        );

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: SummaryCard(
                summary: displaySummary,
                isLoading: isLoading,
              ),
            );
          }
          if (index == 1) {
            return const CategoryFilterBar();
          }
          return const ShimmerTransactionItem();
        },
        childCount: 8,
      ),
    );
  }
}
