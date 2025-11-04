import 'package:budgeetme/features/dashboard/domain/entities/dashboard_transaction_summary.dart';
import 'package:budgeetme/features/dashboard/domain/entities/dashboard_transaction_filter.dart';
import 'package:budgeetme/features/transaction/domain/entities/transaction.dart';

abstract class DashboardRepository {
  Future<DashboardTransactionSummary> fetchSummary({DashboardTransactionFilter? filter});

  Future<List<Transaction>> fetchTransactions({DashboardTransactionFilter? filter});

  Future<DashboardTransactionSummary> fetchCategorySummary(int categoryId);
}
