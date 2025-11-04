import 'package:budgeetme/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:budgeetme/features/dashboard/domain/entities/dashboard_transaction_filter.dart';
import 'package:budgeetme/features/dashboard/presentation/providers/category_filter/category_filter_provider.dart';
import 'package:budgeetme/features/dashboard/domain/entities/dashboard_transaction_summary.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_summary_provider.g.dart';

@riverpod
Future<DashboardTransactionSummary> transactionSummary(Ref ref) async {
  final repository = ref.watch(dashboardRepositoryProvider);
  final categoryId = ref.watch(categoryFilterProvider);

  try {
    final filter = categoryId != null
        ? DashboardTransactionFilter(categoryId: categoryId)
        : null;

    final summary = categoryId != null
        ? await repository.fetchCategorySummary(categoryId)
        : await repository.fetchSummary(filter: filter);

    return DashboardTransactionSummary(
      totalIncome: summary.totalIncome,
      totalExpense: summary.totalExpense,
      balance: summary.balance,
    );
  } catch (error) {
    return DashboardTransactionSummary.empty;
  }
}
