import 'package:budgeetme/core/widgets/empty_state.dart';
import 'package:budgeetme/features/transaction/domain/entities/transaction_summary.dart';
import 'package:budgeetme/features/dashboard/presentation/widgets/category_filter_bar.dart';
import 'package:budgeetme/features/dashboard/presentation/widgets/summary_card.dart';
import 'package:flutter/material.dart';

class EmptyTransactionList extends StatelessWidget {
  const EmptyTransactionList({
    required this.summary,
    super.key,
  });

  final TransactionSummary summary;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: SummaryCard(summary: summary),
        ),
        const CategoryFilterBar(),
        const SizedBox(height: 32),
        const SizedBox(
          height: 400,
          child: EmptyState(
            icon: Icons.receipt_long_rounded,
            title: 'Belum ada transaksi',
            message:
                'Mulai catat pemasukan dan pengeluaran Anda dengan menekan tombol + di bawah.',
          ),
        ),
      ]),
    );
  }
}
