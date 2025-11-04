import 'package:budgeetme/features/dashboard/domain/entities/dashboard_transaction_summary.dart';
import 'package:budgeetme/features/dashboard/domain/entities/dashboard_transaction_filter.dart';
import 'package:budgeetme/features/dashboard/domain/entities/paginated_transactions.dart';

abstract class DashboardRepository {
  Future<DashboardTransactionSummary> fetchSummary({DashboardTransactionFilter? filter});

  Future<PaginatedTransactions> fetchTransactions({
    required int page,
    int? categoryId,
  });

  Future<DashboardTransactionSummary> fetchCategorySummary(int categoryId);
}
