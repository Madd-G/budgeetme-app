import 'package:budgeetme/core/utils/date_grouper.dart';
import 'package:budgeetme/features/transaction/domain/entities/transaction.dart';
import 'package:budgeetme/features/dashboard/presentation/providers/expanded_days/expanded_days_provider.dart';
import 'package:budgeetme/features/dashboard/presentation/widgets/date_header.dart';
import 'package:budgeetme/features/dashboard/presentation/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpandableDayGroup extends ConsumerWidget {
  const ExpandableDayGroup({
    required this.group,
    required this.onTransactionTap,
    required this.onTransactionDelete,
    super.key,
  });

  final GroupedTransaction group;
  final Function(Transaction) onTransactionTap;
  final Function(Transaction) onTransactionDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpanded = ref.watch(expandedDaysProvider).contains(group.dateLabel);

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DateHeader(
            dateLabel: group.dateLabel,
            isExpanded: isExpanded,
            onTap: () {
              ref.read(expandedDaysProvider.notifier).toggle(group.dateLabel);
            },
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: isExpanded
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: group.transactions.asMap().entries.map((entry) {
                      return TweenAnimationBuilder<double>(
                        duration: Duration(milliseconds: 200 + (entry.key * 50)),
                        curve: Curves.easeOut,
                        tween: Tween<double>(begin: 0.0, end: 1.0),
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(0, 20 * (1 - value)),
                            child: Opacity(
                              opacity: value,
                              child: child,
                            ),
                          );
                        },
                        child: TransactionItem(
                          transaction: entry.value,
                          animation: const AlwaysStoppedAnimation(1.0),
                          onTap: () => onTransactionTap(entry.value),
                          onDelete: () => onTransactionDelete(entry.value),
                        ),
                      );
                    }).toList(),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
