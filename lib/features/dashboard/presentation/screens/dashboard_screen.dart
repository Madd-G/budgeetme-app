import 'package:budgeetme/core/theme/theme.dart';
import 'package:budgeetme/core/theme/provider/theme_provider.dart';
import 'package:budgeetme/core/utils/date_grouper.dart';
import 'package:budgeetme/core/widgets/error_view.dart';
import 'package:budgeetme/features/transaction/domain/entities/transaction.dart';
import 'package:budgeetme/features/dashboard/presentation/providers/expanded_days/expanded_days_provider.dart';
import 'package:budgeetme/features/dashboard/presentation/providers/transaction_list/transaction_list_provider.dart';
import 'package:budgeetme/features/transaction/presentation/providers/transaction_manage/transaction_manage_provider.dart';
import 'package:budgeetme/features/dashboard/presentation/providers/transaction_summary/transaction_summary_provider.dart';
import 'package:budgeetme/features/dashboard/presentation/widgets/appbar_title.dart';
import 'package:budgeetme/features/dashboard/presentation/widgets/category_filter_bar.dart';
import 'package:budgeetme/features/dashboard/presentation/widgets/empty_transaction_list.dart';
import 'package:budgeetme/features/dashboard/presentation/widgets/grouped_transaction_list.dart';
import 'package:budgeetme/features/dashboard/presentation/widgets/loading_shimmer.dart';
import 'package:budgeetme/features/dashboard/presentation/widgets/summary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  static const routeName = '/';

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(transactionListProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final transactionsValue = ref.watch(transactionListProvider);
    final summaryValue = ref.watch(transactionSummaryProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(transactionListProvider.notifier).refresh();
        },
        child: CustomScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            SliverAppBar.large(
              floating: true,
              backgroundColor: colorScheme.surface,
              title: AppBarTitle(),
              actions: [
                IconButton(
                  tooltip: 'Toggle theme',
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return RotationTransition(
                        turns: animation,
                        child: FadeTransition(opacity: animation, child: child),
                      );
                    },
                    child: Icon(
                      Theme.of(context).brightness == Brightness.dark
                          ? Icons.light_mode_rounded
                          : Icons.dark_mode_rounded,
                      key: ValueKey(Theme.of(context).brightness),
                    ),
                  ),
                  onPressed: () =>
                      ref.read(themeControllerProvider.notifier).toggle(),
                ),
                const SizedBox(width: 8),
              ],
            ),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
              sliver: transactionsValue.when(
                data: (transactions) {
                  return summaryValue.when(
                    data: (summary) {
                      if (transactions.isEmpty) {
                        return EmptyTransactionList(summary: summary);
                      }

                      final groupedTransactions = DateGrouper.groupByDate(
                        transactions,
                      );

                      // Auto-expand all days on first load
                      if (groupedTransactions.isNotEmpty) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ref.read(expandedDaysProvider.notifier).initializeIfNeeded(
                            groupedTransactions.map((g) => g.dateLabel).toList(),
                          );
                        });
                      }

                      return GroupedTransactionList(
                        summary: summary,
                        groupedTransactions: groupedTransactions,
                        onTransactionTap: _navigateToEdit,
                        onTransactionDelete: _deleteTransaction,
                      );
                    },
                    loading: () => _buildLoadingSliver(),
                    error: (_, __) => _buildLoadingSliver(),
                  );
                },
                loading: () => summaryValue.when(
                  data: (summary) => SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: SummaryCard(summary: summary),
                        );
                      }
                      if (index == 1) {
                        return const CategoryFilterBar();
                      }
                      return const ShimmerTransactionItem();
                    }, childCount: 8),
                  ),
                  loading: () => _buildLoadingSliver(),
                  error: (_, __) => _buildLoadingSliver(),
                ),
                error: (error, _) => SliverFillRemaining(
                    child: ErrorView(
                      error: error,
                      onRetry: () =>
                          ref.read(transactionListProvider.notifier).refresh(),
                    ),
                  ),
                ),
              ),
            ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push('/transaction-form');
        },
        icon: const Icon(Icons.add_rounded),
        label: const Text('Tambah'),
      ),
    );
  }

  Widget _buildLoadingSliver() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        if (index == 0) {
          return const ShimmerSummaryCard();
        }
        if (index == 1) {
          return const CategoryFilterBar();
        }
        return const ShimmerTransactionItem();
      }, childCount: 8),
    );
  }

  void _navigateToEdit(Transaction transaction) {
    context.push('/transaction-form', extra: transaction);
  }

  Future<void> _deleteTransaction(Transaction transaction) async {
    try {
      // Update the list first to remove headers if needed
      final listNotifier = ref.read(transactionListProvider.notifier);
      listNotifier.removeById(transaction.id);

      final notifier = ref.read(transactionManageProvider.notifier);
      await notifier.delete(transaction.id);

      if (!mounted) return;

      // Refresh list to ensure server state is synced
      await listNotifier.refresh();
      if (!mounted) return;

      if (context.mounted) {
        final colorScheme = Theme.of(context).colorScheme;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle_rounded, color: colorScheme.onPrimary),
                const SizedBox(width: 12),
                const Text('Transaksi berhasil dihapus'),
              ],
            ),
            backgroundColor: AppColors.success,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (error) {
      if (!mounted) return;

      if (context.mounted) {
        final colorScheme = Theme.of(context).colorScheme;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.error_rounded, color: colorScheme.onError),
                const SizedBox(width: 12),
                Expanded(child: Text('Gagal menghapus: $error')),
              ],
            ),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }

      await ref.read(transactionListProvider.notifier).refresh();
    }
  }
}
