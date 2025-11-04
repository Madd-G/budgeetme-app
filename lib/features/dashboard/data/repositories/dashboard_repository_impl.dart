import 'package:budgeetme/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:budgeetme/features/dashboard/domain/entities/dashboard_transaction_summary.dart';
import 'package:budgeetme/features/dashboard/domain/entities/dashboard_transaction_filter.dart';
import 'package:budgeetme/features/dashboard/domain/entities/paginated_transactions.dart';
import 'package:budgeetme/features/dashboard/domain/repositories/dashboard_repository.dart';
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
  Future<PaginatedTransactions> fetchTransactions({
    required int page,
    int? categoryId,
  }) async {
    final response = categoryId != null
        ? await _dataSource.fetchTransactionsByCategory(
            categoryId: categoryId,
            page: page,
          )
        : await _dataSource.fetchTransactions(page: page);

    return PaginatedTransactions(
      data: response.data.map((model) => model.toEntity()).toList(),
      total: response.total,
      totalPages: response.totalPages,
      currentPage: response.currentPage,
      perPage: response.perPage,
      categoryId: response.categoryId,
    );
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
