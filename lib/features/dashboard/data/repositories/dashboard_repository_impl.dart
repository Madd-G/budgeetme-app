import 'package:budgeetme/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:budgeetme/features/dashboard/domain/entities/dashboard_transaction_summary.dart';
import 'package:budgeetme/features/dashboard/domain/entities/dashboard_transaction_filter.dart';
import 'package:budgeetme/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:budgeetme/features/transaction/domain/entities/transaction.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_repository_impl.g.dart';

@riverpod
DashboardRepository dashboardRepository(Ref ref) {
  final dataSource = ref.watch(dashboardRemoteDataSourceProvider);
  return DashboardRepositoryImpl(dataSource);
}

class DashboardRepositoryImpl implements DashboardRepository {
  const DashboardRepositoryImpl(this._dataSource);

  final DashboardRemoteDataSource _dataSource;

  @override
  Future<DashboardTransactionSummary> fetchSummary({DashboardTransactionFilter? filter}) async {
    final data = await _dataSource.fetchSummary();
    return DashboardTransactionSummary(
      totalIncome: data.income,
      totalExpense: data.expenses,
      balance: data.balance,
    );
  }

  @override
  Future<List<Transaction>> fetchTransactions({
    DashboardTransactionFilter? filter,
  }) async {
    final response = filter?.categoryId != null
        ? await _dataSource.fetchTransactionsByCategory(
            categoryId: filter!.categoryId!,
          )
        : await _dataSource.fetchTransactions();

    return response.data.map((d) => d.toEntity()).toList();
  }

  @override
  Future<DashboardTransactionSummary> fetchCategorySummary(int categoryId) async {
    final data = await _dataSource.fetchCategorySummary(categoryId);
    return DashboardTransactionSummary(
      totalIncome: data.income,
      totalExpense: data.expenses,
      balance: data.balance,
    );
  }
}
