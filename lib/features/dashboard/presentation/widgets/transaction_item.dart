import 'package:budgeetme/core/extensions/date_time_extensions.dart';
import 'package:budgeetme/core/extensions/number_extensions.dart';
import 'package:budgeetme/core/theme/theme.dart';
import 'package:budgeetme/core/widgets/confirmation_dialog.dart';
import 'package:budgeetme/features/transaction/domain/entities/transaction.dart';
import 'package:flutter/material.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    required this.transaction,
    required this.animation,
    required this.onTap,
    required this.onDelete,
    super.key,
  });

  final Transaction transaction;
  final Animation<double> animation;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final isIncome = transaction.isIncome;
    final amountColor = isIncome ? AppColors.income : AppColors.expense;

    return SizeTransition(
      sizeFactor: animation.drive(CurveTween(curve: Curves.easeOutCubic)),
      child: SlideTransition(
        position: animation.drive(
          Tween<Offset>(
            begin: const Offset(0, 0.1),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeOutCubic)),
        ),
        child: FadeTransition(
          opacity: animation,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Dismissible(
              key: ValueKey(transaction.id),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.expense.withValues(alpha: 0.8),
                      AppColors.expense,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.delete_rounded,
                      color: colorScheme.onError,
                      size: 32,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Hapus',
                      style: AppFont.labelMedium.copyWith(
                        color: colorScheme.onError,
                        fontWeight: AppFont.semiBold,
                      ),
                    ),
                  ],
                ),
              ),
              confirmDismiss: (direction) => _confirmDelete(context),
              onDismissed: (direction) => onDelete(),
              child: Material(
                color: colorScheme.surface,
                child: InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: colorScheme.outline.withValues(alpha: 0.1),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.shadow.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: isIncome
                                  ? [
                                      AppColors.income.withValues(alpha: 0.15),
                                      AppColors.income.withValues(alpha: 0.25),
                                    ]
                                  : [
                                      AppColors.expense.withValues(alpha: 0.15),
                                      AppColors.expense.withValues(alpha: 0.25),
                                    ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            isIncome
                                ? Icons.arrow_downward_rounded
                                : Icons.arrow_upward_rounded,
                            color: amountColor,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                transaction.title,
                                style: AppFont.titleMedium.copyWith(
                                  fontWeight: AppFont.semiBold,
                                  color: colorScheme.onSurface,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today_rounded,
                                    size: 14,
                                    color: colorScheme.onSurface.withValues(
                                      alpha: 0.5,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    transaction.date.toShortDateFormat(),
                                    style: AppFont.bodySmall.copyWith(
                                      color: colorScheme.onSurface.withValues(
                                        alpha: 0.6,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (transaction.description != null) ...[
                                const SizedBox(height: 4),
                                Text(
                                  transaction.description ?? '',
                                  style: AppFont.bodySmall.copyWith(
                                    color: colorScheme.onSurface.withValues(
                                      alpha: 0.5,
                                    ),
                                    fontStyle: FontStyle.italic,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${isIncome ? '+' : '-'} ${transaction.amount.toRupiah()}',
                              style: AppFont.titleMedium.copyWith(
                                fontWeight: FontWeight.bold,
                                color: amountColor,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> _confirmDelete(BuildContext context) {
    return ConfirmationDialog.show(
      context,
      title: "Hapus Transaksi",
      message: "Transaksi yang dihapus tidak dapat dikembalikan",
      isDestructive: true,
    );
  }
}
