import 'package:budgeetme/core/utils/date_grouper.dart';
import 'package:budgeetme/features/transaction/domain/entities/transaction.dart';
import 'package:budgeetme/features/dashboard/domain/entities/dashboard_transaction_summary.dart';
import 'package:budgeetme/features/dashboard/presentation/widgets/category_filter_bar.dart';
import 'package:budgeetme/features/dashboard/presentation/widgets/expandable_day_group.dart';
import 'package:budgeetme/features/dashboard/presentation/widgets/transaction_history_header.dart';
import 'package:budgeetme/features/dashboard/presentation/widgets/summary_card.dart';
import 'package:flutter/material.dart';

class GroupedTransactionList extends StatelessWidget {
  const GroupedTransactionList({
    required this.summary,
    required this.groupedTransactions,
    required this.onTransactionTap,
    required this.onTransactionDelete,
    super.key,
  });

  final DashboardTransactionSummary summary;
  final List<GroupedTransaction> groupedTransactions;
  final Function(Transaction) onTransactionTap;
  final Function(Transaction) onTransactionDelete;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: SummaryCard(summary: summary),
        ),
        const CategoryFilterBar(),
        const TransactionHistoryHeader(),
        ...groupedTransactions.map((group) {
          return ExpandableDayGroup(
            group: group,
            onTransactionTap: onTransactionTap,
            onTransactionDelete: onTransactionDelete,
          );
        }),
      ]),
    );
  }
}
